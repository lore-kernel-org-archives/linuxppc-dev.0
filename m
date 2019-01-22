Return-Path: <SRS0=/GF9=P6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEA7C282C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:50:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A8D820879
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 05:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="uKcJblXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A8D820879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43kHYx1lbfzDqMn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 16:49:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43kHPt0yp8zDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 16:42:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="uKcJblXa"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 43kHPs58Gkz9sBQ; Tue, 22 Jan 2019 16:42:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1548135777; bh=qPXiFSvEqaA7ZqF25fMj+UZctDexxwToJ2hO+G9lINU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uKcJblXaYZR4EVtZbgDKRVOaMa55p5S0M/6YqvqwNLh4Q1xaRLT1cpzQ/z/JS6LKY
 W/sD5uNLYRSI914JOiXqMqma/pqpnBZeCeP3R2ACE367XeyX+tu9IJDsiKZ+Qm+YKI
 /jhh+k96WmzuG6dYJxYW/iAiScaXqgPygc64Np8V22RPRfS78F59IThkrka2sdreMs
 qlVxL43f/SFuw7EbUZwIbXPArwr4Id3jHICKUN1oFysjLz9tG/yhurJHPRshTJBwAx
 6fAB2yvy4cguSRRgysO24KW3dKkvWOazNX3FMMbgZP+cA3+xuDEWGP5H/NPKQlccuz
 /VilHrQhKpSfQ==
Date: Tue, 22 Jan 2019 16:09:52 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
Message-ID: <20190122050952.GD15124@blackberry>
References: <20190107184331.8429-1-clg@kaod.org>
 <20190107184331.8429-7-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107184331.8429-7-clg@kaod.org>
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

On Mon, Jan 07, 2019 at 07:43:18PM +0100, Cédric Le Goater wrote:
> This will let the guest create a memory mapping to expose the ESB MMIO
> regions used to control the interrupt sources, to trigger events, to
> EOI or to turn off the sources.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>  arch/powerpc/include/uapi/asm/kvm.h   |  4 ++
>  arch/powerpc/kvm/book3s_xive_native.c | 97 +++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
> index 8c876c166ef2..6bb61ba141c2 100644
> --- a/arch/powerpc/include/uapi/asm/kvm.h
> +++ b/arch/powerpc/include/uapi/asm/kvm.h
> @@ -675,4 +675,8 @@ struct kvm_ppc_cpu_char {
>  #define  KVM_XICS_PRESENTED		(1ULL << 43)
>  #define  KVM_XICS_QUEUED		(1ULL << 44)
>  
> +/* POWER9 XIVE Native Interrupt Controller */
> +#define KVM_DEV_XIVE_GRP_CTRL		1
> +#define   KVM_DEV_XIVE_GET_ESB_FD	1
> +
>  #endif /* __LINUX_KVM_POWERPC_H */
> diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
> index 115143e76c45..e20081f0c8d4 100644
> --- a/arch/powerpc/kvm/book3s_xive_native.c
> +++ b/arch/powerpc/kvm/book3s_xive_native.c
> @@ -153,6 +153,85 @@ int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>  	return rc;
>  }
>  
> +static int xive_native_esb_fault(struct vm_fault *vmf)
> +{
> +	struct vm_area_struct *vma = vmf->vma;
> +	struct kvmppc_xive *xive = vma->vm_file->private_data;
> +	struct kvmppc_xive_src_block *sb;
> +	struct kvmppc_xive_irq_state *state;
> +	struct xive_irq_data *xd;
> +	u32 hw_num;
> +	u16 src;
> +	u64 page;
> +	unsigned long irq;
> +
> +	/*
> +	 * Linux/KVM uses a two pages ESB setting, one for trigger and
> +	 * one for EOI
> +	 */
> +	irq = vmf->pgoff / 2;
> +
> +	sb = kvmppc_xive_find_source(xive, irq, &src);
> +	if (!sb) {
> +		pr_err("%s: source %lx not found !\n", __func__, irq);

In general it's a bad idea to have a printk that userspace can trigger
at will without any rate-limiting.  Is there a real reason why this
printk is needed (and can't be pr_devel)?

> +		return VM_FAULT_SIGBUS;
> +	}
> +
> +	state = &sb->irq_state[src];
> +	kvmppc_xive_select_irq(state, &hw_num, &xd);
> +
> +	arch_spin_lock(&sb->lock);
> +
> +	/*
> +	 * first/even page is for trigger
> +	 * second/odd page is for EOI and management.
> +	 */
> +	page = vmf->pgoff % 2 ? xd->eoi_page : xd->trig_page;
> +	arch_spin_unlock(&sb->lock);
> +
> +	if (!page) {
> +		pr_err("%s: acessing invalid ESB page for source %lx !\n",
> +		       __func__, irq);

Does this represent a exceptional condition that userspace can't just
trigger at will (i.e. it implies the presence of a kernel bug)?  If
not then the same comment as above applies.

Paul.
