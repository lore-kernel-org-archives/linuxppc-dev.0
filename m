Return-Path: <SRS0=1PmZ=FA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76CC56202
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 03:25:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04FA920578
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 03:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="MJHv2k+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FA920578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ChNRs5RB4zDr9W
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 14:25:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ChNP80CHKzDr61
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 14:22:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=MJHv2k+G; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ChNP64Xkcz9sVH;
 Thu, 26 Nov 2020 14:22:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606360970;
 bh=VD5TisT5ZeXiMTVV+mDfjwYZ697RK3H5XI2Uko5WKkQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=MJHv2k+GKeIIexh6flzGS3pN64+Ne0G3xu1HEQevZlgqQAYfBoy6718zQWX00aK6k
 +VKWdlRnCxwm9B1iUBocNkhxMSi7ZSTovQiwl/GD4NfNZpE1Mg6ntG0Lc1WrYo5/79
 AWMeJ9mSdvIRqmbHCouDkIny1coi3HxENAksR+LmNkUoI2w8bKKQv+EX41YgCnoDJ9
 0RMWQsRAcP3PeCyg4fzzcJeMAukIJXu549Ea3ttEjdngP6X5CDFnNSo/BK4rUoW/Ix
 BPLOtEkITCp7TLQeWV21hmOfeGNGtLRZFwQT9y45O1BPX0bzhk4nany0UxTgeSbA/Y
 qRMypA7QEjKNA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] powerpc/pseries: pass MSI affinity to
 irq_create_mapping()
In-Reply-To: <20201125150932.1150619-3-lvivier@redhat.com>
References: <20201125150932.1150619-1-lvivier@redhat.com>
 <20201125150932.1150619-3-lvivier@redhat.com>
Date: Thu, 26 Nov 2020 14:22:49 +1100
Message-ID: <87zh34yf7a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Laurent Vivier <lvivier@redhat.com>, Marc Zyngier <maz@kernel.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-pci@vger.kernel.org,
 Greg Kurz <groug@kaod.org>, linux-block@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Laurent Vivier <lvivier@redhat.com> writes:
> With virtio multiqueue, normally each queue IRQ is mapped to a CPU.
>
> But since commit 0d9f0a52c8b9f ("virtio_scsi: use virtio IRQ affinity")
> this is broken on pseries.
>
> The affinity is correctly computed in msi_desc but this is not applied
> to the system IRQs.
>
> It appears the affinity is correctly passed to rtas_setup_msi_irqs() but
> lost at this point and never passed to irq_domain_alloc_descs()
> (see commit 06ee6d571f0e ("genirq: Add affinity hint to irq allocation"))
> because irq_create_mapping() doesn't take an affinity parameter.
>
> As the previous patch has added the affinity parameter to
> irq_create_mapping() we can forward the affinity from rtas_setup_msi_irqs()
> to irq_domain_alloc_descs().
>
> With this change, the virtqueues are correctly dispatched between the CPUs
> on pseries.
>
> BugId: https://bugzilla.redhat.com/show_bug.cgi?id=1702939
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
>  arch/powerpc/platforms/pseries/msi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 133f6adcb39c..b3ac2455faad 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -458,7 +458,8 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec_in, int type)
>  			return hwirq;
>  		}
>  
> -		virq = irq_create_mapping(NULL, hwirq);
> +		virq = irq_create_mapping_affinity(NULL, hwirq,
> +						   entry->affinity);
>  
>  		if (!virq) {
>  			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
> -- 
> 2.28.0
