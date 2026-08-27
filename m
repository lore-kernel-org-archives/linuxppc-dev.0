Return-Path: <linuxppc-dev+bounces-26129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882CCC61DB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 06:07:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVrdQ4sjsz2xwN;
	Thu, 27 Aug 2026 16:07:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787810826;
	cv=none; b=iFPUDbTIn78ZFbf50O5X0Z9pQEo7+FssK/+JgpuFke+yyAvWLwtlL5LiOZeCGpuZsWV9CLOR4+DmVT+hX2HaNjhglkSKxDIjPbKQ1xCzKPGBfbtpg1GnDmUclF/AgLLUIysh49eIq6XSXxbmO2JpSHNpMp9GZ/UvmDn0d1ZODOBaKJ4iJK0P1s+kbOg9rN/Y5QDd6DHC6D/SoW8VCRcsMW0H8l1ZKLNlna7r8eRX7ywIucuxh6wPepbqDksgTYHrnNhHe+8m087htWlN9asoQBPgKIhw3Olev3MpSdcQ3kHzc0ZtnYdHMQhuqAYoxz6F8TK3zre9Fk5sW6buXdww4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787810826; c=relaxed/relaxed;
	bh=QFqSOaKx9Xi2yFDGQqxuznFOFvbkTjJnP1Uaos7GH1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsVqqBWZT7QYy20MMv10VaBA17i8+qD70G5zQWp9pG3l7xpkglyK0u2RzMSR7c9d00BggCbaI7pTJsgp2AWQOlBTnjF9gRw/jDRCnwqP1lEDTKII3/DqTh27cASievjfqU28A5I7Dg+bL1UfV//41cJGL1dcN+ylPTqKQh9HB4Ocp/AMM4GBSN17FlUHv2o+g8ANU+15wpAzjcqlveDw5EIl0QfcK2gGWFMdvpx0cwfAWvhyAwT9YkXdCvEYOglBdlefGfl8wrWu8+i44qRc7AVLo1IceEXZnFNg+JL0puMM2el5sYODwTDoLO5ikCq1KPhUYEOVRFUtERNomD2muA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=atxvd2MB; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=atxvd2MB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVrdP3Nycz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 16:07:04 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 343D01691;
	Wed, 26 Aug 2026 23:06:29 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46D2D3F85F;
	Wed, 26 Aug 2026 23:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787810793; bh=4MEVYAYSJL4cEovvPaUuVnqFB51awZSJxYddF6SWzro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=atxvd2MBYeFEkKGg88c3L5GRhXIVBg8ao3BgsUAsWkYA7ds0RiLYyyyMKGlCqEe4v
	 MOEpEcQqGd8VjOnqn4rLw1NEKggOUfl9biN2Je1oGa1rmznEcLbhjXu1/IkCtDfkV+
	 TlSm0YogFKVAPwPubmvtzGJxMq025DHHeIV/tBH0=
Date: Thu, 27 Aug 2026 11:36:29 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
Message-ID: <xj6w5re27lbtih3lxksk2jxv6kvnpek25urjjcoobwj5pgfqtr@z5loauvsw3jj>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
 <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>
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
In-Reply-To: <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>

On Mon, Aug 24, 2026 at 10:45:09AM -0500, Samuel Holland wrote:
> On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> > Move ptrval_to_str() inside a header thus making the helper more generally
> 
> Typo here and in subject: ptrval -> ptval

Fixed.

> 
> > available for new users which are being added later. While here, also move
> > another related string size macro PTVAL_STR_MAX inside the header as well.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@kernel.org>
> > Cc: Lorenzo Stoakes <ljs@kernel.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >  include/linux/mm_types.h | 15 +++++++++++++++
> >  mm/memory.c              | 16 ++--------------
> >  2 files changed, 17 insertions(+), 14 deletions(-)
> > 
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index b18c2b2e7d2c..a5b514e55dd7 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
> >  	return flags & MMF_INIT_LEGACY_MASK;
> >  }
> >  
> > +void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
> > +
> > +#define ptval_to_str(buf, val)								\
> >...

