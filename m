Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36D901A08CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 18:48:27 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: on crash, kexec'ed kernel needs all CPUs are
 online
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1444935658-27319-1-git-send-email-lvivier@redhat.com>
 <1444961690.28419.1.camel@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dgibson@redhat.com, thuth@redhat.com
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <5620ABC5.6060300@redhat.com>
Date: Fri, 16 Oct 2015 09:48:21 +0200
MIME-Version: 1.0
In-Reply-To: <1444961690.28419.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/10/2015 04:14, Michael Ellerman wrote:
> On Thu, 2015-10-15 at 21:00 +0200, Laurent Vivier wrote:
>> On kexec, all secondary offline CPUs are onlined before
>> starting the new kernel, this is not done in the case of kdump.
>>
>> If kdump is configured and a kernel crash occurs whereas
>> some secondaries CPUs are offline (SMT=off),
>> the new kernel is not able to start them and displays some
>> "Processor X is stuck.".
> 
> Do we know why they are stuck?

Yes, we know :)

On the crash, as the CPUs are offline, kernel doesn't call
opal_return_cpu(), so for OPAL all these CPU are always in the kernel.

When the new kernel starts, it call s opal_query_cpu_status() to know
which CPUs are available. As they were not returned to OPAL these CPUs
are not available, but as the kernel logic relies on the fact they must
be available (the logic is SMT is on), it is waiting for their starting
and wait for ever...

When the kernel starts, all secondary processors are started by a call
for each of them of __cpu_up():

__cpu_up()

    ...
    cpu_callin_map[cpu] = 0;
    ...
    rc = smp_ops->kick_cpu(cpu);
    ...wait...
    if (!cpu_callin_map[cpu]) {
                printk(KERN_ERR "Processor %u is stuck.\n", cpu);
    ...

on powernv, kick_cpu() is pnv_smp_kick_cpu():

pnv_smp_kick_cpu()

    ...
    unsigned long start_here =

__pa(ppc_function_entry(generic_secondary_smp_init));
    ...
    /*
     * Already started, just kick it, probably coming from
     * kexec and spinning
     */
    rc = opal_query_cpu_status(pcpu, &status);
    ...
    if (status == OPAL_THREAD_STARTED)
        goto kick;
    ...
    rc = opal_start_cpu(pcpu, start_here);
    ...
kick:
    ...

generic_secondary_smp_init() is a function in assembly language that
calls in the end start_secondary() :

start_secondary()

    ...
    cpu_callin_map[cpu] = 1;
    ...

So processors are stucked because start_secondary() is never called.

start_secondary() is never called because OPAL cpu status is
OPAL_THREAD_STARTED.

Secondary CPUs are in "OPAL_THREAD_STARTED" state because they have not
been returned to OPAL on crash.

CPUs are returned to OPAL by pnv_kexec_cpu_down() which is called by
crash_ipi_callback() (for secondary cpus)... except if the cpu is not
online.

As the CPUs are offline, they are not returned to OPAL, and then kernel
can't restart them.


> I really don't like this fix. The reason we're doing a kdump is because the
> first kernel has panicked, possibly with locks held or data structures
> corrupted. Calling cpu_up() then goes and tries to run a bunch of code in the
> crashed kernel, which increases the chance of us just wedging completely.

I agree, but the whole logic of the POWER kernel is we have all the
threads available.

Moreover the kernel parameter "maxcpus" is ignored if it is not a
multiple of thread per core:

...
static int subcore_init(void)
{
        if (!cpu_has_feature(CPU_FTR_ARCH_207S))
                return 0;

        /*
         * We need all threads in a core to be present to split/unsplit so
         * continue only if max_cpus are aligned to threads_per_core.
         */
        if (setup_max_cpus % threads_per_core)
                return 0;

...
