Return-Path: <linuxppc-dev+bounces-18731-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1846F54ADA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:59:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGVf4dRkz2yrT;
	Wed, 25 Mar 2026 03:59:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371594;
	cv=none; b=Gb8eGPMSjgMpX2nBbvEUwcHV7Yfen0KaHr/LD2+QI920MywdkQv8kd08zzKp6zmlSVbKnk9FKpwgeTEtpCMgL9UWhYJcyH44F3nC7T+hFnNCgNKNM9EqfomnSevcod1vaW3wUORMelfOaEqxQVXk3tVfSRg1wxJys9kfLfH70q5shrmlNZlj4bHTTxSah1Gnq+fgjK5LdBtqbklVNRvKVNjWeawU2kMdrLAry/Md8+4+bpsH8knruDRBdLZ8xUbSsYp0VJmWkCcwCljYbyg6DoP3F5UEJcH3L5bUmNr9z48IEPRGNY0AgvkFX0cD/ispSwUbVzuq9OSU+OHpo4x6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371594; c=relaxed/relaxed;
	bh=zeZp8zC8CS65Vocua5eoclRGzsQLhLqvXnUvfy5ofCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VQat1t5llGJILnXVcPL+I7TEepK24+X7m7Qwj6PSNfIs1r9SRzvN1bp3pkyW3lQVRtUhL0Lr4xGLMlw5amBlMA/qY4ovn0vmQ8Xyf9Zl0mrN29uG4ywEoZ+o9LU0DCif0v0wh+3w8HLtln0u73LSdmvLZOsBcft6kD444rXSbMe6nO8sWWKMr/WiJe3gqp+wooH8nX3sZOZca0PGZ0h+iEmG+tD9c9twJyIl2Bcl309DLnDTcUkigZ7RklBrsZ33JvLcfgyYlAq3vE1cA+JkNLrpRKXdD04vabETH5DBQSppRPuKSq1niEBtgATDG+2NnQ8s8VreQaE9zgTMuNkEcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ITmjLgjg; dkim-atps=neutral; spf=pass (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ITmjLgjg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGVd5KGNz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:59:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371594; x=1805907594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1PkvXAZOx3orpMkb8PpUbgz2WR5NIQkeHlnghDGYLjQ=;
  b=ITmjLgjguMCPrAE93iS45eZuXkBZq4YW8Pkx3HuPBG1qmeNDpYP25jSn
   Co9lEou84RDO3tVw5rG2fxFLkPHNXsT3NFOP6U2Uhmmbob0yUTRz+4zkG
   qTlxJ9eGjYrwvQae6J7/olhOHIvwKowgjDr0uCbmMBCn/qpCGHWUjgk/8
   0b/Ucd5SLOz8PXNrM6vcZpUddtO/0+BABGmMeRCzkIuRM/z1G7DP0CgOF
   gogXK7AVbyNGRu3agiCZldnJRyakxsfAyNnxGObkgZet5rlAhJi/oVg7S
   R2wXg1BXr60m7k3uKyBZeqpWc747Typ5sPU9aQbIAp2V946f+yKRWVTBl
   Q==;
X-CSE-ConnectionGUID: ilw5e6INS0anFCEOqThOXA==
X-CSE-MsgGUID: NgnT9anzRUmYcdacvbMsvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79252793"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="79252793"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:52 -0700
X-CSE-ConnectionGUID: lSvW+pYLTSuPFRVG7+1ISg==
X-CSE-MsgGUID: iJA4o6fzRaW9L3ZwLnjXfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="228447959"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:38 -0700
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
Subject: [PATCH 05/10] am68k/PCI: Remove unnecessary second application of align
Date: Tue, 24 Mar 2026 18:56:28 +0200
Message-Id: <20260324165633.4583-6-ilpo.jarvinen@linux.intel.com>
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
 arch/m68k/kernel/pcibios.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
index 1415f6e4e5ce..7e286ee1976b 100644
--- a/arch/m68k/kernel/pcibios.c
+++ b/arch/m68k/kernel/pcibios.c
@@ -36,8 +36,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
 		start = (start + 0x3ff) & ~0x3ff;
 
-	start = (start + align - 1) & ~(align - 1);
-
 	return start;
 }
 
-- 
2.39.5


