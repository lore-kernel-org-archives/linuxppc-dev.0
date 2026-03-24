Return-Path: <linuxppc-dev+bounces-18733-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AEEF54ADB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:00:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGWB2Tc0z2ytV;
	Wed, 25 Mar 2026 04:00:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371622;
	cv=none; b=BXvFcK+m7b0pDjmx4cJ/RQilePcEDPXkbux7MykGxe1DnWDaZv7c4lifuslDJide7nEs/vmRS5PkA0FSYauC2JcFwDp8QtlN5iRjCwZw2F5qL/0Jn4z2hbieooVBU4fhjI+GkELrq3xndp+ZAad3d8icSQbg6V5nLjsGgsp6fyoZ8su5xkqVEUD6RVyQAXG3lZAH00rt9vee87GjGgKq5pnI94WWpah0bLJSlAimlUyFWtOqtYdhyP8lFbai//VuQdeOPFCSVrWHWM2WW/BXD+Ll9KeJfReiEHb1l33kEEtYGYHKneF3YkxuG376qtqUvDyensOY7JFh7VKQXNdBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371622; c=relaxed/relaxed;
	bh=Xpg1OOHH7W5XsLN+rucSM2WsyuBL1ulEamOIabJEn3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhUkW8XLzo648EViEgaGSfbEhufA46gWKFUWyFdJrxyr2FcB5XwXFbY9Z51jc+q6a/bx224+yz7IHrCoiFr4QeTCDpW+zPIzOMcUjnaQiSzYOG4Un4YStOP7cTM2UPIbaysCMWkr/RyMMwhkioUZ/39QFsGjqbvvPiRnjJejFOS1BGgnMb/IGzB6yCBkQ1/JFkaegikl2XddbuYbqhUJUUp7gyr2UJr7uKgYa0lmr46qmdUIloINZk0hNpqWmMfTOxilis4nLp/KGopb/3xRCafLt0APV6LSKOcT90yoros4TGMv/c8TOc7DO59PKtX2ppWWQl1/A5IYyqavrLLeVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+zuEiYA; dkim-atps=neutral; spf=pass (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=L+zuEiYA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGW86g1dz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 04:00:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371621; x=1805907621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d6KLxSDgRcKiLzDY+NMiMRY2jmIC2rw/9NmZTIuAx/o=;
  b=L+zuEiYAh5L+fX4jmY1MRMkSQKykixIPFGPFhgnwtIChw4Q5YR8fH7cX
   r27dP5b65FhHWJPdRviW1nufFE2fuVTHAzwPawRSMsz8vvQ7Fnhl4dWIU
   pvtptBp6jjJqyjdxEUfOI90SpcqItjUGAr9x2kYjitq/hl5uTegD6zXmW
   QLyZP0LU27PLk7/M3FY6cxRaukG1SDTD2eK4zkyud9ap1wEqbE6p3Suuf
   ZNXAkKgkohWhIisqe8BQ7NCFShVMlyZrFvyjMZQ8rET+qrryVnlJYtC3X
   eM9sn36/I+1QxYlQUN+pR25Uk/UPH16cXhVXPSKiD6tWKlZgIzPUOonip
   g==;
X-CSE-ConnectionGUID: 1k5XyRFjQCCxgR6tC3Lb3Q==
X-CSE-MsgGUID: eYQTcFxETLa1E7ZnBVGxDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75281424"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75281424"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:00:18 -0700
X-CSE-ConnectionGUID: ib4xzWKRSNm/cm3wyP1vbg==
X-CSE-MsgGUID: WCv5QcPyT7OGGuY23A4d9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="219540242"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:00:10 -0700
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
Subject: [PATCH 07/10] parisc/PCI: Cleanup align handling
Date: Tue, 24 Mar 2026 18:56:30 +0200
Message-Id: <20260324165633.4583-8-ilpo.jarvinen@linux.intel.com>
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

Caller of pcibios_align_resource() (__find_resource_space()) already
aligns the start address by 'alignment' so aligning is only necessary
if align > alignment.

Change also to use ALIGN() instead of open-coding.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/parisc/kernel/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index f99b20795d5a..f50be1a63c4c 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -8,6 +8,7 @@
  * Copyright (C) 1999-2001 Hewlett-Packard Company
  * Copyright (C) 1999-2001 Grant Grundler
  */
+#include <linux/align.h>
 #include <linux/eisa.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -200,7 +201,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t alignment)
 {
-	resource_size_t mask, align, start = res->start;
+	resource_size_t align, start = res->start;
 
 	DBG_RES("pcibios_align_resource(%s, (%p) [%lx,%lx]/%x, 0x%lx, 0x%lx)\n",
 		pci_name(((struct pci_dev *) data)),
@@ -209,11 +210,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 
 	/* If it's not IO, then it's gotta be MEM */
 	align = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
-
-	/* Align to largest of MIN or input size */
-	mask = max(alignment, align) - 1;
-	start += mask;
-	start &= ~mask;
+	if (align > alignment)
+		start = ALIGN(start, align);
 
 	return start;
 }
-- 
2.39.5


