Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4982C77B7F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 May 2023 04:46:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QGzrD6sGnz3fQ2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 May 2023 14:46:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=SYn1FHGe;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QGzqJ0Q1Qz3bhL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2023 14:45:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=SYn1FHGe;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGzqD6d7fz4x4h;
	Thu, 11 May 2023 14:45:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1683780345;
	bh=gGQo2Hod1s0dUe8TaV/VGhddTEqXZ34G+98W5auwrHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SYn1FHGeyN2/KAqF8+2vnJXhmFrxun3VUz0Gm9tCde4qEbF3rEovKXDUS6pQCfiyw
	 glrKlKcrrf9chWC+x/mErRxsdtXBHUqxEKAC6crYiVTLfcP/SprOVnkVTHA6ouhNQ/
	 ETxHTeSacOeGfaPHeCdf5c+LKnmdBlSDnLZEOySHAZkk5TuanfORoUgQWu6TTmeK1x
	 fFP2VQAp6atPbM6/tlL4TDo2TzY9xwKsD2SVLI3Va4Qaa/5FBcR5jDFYoIkEKSiUjb
	 LKs1sKrmmNjOr77HT5e+V2hgGKTADo9yergTHjCiPGLJrbDHrlFDbxHHGwgXVy8vzx
	 smd4t/8KrwPIA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build warnings in powercp build
In-Reply-To: <20230511121635.0a6764a0@canb.auug.org.au>
References: <20230511121635.0a6764a0@canb.auug.org.au>
Date: Thu, 11 May 2023 14:45:44 +1000
Message-ID: <871qjna32f.fsf@mail.lhotse>
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Today's (and a few before) linux-next build (powerpc pseries_le_defconfig)
> produced these warnings:

Those aren't really warnings, it's just merge_config.sh telling you what
it's doing. The whole point of the generated configs is to override
those symbols.

Looks like there is a way to silence them, by using merge_into_defconfig_override.

cheers

> Building: powerpc pseries_le_defconfig
> Using /home/sfr/next/next/arch/powerpc/configs/ppc64_defconfig as base
> Merging /home/sfr/next/next/arch/powerpc/configs/le.config
> Merging /home/sfr/next/next/arch/powerpc/configs/guest.config
> Value of CONFIG_VIRTIO_BLK is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_BLK=m
> New value: CONFIG_VIRTIO_BLK=y
>
> Value of CONFIG_SCSI_VIRTIO is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_SCSI_VIRTIO=m
> New value: CONFIG_SCSI_VIRTIO=y
>
> Value of CONFIG_VIRTIO_NET is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_NET=m
> New value: CONFIG_VIRTIO_NET=y
>
> Value of CONFIG_VIRTIO_CONSOLE is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_CONSOLE=m
> New value: CONFIG_VIRTIO_CONSOLE=y
>
> Value of CONFIG_VIRTIO_PCI is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_PCI=m
> New value: CONFIG_VIRTIO_PCI=y
>
> Value of CONFIG_VIRTIO_BALLOON is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_BALLOON=m
> New value: CONFIG_VIRTIO_BALLOON=y
>
> Value of CONFIG_VHOST_NET is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VHOST_NET=m
> New value: CONFIG_VHOST_NET=y
>
> Value of CONFIG_IBMVETH is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_IBMVETH=m
> New value: CONFIG_IBMVETH=y
>
> Value of CONFIG_IBMVNIC is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_IBMVNIC=m
> New value: CONFIG_IBMVNIC=y
>
> I am not sure exactly which change(s) introduced these warnings.
>
> -- 
> Cheers,
> Stephen Rothwell
