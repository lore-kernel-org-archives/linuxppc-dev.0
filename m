Return-Path: <linuxppc-dev+bounces-23795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697CEC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 10:14:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwDTp6XY8z2xKh;
	Wed, 08 Jul 2026 20:14:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41b8:202:deb::311:108"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783505662;
	cv=none; b=PtVE4lcnRfiVHfVQ/YZk6MhhIrDancY6k9PZwipkHOKnFoLodTBXGq8UxQdZ6b3HRL08QAYsoh9FpZUnwP/sQtqk4JKU/vKYSLVpvY5m/sD7RT4R2ZosrgvYSFpiE205fJ5EcHoZdcHHbbwQFmy1znF0aPgEOZzF7VNsjRRDQGLC67gEw3l7t7/UU146VSQnm5HoRKtJeuyXKWV6JeQs3XJr+kU68JY1WxkOkI4LjrbPGL7AXucaw29VTMnRLGKj3UvBNxPk2PmRa8B57e9m/EuiRqbWVnNFwemUZ5a3KSrLXDi/Is+/uGX4zBozt7hVuVHhsoKRG+Gk0aRfHJ30kw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783505662; c=relaxed/relaxed;
	bh=4wOH3yStS8TXfgVR4b88fN1bxTz0c2ZSlenUhPGOL+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEVY3zHUmCmWGspkXdhE/Kjti8TvfasfNSwDJPGzA7ZvYr8PCskC3SYELbtMBgREun/8QvVMTwYuvnDtD3sdMETzHI9qQDHLHwf4tZO89wIrP5s+LCN93m8fVWCKeINefZ9YQdZkwFkmcg8lMqiPTmBnibcymaYK5KuInybbYiD8eJ5MyYFlC/PCuxg7q7zKOdeRyjTxxNIGIQWmbxNXyxyTMqaal+uwxkweTi7oqXWV1d/5dcZ6ZVcGp4dbvn3eM35mutCQ3On8QRdJ9R23A6mRCOT5ZlZhIdhesIp32dqvoneVoVfMLWaVSUm3Ik7VMHhgpFDyq2sxf3h8tr0vKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org; dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=L1fi+kSE; dkim-atps=neutral; spf=pass (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org) smtp.mailfrom=debian.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=L1fi+kSE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=debian.org (client-ip=2001:41b8:202:deb::311:108; helo=stravinsky.debian.org; envelope-from=leitao@debian.org; receiver=lists.ozlabs.org)
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwDTn3rnVz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 20:14:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=4wOH3yStS8TXfgVR4b88fN1bxTz0c2ZSlenUhPGOL+k=; b=L1fi+kSEHEUhMjtbF4ZTHL+XA6
	Fn5PamcMh19x/7VKSe9mD70rETYyBL38mG7kBMUxs4XFazpxa1SH9khOyTd8gnx7lVF8FZ1eTmVhe
	oWYUHAeZmF06dvVS1wRlbFXosGGP4Q18dDP9XW1USqLV71/Hf8vnghMUwC4xBVISGPkOkHw/OCA3N
	y8uqmdrdTRT6DtX98s1S2OcgF0qZyWutZ3VQFHqrqAEs75qWLmtf9BhWqSlTcNExLY0uKG06vOFXN
	pYp6+HW9PutjcPhUoDw/zwmex4MZ/cBpbuSESJ44nRbJI7GOgGCHnmtIt5MX2EdiMhgimLPaMHl3+
	qIOiJDcA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whPHK-002sNT-2F;
	Wed, 08 Jul 2026 10:13:18 +0000
Date: Wed, 8 Jul 2026 03:13:11 -0700
From: Breno Leitao <leitao@debian.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Breno Leitao <leitao@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH RFC] RAS: hwerr_tracking: move recoverable hardware error
 tracking out of vmcoreinfo
Message-ID: <ak4ZC5DsKtJv-tpx@gmail.com>
References: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>
 <20260707160247.GBak0jJwNxVHlvzijD@fat_crate.local>
 <ak0sGAX_NWMyeofC@gmail.com>
 <20260707183517.GCak1G5TKyF1ggs8WW@fat_crate.local>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707183517.GCak1G5TKyF1ggs8WW@fat_crate.local>
X-Debian-User: leitao

On Tue, Jul 07, 2026 at 11:35:17AM -0700, Borislav Petkov wrote:
> On Tue, Jul 07, 2026 at 09:53:34AM -0700, Breno Leitao wrote:
> > The current vmcoreinfo implementation defaults to enabled, so I wanted to
> > preserve that behavior to avoid silently removing symbols that existing
> > tools may depend on. Would you prefer a different default?
> 
> You do know Linus' stance on enabling things by default which are not
> ubiquitous, right?

Oh yea, I am familiar with it. :-)

> Logging hw errors in vmcore is really necessary to be enabled everywhere?

I am happy to make it no, if we transform it to a KCONFIG. Right now it
is not a Kconfig, so, it comes with VMCORE set of exported fields.

> > I agree the sysfs exposure duplicates existing infrastructure, points
> > taken. However, tracking fatal hardware errors provides value at crash
> > analysis time—it lets us quickly determine whether a fatal hardware
> > error occurred during the kernel's lifetime, which is useful for
> > root-cause attribution.
> 
> Yes, that's why you put it in vmcore. You can't read sysfs if you encounter
> a fatal hw error.

Ack. Right now it is not tracking fatal error (just recoverable error),
although I think it is a good idea to also track Fatal error (of course
that not on sysfs).

> > For this, would you like to keep it in vmcore info (as of today), or
> > move to RAS subsystem?
> 
> You mean, would I like to pay attention to more patches than now?
>
> Not really - I can barely manage as it is.

Come one Borislav, we need your insights/review/opinions here as well.
:-)

