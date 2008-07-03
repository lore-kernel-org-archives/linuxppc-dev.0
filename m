Return-Path: <mingo@elte.hu>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0E356DDFC5
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 17:26:56 +1000 (EST)
Date: Thu, 3 Jul 2008 09:26:29 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: generic-ipi tree build failure
Message-ID: <20080703072629.GB5648@elte.hu>
References: <20080703171007.5a17ea25.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080703171007.5a17ea25.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ingo, Jens,
> 
> Today's linux-next build (powerpc ppc64_defconfig) failed like this:
> 
> arch/powerpc/mm/tlb_64.c: In function 'pgtable_free_now':
> arch/powerpc/mm/tlb_64.c:66: error: too many arguments to function 'smp_call_function'
> arch/powerpc/mm/slice.c: In function 'slice_get_unmapped_area':
> arch/powerpc/mm/slice.c:559: error: too many arguments to function 'on_each_cpu'
> arch/powerpc/kernel/machine_kexec_64.c: In function 'kexec_prepare_cpus':
> arch/powerpc/kernel/machine_kexec_64.c:175: error: too many arguments to function 'smp_call_function'
> 
> I applied the patch below.

thanks, applied the tlb_64.c and machine_kexec_64.c bits to 
tip/generic-ipi [see the commit below]. (Please carry the slice.c bits 
in linux-next separately as that's due to new code in linux-next.)

	Ingo

---------------->
commit 392096e98fd55e54035978fe03796fca8d26a574
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Jul 3 17:10:07 2008 +1000

    generic-ipi: fix linux-next tree build failure
    
    Today's linux-next build (powerpc ppc64_defconfig) failed like this:
    
    arch/powerpc/mm/tlb_64.c: In function 'pgtable_free_now':
    arch/powerpc/mm/tlb_64.c:66: error: too many arguments to function 'smp_call_function'
    arch/powerpc/kernel/machine_kexec_64.c: In function 'kexec_prepare_cpus':
    arch/powerpc/kernel/machine_kexec_64.c:175: error: too many arguments to function 'smp_call_function'
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Acked-by: Jens Axboe <jens.axboe@oracle.com>
    Cc: Paul Mackerras <paulus@samba.org>
    Cc: <linuxppc-dev@ozlabs.org>
    Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 704375b..b732b5f 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -172,7 +172,7 @@ static void kexec_prepare_cpus(void)
 {
 	int my_cpu, i, notified=-1;
 
-	smp_call_function(kexec_smp_down, NULL, 0, /* wait */0);
+	smp_call_function(kexec_smp_down, NULL, /* wait */0);
 	my_cpu = get_cpu();
 
 	/* check the others cpus are now down (via paca hw cpu id == -1) */
diff --git a/arch/powerpc/mm/tlb_64.c b/arch/powerpc/mm/tlb_64.c
index e2d867c..69ad829 100644
--- a/arch/powerpc/mm/tlb_64.c
+++ b/arch/powerpc/mm/tlb_64.c
@@ -66,7 +66,7 @@ static void pgtable_free_now(pgtable_free_t pgf)
 {
 	pte_freelist_forced_free++;
 
-	smp_call_function(pte_free_smp_sync, NULL, 0, 1);
+	smp_call_function(pte_free_smp_sync, NULL, 1);
 
 	pgtable_free(pgf);
 }
