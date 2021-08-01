Return-Path: <SRS0=vFFG=MY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2395FC4338F
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 05:17:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E066610A0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 05:17:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4E066610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GcqBM3wzqz3cXM
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Aug 2021 15:16:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=xianting.tian@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gcq9y33rfz304X
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Aug 2021 15:16:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420;
 MF=xianting.tian@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0UhaOfk-_1627794989; 
Received: from localhost(mailfrom:xianting.tian@linux.alibaba.com
 fp:SMTPD_---0UhaOfk-_1627794989) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 01 Aug 2021 13:16:29 +0800
From: Xianting Tian <xianting.tian@linux.alibaba.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, amit@kernel.org,
 arnd@arndb.de
Subject: [PATCH 1/2] tty: hvc: pass DMA capable memory to put_chars()
Date: Sun,  1 Aug 2021 13:16:27 +0800
Message-Id: <20210801051627.78999-1-xianting.tian@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: Xianting Tian <xianting.tian@linux.alibaba.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

As well known, hvc backend can register its opertions to hvc backend.
the opertions contain put_chars(), get_chars() and so on.

Some hvc backend may do dma in its opertions. eg, put_chars() of
virtio-console. But in the code of hvc framework, it may pass DMA
incapable memory to put_chars() under a specific configuration, which
is explained in commit c4baad5029(virtio-console: avoid DMA from stack):
1, c[] is on stack,
   hvc_console_print():
	char c[N_OUTBUF] __ALIGNED__;
	cons_ops[index]->put_chars(vtermnos[index], c, i);
2, ch is on stack,
   static void hvc_poll_put_char(,,char ch)
   {
	struct tty_struct *tty = driver->ttys[0];
	struct hvc_struct *hp = tty->driver_data;
	int n;

	do {
		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
	} while (n <= 0);
   }

Commit c4baad5029 is just the fix to avoid DMA from stack memory, which
is passed to virtio-console by hvc framework in above code. But I think
the fix is aggressive, it directly uses kmemdup() to alloc new buffer
from kmalloc area and do memcpy no matter the memory is in kmalloc area
or not. But most importantly, it should better be fixed in the hvc
framework, by changing it to never pass stack memory to the put_chars()
function in the first place. Otherwise, we still face the smae issue if
a new hvc backend using dma added in the furture.

Considering lock competition of hp->outbuf and the complicated logic in
hvc_console_print(), I didn’t use hp->outbuf, just allocate additional
memory(length N_OUTBUF) and append it to hp->outbuf.
For the issue in hvc_poll_put_char(), I use a static char to replace
the char in stack.

With the patch, we can remove the fix c4baad5029.

Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
Tested-by: Xianting Tian <xianting.tian@linux.alibaba.com>
---
 drivers/tty/hvc/hvc_console.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5bb8c4e44..f7a7fa083 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -151,9 +151,10 @@ static uint32_t vtermnos[MAX_NR_HVC_CONSOLES] =
 static void hvc_console_print(struct console *co, const char *b,
 			      unsigned count)
 {
-	char c[N_OUTBUF] __ALIGNED__;
+	char *c;
 	unsigned i = 0, n = 0;
 	int r, donecr = 0, index = co->index;
+	struct hvc_struct *hp;
 
 	/* Console access attempt outside of acceptable console range. */
 	if (index >= MAX_NR_HVC_CONSOLES)
@@ -163,8 +164,14 @@ static void hvc_console_print(struct console *co, const char *b,
 	if (vtermnos[index] == -1)
 		return;
 
+	list_for_each_entry(hp, &hvc_structs, next)
+		if (hp->vtermno == vtermnos[index])
+			break;
+
+	c = &hp->outbuf[hp->outbuf_size];
+
 	while (count > 0 || i > 0) {
-		if (count > 0 && i < sizeof(c)) {
+		if (count > 0 && i < N_OUTBUF) {
 			if (b[n] == '\n' && !donecr) {
 				c[i++] = '\r';
 				donecr = 1;
@@ -878,6 +885,7 @@ static void hvc_poll_put_char(struct tty_driver *driver, int line, char ch)
 	struct tty_struct *tty = driver->ttys[0];
 	struct hvc_struct *hp = tty->driver_data;
 	int n;
+	static char ch = ch;
 
 	do {
 		n = hp->ops->put_chars(hp->vtermno, &ch, 1);
@@ -922,7 +930,7 @@ struct hvc_struct *hvc_alloc(uint32_t vtermno, int data,
 			return ERR_PTR(err);
 	}
 
-	hp = kzalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size,
+	hp = kzalloc(ALIGN(sizeof(*hp), sizeof(long)) + outbuf_size + N_OUTBUF,
 			GFP_KERNEL);
 	if (!hp)
 		return ERR_PTR(-ENOMEM);
-- 
2.17.1

