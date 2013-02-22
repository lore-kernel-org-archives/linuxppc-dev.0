Return-Path: <phileas-fogg@mail.ru>
Received: from smtp21.mail.ru (smtp21.mail.ru [94.100.176.174])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 372522C02A5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2013 09:41:35 +1100 (EST)
Message-ID: <51280223.9070109@mail.ru>
Date: Sat, 23 Feb 2013 00:41:23 +0100
From: Phileas Fogg <phileas-fogg@mail.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
References: <1360365046.495584377@f356.mail.ru> <5123C729.5040607@mail.ru>
 <5123D864.4060503@mail.ru> <51253558.1070407@mail.ru>
 <1361406741.4676.44.camel@pasglop> <512685B7.5080404@mail.ru>
 <1361478942.4676.53.camel@pasglop> <5126955B.9070808@mail.ru>
 <1361490374.4676.58.camel@pasglop> <5127D9CE.2090500@mail.ru>
 <1361562773.15017.36.camel@pasglop>
In-Reply-To: <1361562773.15017.36.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2013-02-22 at 21:49 +0100, Phileas Fogg wrote:
>> i wanted to let you know that i tested your advice. And let me say, it's was a
>> damn good advice :) I can boot FreeBSD loader on Linux 3.8 now, no SHA256
>> checksum failures. And no panics with FreeBSD LiveCD anymore too.
>>
>> I just inserted hard_irq_disable() after each local_irq_disable() in
>> arch/powerpc/kernel/machine_kexec_64.c
>
> Awesome ! :-)
>
> Care to send a patch with a Signed-off-by: ?
>
> Cheers,
> Ben.
>
>

No problem, but as i said it was your idea how to fix the issue with kexec.
Anyways here is the patch which i tested on my PS3 console with Linux 3.8.
After applying this patch i can boot any Linux kernel starting with 2.6,
FreeBSD loader, FreeBSD LiveCD and my own tiny ELF kernels too.
Even OpenBSD bootloader starts now too :)
And i don't see any failed SHA256 checksums in the purgatory code.

regards

 From c17cdf38dfe180b4a571827bb547aaf9b678cf29 Mon Sep 17 00:00:00 2001
From: Phileas Fogg <phileas-fogg@mail.ru>
Date: Sat, 23 Feb 2013 00:32:19 +0100
Subject: [PATCH] kexec: disable hard IRQ before kexec

Disable hard IRQ before kexec a new kernel image.
Not doing it can result in corrupted data in the memory segments
reserved for the new kernel.
---
  arch/powerpc/kernel/machine_kexec_64.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/machine_kexec_64.c 
b/arch/powerpc/kernel/machine_kexec_64.c
index 7206701..e08b9d0 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -162,6 +162,7 @@ static int kexec_all_irq_disabled = 0;
  static void kexec_smp_down(void *arg)
  {
  	local_irq_disable();
+	hard_irq_disable();
  	mb(); /* make sure our irqs are disabled before we say they are */
  	get_paca()->kexec_state = KEXEC_STATE_IRQS_OFF;
  	while(kexec_all_irq_disabled == 0)
@@ -244,6 +245,7 @@ static void kexec_prepare_cpus(void)
  	wake_offline_cpus();
  	smp_call_function(kexec_smp_down, NULL, /* wait */0);
  	local_irq_disable();
+	hard_irq_disable();
  	mb(); /* make sure IRQs are disabled before we say they are */
  	get_paca()->kexec_state = KEXEC_STATE_IRQS_OFF;

@@ -281,6 +283,7 @@ static void kexec_prepare_cpus(void)
  	if (ppc_md.kexec_cpu_down)
  		ppc_md.kexec_cpu_down(0, 0);
  	local_irq_disable();
+	hard_irq_disable();
  }

  #endif /* SMP */
-- 
1.8.1.4
