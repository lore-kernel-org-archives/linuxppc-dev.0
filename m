Return-Path: <SRS0=1fX1=YX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAC9CA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 10:37:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0974B204FD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 10:37:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QqJNQWV+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0974B204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4734f05f6SzDqbt
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Oct 2019 21:37:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4734bN0G3hzF3yn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2019 21:35:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="QqJNQWV+"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4734bL4bqkz9sPJ;
 Wed, 30 Oct 2019 21:35:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1572431711;
 bh=WmtX+xAbYWaAbWorI0MYAttJQLuDF1ZuIP0rN4t19I0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QqJNQWV+M+xtPfWh3QSjZ/IXALxkPJ6eN4NSrLxoYUPzowgXqqVyyJni/2RY7uCXA
 oaHsjkf2fE8GEgwFaxTExQBji18BbVLN9yChBAJXmudBZ0+dN586yNhcPR2/eFqm6/
 iT6C9vZyNC+3M1FqrcoGv/5NvTvlr4vlr1KpTKpKxc5Sa3JM7Z0zKzQVJc80XT2z5B
 Dm00Ujq7n4lvh3uXdPpCYMOsZ6scz9pGOPLxu1eD0Ekt9PlIGRagXnx1YsTyqDWkVI
 UwDA9mdEIrIRVrY5f9rfIu8a3mQfLZTZ5r0RL1rPw6E+72ENOknYR7SSC8YmETnD+s
 HYFzp1vND1mNg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>, alexander.deucher@amd.com
Subject: Re: [PATCH v3] drm/radeon: Fix EEH during kexec
In-Reply-To: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
References: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Date: Wed, 30 Oct 2019 21:35:10 +1100
Message-ID: <87o8xyfrmp.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Kyle,

KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com> writes:
> From: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
>
> During kexec some adapters hit an EEH since they are not properly
> shut down in the radeon_pci_shutdown() function. Adding
> radeon_suspend_kms() fixes this issue.
> Enabled only on PPC because this patch causes issues on some other
> boards.

Which adapters hit the issues?

And do we know why they're not shut down correctly in
radeon_pci_shutdown()? That seems like the root cause no?


> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 9e55076..4528f4d 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -379,11 +379,25 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>  static void
>  radeon_pci_shutdown(struct pci_dev *pdev)
>  {
> +#ifdef CONFIG_PPC64
> +	struct drm_device *ddev = pci_get_drvdata(pdev);
> +#endif

This local serves no real purpose and could be avoided, which would also
avoid this ifdef.

>  	/* if we are running in a VM, make sure the device
>  	 * torn down properly on reboot/shutdown
>  	 */
>  	if (radeon_device_is_virtual())
>  		radeon_pci_remove(pdev);
> +
> +#ifdef CONFIG_PPC64
> +	/* Some adapters need to be suspended before a

AFAIK drm uses normal kernel comment style, so this should be:

	/*
	 * Some adapters need to be suspended before a
> +	 * shutdown occurs in order to prevent an error
> +	 * during kexec.
> +	 * Make this power specific becauase it breaks
> +	 * some non-power boards.
> +	 */
> +	radeon_suspend_kms(ddev, true, true, false);

ie, instead do:

	radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);

> +#endif
>  }
>  
>  static int radeon_pmops_suspend(struct device *dev)
> -- 
> 1.8.3.1

cheers
