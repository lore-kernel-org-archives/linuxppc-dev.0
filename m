Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B20C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:09:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D1AF213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:09:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HEXrMuWT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D1AF213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V2HY26GbzF3Ns
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 03:09:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="HEXrMuWT";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=samsung.com
 (client-ip=210.118.77.11; helo=mailout1.w1.samsung.com;
 envelope-from=b.zolnierkie@samsung.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=samsung.com header.i=@samsung.com header.b="HEXrMuWT"; 
 dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42V1d671t2zF3LZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 02:39:53 +1100 (AEDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20181009153950euoutp01280cc4b0b3caf4c2395d3475882f20ae~b_uw8d7ZC2703727037euoutp01Z
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 15:39:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20181009153950euoutp01280cc4b0b3caf4c2395d3475882f20ae~b_uw8d7ZC2703727037euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1539099590;
 bh=9fn1dPmI7vmhTRWCwAguV3zFFt8OvhqkZEatvkF3t8c=;
 h=To:Cc:From:Subject:Date:References:From;
 b=HEXrMuWT6FMU4vEcOKCYn3Jf52+BixFQ7OBySz7hFIKAIBeJcGUhX9kbGZJf4qxpP
 s4vxR2xBKbKfwbKonZm8CFgqcjC4CNhKwS/cnk4tB6QGfm6l0Tafx/tts35l2ueye9
 nexjZTTPAS8LI0NwTKhopYYXD0pIW2WEg++faaEU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20181009153949eucas1p123974f3d5f25a0907feed52d0d9d7afa~b_uwJFTbf2251422514eucas1p1I;
 Tue,  9 Oct 2018 15:39:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id F7.61.04806.5CBCCBB5; Tue,  9
 Oct 2018 16:39:49 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20181009153948eucas1p14ad8b13d2482dbb9449888d544ddee15~b_uvNkTH03130331303eucas1p1E;
 Tue,  9 Oct 2018 15:39:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20181009153948eusmtrp292273213fb8f1fcf395b3b1fc14899ee~b_uu8sjOZ0204202042eusmtrp2X;
 Tue,  9 Oct 2018 15:39:48 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-ba-5bbccbc5f68e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id E9.A4.04284.3CBCCBB5; Tue,  9
 Oct 2018 16:39:47 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20181009153947eusmtip1a1813949486ddace2f8095887951e214~b_uufLptj1755517555eusmtip1T;
 Tue,  9 Oct 2018 15:39:47 +0000 (GMT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] powerpc: remove redundant 'default n' from Kconfig-s
Date: Tue, 9 Oct 2018 17:39:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeUgUYRzl25nZHc2V2VXxh5nWkkZmmlowpJhdOIRBEGkoaZuOB+kqO2oZ
 BJtXJZopiSYdVt5Ymiuuq1a05ZXCIna5ShKKqa0lHnimuU6S/733vvfx3vv4SEyqIezIGEUi
 q1TIY2VCc7yxfVG/v627NeSA7jNG59RnEvSf/HYRPZWagdGl4750X/MDIb08v0rQDSqdkC7Q
 z2N0zftnIj8zZnkpHzFPx1U4o650YbKN6QSjL3qCGPXzKQHzsPkOYmbqHc6QweY+EWxsTDKr
 dPe9aB6dVpFKJPwoR1fXRssIFWpJRVnIjATqINROt2EmLKUqEawavbOQ+TqeRZC3qBfyZAaB
 YWhBlIXIjRuFa8d5vQJBV8+oiCe/EVT0ZgtMxJq6gSC/swA3EYwyIPjSvyIyhQipw5B3s3oj
 3Io6CeN59zbCcWo3vPquRaYIG+o85PbsMcliSgJd90dwE8YoR9BMPsD43o0imL7txHuSwTg8
 QPD6CUhfmMN5bAUTHQ0iHtvDmvbxRjmgChEYl8pwntQiqOlpF/Aub3jX0UuYSmDUXqhtdufl
 o6BOGxTy8y3h66SE72MJ+Y2FGC+L4VamlHc7Q115nXAzNktb9a8yAxl9swL+qS+AZmxReBft
 LN6ysnjLyuL/HUoQVo1s2SQuLorlvBTsFTdOHsclKaLcwuPj6tH6d+pe7ZhrQq9XLukQRSKZ
 hbhI0RIiJeTJXEqcDgGJyazFNprmEKk4Qp5yjVXGhymTYllOh7aTuMxWXP7oZYiUipInspdZ
 NoFVbp4KSDM7FZLoJfW/pOpEzYf4Aa90A3duaGrGv8ezyac0tLs7rN3/jSpo1/DbpIEgRys/
 ++WPDoHT6ddbTo9YtFVUBv8M3SdZOvYp2n84csepF5Heg7ISp5ZvamPR2TGDQdnXeagqIac/
 l8huTAtwj3Ldpl2Y8HAdPBIgNUwH9zl7BrRqA8MzZTgXLfdwwZSc/C9ywCH5SgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGIsWRmVeSWpSXmKPExsVy+t/xu7qHT++JNnh7xtqid1Mbq8XfScfY
 LT40tTJbLHlpZ3F51xw2i9/f/7FabGk4xGYx9fx3Zos1RxazO3B6/P41idFj0csGFo/NK7Q8
 et60sHqcn7GQ0WPz2g9MHnN39TF6fN4kF8ARpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKp
 Z2hsHmtlZKqkb2eTkpqTWZZapG+XoJfRvLyJteD5MsaK/8+WsjYw7m5i7GLk4JAQMJGY/t+5
 i5GLQ0hgKaNEW99lZoi4jMTx9WVdjJxAprDEn2tdbBA1bxklvr9byQziiAg0MkrMmzmVCcRh
 FrjDKPHg9lpWkBY2ASuJie2rGEFsYQFXiZcTpzCD2LwCdhL7n71kAbFZBFQk9j7cCVYjKhAh
 cethBwtEjaDEyZlPwGxmAXWJP/MuMUPY8hLb385hnsDIPwtJ2SwkZbOQlC1gZF7FKJJaWpyb
 nltsqFecmFtcmpeul5yfu4kRGEfbjv3cvIPx0sbgQ4wCHIxKPLwz8nZHC7EmlhVX5h5ilOBg
 VhLhFd2+K1qINyWxsiq1KD++qDQntfgQoynQ4ROZpUST84ExnlcSb2hqaG5haWhubG5sZqEk
 znveoDJKSCA9sSQ1OzW1ILUIpo+Jg1OqgZFZ/YRSW190+TRjx2X+eR1qMXuWc2QGLxF+Fufy
 4ZDUhIluL30PzuTfm2WW+rMgauG7I+a7Lmu/lbZUC+q+Kd4z+c9Djtglt9feKbwdetC4YpXS
 exUjxaR7l+5Er3xnwM+6wUr6aMt5b7N5c+VXaxxcu+0vt/b9kgTjP0+V9s1oLwk9Ojv1UY4S
 S3FGoqEWc1FxIgAWZDLXuQIAAA==
Message-Id: <20181009153948eucas1p14ad8b13d2482dbb9449888d544ddee15~b_uvNkTH03130331303eucas1p1E@eucas1p1.samsung.com>
X-CMS-MailID: 20181009153948eucas1p14ad8b13d2482dbb9449888d544ddee15
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009153948eucas1p14ad8b13d2482dbb9449888d544ddee15
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009153948eucas1p14ad8b13d2482dbb9449888d544ddee15
References: <CGME20181009153948eucas1p14ad8b13d2482dbb9449888d544ddee15@eucas1p1.samsung.com>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 arch/powerpc/Kconfig                   |   14 --------------
 arch/powerpc/Kconfig.debug             |    6 ------
 arch/powerpc/platforms/40x/Kconfig     |    9 ---------
 arch/powerpc/platforms/44x/Kconfig     |   22 ----------------------
 arch/powerpc/platforms/82xx/Kconfig    |    1 -
 arch/powerpc/platforms/Kconfig         |   21 ---------------------
 arch/powerpc/platforms/Kconfig.cputype |    4 ----
 arch/powerpc/platforms/cell/Kconfig    |    3 ---
 arch/powerpc/platforms/maple/Kconfig   |    1 -
 arch/powerpc/platforms/pasemi/Kconfig  |    1 -
 arch/powerpc/platforms/powernv/Kconfig |    1 -
 arch/powerpc/platforms/ps3/Kconfig     |    2 --
 arch/powerpc/platforms/pseries/Kconfig |    2 --
 arch/powerpc/sysdev/Kconfig            |    5 -----
 arch/powerpc/sysdev/xive/Kconfig       |    3 ---
 15 files changed, 95 deletions(-)

Index: b/arch/powerpc/Kconfig
===================================================================
--- a/arch/powerpc/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -285,12 +285,10 @@ config ARCH_MAY_HAVE_PC_FDC
 
 config PPC_UDBG_16550
 	bool
-	default n
 
 config GENERIC_TBSYNC
 	bool
 	default y if PPC32 && SMP
-	default n
 
 config AUDIT_ARCH
 	bool
@@ -309,13 +307,11 @@ config EPAPR_BOOT
 	bool
 	help
 	  Used to allow a board to specify it wants an ePAPR compliant wrapper.
-	default n
 
 config DEFAULT_UIMAGE
 	bool
 	help
 	  Used to allow a board to specify it wants a uImage built by default
-	default n
 
 config ARCH_HIBERNATION_POSSIBLE
 	bool
@@ -329,11 +325,9 @@ config ARCH_SUSPEND_POSSIBLE
 
 config PPC_DCR_NATIVE
 	bool
-	default n
 
 config PPC_DCR_MMIO
 	bool
-	default n
 
 config PPC_DCR
 	bool
@@ -344,7 +338,6 @@ config PPC_OF_PLATFORM_PCI
 	bool
 	depends on PCI
 	depends on PPC64 # not supported on 32 bits yet
-	default n
 
 config ARCH_SUPPORTS_DEBUG_PAGEALLOC
 	depends on PPC32 || PPC_BOOK3S_64
@@ -447,14 +440,12 @@ config PPC_TRANSACTIONAL_MEM
        depends on SMP
        select ALTIVEC
        select VSX
-       default n
        ---help---
          Support user-mode Transactional Memory on POWERPC.
 
 config LD_HEAD_STUB_CATCH
 	bool "Reserve 256 bytes to cope with linker stubs in HEAD text" if EXPERT
 	depends on PPC64
-	default n
 	help
 	  Very large kernels can cause linker branch stubs to be generated by
 	  code in head_64.S, which moves the head text sections out of their
@@ -557,7 +548,6 @@ config RELOCATABLE
 config RELOCATABLE_TEST
 	bool "Test relocatable kernel"
 	depends on (PPC64 && RELOCATABLE)
-	default n
 	help
 	  This runs the relocatable kernel at the address it was initially
 	  loaded at, which tends to be non-zero and therefore test the
@@ -769,7 +759,6 @@ config PPC_SUBPAGE_PROT
 
 config PPC_COPRO_BASE
 	bool
-	default n
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
@@ -870,7 +859,6 @@ config PPC_INDIRECT_PCI
 	bool
 	depends on PCI
 	default y if 40x || 44x
-	default n
 
 config EISA
 	bool
@@ -967,7 +955,6 @@ source "drivers/pcmcia/Kconfig"
 
 config HAS_RAPIDIO
 	bool
-	default n
 
 config RAPIDIO
 	tristate "RapidIO support"
@@ -990,7 +977,6 @@ endmenu
 
 config NONSTATIC_KERNEL
 	bool
-	default n
 
 menu "Advanced setup"
 	depends on PPC32
Index: b/arch/powerpc/Kconfig.debug
===================================================================
--- a/arch/powerpc/Kconfig.debug	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/Kconfig.debug	2018-10-09 17:32:25.055264623 +0200
@@ -2,7 +2,6 @@
 
 config PPC_DISABLE_WERROR
 	bool "Don't build arch/powerpc code with -Werror"
-	default n
 	help
 	  This option tells the compiler NOT to build the code under
 	  arch/powerpc with the -Werror flag (which means warnings
@@ -56,7 +55,6 @@ config PPC_EMULATED_STATS
 config CODE_PATCHING_SELFTEST
 	bool "Run self-tests of the code-patching code"
 	depends on DEBUG_KERNEL
-	default n
 
 config JUMP_LABEL_FEATURE_CHECKS
 	bool "Enable use of jump label for cpu/mmu_has_feature()"
@@ -70,7 +68,6 @@ config JUMP_LABEL_FEATURE_CHECKS
 config JUMP_LABEL_FEATURE_CHECK_DEBUG
 	bool "Do extra check on feature fixup calls"
 	depends on DEBUG_KERNEL && JUMP_LABEL_FEATURE_CHECKS
-	default n
 	help
 	  This tries to catch incorrect usage of cpu_has_feature() and
 	  mmu_has_feature() in the code.
@@ -80,16 +77,13 @@ config JUMP_LABEL_FEATURE_CHECK_DEBUG
 config FTR_FIXUP_SELFTEST
 	bool "Run self-tests of the feature-fixup code"
 	depends on DEBUG_KERNEL
-	default n
 
 config MSI_BITMAP_SELFTEST
 	bool "Run self-tests of the MSI bitmap code"
 	depends on DEBUG_KERNEL
-	default n
 
 config PPC_IRQ_SOFT_MASK_DEBUG
 	bool "Include extra checks for powerpc irq soft masking"
-	default n
 
 config XMON
 	bool "Include xmon kernel debugger"
Index: b/arch/powerpc/platforms/40x/Kconfig
===================================================================
--- a/arch/powerpc/platforms/40x/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/40x/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -2,7 +2,6 @@
 config ACADIA
 	bool "Acadia"
 	depends on 40x
-	default n
 	select PPC40x_SIMPLE
 	select 405EZ
 	help
@@ -11,7 +10,6 @@ config ACADIA
 config EP405
 	bool "EP405/EP405PC"
 	depends on 40x
-	default n
 	select 405GP
 	select PCI
 	help
@@ -20,7 +18,6 @@ config EP405
 config HOTFOOT
         bool "Hotfoot"
 	depends on 40x
-	default n
 	select PPC40x_SIMPLE
 	select PCI
         help
@@ -29,7 +26,6 @@ config HOTFOOT
 config KILAUEA
 	bool "Kilauea"
 	depends on 40x
-	default n
 	select 405EX
 	select PPC40x_SIMPLE
 	select PPC4xx_PCI_EXPRESS
@@ -41,7 +37,6 @@ config KILAUEA
 config MAKALU
 	bool "Makalu"
 	depends on 40x
-	default n
 	select 405EX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
@@ -62,7 +57,6 @@ config WALNUT
 config XILINX_VIRTEX_GENERIC_BOARD
 	bool "Generic Xilinx Virtex board"
 	depends on 40x
-	default n
 	select XILINX_VIRTEX_II_PRO
 	select XILINX_VIRTEX_4_FX
 	select XILINX_INTC
@@ -80,7 +74,6 @@ config XILINX_VIRTEX_GENERIC_BOARD
 config OBS600
 	bool "OpenBlockS 600"
 	depends on 40x
-	default n
 	select 405EX
 	select PPC40x_SIMPLE
 	help
@@ -90,7 +83,6 @@ config OBS600
 config PPC40x_SIMPLE
 	bool "Simple PowerPC 40x board support"
 	depends on 40x
-	default n
 	help
 	  This option enables the simple PowerPC 40x platform support.
 
@@ -156,7 +148,6 @@ config IBM405_ERR51
 config APM8018X
 	bool "APM8018X"
 	depends on 40x
-	default n
 	select PPC40x_SIMPLE
 	help
 	  This option enables support for the AppliedMicro APM8018X evaluation
Index: b/arch/powerpc/platforms/44x/Kconfig
===================================================================
--- a/arch/powerpc/platforms/44x/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/44x/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -2,7 +2,6 @@
 config PPC_47x
 	bool "Support for 47x variant"
 	depends on 44x
-	default n
 	select MPIC
 	help
 	  This option enables support for the 47x family of processors and is
@@ -11,7 +10,6 @@ config PPC_47x
 config BAMBOO
 	bool "Bamboo"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440EP
 	select PCI
@@ -21,7 +19,6 @@ config BAMBOO
 config BLUESTONE
 	bool "Bluestone"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select APM821xx
 	select PCI_MSI
@@ -44,7 +41,6 @@ config EBONY
 config SAM440EP
         bool "Sam440ep"
 	depends on 44x
-        default n
         select 440EP
         select PCI
         help
@@ -53,7 +49,6 @@ config SAM440EP
 config SEQUOIA
 	bool "Sequoia"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440EPX
 	help
@@ -62,7 +57,6 @@ config SEQUOIA
 config TAISHAN
 	bool "Taishan"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440GX
 	select PCI
@@ -73,7 +67,6 @@ config TAISHAN
 config KATMAI
 	bool "Katmai"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440SPe
 	select PCI
@@ -86,7 +79,6 @@ config KATMAI
 config RAINIER
 	bool "Rainier"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440GRX
 	select PCI
@@ -96,7 +88,6 @@ config RAINIER
 config WARP
 	bool "PIKA Warp"
 	depends on 44x
-	default n
 	select 440EP
 	help
 	  This option enables support for the PIKA Warp(tm) Appliance. The Warp
@@ -109,7 +100,6 @@ config WARP
 config ARCHES
 	bool "Arches"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 460EX # Odd since it uses 460GT but the effects are the same
 	select PCI
@@ -120,7 +110,6 @@ config ARCHES
 config CANYONLANDS
 	bool "Canyonlands"
 	depends on 44x
-	default n
 	select 460EX
 	select PCI
 	select PPC4xx_PCI_EXPRESS
@@ -134,7 +123,6 @@ config CANYONLANDS
 config GLACIER
 	bool "Glacier"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 460EX # Odd since it uses 460GT but the effects are the same
 	select PCI
@@ -147,7 +135,6 @@ config GLACIER
 config REDWOOD
 	bool "Redwood"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 460SX
 	select PCI
@@ -160,7 +147,6 @@ config REDWOOD
 config EIGER
 	bool "Eiger"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 460SX
 	select PCI
@@ -172,7 +158,6 @@ config EIGER
 config YOSEMITE
 	bool "Yosemite"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440EP
 	select PCI
@@ -182,7 +167,6 @@ config YOSEMITE
 config ISS4xx
 	bool "ISS 4xx Simulator"
 	depends on (44x || 40x)
-	default n
 	select 405GP if 40x
 	select 440GP if 44x && !PPC_47x
 	select PPC_FPU
@@ -193,7 +177,6 @@ config ISS4xx
 config CURRITUCK
 	bool "IBM Currituck (476fpe) Support"
 	depends on PPC_47x
-	default n
 	select SWIOTLB
 	select 476FPE
 	select PPC4xx_PCI_EXPRESS
@@ -203,7 +186,6 @@ config CURRITUCK
 config FSP2
 	bool "IBM FSP2 (476fpe) Support"
 	depends on PPC_47x
-	default n
 	select 476FPE
 	select IBM_EMAC_EMAC4 if IBM_EMAC
 	select IBM_EMAC_RGMII if IBM_EMAC
@@ -215,7 +197,6 @@ config FSP2
 config AKEBONO
 	bool "IBM Akebono (476gtr) Support"
 	depends on PPC_47x
-	default n
 	select SWIOTLB
 	select 476FPE
 	select PPC4xx_PCI_EXPRESS
@@ -241,7 +222,6 @@ config AKEBONO
 config ICON
 	bool "Icon"
 	depends on 44x
-	default n
 	select PPC44x_SIMPLE
 	select 440SPe
 	select PCI
@@ -252,7 +232,6 @@ config ICON
 config XILINX_VIRTEX440_GENERIC_BOARD
 	bool "Generic Xilinx Virtex 5 FXT board support"
 	depends on 44x
-	default n
 	select XILINX_VIRTEX_5_FXT
 	select XILINX_INTC
 	help
@@ -280,7 +259,6 @@ config XILINX_ML510
 config PPC44x_SIMPLE
 	bool "Simple PowerPC 44x board support"
 	depends on 44x
-	default n
 	help
 	  This option enables the simple PowerPC 44x platform support.
 
Index: b/arch/powerpc/platforms/82xx/Kconfig
===================================================================
--- a/arch/powerpc/platforms/82xx/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/82xx/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -51,7 +51,6 @@ endif
 
 config PQ2ADS
 	bool
-	default n
 
 config 8260
 	bool
Index: b/arch/powerpc/platforms/Kconfig
===================================================================
--- a/arch/powerpc/platforms/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -23,7 +23,6 @@ source "arch/powerpc/platforms/amigaone/
 
 config KVM_GUEST
 	bool "KVM Guest support"
-	default n
 	select EPAPR_PARAVIRT
 	---help---
 	  This option enables various optimizations for running under the KVM
@@ -34,7 +33,6 @@ config KVM_GUEST
 
 config EPAPR_PARAVIRT
 	bool "ePAPR para-virtualization support"
-	default n
 	help
 	  Enables ePAPR para-virtualization support for guests.
 
@@ -74,7 +72,6 @@ config PPC_DT_CPU_FTRS
 config UDBG_RTAS_CONSOLE
 	bool "RTAS based debug console"
 	depends on PPC_RTAS
-	default n
 
 config PPC_SMP_MUXED_IPI
 	bool
@@ -86,16 +83,13 @@ config PPC_SMP_MUXED_IPI
 
 config IPIC
 	bool
-	default n
 
 config MPIC
 	bool
-	default n
 
 config MPIC_TIMER
 	bool "MPIC Global Timer"
 	depends on MPIC && FSL_SOC
-	default n
 	help
 	  The MPIC global timer is a hardware timer inside the
 	  Freescale PIC complying with OpenPIC standard. When the
@@ -107,7 +101,6 @@ config MPIC_TIMER
 config FSL_MPIC_TIMER_WAKEUP
 	tristate "Freescale MPIC global timer wakeup driver"
 	depends on FSL_SOC &&  MPIC_TIMER && PM
-	default n
 	help
 	  The driver provides a way to wake up the system by MPIC
 	  timer.
@@ -115,43 +108,35 @@ config FSL_MPIC_TIMER_WAKEUP
 
 config PPC_EPAPR_HV_PIC
 	bool
-	default n
 	select EPAPR_PARAVIRT
 
 config MPIC_WEIRD
 	bool
-	default n
 
 config MPIC_MSGR
 	bool "MPIC message register support"
 	depends on MPIC
-	default n
 	help
 	  Enables support for the MPIC message registers.  These
 	  registers are used for inter-processor communication.
 
 config PPC_I8259
 	bool
-	default n
 
 config U3_DART
 	bool
 	depends on PPC64
-	default n
 
 config PPC_RTAS
 	bool
-	default n
 
 config RTAS_ERROR_LOGGING
 	bool
 	depends on PPC_RTAS
-	default n
 
 config PPC_RTAS_DAEMON
 	bool
 	depends on PPC_RTAS
-	default n
 
 config RTAS_PROC
 	bool "Proc interface to RTAS"
@@ -164,11 +149,9 @@ config RTAS_FLASH
 
 config MMIO_NVRAM
 	bool
-	default n
 
 config MPIC_U3_HT_IRQS
 	bool
-	default n
 
 config MPIC_BROKEN_REGREAD
 	bool
@@ -187,15 +170,12 @@ config EEH
 
 config PPC_MPC106
 	bool
-	default n
 
 config PPC_970_NAP
 	bool
-	default n
 
 config PPC_P7_NAP
 	bool
-	default n
 
 config PPC_INDIRECT_PIO
 	bool
@@ -295,7 +275,6 @@ config CPM2
 
 config FSL_ULI1575
 	bool
-	default n
 	select GENERIC_ISA_DMA
 	help
 	  Supports for the ULI1575 PCIe south bridge that exists on some
Index: b/arch/powerpc/platforms/Kconfig.cputype
===================================================================
--- a/arch/powerpc/platforms/Kconfig.cputype	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/Kconfig.cputype	2018-10-09 17:32:25.055264623 +0200
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC64
 	bool "64-bit kernel"
-	default n
 	select ZLIB_DEFLATE
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
@@ -369,7 +368,6 @@ config PPC_MM_SLICES
 	bool
 	default y if PPC_BOOK3S_64
 	default y if PPC_8xx && HUGETLB_PAGE
-	default n
 
 config PPC_HAVE_PMU_SUPPORT
        bool
@@ -383,7 +381,6 @@ config PPC_PERF_CTRS
 config FORCE_SMP
 	# Allow platforms to force SMP=y by selecting this
 	bool
-	default n
 	select SMP
 
 config SMP
@@ -424,7 +421,6 @@ config CHECK_CACHE_COHERENCY
 
 config PPC_DOORBELL
 	bool
-	default n
 
 endmenu
 
Index: b/arch/powerpc/platforms/cell/Kconfig
===================================================================
--- a/arch/powerpc/platforms/cell/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/cell/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC_CELL
 	bool
-	default n
 
 config PPC_CELL_COMMON
 	bool
@@ -22,7 +21,6 @@ config PPC_CELL_NATIVE
 	select IBM_EMAC_RGMII if IBM_EMAC
 	select IBM_EMAC_ZMII if IBM_EMAC #test only
 	select IBM_EMAC_TAH if IBM_EMAC  #test only
-	default n
 
 config PPC_IBM_CELL_BLADE
 	bool "IBM Cell Blade"
@@ -54,7 +52,6 @@ config SPU_FS
 
 config SPU_BASE
 	bool
-	default n
 	select PPC_COPRO_BASE
 
 config CBE_RAS
Index: b/arch/powerpc/platforms/maple/Kconfig
===================================================================
--- a/arch/powerpc/platforms/maple/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/maple/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -13,7 +13,6 @@ config PPC_MAPLE
 	select PPC_RTAS
 	select MMIO_NVRAM
 	select ATA_NONSTANDARD if ATA
-	default n
 	help
           This option enables support for the Maple 970FX Evaluation Board.
 	  For more information, refer to <http://www.970eval.com>
Index: b/arch/powerpc/platforms/pasemi/Kconfig
===================================================================
--- a/arch/powerpc/platforms/pasemi/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/pasemi/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -2,7 +2,6 @@
 config PPC_PASEMI
 	depends on PPC64 && PPC_BOOK3S && CPU_BIG_ENDIAN
 	bool "PA Semi SoC-based platforms"
-	default n
 	select MPIC
 	select PCI
 	select PPC_UDBG_16550
Index: b/arch/powerpc/platforms/powernv/Kconfig
===================================================================
--- a/arch/powerpc/platforms/powernv/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/powernv/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -30,7 +30,6 @@ config OPAL_PRD
 config PPC_MEMTRACE
 	bool "Enable removal of RAM from kernel mappings for tracing"
 	depends on PPC_POWERNV && MEMORY_HOTREMOVE
-	default n
 	help
 	  Enabling this option allows for the removal of memory (RAM)
 	  from the kernel mappings to be used for hardware tracing.
Index: b/arch/powerpc/platforms/ps3/Kconfig
===================================================================
--- a/arch/powerpc/platforms/ps3/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/ps3/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -49,7 +49,6 @@ config PS3_HTAB_SIZE
 config PS3_DYNAMIC_DMA
 	depends on PPC_PS3
 	bool "PS3 Platform dynamic DMA page table management"
-	default n
 	help
 	  This option will enable kernel support to take advantage of the
 	  per device dynamic DMA page table management provided by the Cell
@@ -89,7 +88,6 @@ config PS3_SYS_MANAGER
 config PS3_REPOSITORY_WRITE
 	bool "PS3 Repository write support" if PS3_ADVANCED
 	depends on PPC_PS3
-	default n
 	help
 	  Enables support for writing to the PS3 System Repository.
 
Index: b/arch/powerpc/platforms/pseries/Kconfig
===================================================================
--- a/arch/powerpc/platforms/pseries/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/platforms/pseries/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -28,7 +28,6 @@ config PPC_PSERIES
 config PPC_SPLPAR
 	depends on PPC_PSERIES
 	bool "Support for shared-processor logical partitions"
-	default n
 	help
 	  Enabling this option will make the kernel run more efficiently
 	  on logically-partitioned pSeries systems which use shared
@@ -99,7 +98,6 @@ config PPC_SMLPAR
 	bool "Support for shared-memory logical partitions"
 	depends on PPC_PSERIES
 	select LPARCFG
-	default n
 	help
 	  Select this option to enable shared memory partition support.
 	  With this option a system running in an LPAR can be given more
Index: b/arch/powerpc/sysdev/Kconfig
===================================================================
--- a/arch/powerpc/sysdev/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/sysdev/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -6,19 +6,16 @@
 config PPC4xx_PCI_EXPRESS
 	bool
 	depends on PCI && 4xx
-	default n
 
 config PPC4xx_HSTA_MSI
 	bool
 	depends on PCI_MSI
 	depends on PCI && 4xx
-	default n
 
 config PPC4xx_MSI
 	bool
 	depends on PCI_MSI
 	depends on PCI && 4xx
-	default n
 
 config PPC_MSI_BITMAP
 	bool
@@ -37,11 +34,9 @@ config PPC_SCOM
 config SCOM_DEBUGFS
 	bool "Expose SCOM controllers via debugfs"
 	depends on PPC_SCOM && DEBUG_FS
-	default n
 
 config GE_FPGA
 	bool
-	default n
 
 config FSL_CORENET_RCPM
 	bool
Index: b/arch/powerpc/sysdev/xive/Kconfig
===================================================================
--- a/arch/powerpc/sysdev/xive/Kconfig	2018-10-09 17:32:25.059264623 +0200
+++ b/arch/powerpc/sysdev/xive/Kconfig	2018-10-09 17:32:25.055264623 +0200
@@ -1,17 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 config PPC_XIVE
 	bool
-	default n
 	select PPC_SMP_MUXED_IPI
 	select HARDIRQS_SW_RESEND
 
 config PPC_XIVE_NATIVE
 	bool
-	default n
 	select PPC_XIVE
 	depends on PPC_POWERNV
 
 config PPC_XIVE_SPAPR
 	bool
-	default n
 	select PPC_XIVE
