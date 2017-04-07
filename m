Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w017y1y1mzDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Apr 2017 23:46:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] fadump: reduce memory consumption for capture
 kernel
In-Reply-To: <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
References: <148647105867.9464.16492047069430229118.stgit@hbathini.in.ibm.com>
 <878tnd7zim.fsf@concordia.ellerman.id.au>
 <d50dfb98-68ac-0135-8e65-560aec1d752e@linux.vnet.ibm.com>
Date: Fri, 07 Apr 2017 23:46:21 +1000
Message-ID: <87efx4gwk2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
> On Friday 07 April 2017 07:24 AM, Michael Ellerman wrote:
>> My preference would be that the fadump kernel "just works". If it's
>> using too much memory then the fadump kernel should do whatever it needs
>> to use less memory, eg. shrinking nr_cpu_ids etc.
>
>> Do we actually know *why* the fadump kernel is running out of memory?
>> Obviously large numbers of CPUs is one of the main drivers (lots of
>> stacks required). But other than that what is causing the memory
>> pressure? I would like some data on that before we proceed.
>
> Almost the same amount of memory in comparison with the memory
> required to boot the production kernel but that is unwarranted for fadump
> (dump capture) kernel.

That's not data! :)

The dump kernel is booted with *much* less memory than the production
kernel (that's the whole issue!) and so it doesn't need to create struct
pages for all that memory, which means it should need less memory.

The vfs caches are also sized based on the available memory, so they
should also shrink in the dump kernel.

I want some actual numbers on what's driving the memory usage.

I tried some of these parameters to see how much memory they would save:

> So, if parameters like
> cgroup_disable=memory,

0 bytes saved.

> transparent_hugepages=never,

0 bytes saved.

> numa=off,

64KB saved.

> nr_cpus=1,

3MB saved (vs 16 CPUs)


Now maybe on your system those do save memory for some reason, but
please prove it to me. Otherwise I'm inclined to merge:

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 8ff0dd4e77a7..03f1f253c372 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -79,8 +79,10 @@ int __init early_init_dt_scan_fw_dump(unsigned long node,
 	 * dump data waiting for us.
 	 */
 	fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump", NULL);
-	if (fdm_active)
+	if (fdm_active) {
 		fw_dump.dump_active = 1;
+		nr_cpu_ids = 1;
+	}
 
 	/* Get the sizes required to store dump data for the firmware provided
 	 * dump sections.

cheers
