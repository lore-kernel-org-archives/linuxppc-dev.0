Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE9C606A324
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 11:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0w4y3pq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVbB952Kfz2xSF;
	Thu, 19 Nov 2026 22:01:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795086081;
	cv=none; b=IC5Ks0LUGkAKFQ39R39q1QvhTmZblrLsb4UIDdbO6DID7g+BKQ+xYJfn9dMToF/vvO7u6iIcOm+hjybyKOn5OjTVsaM7aQaJ68yInihUHRxJJIAv+Wn14ywXH5VtL9jVwnPOpfppCazh5Ambbmfj9QTImf6U1CTEKQgCklW45lm/LYPL7+afvLg+8drownXAfz8PTeU5ks9NHDh1fnWgq/eVkvuk045Y/t6mZQ5zAYKEwknDxsfzidxwDqYdAyXCHgBrAC7bcuSzo80u3EP29eX/J+/DvKHiHSkkI5Eez1h1eb+zfqBaSOJHU4CfQ/+dsury5PYyTdTEV1hVJnsRHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795086081; c=relaxed/relaxed;
	bh=NlUvq2HpnerQLH3flTbOZH1bj0OHRcxRHwUIA48QJc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iuqzS26u7zieAJoU+BDr770Ozds5IG1oeizVc8dE2wwP3GHOwjeTR3HiN8WzmG4b7qCt+Q8eqkOViSlICxVt35gAByjILvI9DlCM4aJAMxmHpfnWbBzVBbBGgQ7pp8rPdLyj6oLDseTvqfFsETvYb5puoQrzpvdLlbcgdnx26eVOU6HKMBXTHZtk+v+n3lmC8Dj9DHvVI5fsaWu2GOgwjJmo6wK/uaRZBSW3+72K7CkFwGixoi0KJyhHk7vIEjKRjFdHsYMWUv4IE/2q4sUEEf/ENbH5eeIT+ZRPQA3Rc3OJTXgWY3K7ufyED+A6yb2pSHGveHtVrq4UCPSGmZFJmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0w4y3pq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0w4y3pq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=pratyush@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVbB85F3Bz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 22:01:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 3D35C437DC;
	Thu, 19 Nov 2026 11:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 128761F000C6;
	Thu, 19 Nov 2026 11:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795086077;
	bh=NlUvq2HpnerQLH3flTbOZH1bj0OHRcxRHwUIA48QJc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=K0w4y3pqXsaP3ubeldycHwHdzHusNNZ8UWp+6vQiAMiUx60nPEzsEI6UORCWk2eQM
	 Wr9MQq++PwU5z61f5LSDEP/iq4naKOipL4OMYf3DinFcFig10sjtTbY97erbnHEo4N
	 YUsiICY5uHAbdPH6LrzIgPYWrXrSB9l/2O0n7IlxkCsCvQCLsq4VEjI6XjjyL4rxmv
	 iQPAM4DO3b1e/YXAvLTi7iTezPwfGOpMZZWOUYfE8tL1pN806bFh5j5ih6yGAgPP1a
	 FfTA7G26gf/3dkJHKJphG6zjuFB4DY41xyN0dDytK5Ezt06txmdtB1kzNPaWLRDwgR
	 3LJf+KdeFvAjA==
From: Pratyush Yadav <pratyush@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,  Alexander Gordeev
 <agordeev@linux.ibm.com>,  Andrew Morton <akpm@linux-foundation.org>,
  Baoquan He <baoquan.he@linux.dev>,  Borislav Petkov <bp@alien8.de>,
  Catalin Marinas <catalin.marinas@arm.com>,  Dave Hansen
 <dave.hansen@linux.intel.com>,  Geert Uytterhoeven <geert@linux-m68k.org>,
  Heiko Carstens <hca@linux.ibm.com>,  Helge Deller <deller@gmx.de>,
  Huacai Chen <chenhuacai@kernel.org>,  Ingo Molnar <mingo@redhat.com>,
  "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,  John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,  Madhavan Srinivasan
 <maddy@linux.ibm.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Pasha
 Tatashin <pasha.tatashin@soleen.com>,  Paul Walmsley <pjw@kernel.org>,
  Pratyush Yadav <pratyush@kernel.org>,  Rich Felker <dalias@libc.org>,
  Russell King <linux@armlinux.org.uk>,  Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>,  Thomas Gleixner <tglx@kernel.org>,  Vasily
 Gorbik <gor@linux.ibm.com>,  Will Deacon <will@kernel.org>,  Yoshinori
 Sato <ysato@users.sourceforge.jp>,  x86@kernel.org,  Alexandre Ghiti
 <alex@ghiti.fr>,  Christian Borntraeger <borntraeger@linux.ibm.com>,
  "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,  Cong Wang
 <cwang@multikernel.io>,  Mark Rutland <mark.rutland@arm.com>,  Michael
 Ellerman <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  "H.
 Peter Anvin" <hpa@zytor.com>,  "Ritesh Harjani (IBM)"
 <ritesh.list@gmail.com>,  Shrikanth Hegde <sshegde@linux.ibm.com>,  Sven
 Schnelle <svens@linux.ibm.com>,  WANG Xuerui <kernel@xen0n.name>,
  kexec@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-m68k@lists.linux-m68k.org,
  linux-mips@vger.kernel.org,  linux-parisc@vger.kernel.org,
  linux-riscv@lists.infradead.org,  linux-s390@vger.kernel.org,
  linux-sh@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities
 in Kconfig.kexec
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org> (Mike
	Rapoport's message of "Thu, 19 Nov 2026 08:16:58 +0200")
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
	<20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
Date: Thu, 19 Nov 2026 11:01:06 +0000
Message-ID: <2vxza4n53x1p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19 2026, Mike Rapoport (Microsoft) wrote:

> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
>
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
>
> Selection conditions are preserved, so there is no functional change.
>
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Acked-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

