Return-Path: <linuxppc-dev+bounces-26621-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F99CC79F8B
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Sep 2026 03:32:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hcwkB66D0z30dl;
	Sun, 06 Sep 2026 13:32:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788665538;
	cv=none; b=nbfLUBcCL+9cKg+XW8Gg5gycU5FRJ/MLw8Igdr0szJsS2iIIwu7xi1/Riot5Y1rDXLMrvu4cJ/svYpEEyy1juYj5JU3SH5nXeoRXJpdDORMCbk7Dmss5b8JYsUvVHkEzEPmnSNaDoAKkhA8meqZY4M7w6FCBNPGGSijX/FcPG2j06Sd2NIyESD+5TBisbuZGDc1hkDZ+l7SGvARVYk/SpqxPx7IfgzocJypU/1+9h56mLzW4V9lUIyMw73uSaxrn1JnMdHlz61m1CNKruAbunoucu4EBhIewp7Hz39vbF7T6tuX3rKuXwcHPSDORnbi+ddr2EUYTMIMtgiwbdnhdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788665538; c=relaxed/relaxed;
	bh=snWICU6AC2JZQJZRiWf8t0K43GqKTPeHjn4VouF9UAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6i5rcdXXONBegvaJFhZz2KpNYoBk12a3nxU2S7YgcPNZS+jiEtnAOhSuE16K7vNFtlx8brVMg9c5XHLUOmaZNwalZC3dXtYoOMNWzv7mtP0DoPjKEyKdIWErgtW+cKZBnNjnlj8oGotDtA3I7A/L4VWwA1F1OgYdZTDJj1S/k9el9Al1+W1mO+GkDuKUc8wUtpoVJdWgS3eeJsgyHqnW9ONBcIL3FiPN5/YvTrspbMqWWiRxQ5IPy1YoqaLupwrjvagHXkhSZFi5VtNlctuAo2r1PEJ8j10DAtYiMa/cTuHl+QN/cWqJsvpfayV9kI/mpe1E5pOxnmg6DazzSc5+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=zhouminqiang@huaweicloud.com; receiver=lists.ozlabs.org) smtp.mailfrom=huaweicloud.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huaweicloud.com (client-ip=45.249.212.56; helo=dggsgout12.his.huawei.com; envelope-from=zhouminqiang@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hcwk82sPxz30Gq
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 13:32:16 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hcwGK4F2BzKHMQZ
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Sep 2026 11:11:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 83D104056B
	for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Sep 2026 11:12:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP1 (Coremail) with UTF8SMTPSA id cCh0CgBnUAsW2pxqmzytAw--.18069S5;
	Sun, 06 Sep 2026 11:12:35 +0800 (CST)
From: Zhou Minqiang <zhouminqiang2@huawei.com>
To: linux@armlinux.org.uk,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com,
	maddy@linux.ibm.com,
	dwmw2@infradead.org,
	richard@nod.at
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org,
	chengzhihao1@huawei.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	zhouminqiang <zhouminqiang2@huawei.com>
Subject: [PATCH v4 1/8] jffs2: wbuf: clear wbuf on recovery failure paths
Date: Sun,  6 Sep 2026 11:03:37 +0800
Message-ID: <20260906030344.2448622-2-zhouminqiang2@huawei.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260906030344.2448622-1-zhouminqiang2@huawei.com>
References: <20260906030344.2448622-1-zhouminqiang2@huawei.com>
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
X-CM-TRANSID:cCh0CgBnUAsW2pxqmzytAw--.18069S5
X-Coremail-Antispam: 1UD129KBjvJXoW3AF4UWw17Gw4DKF47try3XFb_yoW7CrW3pr
	ZIyF13Ar45Kr1xJFs5tF15XrW8u3y8Gr1IgrWruw1xXF4vqr1aganaqFy8uFW0yrZ2qa10
	kwsYk3y7Xr1jy3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF04k20xvEw4C26cxK6c8Ij28IcwCFx2IqxVCF
	s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
	1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8
	JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxUV0PfDUUUU
Sender: zhouminqiang@huaweicloud.com
X-CM-SenderInfo: 52kr3z5lqtxttqj6x35dzhxuhorxvhhfrp/

From: zhouminqiang <zhouminqiang2@huawei.com>

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


