Return-Path: <linuxppc-dev+bounces-26185-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F13C61DD6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Aug 2026 07:55:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hX6wz0b4tz2yjN;
	Sat, 29 Aug 2026 17:54:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787985883;
	cv=none; b=ZjDnMYKk3y1ADzWhtF92LaRtD8xOmcHTJeOQn4OgwJ/dvFnTO3bC9uNmo1bY9ICe7SS5Bq13XpKLubvj50dro+AcQ+wpxNjurmcl0U75R/Mz/acEf4y8E6MKdoHyolmUO/hYIfccMmc9EMiN8HKYCAm0fY+SsfjMLF1d1cItAfsngjAl8uej+Du+bUfuhx0dvbN8e0p0oMOjvL4RqtBgN8IPTqp8jzquCoUBFRMsdRZVTcdyEfvlpo51DB/79O9APUJ5bKci4Mw8zQSJ8rhkuvZHaPZfiuRsU79iXKIWAcpvglNPYAcbi1VVMaIfDmGTeIMTWbGXUZOGZQ9p7R0HCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787985883; c=relaxed/relaxed;
	bh=9NpBB7CEIjqjyGCb4SVckgVeutjU9azjoaZgEVa947o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nYsrPntkTVE8O9P/Od3xrDPzwE7OD4mDm9zpSzEbrhc9JEri0P7CF9OjmSgJowUV5VohQpr8EsPU1Gmv9+6OqITEQPIPqhGbvP4Qyf7ptGUNrE/0QYE9nrBvUh7AH/dWWCQ3Al52uvlidxgWRKdUYDrkM3muPM4wNHoEgICU9WKnoKSaWne0EkyUkjsuacAKq9Vow115Ot1zAfPWa1dhln60DP4nisao413o1vZ+5nRpEads3B9oSAUCIUgtbKYkMGDaNjggLE3pMH7YQjHG/PS2Jfxzpa/4EXpuMUuVRU5lcNNObY02Xi6v5w/siuHrEuKHlH/LaaHnvLyddw5K5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=sLIQWxtr; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=sLIQWxtr; dkim-atps=neutral; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=sLIQWxtr;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=sLIQWxtr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhouminqiang2@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hX5Ms1RTVz2xZV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 16:44:40 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9NpBB7CEIjqjyGCb4SVckgVeutjU9azjoaZgEVa947o=;
	b=sLIQWxtrS8w5ERuoFDXmbubInkswYa662b4wJY61Zn7xeDFflLoibLq4MWzVHCe0KOiu45zz/
	WsF0/wDXGz+6Irxls6bqJzT51YJ9VpzdmO28F/hdacMD9/6HUBU+B/lIjOaXLBS1rXND9jmd36W
	gmNkFosl91edLNaX6LjQcZk=
Received: from canpmsgout09.his.huawei.com (unknown [172.19.92.135])
	by szxga04-in.huawei.com (SkyGuard) with ESMTPS id 4hX4ww2HcJz126M1g
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2026 14:24:48 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9NpBB7CEIjqjyGCb4SVckgVeutjU9azjoaZgEVa947o=;
	b=sLIQWxtrS8w5ERuoFDXmbubInkswYa662b4wJY61Zn7xeDFflLoibLq4MWzVHCe0KOiu45zz/
	WsF0/wDXGz+6Irxls6bqJzT51YJ9VpzdmO28F/hdacMD9/6HUBU+B/lIjOaXLBS1rXND9jmd36W
	gmNkFosl91edLNaX6LjQcZk=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hX4jH4tCWz1cyPY;
	Sat, 29 Aug 2026 14:14:43 +0800 (CST)
Received: from dggpemr100018.china.huawei.com (unknown [7.185.36.64])
	by mail.maildlp.com (Postfix) with ESMTPS id 7539A40572;
	Sat, 29 Aug 2026 14:25:30 +0800 (CST)
