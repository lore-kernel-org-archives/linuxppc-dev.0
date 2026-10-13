Return-Path: <linuxppc-dev+bounces-29367-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB23CCC6B03
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Oct 2026 13:11:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3vqv1LTWz3brM;
	Wed, 14 Oct 2026 00:11:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791897115;
	cv=none; b=aOplzaxgTg+k+gYGGAJnX8vvpqmCR+kME5XybCgHyES4qYf16nsNgQPftgwoTiqYLDGJAOohjUIoUUIxHUF2qM/0HTy8aLNdi9rp89iXjC3aoBRtthcdIZC3mD0LnQz72IIyKYRt+DOg7vDEDM4sW2wSFkLalQtVi9aPCMn1ADZc1ZAznUbb8OizgmIRfneV0N2b76Qu9tJCfT1qKvS/ptwTxpeahy18zRoaHDjzcsY7IJDn5xbW47/CgoUH/jmmSudl4rXJJHIWz/K6SK5NPo4MmE8qaLdG8JJygFsSc5FUPMZbm/hJQoBigzrnS2wlo6zbkzwaPYHIvZdiYeDupw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791897115; c=relaxed/relaxed;
	bh=vvSFuBpCg9MUQEEmYe5mt1ze+jBGKsiIknmpVEscHf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZxqnUas7tyMLeJYUgnTldZK4k9oCsaiEILiYeLaOUE2P3Tpxua7FW0N1yxrH22vkCXmXsvqrK4KBgqiMv8wS2hw3WI3Er+7VQRKxeFi4uMkmK905Nf7LwkW6WctIHECfy88qur9GA348yTd5UmSTrTKDBjwwVuHG8zStQM7tc118fHLP6J8imZ/cnjGWkQ9g+Ptcek39oPAfNUKapDMycceDqBrXEJki+TuPIE6FDXYbVI077j7C1wYkUk1PeOp/dyilQsDtd66pAidVs8aXksNxqFYrk0RnxyVlc+kaSLEyHzzlJlOEJULMtq3TPShKOg5pChjdqo0WOuhVdvkAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LIe9Ufn3; dkim-atps=neutral; spf=pass (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LIe9Ufn3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 66 seconds by postgrey-1.37 at boromir; Wed, 14 Oct 2026 00:11:52 AEDT
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3vqr0YRfz30VV
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 00:11:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791897113; x=1823433113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cs5jW56J1YkYHZWz8meTkpKfUi99fHIjVaZV/OzPCeA=;
  b=LIe9Ufn3ayh5x2FoSBUF4uXb31BTXm3Nn+KtXT+KrkbP34iQ4a1zMoDj
   5pluLjsFiQSm/ZUmorF0Y57rKeBBCqy5ldS8LdjggGqLNSAgHTmRLcS7R
   hrrLq3di7rpOysfUqW/iKXs0/gmLiWXTABvigxHUpPLBG5m+kwpA1V3s9
   r0giselvm5/yCESBjTY8VbpEeoW+DIBjJZCukfX8caxapatUYxdytZFSS
   bn8quR83uzOJkawws6SeXX0obrASc9FZJyHY0yDRirQ4gHqOJ2CzisDtI
   VRe8N3f8+PraRHwrNKluCyzIYBFdZdzJ/XX4bSCSmsU2TZ3vTV5/X8VUJ
   g==;
X-CSE-ConnectionGUID: rdaFdaZzQ8Wfpu0PKPTg7g==
X-CSE-MsgGUID: F7L2+ENsSi+F5I4FgCwGxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="630348"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="630348"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:41 -0700
X-CSE-ConnectionGUID: pL5AquSmR9qhmKR9AVg0PQ==
X-CSE-MsgGUID: oyq8mleGQR2zRE/bjkut4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1084983"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 06:10:25 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Nikolas Joshua Britton <nbritton@exabit.io>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	David Airlie <airlied@redhat.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Simona Vetter <simona@ffwll.ch>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: Bradley Morgan <brads@mainlining.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 3/8] PCI: Honor alignment overrides
Date: Tue, 13 Oct 2026 16:09:37 +0300
Message-ID: <20261013130948.6231-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
References: <20261013130948.6231-1-ilpo.jarvinen@linux.intel.com>
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

pci=resource_alignment argument can override the default alignment for
the resource. The remainder code introduced in the commit 9036bd0efcb6
("PCI: Align head space better") can move remainder space (non-aligning
part of the size) before the aligning left edge which results in
violating the requested alignment.

Introduce struct pci_resreq_data to hold device and user-given alignment
to be able to honor it in pci_align_resource(). When user-given alignment
is found, any remainder movement is skipped.

Fixes: 9036bd0efcb6 ("PCI: Align head space better")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/linux-pci/20260923133202.07DF61F000FF@smtp.kernel.org/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

IMO, PPC rigging the user alignment override to enforce arch specific
min alignment is mixing things wrongly. It would be more appropriate
to do arch alignment overrides by overriding pci_resource_alignment().

Jani Nikula <jani.nikula@intel.com> did ack this with a condition that
there is a proper review done by somebody else so I've not yet included
his tag.

---
 arch/alpha/kernel/pci.c          |  3 ++-
 arch/arm/kernel/bios32.c         |  5 +++--
 arch/m68k/kernel/pcibios.c       |  4 ++--
 arch/mips/pci/pci-generic.c      |  5 +++--
 arch/mips/pci/pci-legacy.c       |  5 +++--
 arch/parisc/kernel/pci.c         |  5 +++--
 arch/powerpc/kernel/pci-common.c |  5 +++--
 arch/sh/drivers/pci/pci.c        |  5 +++--
 arch/x86/pci/i386.c              |  5 +++--
 arch/xtensa/kernel/pci.c         |  5 +++--
 drivers/char/agp/intel-gtt.c     |  5 ++++-
 drivers/gpu/drm/i915/i915_gmch.c |  5 +++--
 drivers/pci/pci.c                |  5 +++--
 drivers/pci/setup-res.c          | 19 +++++++++++++------
 include/linux/pci.h              | 32 ++++++++++++++++++++++++++++++--
 15 files changed, 81 insertions(+), 32 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 11df411b1d18..c5d725a9781f 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -128,7 +128,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	struct pci_controller *hose = dev->sysdata;
 	unsigned long alignto;
 	resource_size_t start = res->start;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index ac0e890510da..3e61826f07fb 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -564,7 +564,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 	struct pci_host_bridge *host_bridge;
 
@@ -578,7 +579,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				start, size, align);
 
 	if (res->flags & IORESOURCE_MEM)
