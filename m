Return-Path: <linuxppc-dev+bounces-23717-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B842DC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 16:03:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvmHN69bmz2xKh;
	Wed, 08 Jul 2026 02:03:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783440224;
	cv=none; b=WQyVI1XQoVjdJrwtyUZIIh0SHucYcQwPuzKTf6V4TboJwmLal5hCbDdJgcBi5mnwLgR+L7ALuOBE6TMm18xW3nMhE2g2t+tLzuNFzBk6R3Mw/v4SyuyW4RL4BdfBbrKhqWSJpKDsfb7K0Sh0UAdfzt8z7KR382n6+Jg5ijzEXkEleJWWf8nhr1n6lmJtjV/epfLA1JENqEWi9D/0g6JgEwSq38eefD+uzJduiQn6MPcFStTeYCuRMteAtr72b+qL9pRckNiyJqWzEzU4lU2mrcam6L6ZSjhDLguZBJgoa/V/7wFpjB6SCSqWTj6OlpehI4NCBj0EEDIVNQrFCzN/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783440224; c=relaxed/relaxed;
	bh=jrte9NBm4q/rTKQWvpYKzCAl0UD9vv89gYW9jFKzQSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMl2WV/GOpYKrfeHq3RBnbDvCEC4Z1DwEMfSf9nrymA9CI7FXMIo1Mjf3kpXZv0zYz/PTJ2mdzQYuyQr9LkncwMDFE45g5YL3/QFkYgvZXp1RZz4Sf19KaXhS6pn/3q8T1vSWg8cxfQmcHk87Wa5ttyDlzjqkU3aUdh7co+56sa0cLfWpSRERxLrFOyFlR40+P4SKUMUattVHrk9eannO6H6zFhaWEhtNzAlwn/Wz1qsGsPNQdBlsFOi8ojjSyXAYoDj3BYt/OF1oKbwToW7i7bUMnhw/8Gj+DpRNi+FS7tBfV4lJh5M8bKZx454hnjbosfnJS83G3uot6wBMYL6Hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Jb/xOufM; dkim-atps=neutral; spf=pass (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=Jb/xOufM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvmHJ53dXz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 02:03:40 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4349040E0163;
	Tue,  7 Jul 2026 16:03:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2-P6C307Q-uX; Tue,  7 Jul 2026 16:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1783440193; bh=jrte9NBm4q/rTKQWvpYKzCAl0UD9vv89gYW9jFKzQSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jb/xOufMFOk7Oao/xwQ7D8yiHQ9WdFq/cyYxZHK1MZPwfu2BwuMbJt+mSg8/ZA1N0
	 9E9nWtZQuiDAIEp4N0G+SKuaoBKUtsGbOe8wlz7YNcuRYeqB9N67cdLhxkl9ruqlRO
	 tj4Yyj64yAtMiQ48uEyYypEDXeTN855u4K23kRNm4FRzlQ28bbUQ1dlpwxuFwLHJy9
	 hWE+axGnpJL1duMX7YD27MSExgTygbuiT0+gwVLVaQS0ARnKRWZQ/g+K/WWtIxmKxR
	 MaP0BpP4teMNOabPWBrlH1zrXtfFgTJc6BBe6s1ns+W4bX/+RyGaFp/L1tb2ozziS0
	 MFvKGvE6y1/T+OB+n2OnQTqhMff/cJo47U0rINPLUqZGp6KKjSL8FhWiYnhha0w20V
	 Jat053/N3AOuHRP8z/xNLUpBnPa/kJQMj1ckH5oNHyPWnKozujrVcYPvlnLBbcY0R2
	 Q+z4VGk5YfLR25hedq5IQRC/3L9uftfAEbatSMHfTurs9JkQphB5l8XszcHUP2Zao7
	 SBKLFwAZX4rfLx/IB/RSs5bMOVLOpWj7fW1dIBQyUXFKqOBmq6PYlCn07sJorehDqa
	 /wNj2yIzohTrEBVNyv9mPaWkZylYnRBb55IOjYVykkyUljT2d5jKYAToRxnEIj3cMN
	 3c5v724sJ4sAj/lHlaEHVyt8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2166940E00DC;
	Tue,  7 Jul 2026 16:02:50 +0000 (UTC)
Date: Tue, 7 Jul 2026 09:02:47 -0700
From: Borislav Petkov <bp@alien8.de>
To: Breno Leitao <leitao@debian.org>
Cc: Tony Luck <tony.luck@intel.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Breno Leitao <leitao@kernel.org>, linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH RFC] RAS: hwerr_tracking: move recoverable hardware error
 tracking out of vmcoreinfo
Message-ID: <20260707160247.GBak0jJwNxVHlvzijD@fat_crate.local>
References: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>
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
In-Reply-To: <20260707-hwerr-ras-v1-1-4aea4a79d085@debian.org>

On Tue, Jul 07, 2026 at 07:02:34AM -0700, Breno Leitao wrote:
> The recoverable hardware error tracking (hwerr_log_error_type() and the
> hwerr_data[] counters) was added under vmcoreinfo, but it uses none of the
> vmcoreinfo note machinery: hwerr_data[] is a plain global array that crash
> tools read from the vmcore by symbol, like any other global.  Functionally
> it is RAS code, fed only by the hardware error paths (x86 MCE, APEI GHES
> and PCIe AER).
> 
> I wanted to expand it, and Baoquan suggested moving it away from vmcore
> info, which makes sense. [1]
> 
> Move the implementation to drivers/ras/hwerr_tracking.c and the
> declaration (with its no-op stub) to <linux/ras.h>.  Give it a dedicated
> CONFIG_RAS_HWERR (bool, under RAS, default y) rather than riding

Definitely not default y.

> CONFIG_VMCORE_INFO, so it is a first-class RAS feature that can be turned
> off on its own.  The producers now reach hwerr_log_error_type() through
> <linux/ras.h>: x86 MCE and APEI GHES already include it, so drop their
> <linux/vmcore_info.h> include; PCIe AER switches its include from
> <linux/vmcore_info.h> to <linux/ras.h>.
> 
> enum hwerr_error_type stays in <uapi/linux/vmcore.h> as it has been part
> of the UAPI since the feature shipped; <linux/ras.h> includes it from
> there.
> 
> hwerr_data[] keeps its name and layout, so existing crash/drgn recipes
> keep working.  The config gate moves from CONFIG_VMCORE_INFO to
> CONFIG_RAS_HWERR (default y).

Do not explain the WHAT - that's visible from the diff below; explain the WHY.

> Link: https://lore.kernel.org/all/aYvi4Y_HNqk_u1-v@fedora/ [1]
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Once we move it outside of vmcore info, I am planning to add new
> features that are in the limbo now, given they don't belong to vmcore
> info, such as:
> 
> Track fatal hardware errors
> 	https://lore.kernel.org/all/20260617-hwerr-v1-0-ff131cd6203c@debian.org/
> 
> Expose hardware error recovery statistics via sysfs
> 	https://lore.kernel.org/all/20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org/

We already have rasdaemon and a whole pile of infrastructure around reporting
errors. Why isn't what we have, enough?

The stick-the-error-into-vmcore makes sense as a use case, sure. But this
other information we already have plenty. I think you should use/extend that
instead of adding more.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

