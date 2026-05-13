Return-Path: <linuxppc-dev+bounces-20919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2901CCD4F21
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 16:55:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gG02B36R7z2xld;
	Thu, 14 May 2026 02:55:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.137.202.136
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778691314;
	cv=none; b=fvYC6v0eiNy1kDURnDeXT7nbLhzHgU8fLX1iD9IrJqf9oSauQ26KqQZl7Nuz7wUSVhH/MFYD+0+8DIsHYbvHRglFN4bo67bsRkMcd80OcwXP+4qND5MLiC3wXstbIrEfLHLhbr4zY3xHjsL42bCyJIIYgpi/jsI7lFC5TqH2rNFxzxwDn81golJqFZUmLk2boK+h4Tjcow+K5OxwDU8LJCLEtwf1YRi4/wfR5tP1qoBjI47hqnDMmY93Kl8QO6E/mA//PEoVKcvRbrfFHWq43nPiBJucHtIP0PZ5ocuoLMiKjAm2YCbb+ZXk/yIfuIq24XEq+mU1+6TY1BKXPtFdeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778691314; c=relaxed/relaxed;
	bh=kzc3j2nHoRxQd9M0vkzx/uZg5Iwn8WIixU3RTEBg+i4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WIESGIFCP3LGTnrY1XtbDpV6V4QlF/zhv6nairZOKhRbXFrfyokNdV3+328bO7EPRhA+ORxTfJxlXG9F7KvhvgzjmPrXD75z9asNdRKSdV+uWmep0tPRMBedGfNum+7FKaeTZw4Wn48u0Z+6NyqiiPDB5kGtRrkzpJE/Iew+mT2HZzpKUjzosCVpx40pI06FpFIrjNrvB+Y+cNZvwb8M1TAsi9AhgrxKzoeeMfaxWZLJuQow+h0D07/8JuBdAkGnGxKzND7CzMNd85ENKDkrjUprsbSOPuQbSj8VAQDPzBwWwKrmTnhh9zpXJufGu43dKEpNTNrDWC6aCRKyW2dvgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com; dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026042601 header.b=Ahhs2ZaN; dkim-atps=neutral; spf=pass (client-ip=198.137.202.136; helo=terminus.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org) smtp.mailfrom=zytor.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=zytor.com header.i=@zytor.com header.a=rsa-sha256 header.s=2026042601 header.b=Ahhs2ZaN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=zytor.com (client-ip=198.137.202.136; helo=terminus.zytor.com; envelope-from=hpa@zytor.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 899 seconds by postgrey-1.37 at boromir; Thu, 14 May 2026 02:55:12 AEST
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gG02824spz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 02:55:12 +1000 (AEST)
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 64DGEn1a2905667
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 13 May 2026 09:14:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 64DGEn1a2905667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026042601; t=1778688894;
	bh=kzc3j2nHoRxQd9M0vkzx/uZg5Iwn8WIixU3RTEBg+i4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Ahhs2ZaNxCuIyTcDd/to/S7gqU6ft6zabx6TakulFhnIjDt8bXMJ0LGzYVyEfrxzF
	 EoSq1ir5sKEz+X8RiAhKD9hHd7SJ2OozMvt9/+9wrxu0pBvVJBlgjVq84smFg5PvWl
	 ODAygtu3MetLOSzf39fcORVc45KgUJxXa0B3c1WcYV/TBfKv8I2j2JZj6Oo7LMLnaS
	 F/w+6e9Kh9WjQd20++VspvTwbnc9Zogl0CKsAiiMu7QXkJbZu0hP9l3BvRBi3h/lIE
	 60H32//SMm5Gsh1hto9j6ldrE4pFtBClA6C9ESo0hnzWXYJCYw3OlK+u43GeYa68K6
	 OTz8RC1DMTHsw==
Date: Wed, 13 May 2026 09:14:44 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Song Liu <song@kernel.org>,
        Yu Kuai <yukuai@alb-78bjiv52429oh8qptp.cn-shenzhen.alb.aliyuncs.com>,
        Li Nan <linan122@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [PATCH 01/19] btrfs: require at least 4 devices for RAID 6
User-Agent: K-9 Mail for Android
In-Reply-To: <20260512052230.2947683-2-hch@lst.de>
References: <20260512052230.2947683-1-hch@lst.de> <20260512052230.2947683-2-hch@lst.de>
Message-ID: <45B68AA3-36E2-4187-BD30-F4631C7F32C2@zytor.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On May 11, 2026 10:20:41 PM PDT, Christoph Hellwig <hch@lst=2Ede> wrote:
>While the RAID6 algorithm could in theory support 3 devices by just
>copying the data disk to the two parity disks, this version is not only
>useless because it is a suboptimal version of 3-way mirroring, but also
>broken with various crashes and incorrect parity generation in various
>architecture-optimized implementations=2E  Disallow it similar to mdraid
>which requires at least 4 devices for RAID 6=2E
>
>Fixes: 53b381b3abeb ("Btrfs: RAID5 and RAID6")
>Signed-off-by: Christoph Hellwig <hch@lst=2Ede>
>---
> fs/btrfs/volumes=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/fs/btrfs/volumes=2Ec b/fs/btrfs/volumes=2Ec
>index a88e68f90564=2E=2E0b54b97bdad8 100644
>--- a/fs/btrfs/volumes=2Ec
>+++ b/fs/btrfs/volumes=2Ec
>@@ -159,7 +159,7 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_N=
R_RAID_TYPES] =3D {
> 		=2Esub_stripes	=3D 1,
> 		=2Edev_stripes	=3D 1,
> 		=2Edevs_max	=3D 0,
>-		=2Edevs_min	=3D 3,
>+		=2Edevs_min	=3D 4,
> 		=2Etolerated_failures =3D 2,
> 		=2Edevs_increment	=3D 1,
> 		=2Encopies	=3D 1,

Yes, if anyone cares about < 4 disks for the RAID-6 case (or < 3 for the R=
AID-4/5 case), just use the RAID-1 code=2E

