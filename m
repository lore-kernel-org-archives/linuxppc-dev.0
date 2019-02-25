Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87E7C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 05:32:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE0162084D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 05:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="TU7jlG3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE0162084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4479Yc55KxzDqLL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 16:32:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4479Wq5s7QzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 16:30:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="TU7jlG3y"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4479Wq3hrLz9sDX; Mon, 25 Feb 2019 16:30:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1551072631; bh=Kd+IEq1329U7pyx2n1HgD2DE59v4KqdppGEILzfakGc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TU7jlG3yhFMANnX6kTfR8eNztOUUvQxUFcbf9u66UyoZvu4VOUFRYdTe62GF/nZoU
 EeECvbRFoPi9E9OgsYZj1UG1oFDg9sHTJT06BJAHrKA7Asd1eymCVLl1Tyz4neaHJe
 m13PWkUylXJvq3nmg6GaH9va8PmnwlP9EJ+1CzxlY/NM+CB7LBdo8Tdi9jotgJ9CUA
 6x1Uim19RILfs3iF5FSFxFBpKhRb6cv9amlr8rV4CIan6cXSftFJnkdgXTs97Dh1ZL
 FsrtBaDupyFzpWbCXMI9s+1TSMK46V7X2EaS2W2UjyituYoAAoLhrIpLXiC02bRdtQ
 b0G3qVBCfV+gw==
Date: Mon, 25 Feb 2019 16:30:27 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 04/16] KVM: PPC: Book3S HV: XIVE: add a control to
 initialize a source
Message-ID: <20190225053027.GC20501@blackberry>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-5-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222112840.25000-5-clg@kaod.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Feb 22, 2019 at 12:28:28PM +0100, Cédric Le Goater wrote:
> The associated HW interrupt source is simply allocated at the OPAL/HW
> level and then MASKED. KVM only needs to know about its type: LSI or
> MSI.

I think it would be helpful to explain to the reader here that with
XIVE, all interrupts have a hardware source, even IPIs and virtual
device interrupts, for which we allocate a software-triggerable
interrupt source in the XIVE hardware.

> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h        |   5 +
>  arch/powerpc/kvm/book3s_xive.h             |  10 ++
>  arch/powerpc/kvm/book3s_xive.c             |   8 +-
>  arch/powerpc/kvm/book3s_xive_native.c      | 114 +++++++++++++++++++++
>  Documentation/virtual/kvm/devices/xive.txt |  15 +++
>  5 files changed, 148 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index b002c0c67787..a9ad99f2a11b 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -677,5 +677,10 @@ struct kvm_ppc_cpu_char {
>  
>  /* POWER9 XIVE Native Interrupt Controller */
>  #define KVM_DEV_XIVE_GRP_CTRL		1
> +#define KVM_DEV_XIVE_GRP_SOURCE		2	/* 64-bit source attributes */
> +
> +/* Layout of 64-bit XIVE source attribute values */
> +#define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> +#define KVM_XIVE_LEVEL_ASSERTED		(1ULL << 1)
>  
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xive.h
> index bcb1bbcf0359..f22f2d46d0f0 100644
> --- a/arch/powerpc/kvm/book3s_xive.h
> +++ b/arch/powerpc/kvm/book3s_xive.h
> @@ -12,6 +12,13 @@
>  #ifdef CONFIG_KVM_XICS
>  #include "book3s_xics.h"
>  
> +/*
> + * The XIVE IRQ number space is aligned with the XICS IRQ number
> + * space, CPU IPIs being allocated in the first 4K.
> + */
> +#define KVMPPC_XIVE_FIRST_IRQ	0
> +#define KVMPPC_XIVE_NR_IRQS	KVMPPC_XICS_NR_IRQS
> +
>  /*
>   * State for one guest irq source.
>   *
> @@ -253,6 +260,9 @@ extern int (*__xive_vm_h_eoi)(struct kvm_vcpu *vcpu, unsigned long xirr);
>   */
>  void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu);
>  int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu);
> +struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
> +	struct kvmppc_xive *xive, int irq);
> +void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb);

So we're using the same source block data structure (effectively a
2-level tree) that the XICS-on-XIVE code uses.  That would be worth
mentioning as a design choice in the patch description.

>  
>  #endif /* CONFIG_KVM_XICS */
>  #endif /* _KVM_PPC_BOOK3S_XICS_H */
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> index d1cc18a5b1c4..6f950ecb3592 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -1485,8 +1485,8 @@ static int xive_get_source(struct kvmppc_xive *xive, long irq, u64 addr)
>  	return 0;
>  }
>  
> -static struct kvmppc_xive_src_block *xive_create_src_block(struct kvmppc_xive *xive,
> -							   int irq)
> +struct kvmppc_xive_src_block *kvmppc_xive_create_src_block(
> +	struct kvmppc_xive *xive, int irq)
>  {
>  	struct kvm *kvm = xive->kvm;
>  	struct kvmppc_xive_src_block *sb;
> @@ -1565,7 +1565,7 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
>  	sb = kvmppc_xive_find_source(xive, irq, &idx);
>  	if (!sb) {
>  		pr_devel("No source, creating source block...\n");
> -		sb = xive_create_src_block(xive, irq);
> +		sb = kvmppc_xive_create_src_block(xive, irq);
>  		if (!sb) {
>  			pr_devel("Failed to create block...\n");
>  			return -ENOMEM;
> @@ -1789,7 +1789,7 @@ static void kvmppc_xive_cleanup_irq(u32 hw_num, struct xive_irq_data *xd)
>  	xive_cleanup_irq_data(xd);
>  }
>  
> -static void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
> +void kvmppc_xive_free_sources(struct kvmppc_xive_src_block *sb)
>  {
>  	int i;
>  
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
> index 1f3da47a4a6a..a9b2d2d9af99 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -31,6 +31,29 @@
>  
>  #include "book3s_xive.h"
>  
> +/*
> + * TODO: introduce a common template file with the XIVE native layer
> + * and the XICS-on-XIVE glue for the utility functions
> + */
> +#define __x_eoi_page(xd)	((void __iomem *)((xd)->eoi_mmio))
> +#define __x_trig_page(xd)	((void __iomem *)((xd)->trig_mmio))
> +#define __x_readq	__raw_readq
> +#define __x_writeq	__raw_writeq
> +
> +static u8 xive_vm_esb_load(struct xive_irq_data *xd, u32 offset)
> +{
> +	u64 val;
> +
> +	if (xd->flags & XIVE_IRQ_FLAG_SHIFT_BUG)
> +		offset |= offset << 4;
> +
> +	val = __x_readq(__x_eoi_page(xd) + offset);

Ben originally defined the __x_* macros so that he could use the same
source code twice, once for real mode and once for virtual mode.
Since you're not doing that, is there really any reason for this
indirection?  Why not just __raw_readq, __raw_writeq etc. directly?

Paul.
