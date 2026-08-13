Return-Path: <linuxppc-dev+bounces-25789-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD7EAC5AC67
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:04:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLFDJ68BZz2y1Y;
	Thu, 13 Aug 2026 16:04:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786601040;
	cv=none; b=St+zUlWpCa12Ufe6sBjU+SWj+2FbFDGqC8E1AVciwGTfWoidl0wOnYYCRgqFCv0rbFMVeU/SZhQuhpDQjdpV5vIxwRrTR2r0XrsUx1DTBnNFfNo6tuix1dkVyHuZXROztaH+xlg3U106ReR91w8wqn/NJTq4scbKktoNMSBDgdUML8xkKdYQbZA6vfRXqtHwgLiIohWk1vCOeOuGPGOJHBmX83M5D/p1oVfpKi3L9hUSp/BsxUEC/7KVxJWVdDE6LL632nxIB2ByPYdMRM+5qkyBHPJ5iEeMW95/kOAfCR+Lol1JORBcGpp+Wrj2VfjKp2oDTsmyFvSecV4fddCZ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786601040; c=relaxed/relaxed;
	bh=Ns4GoDNqcj/9AON25YCP9GahdV/I2v0GEJ5Utg1AonY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqBXEfJZLKvvpiItnwk6jUOVdP9Bujq3hpSf/ZbS4E7knQD8EWybrjMDIPF4YwHRhm354iMPxWUbVstHhYcSI4G8/as3F+3UCJk6P4mv0hA9P57KnwlAVKufMG9PTrSYefmtlA2WzWAQUWllnBzmp6/+GswWwG/E6GM1L23XyO8KplyiUKmG1sAlT1wUkSqnCvAjyns0gjv5MENXMwOIT+FQ6D3P95OqWnPnFAE7zT3u/k0qahN71L1NIUDdVEAkBSguW+OK4P/HRJNjmKUJ0EnvMh6lHu4xslmffh+IuX+kLM+wtKHmbRwvN9sjns1jJjzSBwp762pEdnT4Gh6JUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FCmrH71a; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=FCmrH71a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLFDH3JKhz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:03:58 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27767153B;
	Wed, 12 Aug 2026 23:03:23 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B05F3F632;
	Wed, 12 Aug 2026 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786601007; bh=urvzQP14xjouAFJaMxm1KkmF2FK+YkPxtlg+0tmM3dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FCmrH71a8GibDaT/4TzLpR5i+19TJkV8Y7yUEveP9J/tnpZ41lNWsq0jvpmBepdWh
	 3M9emmtusN3STsiD2oIUPfk8jrriw7cyAgWrBFzUsYOHmzUnSzzBNBDES9ShVkwlc0
	 +Kv5zwJCzOVfLHIcWwsl8hCWFk4UC3OStKBDaUuE=
Date: Thu, 13 Aug 2026 11:33:23 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
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
Message-ID: <2ys7apbnfuj3ugfoqgbptgej3jjcyfpmdgbv6qbxupmwg6mefc@h5p33ua2nzlu>
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-7-anshuman.khandual@arm.com>
 <1fb9ed88-67d0-4ac1-878d-0dc8e1135d19@kernel.org>
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
In-Reply-To: <1fb9ed88-67d0-4ac1-878d-0dc8e1135d19@kernel.org>

On Wed, Aug 12, 2026 at 01:33:14PM +0200, David Hildenbrand (Arm) wrote:
> On 8/11/26 06:21, Anshuman Khandual wrote:
> > pxd_ERROR() has been used in generic mm just to print the page table entry
> > in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> > pxd_ERROR() macros have been provided by all platforms which basically did
> > the same thing.
> > 
> > Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> > page table entries thus completely dropping dependency on platform provided
> > pxd_ERROR() macros which can then be dropped off. First move all required
> > helpers in core MM into a header file which could then be used else where.
> > 
> 
> It might make sense to split this patch further up to ease review:
> 
> Patch 1) provide ptval_to_str() a header.
> 
> Patch 2) Stop using pxd_ERROR() and friends in common code, converting to
> pteval_to_str()
> 
> Patch 3) Remove now unused pxd_ERROR() and friends from arch code.

Sure but the intiial platform changes which now use ptval_to_str() as well
will probably come after the Patch (2) but before the Patch (3).

> 
> ...
> > +static inline void
> > +ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
> > +{
> > +	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
> > +		snprintf(buf, buf_size, "overflow");
> > +		return;
> > +	}
> > +
> > +	switch (entry_size) {
> > +	case sizeof(u32):
> > +		snprintf(buf, buf_size, "%08x", *(const u32 *)entry);
> > +		break;
> > +	case sizeof(u64):
> > +		snprintf(buf, buf_size, "%016llx", *(const u64 *)entry);
> > +		break;
> > +#if defined(__SIZEOF_INT128__)
> > +	case sizeof(u128):
> > +		snprintf(buf, buf_size, "%016llx%016llx",
> > +			 (unsigned long long)(*(const u128 *)entry >> 64),
> > +			 (unsigned long long)*(const u128 *)entry);
> > +		break;
> > +#endif
> > +	default:
> > +		snprintf(buf, buf_size, "unsupported");
> > +		break;
> > +	}
> > +}
> 
> Why not leave ptval_bytes_to_hex_str() in the C file for less churn for now?

Agreed - will change.

> 
> -- 
> Cheers,
> 
> David

Thanks for the review.

