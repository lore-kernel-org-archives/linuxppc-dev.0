Return-Path: <linuxppc-dev+bounces-18728-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B089FF54ADC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:59:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGTn2zYXz2ypV;
	Wed, 25 Mar 2026 03:59:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371549;
	cv=none; b=GXUZUeHzxpkljGc12uQIypA1OLzK7SEJllRX1EL9rAFcMEZZjHgV8QFlfAhwJGpYiaNR+auOUnJo+3v8Y8Q8rzCSAD0lLG8cjux76EbC1YAj/BIs84YVHCrGV8tWhs8DTDmr/wL0gSbXW5gtG5aS9+SwsIq2TQ1B7cX/jWNZamLt+Pok7zw3O54m7Z83MenRDmqaS3in7FXzYWq1dGCUR9UJ0Cmpb2IlFhyquNcyQrv8QSjvA3Uz4Xk7o31G+j/t4xLTmgZeX13RYDFjOEJ0RXq/kLXdc1/hDaDqqtvVvKr9PMlWOmeG7zSrfJxYao7TUTrx7KZKYDdJN3eW8TEwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371549; c=relaxed/relaxed;
	bh=Iz+cFKp0cOuPVnSI/ZbHfsfZ1tcuBjhlVwnrvif2J6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h677MahN0aheS0+mI04SZBf7J7Ll53VGetzNysgBo2zkcpSUejf3RpVjqkrHB2geUh6FQeemad4KuYKU+5FrLo08mUehmI4HzgVhP+SrE3jwVLecaGDNurwiG+5liah3uuk3y7MQx1D++QWov23STyD2cSVe1PgIeNUEAExg6k0hRTjnZI6tWk3U/2acEeRYd9e730RvMEi6312Anclni7OvCXye+iRHbI8JNgfmzWxT94XPwgCQHCL80txmiVP2/bZLmobA+YhBHCeXy5w0wzIKd8TDB7rqcSgE9saQspva8IXmq0HiAMn2gYzyApnTFrJMBp6dqJuPGolgHivU5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h/yQw/T6; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=h/yQw/T6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGTm2B6kz2ynv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:59:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371549; x=1805907549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WCR3Q80GUH+QkmAMmzfR2ddGucv9DgzL69WXspRX/jg=;
  b=h/yQw/T6mHLOdAOkWzG/yCdenMlYB1SuK2bOvMk8UzxmdlvwrDT2SCLf
   PM8EV7bwyd/xG+GRyFtX/QuiQi+g03szDjVBuuIB+4iDw1LjXm4SvpD7o
   WLaT1pGaN9LujGHtOGEqda3W4UdcU7s7+dhziRbmqUrd3FLMze5vFQQ7h
   uyjp59TODi1hFeibZ48JyzBFptCYux/6H7XE3yKJaGwLFSYgEkM/AeyLE
   klret5hymD+aaYwjiBSmrUW/7daDY0J5qA9t6+DnB23uh9hyjqjFj/J+1
   YhzfepchKQ3d0kId2atgdTz/Pd+g0mPFv1Ze5igB/tyjIkpi8IckX8Orm
   g==;
X-CSE-ConnectionGUID: VoSECytZSvSbqE12/zrJ6A==
X-CSE-MsgGUID: 15S6ri/XTz6eEgvdqfsfkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86471715"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86471715"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:59:06 -0700
X-CSE-ConnectionGUID: WtnV/loaRsCO4KMKean0ww==
X-CSE-MsgGUID: ZxEF/K58SR25QVPpKDYMzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224666153"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:58:46 -0700
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
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 02/10] resource: Pass full extent of empty space to resource_alignf CB
Date: Tue, 24 Mar 2026 18:56:25 +0200
Message-Id: <20260324165633.4583-3-ilpo.jarvinen@linux.intel.com>
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

__find_resource_space() calculates the full extent of empty space but
only passes the aligned space to resource_alignf callback. In some
situations, the callback may choose take advantage of the free space
before the requested alignment.

