Return-Path: <SRS0=+31F=RA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A965C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 05:02:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0492087C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 05:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="M/1ixHdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0492087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4478vy5LPTzDqSY
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Feb 2019 16:02:54 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4478r72YTlzDqL7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 15:59:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="M/1ixHdO"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 4478r65LXrz9s9y; Mon, 25 Feb 2019 15:59:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1551070774; bh=ZoJ3OFZAu4czQjw6ArCWNXdU8ZQvw3age0dLC0xDs7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=M/1ixHdOFN87cT553foouC6gsDqNJ5XTe2lsCsfzLEpBJGm3v/n/mDggWe8vzENP4
 In81SigqmiRx2o7k4fTcw41UGtSkBk1f1OS4ikx2h4zkgJ90/w6HcgOsALBKDXnxbF
 +p42wYKSSowG9WIxgBjD08CYvlFEU4OVXRo/U/U7aAmAHVB4CTZZOXr0O0Tb4O+B4E
 v11gPbc+aPqBkzYQioLDYukRBy9Bxd6MsvyeWQVkWVl6mVrz6yvvxE0F33G2J4Crzk
 lAcuUEoTxjb9KTNm2Kka/BFIP2N4dOtKDjW/sJJBWCf1ydE85JGQqaDnoryyh3uk+Q
 gCO3/xJg6FeTg==
Date: Mon, 25 Feb 2019 15:35:51 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 03/16] KVM: PPC: Book3S HV: XIVE: introduce a new
 capability KVM_CAP_PPC_IRQ_XIVE
Message-ID: <20190225043551.GA20501@blackberry>
References: <20190222112840.25000-1-clg@kaod.org>
 <20190222112840.25000-4-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190222112840.25000-4-clg@kaod.org>
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

On Fri, Feb 22, 2019 at 12:28:27PM +0100, Cédric Le Goater wrote:
> The user interface exposes a new capability to let QEMU connect the
> vCPU to the XIVE KVM device if required. The capability is only
> advertised on a PowerNV Hypervisor as support for nested guests
> (pseries KVM Hypervisor) is not yet available.

If a bisection happened to land on this commit, we would have KVM
saying it had the ability to support guests using XIVE natively, but
it wouldn't actually work since we don't have all the code that is in
the following patches.

Thus, in order to avoid breaking bisection, you should either add the
capability now but have it always return false until the rest of the
code is in place, or else defer the addition of the capability until
the end of the patch series.

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 8c69af10f91d..a38a643a24dd 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -570,6 +570,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  	case KVM_CAP_PPC_GET_CPU_CHAR:
>  		r = 1;
>  		break;
> +#ifdef CONFIG_KVM_XIVE
> +	case KVM_CAP_PPC_IRQ_XIVE:
> +		/* only for PowerNV */
> +		r = !!cpu_has_feature(CPU_FTR_HVMODE);

Shouldn't this be r = xive_enabled() && !!cpu_has_feature(CPU_FTR_HVMODE)
(or alternatively r = xics_on_xive(), though that would be confusing
to the reader)?

As it stands this would report true on POWER8, unless I'm missing
something.

Paul.
