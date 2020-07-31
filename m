Return-Path: <SRS0=XZtv=BK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDBCC433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 03:32:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3135206FA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 03:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnoN+fOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3135206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BHtBq0122zDqbW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2020 13:32:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d42;
 helo=mail-io1-xd42.google.com; envelope-from=oohall@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=HnoN+fOj; dkim-atps=neutral
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com
 [IPv6:2607:f8b0:4864:20::d42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BHt8Y0J3SzDqY7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2020 13:30:34 +1000 (AEST)
Received: by mail-io1-xd42.google.com with SMTP id s189so23178049iod.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2020 20:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Su5lKFNWeulhsct9iwtDAxmGUMKFC2lpWVUWlye0WBs=;
 b=HnoN+fOjIxv1/Df2dvqEhUbB7GLtOExM56z76Ap6dpEUm9CQfbm37z+IXIaLZnuuYc
 hyAfyFxOlLTsUkjKTCDPjA3LeUuQJ7FrJPOJYbUQlYV2XqzAvBR/N0F6vddyhySelAsG
 a2uz++Su+vpLvOqFZG13Z74k2E4BtXiPEFqpueqZKiWCeod90yQlAKH+OP2Fhg36X1ck
 fsPp5cKMpoOiW0UMfL6AcOdDdR87n1fHkl9u6pBS+XXiOkGQHcYDuxMfxeHcmjJEKLNY
 yx5EjjBizz8v4PRTRd3Vyw1/qCpZNiF7C/tbcLfxb9ELxjLuZxNck7L43y+N1JsUQVmq
 gj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Su5lKFNWeulhsct9iwtDAxmGUMKFC2lpWVUWlye0WBs=;
 b=uJDAGK8a1PCGM6fidjXaTuqyNihW7fuTHABG7AUz9kE59gb8uFnXWoXqloC0lTIAn/
 8sRmUz7UFvGCY1zP8q9XrGGlhmolrBJYnlWfovltdS98ztai79ao/9P9oNwcsxMx8aFH
 tB1T+OIJX3bTxhcxch0wjOr5NAusu8PHaxVfClIRvaCfjih1rCIxNp03Bu6SmV6nknDG
 k6bTpnWUXMkILmjJeCaqW+p1Xvejh5v6FBI2+n6scz3S6IGpw3dyuLK/vUuNhJVv/sRY
 2+iX6wGVOy+jH1fkgzxvqzXfQoC7yqlWqOyIMQ0KVuPhQrfcPxva8oeucqT8n+etDhb8
 p+ZA==
X-Gm-Message-State: AOAM532yhYzgqvlVmDcSjHM+eW6UOgOXW/wKR7/Ol0UkOc9SreQiNv+N
 7kaxo/fTZhVL9SGtNNtVgYQLw1gPuAbIMjhKzgk=
X-Google-Smtp-Source: ABdhPJxvvO1IcEtJ+7bcSB6kUy2CcSTiVMB06Q2hv1UyFbElqivrTTce1lNxaVdPclzUoXfd4OaoGuVoXGKM0N99IVI=
X-Received: by 2002:a05:6638:2401:: with SMTP id
 z1mr2673950jat.97.1596166230243; 
 Thu, 30 Jul 2020 20:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200430131520.51211-1-maxg@mellanox.com>
In-Reply-To: <20200430131520.51211-1-maxg@mellanox.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Fri, 31 Jul 2020 13:30:19 +1000
Message-ID: <CAOSf1CERo2EGafcjOPfJ7NNFwE2Y7OJ_yGbR7xOGvf+PnrxSfw@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] powerpc/dma: Define map/unmap mmio resource
 callbacks
To: Max Gurtovoy <maxg@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: vladimirk@mellanox.com, Carol L Soto <clsoto@us.ibm.com>,
 linux-pci <linux-pci@vger.kernel.org>, shlomin@mellanox.com,
 israelr@mellanox.com, Frederic Barrat <fbarrat@linux.ibm.com>,
 idanw@mellanox.com, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>, aneela@mellanox.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Apr 30, 2020 at 11:15 PM Max Gurtovoy <maxg@mellanox.com> wrote:
>
> Define the map_resource/unmap_resource callbacks for the dma_iommu_ops
> used by several powerpc platforms. The map_resource callback is called
> when trying to map a mmio resource through the dma_map_resource()
> driver API.
>
> For now, the callback returns an invalid address for devices using
> translations, but will "direct" map the resource when in bypass
> mode. Previous behavior for dma_map_resource() was to always return an
> invalid address.
>
> We also call an optional platform-specific controller op in
> case some setup is needed for the platform.

Hey Max,

Sorry for not getting to this sooner. Fred has been dutifully nagging
me to look at it, but people are constantly throwing stuff at me so
it's slipped through the cracks.

Anyway, the changes here are fine IMO. The only real suggestion I have
is that we might want to move the direct / bypass mode check out of
the arch/powerpc/kernel/dma-iommu.c and into the PHB specific function
in pci_controller_ops. I don't see any real reason p2p support should
be limited to devices using bypass mode since the data path is the
same for translated and untranslated DMAs. We do need to impose that
restriction for OPAL / PowerNV IODA PHBs due to the implementation of
the opal_pci_set_p2p() has the side effect of forcing the TVE into
no-translate mode. However, that's a platform issue so the restriction
should be imposed in platform code.

I'd like to fix that, but I'd prefer to do it as a follow up change
since I need to have a think about how to fix the firmware bits.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
