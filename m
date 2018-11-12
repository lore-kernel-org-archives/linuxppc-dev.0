Return-Path: <SRS0=Ph+o=NX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D49C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 02:44:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D7620881
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 02:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fzvuX3Br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D7620881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42tZpQ2Zq2zF3PN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Nov 2018 13:44:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nifty.com header.i=@nifty.com header.b="fzvuX3Br";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=socionext.com
 (client-ip=210.131.2.75; helo=conuserg-08.nifty.com;
 envelope-from=yamada.masahiro@socionext.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nifty.com header.i=@nifty.com header.b="fzvuX3Br"; 
 dkim-atps=neutral
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42tZg36XpXzF3Mm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Nov 2018 13:37:51 +1100 (AEDT)
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp
 [153.142.97.92]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id wAC2ZqVU015801;
 Mon, 12 Nov 2018 11:35:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com wAC2ZqVU015801
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1541990155;
 bh=D/YvA7fG3eU8iQ4XCYgoVJjQnd4bdw8V+EnSjh78kh0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fzvuX3Bra8KLE9Rh3REv55KBUmUCE7oTRkQlfJ2ZyFZNyr7uLINHuLHxFSk6lrTLi
 kNcg3yxZAGvaNt0UVlG3Uh3HecmArW8QmgBJQ7/ejCUUxxKYkSuKrZaf2x81bFmg6S
 zv5ZN0s2WmCLfl35TvG2Hm306NwOHWGmgQf8yVI322xsSpwFnND2PCH4zaRiySqtNg
 pQpYzKR+8/H96J13EPQpu64My7ZB7DU6tyHT69MFLHIUyqAaK5NGt4F+eimsAjlTdd
 ArY3H7djdnoflh2KtFzqQ5ApxLN0HslLF5dVNNS3u+LRZ/HUDQXjGpieEYxt0cE3oo
 BP0FjJUpn4nCA==
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org
Subject: [PATCH 2/2] x86,
 powerpc: remove -funit-at-a-time compiler option entirely
Date: Mon, 12 Nov 2018 11:35:20 +0900
Message-Id: <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
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
Cc: linux-kernel@vger.kernel.org,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Paul Mackerras <paulus@samba.org>, Richard Weinberger <richard@sigma-star.at>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

GCC 4.6 manual says:

-funit-at-a-time
  This option is left for compatibility reasons. -funit-at-a-time has
  no effect, while -fno-unit-at-a-time implies -fno-toplevel-reorder
  and -fno-section-anchors.
  Enabled by default.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/powerpc/Makefile | 4 ----
 arch/x86/Makefile     | 4 ----
 arch/x86/Makefile.um  | 5 -----
 3 files changed, 13 deletions(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 8a2ce14..854199c 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -228,10 +228,6 @@ KBUILD_CFLAGS += $(call cc-option,-mno-vsx)
 KBUILD_CFLAGS += $(call cc-option,-mno-spe)
 KBUILD_CFLAGS += $(call cc-option,-mspe=no)
 
-# Enable unit-at-a-time mode when possible. It shrinks the
-# kernel considerably.
-KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
-
 # FIXME: the module load should be taught about the additional relocs
 # generated by this.
 # revert to pre-gcc-4.4 behaviour of .eh_frame
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 88398fd..3508049 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -130,10 +130,6 @@ else
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
-
-        # -funit-at-a-time shrinks the kernel .text considerably
-        # unfortunately it makes reading oopses harder.
-        KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
 endif
 
 ifdef CONFIG_X86_X32
diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 577976b..1db7913 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -26,9 +26,6 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
 # an unresolved reference.
 cflags-y += -ffreestanding
 
-# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
-KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
-
 KBUILD_CFLAGS += $(cflags-y)
 
 else
@@ -50,6 +47,4 @@ ELF_FORMAT := elf64-x86-64
 LINK-$(CONFIG_LD_SCRIPT_DYN) += -Wl,-rpath,/lib64
 LINK-y += -m64
 
-# Do unit-at-a-time unconditionally on x86_64, following the host
-KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
 endif
-- 
2.7.4

