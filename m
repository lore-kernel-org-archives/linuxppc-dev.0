Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FDAC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:42:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E20A218D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 06:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="ltablZQM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="knPBS9Z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E20A218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44prMb0DMYzDqWJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 16:42:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=russell.cc
 (client-ip=64.147.123.24; helo=wout1-smtp.messagingengine.com;
 envelope-from=ruscur@russell.cc; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=russell.cc
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=russell.cc header.i=@russell.cc header.b="ltablZQM"; 
 dkim=pass (2048-bit key;
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.b="knPBS9Z5"; dkim-atps=neutral
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44prKk6PdDzDqT5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 16:40:26 +1000 (AEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.west.internal (Postfix) with ESMTP id 6DFB147A;
 Wed, 24 Apr 2019 02:40:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Wed, 24 Apr 2019 02:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding; s=fm1; bh=DR9pC3dPwL/mF1FX602vl7rD2o
 fYOALoTyhygc4EkWE=; b=ltablZQM16QrLcqsHuwX8EJN9RIvoPERKCMJzrkO02
 rl3O6lKw7VAv4cvpH7twUlL++2GpG3fo4NZRaA4tMySG5pA2dzd1VOi/cNhZvYZl
 LLj+l/4c08XxwbAq3+w8iuNg7Ah9nzyqnphXUASDbBCjAvW+3bwckcNnFfc06Hi/
 QRM5oYj1XklxB/ixKMy2r2LIFsuw9WQEXTrCZBQAfUgzxlWRrAei5XHqLI8nniiN
 gxHhEmObocXs/Mmnku+SNw9fH5WvNz0XCkVufyg9TkS3og+o4dVSVjzNwTjOJg8x
 3Yic3d3n7SWrLYNvOUL81HCpHpWoxcM3pv649iawlwKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DR9pC3dPwL/mF1FX6
 02vl7rD2ofYOALoTyhygc4EkWE=; b=knPBS9Z54+TH9NaACmI+XvH0nx2xVJ/Cx
 fJmNyNyiDZQccUe/8VkkuybJ9QvOD9tXni50F7irACJjPA2p36qn2zVNesVVvXSH
 xuIkf4RFiXPovT3RGC8umja3aDOO+kXvFCBJxegzLaJH22+bNDbxEdml2etMPjka
 v3boJ5TaOgWPW5RVbQy5ggWRIguuDIHd/LKbW+mZiXcmumM+9trshOAARdXFEQlW
 gvhfi+56I9kIuv2E6QTBMHGU/b74BIshBHch+VQpOEmEeFdP/NLMyPjdPUFjXOc4
 JIPQ8/D4iiooPteylUM3fkMqM3sgcRRt30wYVuGnf60pBVwipAuQw==
X-ME-Sender: <xms:1QTAXLVLuaqOOJBOaziL6CK8issNau6Ns4XpUpCI8j1y0bDUrw3Tmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrgeelgddutdelucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
 fufffkofgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhrvgih
 uceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecukfhppeduvddvrdelledrkedvrd
 dutdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgt
 tgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:1QTAXLl5Oc1X7TpbEyXPlUz7fDlsX6MFUjBRpKfD4CAAr1jd_Y0dvQ>
 <xmx:1QTAXIDfHdtRp8mkEy3bIvvy8ozw3azzN5-o9Bo-NvUjxGA3Y1eKYw>
 <xmx:1QTAXF5ccsnKoa09ZX-rePkEr4jGY-2KgnXutfCKgn0BXf7oZcgzOg>
 <xmx:1wTAXKm6nHTVmjb80ZNO-YPztf20hPzCER0JdTWFwx6kobvErYREiw>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
 by mail.messagingengine.com (Postfix) with ESMTPA id 33B8B103D1;
 Wed, 24 Apr 2019 02:40:18 -0400 (EDT)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/mm/ptdump: Wrap seq_printf() to handle NULL
 pointers
Date: Wed, 24 Apr 2019 16:39:57 +1000
Message-Id: <20190424063958.24559-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Julia.Lawall@lip6.fr, rashmica.g@gmail.com,
 Russell Currey <ruscur@russell.cc>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Lovingly borrowed from the arch/arm64 ptdump code.

This doesn't seem to be an issue in practice, but is necessary for my
upcoming commit.

Converts a putc() into a puts().

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/mm/ptdump/ptdump.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 37138428ab55..c50cb7faa334 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -104,6 +104,18 @@ static struct addr_marker address_markers[] = {
 	{ -1,	NULL },
 };
 
+#define pt_dump_seq_printf(m, fmt, args...)	\
+({						\
+	if (m)					\
+		seq_printf(m, fmt, ##args);	\
+})
+
+#define pt_dump_seq_puts(m, fmt)	\
+({					\
+	if (m)				\
+		seq_printf(m, fmt);	\
+})
+
 static void dump_flag_info(struct pg_state *st, const struct flag_info
 		*flag, u64 pte, int num)
 {
@@ -121,19 +133,19 @@ static void dump_flag_info(struct pg_state *st, const struct flag_info
 			val = pte & flag->val;
 			if (flag->shift)
 				val = val >> flag->shift;
-			seq_printf(st->seq, "  %s:%llx", flag->set, val);
+			pt_dump_seq_printf(st->seq, "  %s:%llx", flag->set, val);
 		} else {
 			if ((pte & flag->mask) == flag->val)
 				s = flag->set;
 			else
 				s = flag->clear;
 			if (s)
-				seq_printf(st->seq, "  %s", s);
+				pt_dump_seq_printf(st->seq, "  %s", s);
 		}
 		st->current_flags &= ~flag->mask;
 	}
 	if (st->current_flags != 0)
-		seq_printf(st->seq, "  unknown flags:%llx", st->current_flags);
+		pt_dump_seq_printf(st->seq, "  unknown flags:%llx", st->current_flags);
 }
 
 static void dump_addr(struct pg_state *st, unsigned long addr)
@@ -148,12 +160,12 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 #define REG		"0x%08lx"
 #endif
 
-	seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
+	pt_dump_seq_printf(st->seq, REG "-" REG " ", st->start_address, addr - 1);
 	if (st->start_pa == st->last_pa && st->start_address + PAGE_SIZE != addr) {
-		seq_printf(st->seq, "[" REG "]", st->start_pa);
+		pt_dump_seq_printf(st->seq, "[" REG "]", st->start_pa);
 		delta = PAGE_SIZE >> 10;
 	} else {
-		seq_printf(st->seq, " " REG " ", st->start_pa);
+		pt_dump_seq_printf(st->seq, " " REG " ", st->start_pa);
 		delta = (addr - st->start_address) >> 10;
 	}
 	/* Work out what appropriate unit to use */
@@ -161,7 +173,7 @@ static void dump_addr(struct pg_state *st, unsigned long addr)
 		delta >>= 10;
 		unit++;
 	}
-	seq_printf(st->seq, "%9lu%c", delta, *unit);
+	pt_dump_seq_printf(st->seq, "%9lu%c", delta, *unit);
 
 }
 
@@ -178,7 +190,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		st->start_address = addr;
 		st->start_pa = pa;
 		st->last_pa = pa;
-		seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+		pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
 	/*
 	 * Dump the section of virtual memory when:
 	 *   - the PTE flags from one entry to the next differs.
@@ -202,7 +214,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 					  st->current_flags,
 					  pg_level[st->level].num);
 
-			seq_putc(st->seq, '\n');
+			pt_dump_seq_puts(st->seq, "\n");
 		}
 
 		/*
@@ -211,7 +223,7 @@ static void note_page(struct pg_state *st, unsigned long addr,
 		 */
 		while (addr >= st->marker[1].start_address) {
 			st->marker++;
-			seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
+			pt_dump_seq_printf(st->seq, "---[ %s ]---\n", st->marker->name);
 		}
 		st->start_address = addr;
 		st->start_pa = pa;
-- 
2.21.0

