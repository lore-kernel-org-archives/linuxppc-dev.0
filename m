Return-Path: <linuxppc-dev+bounces-24529-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CC7C4452D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 19:05:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3qht6XlCz2ySN;
	Tue, 21 Jul 2026 05:05:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784574318;
	cv=none; b=AO4PiSiKCWmSZQO4dnCEJP7QVenx8661l2RQj+5EOh1ipxGYHybYocU8OsK0NAeg7l7hpvdsdjUR3+uji+lP1VvM0SouHErIH1hBd1HRPLdndXZQmd12dLZYY611kibYQuuPsR6caehx99Zh26PcQL015NZ2tz+Qd7trCrABs5W3l5PzhwXJs6X8U3vmLpdDzIxL6eTXSVKUmWKFNfQWGRtOEOgv0zXDdopt66Xg1ZOPDC+9yfDJsHRVcuK205YTSkFKEI6pzM3OuletUFnsjMWQgsOICR4nnkp90GCADCB0CLMSCM+uH2FrV3vYE6Ju64C8aJTvc5cucb1OTrZVPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784574318; c=relaxed/relaxed;
	bh=kPMaiKQm/Lrn2+15jJw1Tz84+egEdnjBHflNkHpDaxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVFJkHySOzp+d03g/QldnhKrqlzkrWYKBfmRVmIH6830DU3T/t3flQq6l9Ulrem8I/sE0mrJ623GAZGzYpOmhYaTXuTCbcngmwjTDYHsUaa0gR0Jm/paZSZ616GZsMi/wtwAjvEsMuvTrmFCRHhtPbN/dWpbmSpaN8TG9IJvIb8jU7q3IEyGYJbGSPtEPZ6wyfbtxvQIPwcEteWlHAErVYvoCdzLFj35zgJIwnxMGNtuAL41rrqmui+KUZS0zseYSTso8Ak6MC6weSG8A0GlwLQwK9lQndmlnqC+iqXNL+734cDDVmJyjwWTiLnv8W92V9FGeS1FjUltDEUz3Bo4yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XgHM4gUC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=vishal.moola@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XgHM4gUC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=vishal.moola@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3qhs2S08z2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 05:05:16 +1000 (AEST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2ceae1ed204so84113055ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784574313; x=1785179113; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kPMaiKQm/Lrn2+15jJw1Tz84+egEdnjBHflNkHpDaxg=;
        b=XgHM4gUCtXEepCYa4RkEpI4Bx1zGfCHTNIwiK4J14313b+rF4ydoq5kZqvQSVoojr0
         dH8J9hU49tiDxLZWjNC9sQvcBGCsv8CwCExzMi05d8dIrzswmOUT31MNNwYiMqa71OUe
         Qfbl8Dq/0H/AudRtzvVYCOVc2Tlfey1Bhv5GxYy9oadtsjyBB+4MkvLmZ9mjptKmxj7v
         EEEbRGDfaD27NMBHb4q+Yyjc4IcuCflSAFuE0817G4Iu11YTuyLU4l/2SR/aLxUDiUc1
         7IpRx5xF/uOSNUiQWDTTCWoo2HbI0Bs/5G5Y/8AuNNZGRSx7caGD2D4yx+NmcTVT+155
         RGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784574313; x=1785179113;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kPMaiKQm/Lrn2+15jJw1Tz84+egEdnjBHflNkHpDaxg=;
        b=i7dtZX0UnTReFD7TV7/RIkUk+7VzdloSY/XeMtJXixeBfSxj9XrGzGvQ6L3Xsx4NeR
         OWkEMeNvg4OqCTGUiEnp4e/Neu32rstLgJ+ebeUEFtQaPcn25lOBczPhvmkSvwn129yW
         Irq/w+ctRwIld37JPjq5qlhDqrUeyo75vWzfAhhGgEbz54JB80/JeHcDeYaO+GoUlWOL
         UWLNlER1DmtN5/Rhb7MSCiZmUhCRvodZ1RXSwUYj95PC47VSkMQMUE5PEaqptd98NM3c
         i/f2ESwoSvNGK6O+cvP6GXXEPG8Fk7ebeDzX3mWLG4ULPXLW/nBKEBUYrg6Oa0m5/a8K
         oiDA==
X-Forwarded-Encrypted: i=1; AHgh+Rp+oJxTJRDqlJwjk4QTqpAtBkLYwnld4S2laLLCyNw7kizTK5n6Myb+PJ94AwSKDwxO6JJB7TAQrEOkm4g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzm+S9KDHsHi3isMvzfi1ktu93x3QqmKfN7d/PFOrqsXS0ySXg6
	de5uOIUYw+hNvmeFYi39jXTLrwtxqiAWa5ZW1pTrLhAvtEoKqc5P/er5
X-Gm-Gg: AR+sD11j5H9lkH6E5pelSfAMxcg1i7yPk8ev2S8n2cvK+YWZMS8CZJZwuRVwW4+V6g9
	sEZ1h2LyacnTpuBfDp3z83iUu1M6HR55zSHHsMpKGo7+UaEu8gWlCsafnoERhCw6/jiV6zNzfZJ
	LpBqFuIMX+r3OKzsdVJ7oqWfayyVlY6FP6hLSQyfHwBSZL3FWvwKLeTLnQfgJx09yDlRrrdCShU
	sYnrNjG3koftqGbJ/lAmO6f/1k4ibsBJfYtm97MaIEO9rzLH8WjzwlIMBYNKcGqwnV/U6u5FDY+
	yyratANhGXSIqPXQKNzZAwBmb38L7TPE5ITPBMUfhmyDWZp37Q6ZIlGBFAAAclIyqRrF7MBu5oM
	h4Jdwuep5vUFbUsxB80P7e7A6ND3Yrvpnmy0m+/wJGBU6iQQEObSkDTN2RhzuU5oPdvitQQ8auN
	euseVQGgR2NzkYX87V3MTxIYSgVYwHk0n2Bw==
X-Received: by 2002:a17:902:f681:b0:2ca:3e3f:4956 with SMTP id d9443c01a7336-2cf34a35445mr164591015ad.44.1784574312756;
        Mon, 20 Jul 2026 12:05:12 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448f73esm60735085ad.16.2026.07.20.12.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:05:11 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:05:08 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ning Sun <ning.sun@intel.com>, x86@kernel.org,
	tboot-devel@lists.sourceforge.net, Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 14/22] mm: set page table page type when allocated
