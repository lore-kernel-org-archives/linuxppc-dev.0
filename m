Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7A0CD1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 10:13:27 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B942314010F
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2015 10:13:26 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 25 Feb 2015 16:13:24 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 07180C90045
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 18:04:32 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1PNDLpQ30081238
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 23:13:21 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1PNDKGH016842
 for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2015 18:13:21 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/smp: Wait until secondaries are active & online
In-Reply-To: <1424761082-29938-1-git-send-email-mpe@ellerman.id.au>
References: <1424761082-29938-1-git-send-email-mpe@ellerman.id.au>
Date: Thu, 26 Feb 2015 10:13:16 +1100
Message-ID: <m3fv9tegab.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> Anton has a busy ppc64le KVM box where guests sometimes hit the infamous
> "kernel BUG at kernel/smpboot.c:134!" issue during boot:
>
>   BUG_ON(td->cpu != smp_processor_id());
>
> Basically a per CPU hotplug thread scheduled on the wrong CPU. The oops
> output confirms it:
>
>   CPU: 0
>   Comm: watchdog/130
>
> The problem is that we aren't ensuring the CPU active bit is set for the
> secondary before allowing the master to continue on. The master unparks
> the secondary CPU's kthreads and the scheduler looks for a CPU to run
> on. It calls select_task_rq() and realises the suggested CPU is not in
> the cpus_allowed mask. It then ends up in select_fallback_rq(), and
> since the active bit isnt't set we choose some other CPU to run on.
>
> This seems to have been introduced by 6acbfb96976f "sched: Fix hotplug
> vs. set_cpus_allowed_ptr()", which changed from setting active before
> online to setting active after online. However that was in turn fixing a
> bug where other code assumed an active CPU was also online, so we can't
> just revert that fix.
>
> The simplest fix is just to spin waiting for both active & online to be
> set. We already have a barrier prior to set_cpu_online() (which also
> sets active), to ensure all other setup is completed before online &
> active are set.
>
> Fixes: 6acbfb96976f ("sched: Fix hotplug vs. set_cpus_allowed_ptr()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Anton Blanchard <anton@samba.org>

By building a gcov enabled skiboot, which makes OPAL_START_CPU a whole
bunch slower (because gcov), I could really *really* reliably reproduce
this. With this patch, I cannot.

Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
