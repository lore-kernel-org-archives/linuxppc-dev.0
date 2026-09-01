Return-Path: <linuxppc-dev+bounces-26349-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F3FC61DFD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 02:49:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYr0h4FK3z2yCv;
	Tue, 01 Sep 2026 12:49:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788230948;
	cv=none; b=lnrTXgtip4Rbfpa4FMycqepFWxP/NrPd9u/Vzet+oiyCexivivMIHRIa30qgvCBJt3NdQATEGDu0tQ4WNvIlESLQR8dboATGxcmel3rQEqNu8UGV/oR0aaVFox4tX8PobAX+nDP+rhPJdI+MbJfrlr1msO5YQgzr89EeZfm8ka05Pxc4hl4xmY1q4WLXojQ9c9qd6P0ukpxdyvkm074+QYE+xPRjkGSR+rQDWZ9+uyzwRNWQ5Zb38XWB/bKksBdN11vLnFu07diKXinA/vHduk1oDv7QQrTu0EO9vQuAgB3TK1x6M8+HBy+FdYT5KKEbFsu2iUrgDfcLiXiTpcnG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788230948; c=relaxed/relaxed;
	bh=PIPRUowfHI6K98aTZtO+bijz6IaH7fRlyyv5nHGo4e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euPCcympXSF/WeTNnGrFpRZXVwtOKmfaL8SqnzMLaELFWkDdLHS/wj46n+ZPdWDEwcQELvHEA6dIckpkfOiYOg1ceATd7kPqsWkARuRHjRYs+ws0LBK0J0dTp/40To41AiQjUXtnZYWpZ50ApUtD86GGlC0GNlNt+jdgrfSWgTzqHUDkatD3KItgjGDa44dSsTMgRRmm63b03xblKJopR+a4tYPLI6pSs/6dsWVGTRz575CnxX2UmbRStf9PQsMqcADK8l4A1SQzvrQOpmQM895fmerVfds6JMI5wNwEcamLH4hc6jg4OZbXASC5HAcpOV0/beyDJQPIjrgBH5S7tw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=usDt8rhj; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=usDt8rhj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=anshuman.khandual@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYr0f061pz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 12:49:04 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CD931692;
	Mon, 31 Aug 2026 19:48:28 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5150C3F882;
	Mon, 31 Aug 2026 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788230912; bh=it2TzzIDYTIEJor+n+hAx7Y9VTg7srHvqDHPINLC58w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usDt8rhjPTPyhurOvXc8PdfuSoWH0nYsX72TOilRCeK51T4CARGkosyhwrLBvxyhc
	 l9WrmE/Q4V575jMJywI4lXro08Z3FihKyE+sAH5OZKnsGdk8N6U5ibobJVe6+qJK5R
	 M+KgzpkQ/xqu4+mMb5mvQGSArMljTWloMojjfQx4=
Date: Tue, 1 Sep 2026 08:18:28 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, samuel.holland@sifive.com, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
Message-ID: <44crgg3r7p2d26blmgq2ewqan3anfhdo73zxe52rvpcjsdhdvd@xztk7osntzhf>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831185519.66c6e6e83ce62d0fd9aee945@linux-foundation.org>
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
In-Reply-To: <20260831185519.66c6e6e83ce62d0fd9aee945@linux-foundation.org>

On Mon, Aug 31, 2026 at 06:55:19PM -0700, Andrew Morton wrote:
> On Mon, 31 Aug 2026 11:13:22 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
> > pxd_ERROR() macros have been provided by all platforms, which are very much
> > identical and can be dropped off completely if these pgtable printing could
> > be moved to callers in generic MM aka all pxd_clear_bad().
> > 
> > But first cleanups and re-organizations are required in some platforms that
> > are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> > macros have been completely dropped from the entire tree.
> 
> All was going nicely until...
> 
> > This series is based on v7.3-rc1 after the following patch and has also been
> > built tested on multiple platforms.
> 
> *what* following patch???

The dependency patch has already been merged upstream.

092836fedd82 (mm: standardize printing for pgtable entries)

Please ignore this.

> 
> Oh well, I'll queue it all up and shall hope for the arch maintainer
> acks to roll in.  Please.

Thanks !

