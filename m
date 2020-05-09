Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF11C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 19:19:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35AE820644
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 19:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QX9POZj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35AE820644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49KH841QQ5zDr7M
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2020 05:19:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49KGh13stczDr5D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 May 2020 04:58:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=oyp2159SuQimkAaP2XvbdzTHQC+j+kFnxcKYSUlp4UQ=; b=QX9POZj/ZcUKjl+ayz9cwwaFQI
 oh8XgJXdpwz94GaA/KUevXnJ9Qnu6RK8QePKySyLtf46EhbdltiNcx+5r6CmDcDroJatTLd98qm8q
 b5U6IPlasH/XsNywqDlUM9kpQbgR5wD+rLUTJJaeZ5sl2xApDYpyZngfX2KHNB/EJCPl7TkuX1sCP
 vDVc6rgMFZMkoHMfZxGc76A1PGKYYUs+ly4B7jHoAYjH1GhwcPO9LtOSpG3Kv4huyqjkFY5NRpoiU
 zEG6xwgCZlhdfLgg9+3WMcugDhyVA1qLgaxDDeuxbuq2lJsvqkY6LFdsbccKH91qEzc4H/Uz1HsDF
 La6DQKNQ==;
Received: from geoff by merlin.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jXUgC-0003EB-Cw; Sat, 09 May 2020 18:58:32 +0000
Message-Id: <6f6294df663a53f47bb28abcbb1ef756c6a59922.1589049250.git.geoff@infradead.org>
In-Reply-To: <cover.1589049250.git.geoff@infradead.org>
References: <cover.1589049250.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Wed, 1 Apr 2020 20:16:27 -0700
Subject: [PATCH v2 9/9] hvc_console: Allow backends to set I/O buffer size
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Sat, 09 May 2020 18:58:32 +0000
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
Cc: linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

To allow HVC backends to set the I/O buffer sizes to values
that are most efficient for the backend, change the macro
definitions where the buffer sizes are set to be conditional
on whether or not the macros are already defined.  Also,
rename the macros from N_OUTBUF to HVC_N_OUBUF and from
N_INBUF to HVC_N_INBUF.

Typical usage in the backend source file would be:

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 drivers/tty/hvc/hvc_console.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 436cc51c92c3..2928bad057fc 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -42,12 +42,15 @@
 #define HVC_CLOSE_WAIT (HZ/100) /* 1/10 of a second */
 
 /*
- * These sizes are most efficient for vio, because they are the
- * native transfer size. We could make them selectable in the
- * future to better deal with backends that want other buffer sizes.
+ * These default sizes are most efficient for vio, because they are
+ * the native transfer size.
  */
-#define N_OUTBUF	16
-#define N_INBUF		16
+#if !defined(HVC_N_OUTBUF)
+# define HVC_N_OUTBUF	16
+#endif
+#if !defined(HVC_N_INBUF)
+# define HVC_N_INBUF	16
+#endif
 
 #define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
 
@@ -151,7 +154,7 @@ static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
 static void hvc_console_print(struct console *co, const char *b,
 			      unsigned count)
 {
-	char c[N_OUTBUF] __ALIGNED__;
+	char c[HVC_N_OUTBUF] __ALIGNED__;
 	unsigned i = 0, n = 0;
 	int r, donecr = 0, index = co->index;
 
@@ -640,7 +643,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 {
 	struct tty_struct *tty;
 	int i, n, count, poll_mask = 0;
-	char buf[N_INBUF] __ALIGNED__;
+	char buf[HVC_N_INBUF] __ALIGNED__;
 	unsigned long flags;
 	int read_total = 0;
 	int written_total = 0;
@@ -681,7 +684,7 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 
  read_again:
 	/* Read data if any */
-	count = tty_buffer_request_room(&hp->port, N_INBUF);
+	count = tty_buffer_request_room(&hp->port, HVC_N_INBUF);
 
 	/* If flip is full, just reschedule a later read */
 	if (count == 0) {
-- 
2.20.1

