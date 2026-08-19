Return-Path: <linuxppc-dev+bounces-25967-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD4C5DF81
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2026 02:50:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPrdh3cjgz2xxr;
	Wed, 19 Aug 2026 12:50:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787107800;
	cv=none; b=e5ID58FU7BLZ6odWh98kcmin5opowDrefCMb6oIweyvnIH5ltwoivSSkmCAVeE57w/o3ny4cQzQMkQajnSQWklk+4QjbNVLjC5B+JBwO1hYoYYlwHphW8zqoRjhIrmxkswi3HCVAHfsqBSy5t67neda5sUU9lor0zOwYoVZXv7i6YJPmH5JENAgDxX33k30MlM4MTK5atvM/WmqK4EMlFQbW8+dvFizEPwSE6hyWHB5CyCkIG0qtK9q4zOKw2+BxGs67xHfjfq2O926BjrcwlQlvj0xad+uL0UGd3T97eB7pS3emiFPnb8VJyKvn8FIy8xqNwTyMeJ9wdLygcapd0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787107800; c=relaxed/relaxed;
	bh=5mBZvCeN2//ZyvUUsC1lfsgAjSbsE53j1pTePzGlSm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhgCP7MNMhm8A2VxzAI5x7nZ+ZVcFB0McWxediQW0z9ORtInVD5Y5KdZWrJLBhvLEKyNIska4Vru6/dSPiuwoTB4ZuNzJXYnQwwMl/vQuWVHfIIBb+aSX/s0H24XokIE3XRT5/4elBO8k/EoK/S8jO80TghaUN+HF7A1/leIuKunndAZlZ8UD2jrwO6N70RiMoa2ZOvRmEgOR+hcvIvUXaueph/Hyq9nzWWQds6vQHv5D9lLg2Y3c5W/9iqLiA1kKswcLlO7uFy4ZpcC52lnr3c2y/5GjUtkCFut7AeNzJwUFkxrHR6Y8V0UWx4yrqdPqvzOkJI/s/DFzKNRhzuQdA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vJl0n3O7; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=vJl0n3O7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPrdd46HQz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2026 12:49:55 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7DA416A3;
	Tue, 18 Aug 2026 19:49:18 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E01DD3F66F;
	Tue, 18 Aug 2026 19:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787107762; bh=oAq7LZNVfuWLyY8F6bgNDhoqq4F1x7DlAd3a+zTStqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJl0n3O768ihB63yzY/C3psnBKMwgj31m+kzmZIZlkySfUrUB1m+qr/j5JU5c9Afe
	 eXlqYLfwodRGlGGDBoPRCFbNWaxAndC9cqljsF8lDwcjTwNIut2KUoxp62ngsl8nn1
	 zy9caih5g0LTIVBgKUQNdkShhYRX1qD1/PYrFpfg=
Date: Wed, 19 Aug 2026 08:19:19 +0530
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
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
Message-ID: <mc5cbirsrv24mwu4bg35ksxjyzfoydlgewq4tt7uu3ij7f642o@m4w7dm37nmdh>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
 <55d92b3e-ad3f-464f-b2db-a2552353223e@kernel.org>
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
In-Reply-To: <55d92b3e-ad3f-464f-b2db-a2552353223e@kernel.org>

On Tue, Aug 18, 2026 at 07:25:07PM +0200, David Hildenbrand (Arm) wrote:
> On 8/18/26 06:00, Anshuman Khandual wrote:
> > Move ptrval_to_str() inside a header thus making the helper more generally
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
> 
> I would have placed that into include/linux/pgtable.h. Any particular reason for
> mm_types?

Yes - that works as well. These declaration and macros need to be moved inside
#ifndef __ASSEMBLY__ block in include/linux/pgtable.h file. Will do the change
as suggested while dropping the RFC tag once v7.3-rc1 is released.

> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> -- 
> Cheers,
> 
> David

