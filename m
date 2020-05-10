Return-Path: <SRS0=SEXK=6Y=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361DFC38A2A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2020 22:52:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8305020746
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 May 2020 22:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SVHKJpJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8305020746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Kzph0bFNzDqfp
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2020 08:52:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49KzmM31DWzDqfp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2020 08:50:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=r1JJgcj57+cswSHehYKi2Pf8Y7o/cmz6W0+WQOanUiI=; b=SVHKJpJPw90GGarpVqlDbvSBUU
 PLMatye+Iv5hws65WjvYkMGA5M8rkF6Z3aLxYy7tdhKTAkqrjdllDQr0xWKvnHt/yKqHkjKVOSrek
 +vvQZCa0ICn/rIRqlbPg+P+p2D1SIxkiF2NaIM3BhuN1HQw2omB7IeCakTT/5bZPy+9P6YJu9le6A
 suO36wfYa5EHsYpBm4WIychLZgvUo7CJkdeLzjUou+0Fu7x1DXSdIAupWostH2rmiLkCKstqR5VYx
 aoR6HIjpJXOdRfce8tf9Ve3jOKpRVoeletKrB4z4ebRYvcqcKcEg2MdXGSivFCarZ0Eis6ic5Jvnb
 OTR94aqw==;
Received: from [2602:306:37b0:7840:74d2:f789:74e8:9f56]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jXulr-0005xq-TW; Sun, 10 May 2020 22:50:07 +0000
Subject: Re: [PATCH v3 9/9] hvc_console: Allow backends to set I/O buffer size
From: Geoff Levand <geoff@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
References: <cover.1589049250.git.geoff@infradead.org>
 <6f6294df663a53f47bb28abcbb1ef756c6a59922.1589049250.git.geoff@infradead.org>
Message-ID: <6aedca74-63e0-48ac-45de-018cb840d214@infradead.org>
Date: Sun, 10 May 2020 15:50:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6f6294df663a53f47bb28abcbb1ef756c6a59922.1589049250.git.geoff@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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

 #define HVC_N_OUTBUF 32
 #define HVC_N_INBUF 32
 #include "hvc_console.h"

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