Received: from huawei.com (10.50.85.155) by dggpemr100018.china.huawei.com
 (7.185.36.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Sat, 29 Aug
 2026 14:25:29 +0800
From: zhouminqiang <zhouminqiang2@huawei.com>
To: <linux@armlinux.org.uk>, <vz@mleia.com>, <piotr.wojtaszczyk@timesys.com>,
	<maddy@linux.ibm.com>, <dwmw2@infradead.org>, <richard@nod.at>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mtd@lists.infradead.org>,
	<chengzhihao1@huawei.com>, <yangerkun@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 1/7] jffs2: wbuf: clear wbuf on recovery failure paths
Date: Sat, 29 Aug 2026 14:16:51 +0800
Message-ID: <20260829061658.306854-2-zhouminqiang2@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260829061658.306854-1-zhouminqiang2@huawei.com>
References: <20260829061658.306854-1-zhouminqiang2@huawei.com>
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
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.85.155]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemr100018.china.huawei.com (7.185.36.64)

Write verification was introduced by commit a6bc432e296d ("[JFFS2]
Add support for write-buffer verification.") to detect transport or
program-time corruption. When verification fails, jffs2_wbuf_recover()
attempts to recover the data: it first calls jffs2_block_refile()
to mark the old eraseblock's remaining space as REF_OBSOLETE,
then rewrites the old block's data along with the new data still
in the wbuf to a new block.  However, when the recovery write
verification also fails, the function returns without clearing
c->wbuf_len, leaving the wbuf still pointing to the refiled old
block, which leads to two kinds of bugs.

Both cases below are illustrated with a filesystem of
erasesize=16KB and wbuf_pagesize=512B.

Case 1: BUG_ON in jffs2_link_node_ref():

    User: Two 1KB writes
      ref0: [A+0,    A+1092) (ri:68B + data:1024B)
      ref1: [A+1092, A+2184)

    User: append 1KB write
      ...
      jffs2_write_dnode
        jffs2_flash_writev
          c->wbuf_ofs = A+2048, c->wbuf_len = 512
          __jffs2_flush_wbuf
            mtd_write                          -> 0-to-1 bit flip
            jffs2_verify_write                 -> verify failed
            jffs2_wbuf_recover
              jffs2_block_refile
                c->nextblock = NULL
                jffs2_link_node_ref            -> mark A remaining
                  ref2: [A+2184, A+16384)         space REF_OBSOLETE,
                                                  jeb_A->free_size = 0
              jffs2_reserve_space_gc
                jffs2_do_reserve_space
                  jffs2_find_nextblock
                    c->nextblock = B
              start = A+1092, end = A+2184
              end - start >= c->wbuf_pagesize  -> recover data in A
              mtd_write
              jffs2_verify_write               -> verify also failed
              return                           -> c->wbuf_ofs = A+2048
                                                  c->wbuf_len = 512
        retry
        jffs2_flash_writev
          if (SECTOR_ADDR(to) != SECTOR_ADDR(c->wbuf_ofs))
                                               -> SECTOR(to) = B
                                               -> SECTOR(c->wbuf_ofs) = A
          __jffs2_flush_wbuf(c, PAD_NOACCOUNT) -> flush residual wbuf data
            wbuf_jeb = A                       -> c->wbuf_ofs still points
                                                  to refiled old block
            mtd_write                          -> succeeds via NAND AND
            jffs2_verify_write                 -> passed
            if (pad)
            jffs2_link_node_ref
              ref_offset(ref) = c->wbuf_ofs + c->wbuf_len = A+2560
              jeb_A->offset = A
              c->sector_size = 16384
              jeb_A->free_size = 0
              ref_offset(ref) != jeb_A->offset +
                c->sector_size - jeb_A->free_size -> BUG

Case 2: deadlock in jffs2_flush_wbuf_pad():

    User: 1KB write
      A_ref0: [A+0,    A+1092) (ri:68B + data:1024B)

    User: append 1K write
      ...
      jffs2_write_dnode
        jffs2_flash_writev
          c->wbuf_ofs = A+1024, c->wbuf_len = 512
          __jffs2_flush_wbuf
            mtd_write                          -> bit flip
            jffs2_verify_write                 -> verify failed
            jffs2_wbuf_recover
              jffs2_block_refile
                c->nextblock = NULL
                jffs2_link_node_ref            -> mark A remaining
                  A_ref1: [A+1092, A+16384)       space as REF_OBSOLETE
              jffs2_reserve_space_gc
                jffs2_do_reserve_space
                  jffs2_find_nextblock
                    c->nextblock = B
              start = A, end = A+1092
              end - start >= c->wbuf_pagesize  -> recover data in A
              mtd_write
              jffs2_verify_write               -> verify also failed
              jffs2_add_physical_node_ref      -> mark written area in
                B_ref0: [B+0, B+1536)             B as REF_OBSOLETE
              return                           -> c->wbuf_ofs = A+1024
                                                  c->wbuf_len = 512
        retry
        jffs2_flash_writev
          down_write(&c->wbuf_sem)
          if (SECTOR_ADDR(to) != SECTOR_ADDR(c->wbuf_ofs))
                                               -> SECTOR(to) = B
                                               -> SECTOR(c->wbuf_ofs) = A
          __jffs2_flush_wbuf(c, PAD_NOACCOUNT) -> flush residual wbuf data
            wbuf_jeb = A                       -> c->wbuf_ofs still points
                                                  to refiled old block
            mtd_write                          -> bit flip
            jffs2_verify_write                 -> verify failed
            jffs2_wbuf_recover
              jffs2_block_refile
                c->nextblock != jeb            -> jeb = A, nextblock = B
                jffs2_link_node_ref            -> append zero-length ref
                  A_ref2: [A+16384, A+16384)      marked REF_OBSOLETE
                                                  after the existing one
              end = jeb_A->last_node           -> inflates to
                                                  eraseblock tail
              start = A, end = A+16384
              jffs2_reserve_space_gc
                minsize = end - start = 16384
                jffs2_do_reserve_space
                  jeb = c->nextblock           -> points to B
                  jeb_B->free_size = 16384 - 1536
                  minsize > jeb_B->free_size   -> first recovery's OBSOLETE
                                                  ref reduced free_size
                  jffs2_wbuf_dirty(c)
                  jffs2_flush_wbuf_pad(c)
                    down_write(&c->wbuf_sem)   -> already held, deadlock

Fix this by setting c->wbuf_len = 0 when jffs2_verify_write fails in
recovery path, and also in the jffs2_reserve_space_gc() and
jffs2_prealloc_raw_node_refs() failure paths, ensuring subsequent
flushes will not attempt writes on refiled blocks.

Signed-off-by: zhouminqiang <zhouminqiang2@huawei.com>
---
 fs/jffs2/wbuf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index 3b7803c75d58..61e3dbd4cd7b 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -390,6 +390,7 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
 	if (ret) {
 		pr_warn("Failed to allocate space for wbuf recovery. Data loss ensues.\n");
 		kfree(buf);
+		c->wbuf_len = 0;
 		return;
 	}
 
@@ -400,6 +401,7 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
 	if (ret) {
 		pr_warn("Failed to allocate node refs for wbuf recovery. Data loss ensues.\n");
 		kfree(buf);
+		c->wbuf_len = 0;
 		return;
 	}
 
@@ -431,12 +433,13 @@ static void jffs2_wbuf_recover(struct jffs2_sb_info *c)
 
 		if (ret || retlen != towrite || jffs2_verify_write(c, rewrite_buf, ofs)) {
 			/* Argh. We tried. Really we did. */
-			pr_crit("Recovery of wbuf failed due to a second write error\n");
+			pr_crit("Recovery of wbuf failed due to a second write error. Data loss ensues.\n");
 			kfree(buf);
 
 			if (retlen)
 				jffs2_add_physical_node_ref(c, ofs | REF_OBSOLETE, ref_totlen(c, jeb, first_raw), NULL);
 
+			c->wbuf_len = 0;
 			return;
 		}
 		pr_notice("Recovery of wbuf succeeded to %08x\n", ofs);
-- 
2.52.0