Message-ID: <al5xZHiFwatn518I@fedora>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
 <alZSwAM4pwmMOeaD@fedora>
 <f3afa5df-73f3-49da-87a6-d75eb5f3610f@arm.com>
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
In-Reply-To: <f3afa5df-73f3-49da-87a6-d75eb5f3610f@arm.com>

On Thu, Jul 16, 2026 at 11:49:31AM +0200, Kevin Brodsky wrote:
> On 14/07/2026 17:16, Vishal Moola wrote:
> > On Tue, Jul 14, 2026 at 03:04:03PM +0100, Kevin Brodsky wrote:
> >> As a step towards removing pagetable ctor/dtor calls for kernel
> >> mm's, move the page type updates from the ctor/dtor to
> >> pagetable_{alloc,free}.
> > Thanks for doing this patchset.
> 
> Thanks for suggesting it :) It's turning out to be quite a bit more
> involved than I expected though! (There are multiple cases where we call
> the ctor/dtor without using pagetable_{alloc,free}, see my reply to the
> cover letter.)
> 
> > We should switch over from __folio_set_pgtable() to __SetPagePgtable()
> > in this patch. Ptdescs and folios should be treated as distinctly
> > independent of each other.
> 
> I sure remember the previous discussion, but my reading of your comments
> [1] is that we cannot really change this as long as pagetable_alloc()
> can be called with order > 0, right? Multiple archs still rely on that.

Kinda...

The concern was about callers accessing tail pages directly for that
information. Using the folio API ensures that we always look into the
head page.

Since we're now doing it at allocation time, we know we always have the
head page, so it's fine.

The dtor/free should be more questionable because the underlying api
uses virt_to_page() which could look at a tail page... oopsie. I
haven't seen any reports tied to it so its probably fine (the
setting/clearing has been using the folio API since ptdescs).

We can say thats a happy accident that makes distinguishing ptdescs
and folios easier :)

> > Eventually, we want to replace the memcg accounting as well, but
> > there's no existing API for that right now. Lets leave that as is for
> > now; this patchset is big enough already ;)
> 
> Yep, looks like there was an attempt to improve this but it had to be
> reverted [2].
> 
> - Kevin
> 
> [1] https://lore.kernel.org/all/aha321ndGSdReBJR@fedora/
> [2]
> https://lore.kernel.org/all/20260225002434.2953895-1-axelrasmussen@google.com/
> 

