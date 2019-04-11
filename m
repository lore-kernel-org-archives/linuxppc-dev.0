Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F27C10F11
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:18:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04922133D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 03:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="b0ypBdod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04922133D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fmSK6NM7zDqFs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 13:18:09 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fmQN2VnkzDqDJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 13:16:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="b0ypBdod"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 44fmQN0VRlz9s71; Thu, 11 Apr 2019 13:16:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1554952588; bh=ogizDjhR016Ty7xjWcdRKvgsaqrWqbpGkzQDlVKPKqw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=b0ypBdodFLFdHWi9PwQ6E4Jnsk1CEZPQMutWOJ6TAcyog/UyVE9N6xwKxCWZ/lJyY
 wyr1CRj5jDwnbdhIR02Fes2AK63jkadxy6u1Ef7Nw9N+CkanlQCmMFz0j5seFHkMic
 bVllekbgBDS1GK23yMxQS2LkZHs3I84+X/or/P9m0p3Z4TVNFudR1RZmWA+BWgNBui
 f8yil4X1yHl5PE2KXj5fRKcbzrOf6exoouLSotAcZHAjbXTCpUWEJjT0hjxgsZmsG/
 lczX3Dw9EGri7ibz/+sBA0mVsYeIz+4u+0zsOkwKQPNft5OKtowNHGlW2Vd0KWYlgJ
 upPb34IgPAywg==
Date: Thu, 11 Apr 2019 13:16:25 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v5 16/16] KVM: PPC: Book3S HV: XIVE: introduce a
 'release' device operation
Message-ID: <20190411031625.GA21252@blackberry>
References: <20190410170448.3923-1-clg@kaod.org>
 <20190410170448.3923-17-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190410170448.3923-17-clg@kaod.org>
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Apr 10, 2019 at 07:04:48PM +0200, Cédric Le Goater wrote:
> When a P9 sPAPR VM boots, the CAS negotiation process determines which
> interrupt mode to use (XICS legacy or XIVE native) and invokes a
> machine reset to activate the chosen mode.
> 
> To be able to switch from one mode to another, we introduce the
> capability to release a KVM device without destroying the VM. The KVM
> device interface is extended with a new 'release' operation which is
> called when the file descriptor of the device is closed.

I believe the release operation is not called until all of the mmaps
using the fd are unmapped - which is a good thing for us, since it
means the guest can't possibly be accessing the XIVE directly.
You might want to reword that last paragraph to mention that.

> Such operations are defined for the XICS-on-XIVE and the XIVE native
> KVM devices. They clear the vCPU interrupt presenters that could be
> attached and then destroy the device.
> 
> This is not considered as a safe operation as the vCPUs are still
> running and could be referencing the KVM device through their
> presenters. To protect the system from any breakage, the kvmppc_xive
> objects representing both KVM devices are now stored in an array under
> the VM. Allocation is performed on first usage and memory is freed
> only when the VM exits.

One quick comment below:

> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
> index 480a3fc6b9fd..064a9f2ae678 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -1100,11 +1100,19 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
>  void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
>  {
>  	struct kvmppc_xive_vcpu *xc = vcpu->arch.xive_vcpu;
> -	struct kvmppc_xive *xive = xc->xive;
> +	struct kvmppc_xive *xive;
>  	int i;
>  
> +	if (!kvmppc_xics_enabled(vcpu))
> +		return;

Should that be kvmppc_xive_enabled() rather than xics?

Paul.