Pass the full extent of the calculated empty space to resource_alignf
callback as an additional parameter.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 arch/alpha/kernel/pci.c          | 1 +
 arch/arm/kernel/bios32.c         | 4 +++-
 arch/m68k/kernel/pcibios.c       | 4 +++-
 arch/mips/pci/pci-generic.c      | 3 ++-
 arch/mips/pci/pci-legacy.c       | 1 +
 arch/parisc/kernel/pci.c         | 4 +++-
 arch/powerpc/kernel/pci-common.c | 4 +++-
 arch/s390/pci/pci.c              | 1 +
 arch/sh/drivers/pci/pci.c        | 4 +++-
 arch/x86/pci/i386.c              | 3 ++-
 arch/xtensa/kernel/pci.c         | 1 +
 drivers/pci/setup-res.c          | 3 ++-
 drivers/pcmcia/rsrc_nonstatic.c  | 3 ++-
 include/linux/ioport.h           | 2 ++
 include/linux/pci.h              | 7 ++++---
 kernel/resource.c                | 3 ++-
 16 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/kernel/pci.c b/arch/alpha/kernel/pci.c
index 51a8a4c4572a..11df411b1d18 100644
--- a/arch/alpha/kernel/pci.c
+++ b/arch/alpha/kernel/pci.c
@@ -125,6 +125,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pcibios_fixup_final);
 
 resource_size_t
 pcibios_align_resource(void *data, const struct resource *res,
+		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index b5793e8fbdc1..5b9b4fcd0e54 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -560,7 +560,9 @@ char * __init pcibios_setup(char *str)
  * which might be mirrored at 0x0100-0x03ff..
  */
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
-				resource_size_t size, resource_size_t align)
+				       const struct resource *empty_res,
+				       resource_size_t size,
+				       resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	resource_size_t start = res->start;
diff --git a/arch/m68k/kernel/pcibios.c b/arch/m68k/kernel/pcibios.c
index e6ab3f9ff5d8..1415f6e4e5ce 100644
--- a/arch/m68k/kernel/pcibios.c
+++ b/arch/m68k/kernel/pcibios.c
@@ -27,7 +27,9 @@
  * which might be mirrored at 0x0100-0x03ff..
  */
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
-	resource_size_t size, resource_size_t align)
+				       const struct resource *empty_res,
+				       resource_size_t size,
+				       resource_size_t align)
 {
 	resource_size_t start = res->start;
 
diff --git a/arch/mips/pci/pci-generic.c b/arch/mips/pci/pci-generic.c
index d2d68bac3d25..f4957c26efc7 100644
--- a/arch/mips/pci/pci-generic.c
+++ b/arch/mips/pci/pci-generic.c
@@ -22,7 +22,8 @@
  * which might have be mirrored at 0x0100-0x03ff..
  */
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
-				resource_size_t size, resource_size_t align)
+				       const struct resource *empty_res,
+				       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	resource_size_t start = res->start;
diff --git a/arch/mips/pci/pci-legacy.c b/arch/mips/pci/pci-legacy.c
index d04b7c1294b6..817e97402afe 100644
--- a/arch/mips/pci/pci-legacy.c
+++ b/arch/mips/pci/pci-legacy.c
@@ -52,6 +52,7 @@ unsigned long pci_address_to_pio(phys_addr_t address)
  */
 resource_size_t
 pcibios_align_resource(void *data, const struct resource *res,
+		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
diff --git a/arch/parisc/kernel/pci.c b/arch/parisc/kernel/pci.c
index cf285b17a5ae..f99b20795d5a 100644
--- a/arch/parisc/kernel/pci.c
+++ b/arch/parisc/kernel/pci.c
@@ -196,7 +196,9 @@ void __ref pcibios_init_bridge(struct pci_dev *dev)
  * than res->start.
  */
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
-				resource_size_t size, resource_size_t alignment)
+				       const struct resource *empty_res,
+				       resource_size_t size,
+				       resource_size_t alignment)
 {
 	resource_size_t mask, align, start = res->start;
 
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index a7a2fb605971..e7bfa15da043 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1132,7 +1132,9 @@ static int skip_isa_ioresource_align(struct pci_dev *dev)
  * which might have be mirrored at 0x0100-0x03ff..
  */
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
-				resource_size_t size, resource_size_t align)
+				       const struct resource *empty_res,
+				       resource_size_t size,
+				       resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	resource_size_t start = res->start;
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 2a430722cbe4..39bd2adfc240 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -266,6 +266,7 @@ static int zpci_cfg_store(struct zpci_dev *zdev, int offset, u32 val, u8 len)
 }
 
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				       const struct resource *empty_res,
 				       resource_size_t size,
 				       resource_size_t align)
 {
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index a3903304f33f..7a0522316ee3 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -168,7 +168,9 @@ subsys_initcall(pcibios_init);
  * modulo 0x400.
  */
 resource_size_t pcibios_align_resource(void *data, const struct resource *res,
-				resource_size_t size, resource_size_t align)
+				       const struct resource *empty_res,
+				       resource_size_t size,
+				       resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	struct pci_channel *hose = dev->sysdata;
diff --git a/arch/x86/pci/i386.c b/arch/x86/pci/i386.c
index c4ec39ad276b..6fbd4b34c3f7 100644
--- a/arch/x86/pci/i386.c
+++ b/arch/x86/pci/i386.c
@@ -153,7 +153,8 @@ skip_isa_ioresource_align(struct pci_dev *dev) {
  */
 resource_size_t
 pcibios_align_resource(void *data, const struct resource *res,
-			resource_size_t size, resource_size_t align)
+		       const struct resource *empty_res,
+		       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
 	resource_size_t start = res->start;
diff --git a/arch/xtensa/kernel/pci.c b/arch/xtensa/kernel/pci.c
index 62c900e400d6..64ccb7e0d92f 100644
--- a/arch/xtensa/kernel/pci.c
+++ b/arch/xtensa/kernel/pci.c
@@ -39,6 +39,7 @@
  */
 resource_size_t
 pcibios_align_resource(void *data, const struct resource *res,
+		       const struct resource *empty_res,
 		       resource_size_t size, resource_size_t align)
 {
 	struct pci_dev *dev = data;
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index bb2aef373d6f..c375e255c509 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -251,10 +251,11 @@ static int pci_revert_fw_address(struct resource *res, struct pci_dev *dev,
  */
 resource_size_t __weak pcibios_align_resource(void *data,
 					      const struct resource *res,
+					      const struct resource *empty_res,
 					      resource_size_t size,
 					      resource_size_t align)
 {
-       return res->start;
+	return res->start;
 }
 
 static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 0679dd434719..949e69921fe9 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -602,7 +602,8 @@ static resource_size_t pcmcia_common_align(struct pcmcia_align_data *align_data,
 
 static resource_size_t
 pcmcia_align(void *align_data, const struct resource *res,
-	resource_size_t size, resource_size_t align)
+	     const struct resource *empty_res,
+	     resource_size_t size, resource_size_t align)
 {
 	struct pcmcia_align_data *data = align_data;
 	struct resource_map *m;
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 19d5e04564d9..3c73c9c0d4f7 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -202,6 +202,7 @@ enum {
  * typedef resource_alignf - Resource alignment callback
  * @data:	Private data used by the callback
  * @res:	Resource candidate range (an empty resource space)
+ * @empty_res:	Empty resource range without alignment applied
  * @size:	The minimum size of the empty space
  * @align:	Alignment from the constraints
  *
@@ -212,6 +213,7 @@ enum {
  */
 typedef resource_size_t (*resource_alignf)(void *data,
 					   const struct resource *res,
+					   const struct resource *empty_res,
 					   resource_size_t size,
 					   resource_size_t align);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d5123..ac332ff9da9f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1206,9 +1206,10 @@ int __must_check pcibios_enable_device(struct pci_dev *, int mask);
 char *pcibios_setup(char *str);
 
 /* Used only when drivers/pci/setup.c is used */
-resource_size_t pcibios_align_resource(void *, const struct resource *,
-				resource_size_t,
-				resource_size_t);
+resource_size_t pcibios_align_resource(void *data, const struct resource *res,
+				       const struct resource *empty_res,
+				       resource_size_t size,
+				       resource_size_t align);
 
 /* Generic PCI functions used internally */
 
diff --git a/kernel/resource.c b/kernel/resource.c
index 1e2f1dfc0edd..1b8d3101bdc6 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -759,7 +759,8 @@ static int __find_resource_space(struct resource *root, struct resource *old,
 			alloc.flags = avail.flags;
 			if (alignf) {
 				alloc.start = alignf(constraint->alignf_data,
-						     &avail, size, constraint->align);
+						     &avail, &tmp,
+						     size, constraint->align);
 			} else {
 				alloc.start = avail.start;
 			}
-- 
2.39.5


