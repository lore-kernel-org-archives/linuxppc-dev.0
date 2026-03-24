Return-Path: <linuxppc-dev+bounces-18732-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF7EF54ADB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:00:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGVx1Sgwz2yrl;
	Wed, 25 Mar 2026 04:00:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371609;
	cv=none; b=XAcsdubJmns7eu9L+VJL490NZy0st0o3bQocJfvblaNPb3EDOjWiMDEeQJEmSKx57RMvXjXhYxpxxapWIfd1/Q1ULpwX/09ZQacvJZzZPTqQAiiu9o29dc33vZLrhuk93wlramTRZJzWdJIcMAJXvDB/0/vwj5arOnqfGO+bi/r8k62WOxHIYdgiDXVvOz6+fuSwDvSZQ20bT3FONr0UPZeE1tLkkmC2UQTFeBfPEqnMFfC2+DuVYfysaXE1BlRIOa/l4Cx4oetK3kxoWdYLzOvgmZUzYgEwMY19oknijiZW4gLgPXSMD0TPzkMbCf8F3AaulyKLFB0HMVEOH/mZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371609; c=relaxed/relaxed;
	bh=8+Jw00CvTMU1v2XHS+Iv9vE7g3+9u1r52N76fFD2Nsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CtW4bpbQPqBSk5uqzB4Fn5eZ92v20flhp87dcRSAlD/jYQBbnnHnNsLlLbPXoYXYftKGOI5IQ3UDk8WkUUy1mkEgYUYzP/GqLPQLOX4kLthpn4Xt5U+/pnOEAJSle5mmTlnP0thIz6CqggmgXYkpKCA09GqQgcLsiSOY/MaE0HRyaLZ6ri/3BGBgwa+J0NZN4EJ16TMKhFC3rE/WRPK684ul+qvuoXdjXcQReW1goEiFrkIVTyWlMw9eWg9/Ap5GDCCcNvfWONdUf7BgU0Oq3RooWdBDlLVuXoBs2G93iP8BzMXlYIJAetjfwxwJnjfNGVbc1YbB60o0bZdou9FjEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mv0kA5a+; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Mv0kA5a+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGVw2FTBz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 04:00:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371608; x=1805907608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9hvV8PDAdyGkHU10me7VyjfjKt6p0yD22QH58KrfakU=;
  b=Mv0kA5a+PivZj1Nb+A5j/b98XUl9f07yCNIVtj5qF4fI9W5nBTpYYqLl
   bAn8A9OdD3v3R4Q7XqnO+o8jIuTdHTTyuij78lwWTfHKUXWdKzfgb4p+y
   /TRpdb0GzB2jHbjdZ/nVH9anhYh1ngft0ogmwLqX0/RWiexg472OpGt1v
   m7zpl9bWLH5nUeqqzBjUEXB+dKcEEC+8NtrFB+FP1oMDOEFjEAA8EWa8J
   A6CNYsB/+gL1XL9bJRTIp3wO+HKXcDkxeCXWO5DJA0GW2Q7RMYcfTJwFR
   Cr1OZlvTUyBBM+wAj37PWW1OFiBsOM9NlnVG/iX2q6ezGpqIhNYj95IOQ
   w==;
X-CSE-ConnectionGUID: BYFfDvAQRnCuDc11h8ZmDw==
X-CSE-MsgGUID: 3vDBjaMLT+qHi7f0JQByJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75281403"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75281403"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:00:06 -0700
X-CSE-ConnectionGUID: ZabKv/GtRfqHh4rMbY+IrQ==
X-CSE-MsgGUID: KjVhSRgDSkWdd+eayrpYDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219540084"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/10] MIPS: PCI: Remove unnecessary second application of align
Date: Tue, 24 Mar 2026 18:56:29 +0200
Message-Id: <20260324165633.4583-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
References: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Aligning res->start by align inside pcibios_align_resource() is
unnecessary because caller of pcibios_align_resource() is
__find_resource_space() that aligns res->start with align before
calling pcibios_align_resource().

Aligning by align in case of IORESOURCE_IO && start & 0x300 cannot ever
result in changing start either because 0x300 bits would have not
survived the earlier alignment if align was large enough to have an
impact.

Thus, remove the duplicated aligning from pcibios_align_resource().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/mips/pci/pci-generic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index f4957c26efc7..aaa1d6de8bef 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -32,8 +32,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
 
-	start = (start + align - 1) & ~(align - 1);
-
 	host_bridge = pci_find_host_bridge(dev->bus);
 
 	if (host_bridge->align_resource)
-- 
2.39.5


