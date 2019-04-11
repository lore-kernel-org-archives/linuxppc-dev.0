Return-Path: <SRS0=HNI+=SN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5487DC10F13
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 10:28:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83262084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 10:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="rBgkoiWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83262084D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fy1H1nhyzDqQx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Apr 2019 20:28:51 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44fxzR6vcCzDqNx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2019 20:27:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="rBgkoiWN"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 44fxzR2Jt2z9s71; Thu, 11 Apr 2019 20:27:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1554978435; bh=ppqUwnkzsxm0Z2Fzw4KgjrLdBsT6oyRWP9hNqLrvASY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rBgkoiWNEAkrJwLNXBPbCcNULiSnUyBa3zErTbSNm58z9hqqBNPsLxBRwQc3HwOiY
 5CcLRiR8p3VIMbRL3OHuTs6tg4UX+yGYURJ02ekFtLkJT2xaNVHTTHyNv7tqDD4ok/
 VkNG01CI5Z/AZdqmy17gxkUdw0WxV6QwbpAZlETlV6H+vlmZdF0t0DWORiKH5ei1iv
 +xlCjBpJK2p+vTVmiEVdRkIffyrKrOzwA21YaabVpXhNlNSIWqHULIa6/pTYrxO439
 4ckvaXV1/kujuxCmSomDZ9pFVaMA056BgZ34UYg3Uvb1kJCxTdhHt4geD4Ukpw8jQM
 B6p1eyobtvi6Q==
Date: Thu, 11 Apr 2019 20:27:10 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v5 16/16] KVM: PPC: Book3S HV: XIVE: introduce a
 'release' device operation
Message-ID: <20190411102710.GD21252@blackberry>
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

Unfortunately, I think there is now a memory leak:

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index ea2018ae1cd7..ea2619d5ca98 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2938,6 +2938,19 @@ static int kvm_device_release(struct inode *inode, struct file *filp)
>  	struct kvm_device *dev = filp->private_data;
>  	struct kvm *kvm = dev->kvm;
>  
> +	if (!dev)
> +		return -ENODEV;
> +
> +	if (dev->kvm != kvm)
> +		return -EPERM;
> +
> +	if (dev->ops->release) {
> +		mutex_lock(&kvm->lock);
> +		list_del(&dev->vm_node);

Because the device is now no longer in the kvm->devices list,
kvm_destroy_devices() won't find it there and therefore won't call the
device's destroy method.  In fact now the device's destroy method will
never get called; I can't see how kvmppc_xive_free() or
kvmppc_xive_native_free() will ever get called.  Thus the memory for
the kvmppc_xive structs will never get freed as far as I can see.

We could fix that by freeing both of the kvm->arch.xive_devices
entries at VM destruction time.

If it is true that any device that has a release method will never see
its destroy method being called, then that needs to be documented
clearly somewhere.

Paul.
