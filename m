Return-Path: <linuxppc-dev+bounces-25735-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917F6C5B574
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 08:35:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK4gk416Wz2yvG;
	Tue, 11 Aug 2026 18:35:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786437314;
	cv=none; b=P9+KcNAa59OxQh4a58pN0w/F5JVareZOfektXHUsMygBFfbidUZiV7woUVkj4vgo2uNfNyRli1fz797yPwThNr08tsdkbkUgSIxNcIUVLeeDFUptjLy47pLETQVI9JZjNm9QtAtEBbb3cJhK7lzyF34Kj2B41ElzynZfZZCf2VvnAt5wgBUe6EQotVN0kTAmvYFnBmstBBrVef8v3z4Kpr/UoPLV0X9t3Hoc8/evFe6nrZ7E5FGDU8OAQIA5ghsqNqHvL7BU135dwYzIm8SbcC+PeZIKvoNFE0UcVG/THYeevW7tnW4wsEsSUcxnUMqaLznTP3eIXS4uG6aDZmOKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786437314; c=relaxed/relaxed;
	bh=FpB3+FkrG1uWOg00/UfBQNwp9iXrIA9AhO2Rb76OdaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egRUxQG+wCH7hrQfuZFOU6qoPMdnVU4XbOU0ztwOl7l//CUOJT1bQaLZ2Mya3nORraHwV7fSuLxnJTlkipfHtTMQSepLOt003LxLUisdalYJi9H6C+3pVLO3+4WvbDGBtUDBkckU2nNOXo97GXMnOVb942JEdMP42N+wRxq0j+5wRESbyqN20n7IXjIggRIprHQf8hTBZ9XZzVIOJNfWfpoex5oV4K0pmPxY5Zf6vzPvwgpf4zDlDFe34FSnV/q5kogkUrE/bceijqRkqZBFB7DRFnjDK5YMvge1HdK1Q6OXqaXBuSonbDrnEf2o+nmOabYbCXPdZoaF4jbHXawgbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ILvmNn+1; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ILvmNn+1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hK4gf6t5Qz2ynH
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 18:35:08 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B295E1516;
	Tue, 11 Aug 2026 01:34:31 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA58F3F673;
	Tue, 11 Aug 2026 01:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786437275; bh=ZT08f1GiOgKpD31g66zZnUhmuNu7zNORWfMHkMNA+MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILvmNn+1uP0GCjTeWxHAARq3POjelk/zkkggHRqr669N5vBlnXQv9Yg8uShAHAWPV
	 r+uFJpIr4Ahch5mMzxC2ouczYWRZPMGrkwVkFNIVMPn+HCacIXd33isOumG+cExtcS
	 egAiyy/T4cf+1AQQkz3B427/hIS4SjOBaBYGwt8M=
Date: Tue, 11 Aug 2026 14:04:32 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 6/6] mm: Drop pxd_ERROR()
Message-ID: <ijjadks7zjpwqlw4nbcawr3tva2r4y6gn3weuc73vbec46petn@ovlf52m2kugw>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-7-anshuman.khandual@arm.com>
 <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXfpkpYzZWGVb0fQrdn3uYHU3pyCkyAX9o2ux_Jj=2ByA@mail.gmail.com>

On Tue, Aug 11, 2026 at 08:49:43AM +0200, Geert Uytterhoeven wrote:
> Hi Anshuman,
> 
> Thanks for your patch!
> 
> On Tue, 11 Aug 2026 at 06:22, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
> > pxd_ERROR() has been used in generic mm just to print the page table entry
> > in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> > pxd_ERROR() macros have been provided by all platforms which basically did
> > the same thing.
> >
> > Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> > page table entries thus completely dropping dependency on platform provided
> > pxd_ERROR() macros which can then be dropped off. First move all required
> > helpers in core MM into a header file which could then be used else where.
> 
> Oh, the "x" in "pxd" is a wildcard?
> Except that is not, as it does not match "pte" ;-)

Unfortunately that's the odd one but "pxd" was the closest possible :)

> 
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> >  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
> >  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
> >  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Thanks !

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

