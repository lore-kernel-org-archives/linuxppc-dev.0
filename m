Return-Path: <linuxppc-dev+bounces-24714-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF772C4453E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jul 2026 05:54:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5L1J1mgmz2xrL;
	Thu, 23 Jul 2026 15:54:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784786084;
	cv=none; b=c/Va7nc3Ju+/08790anuSv6wR0jO8CxwIuBLguAa3PEnRLSH1Icq/sliOWyRWEplMBsC7dKU+8BLIr2wWWsuSVbi8y0O+mCWYS3VLjxIejUzBGrdo0/J821X+xZZhfiwUxcpYNH0cIzM/XzkUb0Ob8ifum84yyiptL5lG8q0sL+HwrPEuhXSDyjZD5dLVZIfzgBMcumteJuKkU9tq99wD/kTGfMDuKa5NN7E/uu6JXouB2xKvHz5un0bNYBvHCsxUdJW2Wu9wRW3cbLEPgMd02xi7nM26lVkX+BeWyqBLzpfyrO1wjBvkqGxE1tWWa4KQcKuWN/Y29rlgBf8tShMWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784786084; c=relaxed/relaxed;
	bh=aXME5abyiM2FcxO7X1xQmBbHpKRCAC/9uxeBwGv3xMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QF/X1MJYNQONof8YpGJjW8QnFDiCmSLnMKzzi28rj07Y7Cm9Ss7HusdiiNG+oRTZdnyydNh6uB3wq5F1R+eHvyN3JzC2qHB5K0zw7Re4glgGV6n+hm4UAuQOdSauwh9EY7eqOE1wP+qDjGDI+f/j12Bbds9MG7eY2l1L8hLIoPl5NGhgHkqOut9xmAoxZXBnTibqrYkUbLS7X8pXe3+Ho/r24U3kC8p/Fs7g7inCEIVaheF18TqTbW5zkfXwwCJoKxazzHSRofWZ04Fyv4duyvgFaSa4c8OsXZihC5bS8lI97DYu6TOirnMddnc6zs75yjM8V+eF29A0/pk2eng1ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=PGctRurX; dkim-atps=neutral; spf=pass (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=PGctRurX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5L1H0fFvz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2026 15:54:41 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0DD8540E014C;
	Thu, 23 Jul 2026 05:54:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id IfZZW43a_hB5; Thu, 23 Jul 2026 05:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784786065; bh=aXME5abyiM2FcxO7X1xQmBbHpKRCAC/9uxeBwGv3xMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGctRurXJKTEW2YvBriW7lCS7WhfSyajw1bnCuPeviUMT+0x6NagYuptYbij+f3qO
	 UR7nNWjT60I55kQn8KVkEFT4CzS9rsz41VK0vb0OSHPlr1Q0IxxyzlU1dwnPjQ5WSq
	 TFCmrM6hToC17Tyx1eq330KOAW7qrYTrljZ21VFrACkyQj+3wPNHq61G3o06Q4CuHd
	 o0mu93GU04hrXUyF4Py56rx+pf903NOEPrzehmwHVXNQElwcT/L1NabQD4f2ffM5Ot
	 xkHZCBagPv0iQgFYA08v5AVxAubbJSAjb9HudxedE7xjnymAJ2fgTnaXh09qqdkIzy
	 FzVqHf7WtVm1/3pHyazyb4ucJT7tEbj7/5ing2oxJsy8evoc80J1h2KsOWShPwr5VU
	 CwkSU0UMyyk/Z5wtaDe36hPdbpv5MEgIYo9MVCRInwhRspbYqgohoyeCy9nAl5OGL4
	 gJ/bfUGhfZd5QjZZXgYnC+ZjoPQykUzpDqoldn99CrTGjEWIu1xs18IomT0tdKWQEF
	 +KPSt/qEenYZ2ebfhemLbU/wyn9/1x8mZ2/QXFo06RpJvuYNlBlSGJ/+rgQWWiPE7s
	 uLfT/7KPvIalk8nIK5sitbpSX25as+sElMn6NQWSp8lfHlXMJcIapikTjsrE3iEmEd
	 ASmQxBa98HokJ59dcKrjsVE8=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF04D40E00DC;
	Thu, 23 Jul 2026 05:53:50 +0000 (UTC)
Date: Wed, 22 Jul 2026 22:53:47 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ahmed Tiba <ahmed.tiba@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>, Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-cxl@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-doc@vger.kernel.org, Dmitry.Lamerov@arm.com
Subject: Re: [PATCH v7 00/10] ACPI: APEI: share GHES CPER helpers and add DT
 FFH provider
Message-ID: <20260723055347.GHamGsaxesLkMbSnfR@fat_crate.local>
References: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>
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
In-Reply-To: <20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef@arm.com>

On Wed, Jul 08, 2026 at 02:58:59PM +0100, Ahmed Tiba wrote:
> This is v7 of the GHES refactor series. Compared to v6, it addresses
> the Sashiko-reported issues including pre-existing ones and fixes
> the ACPI-disabled cper-x86 build break.
> 
> The DT firmware-first CPER provider is intended for the upstream zena-css
> platform. Validation so far has been on FVP.
> 
> Changes in v7:
> - Address Sashiko-reported issues for this series, including pre-existing ones.

And Sashiko flagged more:

https://sashiko.dev/#/patchset/20260708-topics-ahmtib01-ras_ffh_arm_internal_review-v7-0-8b3a85216cef%40arm.com

I'd leave this to Rafael to decide but I would fix them all first before we go
and carve out things. Maybe we can share the effort and such. I see an EDAC
one which I wanna take a look when I get a chance.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

