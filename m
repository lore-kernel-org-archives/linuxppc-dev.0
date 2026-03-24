Return-Path: <linuxppc-dev+bounces-18730-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C18F54ADA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:59:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGVP2fjxz2yr4;
	Wed, 25 Mar 2026 03:59:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371581;
	cv=none; b=KLPbzluKtIJFmeKoMWBFRnYwy+JnMJTx0VQuu0O5gma2cnweWaW51cE2aIkrNFko9DMf0aNNei/Xu10K+gVjiKsul6h+SpA3ktj9UOHBKoOb7xT/tjfAwyetfA4c/A/x7qFCd8JJxaO8XqiDABEl6JvlNlpappS/VP32Krj7OCIMA65i2Jb3g22BE4ARQDSfa18BXz5k/qVp5A/e4BG6XkBr+6jfzDTID0ZFjbrLtWM/SyctIycXCF7MKz54Q9PJESJgKlBqFsp6bhcLtxjBCElN+/LG+t7h6ugkvnm2UllN+vxDbcJvh37LeGLYwkThaNNf9HGIQatM5vCXqTan9g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371581; c=relaxed/relaxed;
	bh=pJDNoTaGftVFib8voNKcZV7M81zwjnGP3NBshahnzuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcOTcz/y/8R/db7D9QepSo6JNUCf9foEcZgVbnDRZd2rg7v0cxFa5PtOq1SWPbOEDzdEvEHGUjjuxJdTDsdqfTZriIiYVNIhnKuabLG/X/QThzwtmpGtebrDXa3zGt/L6cNCkfmZYSn/mf8Q4z2duRPvCFThJiCO2Ne6ceMj7nuYjyUHWy2VHdUefy77GEUYqeJXW01BKoU7HdYl32ZosQCeLS/E8LI+eWpG2DzfB+HB3yOSEptsisPP5Hs+CWMzGJroHtFg+0LNKhYyLX35Vh3zcr88BVNgvJMa9Ehf9TahUltlO+KKvtJvsyDPNyMz8n83xw6vtPyKSbEHn9K5Yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EMONrTqb; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EMONrTqb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGVN2ky7z2yng
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:59:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371581; x=1805907581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQi+TnP6KS0Xel2L1NUm1zOxuJkTQw+HXZFhNST/QpA=;
  b=EMONrTqb3oqMvXPEdYqJ5zFOYtB36f2finEMG6El6pyyQbL3wYKefgZX
   BmN6NLHEVKH6nm3cqKYZ+x6lun7CXI5Ob0iVzfzfU0AWlMQyAGr/nsxnW
   w50HkIwObFdI7pTgF0fJqjB19QPHYkqaAbwB/IkzNjkZ1B3T7H+BWpH4J
   5Tws7CRX95WqGQp0BT0Jjq035n4gFSNjgZojTS1FV/4dSroa2zGRLLtut
   r7WXpOGhUpiWCeDk2nD/0joYsknGgw3hWaz/iZrKM8HsooKkr23/ve1DK
   Hq3atHBQC2LCFvRHQyD1d7xWTjZJMuRukglN3IqrZqD6vwEgwQUE/ojne
   w==;
X-CSE-ConnectionGUID: ZoaOHmFCSx+t5QXCOskxUw==
X-CSE-MsgGUID: wuE9EltOTESk6SNXjPVDgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79252750"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79252750"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:34 -0700
X-CSE-ConnectionGUID: bklkz5swSMGrpU/gEbGm9Q==
X-CSE-MsgGUID: DjRzhFV5Q9qVW8oMHuNG1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228447839"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:22 -0700
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
Subject: [PATCH 04/10] ARM/PCI: Remove unnecessary second application of align
Date: Tue, 24 Mar 2026 18:56:27 +0200
Message-Id: <20260324165633.4583-5-ilpo.jarvinen@linux.intel.com>
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
 arch/arm/kernel/bios32.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 5b9b4fcd0e54..cedb83a85dd9 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -571,8 +571,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if (res->flags & IORESOURCE_IO && start & 0x300)
 		start = (start + 0x3ff) & ~0x3ff;
 
-	start = (start + align - 1) & ~(align - 1);
-
 	host_bridge = pci_find_host_bridge(dev->bus);
 
 	if (host_bridge->align_resource)
-- 
2.39.5