-		return pci_align_resource(dev, res, empty_res, size, align);
+		return pci_align_resource(rr, res, empty_res, size, align);
 
 	return start;
 }
diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
index 7a9e60df79c5..3024408412bc 100644
--- a/arch/m68k/kernel/pcibios.c
+++ b/arch/m68k/kernel/pcibios.c
@@ -31,14 +31,14 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
 	resource_size_t start = res->start;
 
 	if ((res->flags & IORESOURCE_IO) && (start & 0x300))
 		start = (start + 0x3ff) & ~0x3ff;
 
 	if (res->flags & IORESOURCE_MEM)
-		return pci_align_resource(dev, res, empty_res, size, align);
+		return pci_align_resource(rr, res, empty_res, size, align);
 
 	return start;
 }
diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index c2e23d0c1d77..7f3ecb91b85b 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -25,7 +25,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       const struct resource *empty_res,
 				       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 	struct pci_host_bridge *host_bridge;
 
@@ -39,7 +40,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				start, size, align);
 
 	if (res->flags & IORESOURCE_MEM)
-		return pci_align_resource(dev, res, empty_res, size, align);
+		return pci_align_resource(rr, res, empty_res, size, align);
 
 	return start;
 }
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index dae6dafdd6e0..82d4b01db64e 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -55,7 +55,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	struct pci_controller *hose = dev->sysdata;
 	resource_size_t start = res->start;
 
@@ -70,7 +71,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 
 		/* Make sure we start at our min on all hoses */
 		if (start < PCIBIOS_MIN_MEM + hose->mem_resource->start)
diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index 96950fe9c2b7..36a3a439f609 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -193,7 +193,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t alignment)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t align, start = res->start;
 
 	pci_dbg(dev, "%pR: pcibios_align_resource(%lx, 0x%llx, 0x%llx)\n",
@@ -205,7 +206,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	if (align > alignment)
 		start = ALIGN(start, align);
 	else
-		start = pci_align_resource(dev, res, empty_res, size, alignment);
+		start = pci_align_resource(rr, res, empty_res, size, alignment);
 
 	return start;
 }
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 4fc52c21fe5d..23594759cfe2 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1131,7 +1131,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
@@ -1140,7 +1141,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 	}
 
 	return start;
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index 878a27a1acfb..279f2770ff4b 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -172,7 +172,8 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	struct pci_channel *hose = dev->sysdata;
 	resource_size_t start = res->start;
 
@@ -186,7 +187,7 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 	}
 
 	return start;
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index e2de26b82940..4178ae4380c2 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -156,7 +156,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
@@ -165,7 +166,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 
 		/* The low 1MB range is reserved for ISA cards */
 		if (start < BIOS_END)
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 305031551136..4e8ad4a3c9fe 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -42,7 +42,8 @@ pcibios_align_resource(void *data, const struct resource *res,
 		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
+	struct pci_dev *dev = rr->dev;
 	resource_size_t start = res->start;
 
 	if (res->flags & IORESOURCE_IO) {
@@ -55,7 +56,7 @@ pcibios_align_resource(void *data, const struct resource *res,
 		if (start & 0x300)
 			start = (start + 0x3ff) & ~0x3ff;
 	} else if (res->flags & IORESOURCE_MEM) {
-		start = pci_align_resource(dev, res, empty_res, size, align);
+		start = pci_align_resource(rr, res, empty_res, size, align);
 	}
 
 	return start;
diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index bcc26785175d..2214347906a6 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -1038,10 +1038,13 @@ static struct agp_memory *intel_fake_agp_alloc_by_type(size_t pg_count,
 
 static int intel_alloc_chipset_flush_resource(void)
 {
+	struct pci_resreq_data rr;
 	int ret;
+
+	pci_init_pci_resreq_data(&rr, intel_private.bridge_dev);
 	ret = pci_bus_alloc_resource(intel_private.bridge_dev->bus, &intel_private.ifp_resource, PAGE_SIZE,
 				     PAGE_SIZE, PCIBIOS_MIN_MEM, 0,
-				     pcibios_align_resource, intel_private.bridge_dev);
+				     pcibios_align_resource, &rr);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/i915_gmch.c b/drivers/gpu/drm/i915/i915_gmch.c
index b0ef6ef577a3..d35097bebc0f 100644
--- a/drivers/gpu/drm/i915/i915_gmch.c
+++ b/drivers/gpu/drm/i915/i915_gmch.c
@@ -38,6 +38,7 @@ static int mchbar_reg(struct drm_i915_private *i915)
 static int
 intel_alloc_mchbar_resource(struct drm_i915_private *i915)
 {
+	struct pci_resreq_data rr;
 	u32 temp_lo, temp_hi = 0;
 	u64 mchbar_addr;
 	int ret;
@@ -55,12 +56,12 @@ intel_alloc_mchbar_resource(struct drm_i915_private *i915)
 	/* Get some space for it */
 	i915->gmch.mch_res.name = "i915 MCHBAR";
 	i915->gmch.mch_res.flags = IORESOURCE_MEM;
+	pci_init_pci_resreq_data(&rr, i915->gmch.pdev);
 	ret = pci_bus_alloc_resource(i915->gmch.pdev->bus,
 				     &i915->gmch.mch_res,
 				     MCHBAR_SIZE, MCHBAR_SIZE,
 				     PCIBIOS_MIN_MEM,
-				     0, pcibios_align_resource,
-				     i915->gmch.pdev);
+				     0, pcibios_align_resource, &rr);
 	if (ret) {
 		drm_dbg(&i915->drm, "failed bus alloc: %d\n", ret);
 		i915->gmch.mch_res.start = 0;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b2879a6be5f8..1b7a4469c6ca 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6444,8 +6444,8 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
  * RETURNS: Resource alignment if it is specified.
  *          Zero if it is not specified.
  */
-static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
-							bool *resize)
+resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
+						 bool *resize)
 {
 	int align_order, count;
 	resource_size_t align = pcibios_default_alignment();
@@ -6497,6 +6497,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
 	spin_unlock(&resource_alignment_lock);
 	return align;
 }
+EXPORT_SYMBOL_GPL(pci_specified_resource_alignment);
 
 static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 					   resource_size_t align, bool resize)
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 376f09630a4a..441a62807719 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -265,17 +265,21 @@ resource_size_t pci_resource_alignment(const struct pci_dev *dev,
  * before res->start if there's enough free space there. This enables
  * tighter packing for resources.
  */
-resource_size_t pci_align_resource(struct pci_dev *dev,
+resource_size_t pci_align_resource(struct pci_resreq_data *rr,
 				   const struct resource *res,
 				   const struct resource *empty_res,
 				   resource_size_t size,
 				   resource_size_t align)
 {
+	struct pci_dev *dev = rr->dev;
 	resource_size_t remainder, start_addr;
 
 	if (!(res->flags & IORESOURCE_MEM))
 		return res->start;
 
+	if (rr->user_align)
+		return res->start;
+
 	if (IS_ALIGNED(size, align))
 		return res->start;
 
@@ -306,18 +310,21 @@ resource_size_t __weak pcibios_align_resource(void *data,
 					      resource_size_t size,
 					      resource_size_t align)
 {
-	struct pci_dev *dev = data;
+	struct pci_resreq_data *rr = data;
 
-	return pci_align_resource(dev, res, empty_res, size, align);
+	return pci_align_resource(rr, res, empty_res, size, align);
 }
 
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		int resno, resource_size_t size, resource_size_t align)
 {
 	struct resource *res = pci_resource_n(dev, resno);
+	struct pci_resreq_data rr;
 	resource_size_t min;
 	int ret;
 
+	pci_init_pci_resreq_data(&rr, dev);
+
 	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
 	/*
@@ -329,7 +336,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	ret = pci_bus_alloc_resource(bus, res, size, align, min,
 				     IORESOURCE_PREFETCH | IORESOURCE_MEM_64,
-				     pcibios_align_resource, dev);
+				     pcibios_align_resource, &rr);
 	if (ret == 0)
 		return 0;
 
@@ -341,7 +348,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	     (IORESOURCE_PREFETCH | IORESOURCE_MEM_64)) {
 		ret = pci_bus_alloc_resource(bus, res, size, align, min,
 					     IORESOURCE_PREFETCH,
-					     pcibios_align_resource, dev);
+					     pcibios_align_resource, &rr);
 		if (ret == 0)
 			return 0;
 	}
@@ -354,7 +361,7 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 	 */
 	if (res->flags & (IORESOURCE_PREFETCH | IORESOURCE_MEM_64))
 		ret = pci_bus_alloc_resource(bus, res, size, align, min, 0,
-					     pcibios_align_resource, dev);
+					     pcibios_align_resource, &rr);
 
 	return ret;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d31a8d107b1e..ea7d75871269 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1217,12 +1217,40 @@ int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 /* Architecture-specific versions may override this (weak) */
 char *pcibios_setup(char *str);
 
-/* Used only when drivers/pci/setup.c is used */
+/* Resource assignment request handling */
+/**
+ * struct pci_resreq_data - Data passed to pcibios_align_resource()
+ * @dev: PCI device
+ * @user_align: User provided alignment override (pci=resource_alignment param)
+ */
+struct pci_resreq_data {
+	struct pci_dev *dev;
+	resource_size_t user_align;
+};
+
+resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
+						 bool *resize);
+/*
+ * TODO: Improve PCI resource assignment interface so that callers outside PCI
+ * core do not need to know about this detail.
+ */
+static inline void pci_init_pci_resreq_data(struct pci_resreq_data *rr,
+					    struct pci_dev *dev)
+{
+	bool user_aligned;
+
+	memset(rr, 0, sizeof(*rr));
+	rr->dev = dev;
+	rr->user_align = pci_specified_resource_alignment(dev, &user_aligned);
+	if (!user_aligned)
+		rr->user_align = 0;
+}
+
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 				       const struct resource *empty_res,
 				       resource_size_t size,
 				       resource_size_t align);
-resource_size_t pci_align_resource(struct pci_dev *dev,
+resource_size_t pci_align_resource(struct pci_resreq_data *rr,
 				   const struct resource *res,
 				   const struct resource *empty_res,
 				   resource_size_t size,
-- 
2.47.3


