Return-Path: <linuxppc-dev+bounces-18729-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B44F54ADC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:59:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGV00ZzFz2ynn;
	Wed, 25 Mar 2026 03:59:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371560;
	cv=none; b=LecH4jKg2vUvZtkKgeAcAJlgkwoo4UhQlihQ2FdT/EQ0TDf0Yqh70YFEWQd/H6j4oueCkSz8zAMUyno2Na1v7uBZhuzs+4AHCdpc3m6Fj4jMRjEzuT/oL1qDNs1BAbPmbUxOT8Aug//q+2y5DYT+Zli2tRTYlAkBmVihj0glqpEsOZv61DTHhQAfpmIiTDp7do0KJzxnewDklH4unq7YYTm6kSzFuu//ASpTIvjV1e734JWjXQjQuYcVLacbR81U4s/0UxG1CoszHc16yyk3WPJ6eGFcWV9vhk7EIxP9q4LT9aLbQY8cOpN9MXefe0MvA2fGCM9IaBAVHa1X6LdMjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371560; c=relaxed/relaxed;
	bh=TtPJfOS6ybRUYylo/bLt96EKp7yLEhb5rsHoucJB9QI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ff8mfLr0uYgYJPx6U34QKkvyhgrka+GtaV1zn3FxEvPOsUbKjqz1YfjeROlaMG8KFclrOk/QqOSA4GyBruSo5yccMU1P9znr6D9uZwFl1/Y1kXaTAZ1DvL/Hh0UbuFhxpoGMw3V/QAieTZIMe8EsfFTR4ntmnSzTy/k1iUhPUXuI3nUgxdKVzzzkUPdOHYmzgvx5QRM5HgP2w/jLY1nKoF1yZj4322+w+qJrvZpdMIxXnycegAZv47SFj5E/+ABx2K5bIPnSw0Q8TV9gnVtpZWmbpjOiKvMDa+6qe9pfqL/Q0Na711Ogl/HVSx0Cu7ZCZmSDVmy3PcRtK+P1BBkoxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V/8ZH+Ba; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=V/8ZH+Ba;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGTz121rz2yng
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:59:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371559; x=1805907559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4wZaEWcRmOK6fFyQu8mcl48M7LLtMpZtBEYXsd1Cc4E=;
  b=V/8ZH+BaDVsbPovTcc/Poq/kTAzFx1IveeVlLF9Ak7MHlAyBmfRr/cqV
   ZH9i4dW4dt11ieyFkZ0oUsJXaZELg1r+VZsEFnx/zGKanvPq/tTKUoSo9
   StIC3UYTiT5wd14tjffT4E5Q/9lhF+BknUVe02I4QvZHh7Y8ua08pGMyD
   25nanBMe5wdZm+54Tq9Y/ovfQULO4pE9WbBbv2W7m6WRyydjvvHSqjKF8
   fh2z6s1NMB4LaJv3aHwk+HGYWwAZhNYgNywD6efqflFOdFyy4W3kKL/A3
   EZzUEmpYnmtKthffdSWLx3Rw4Ald+fuJk0K2iJ5TB63DFY3e7EvCIyUK3
   A==;
X-CSE-ConnectionGUID: fSQ1PLQbRB2h3GEzzLrrFA==
X-CSE-MsgGUID: NdKpZY4ZTFOxPeQG2cmFQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86471768"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86471768"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:17 -0700
X-CSE-ConnectionGUID: b26LCQzsTZi2fIETMNneag==
X-CSE-MsgGUID: WA0Ub946SXOBfg0OV/eeeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224666273"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:07 -0700
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
Subject: [PATCH 03/10] resource: Rename 'tmp' variable to 'full_avail'
Date: Tue, 24 Mar 2026 18:56:26 +0200
Message-Id: <20260324165633.4583-4-ilpo.jarvinen@linux.intel.com>
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

__find_resource_space() has variable called 'tmp'. Rename it to
'full_avail' to better indicate its purpose.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 kernel/resource.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 1b8d3101bdc6..8c5fcb30fc33 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -727,39 +727,39 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 				 struct resource_constraint *constraint)
 {
 	struct resource *this = root->child;
-	struct resource tmp = *new, avail, alloc;
+	struct resource full_avail = *new, avail, alloc;
 	resource_alignf alignf = constraint->alignf;
 
-	tmp.start = root->start;
+	full_avail.start = root->start;
 	/*
 	 * Skip past an allocated resource that starts at 0, since the assignment
-	 * of this->start - 1 to tmp->end below would cause an underflow.
+	 * of this->start - 1 to full_avail->end below would cause an underflow.
 	 */
 	if (this && this->start == root->start) {
-		tmp.start = (this == old) ? old->start : this->end + 1;
+		full_avail.start = (this == old) ? old->start : this->end + 1;
 		this = this->sibling;
 	}
 	for(;;) {
 		if (this)
-			tmp.end = (this == old) ?  this->end : this->start - 1;
+			full_avail.end = (this == old) ?  this->end : this->start - 1;
 		else
-			tmp.end = root->end;
+			full_avail.end = root->end;
 
-		if (tmp.end < tmp.start)
+		if (full_avail.end < full_avail.start)
 			goto next;
 
-		resource_clip(&tmp, constraint->min, constraint->max);
-		arch_remove_reservations(&tmp);
+		resource_clip(&full_avail, constraint->min, constraint->max);
+		arch_remove_reservations(&full_avail);
 
 		/* Check for overflow after ALIGN() */
-		avail.start = ALIGN(tmp.start, constraint->align);
-		avail.end = tmp.end;
+		avail.start = ALIGN(full_avail.start, constraint->align);
+		avail.end = full_avail.end;
 		avail.flags = new->flags;
-		if (avail.start >= tmp.start) {
+		if (avail.start >= full_avail.start) {
 			alloc.flags = avail.flags;
 			if (alignf) {
 				alloc.start = alignf(constraint->alignf_data,
-						     &avail, &tmp,
+						     &avail, &full_avail,
 						     size, constraint->align);
 			} else {
 				alloc.start = avail.start;
@@ -777,7 +777,7 @@ next:		if (!this || this->end == root->end)
 			break;
 
 		if (this != old)
-			tmp.start = this->end + 1;
+			full_avail.start = this->end + 1;
 		this = this->sibling;
 	}
 	return -EBUSY;
-- 
2.39.5


