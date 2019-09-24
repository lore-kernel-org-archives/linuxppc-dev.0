Return-Path: <SRS0=kV/c=XT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB92EC4320D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 17:03:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E892F214AF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 17:03:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0cAdPce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E892F214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46d6w96rtXzDqMl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Sep 2019 03:03:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="i0cAdPce"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46d6TD2B7tzDqSV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Sep 2019 02:43:44 +1000 (AEST)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 909D6217D9;
 Tue, 24 Sep 2019 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1569343422;
 bh=krP95kJpB0a0xTJ3F8JGhh+MB+OwJOuNWiIa/d8ubwc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i0cAdPcezdf9j0COqnZ701kLOBek/bL8eK6h8RutYAQMp12DcFH9VzjaDZVwg8L/E
 tIfYNd5xupyrAOLSxwulFBtTOGvBEAS1qTr7ckXNhSxmTvsFGOusPQc0NjIyBBOJ5R
 /k+evZm9ENQaGnodGjkimKAuXVrgsow8XK9yDGQY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.3 44/87] powerpc/ptdump: fix walk_pagetables()
 address mismatch
Date: Tue, 24 Sep 2019 12:41:00 -0400
Message-Id: <20190924164144.25591-44-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924164144.25591-1-sashal@kernel.org>
References: <20190924164144.25591-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Christophe Leroy <christophe.leroy@c-s.fr>

[ Upstream commit e033829d2aaad85cb7cf46986c3be0bcc72f791e ]

walk_pagetables() always walk the entire pgdir from address 0
but considers PAGE_OFFSET or KERN_VIRT_START as the starting
address of the walk, resulting in a possible mismatch in the
displayed addresses.

Ex: on PPC32, when KERN_VIRT_START was locally defined as
PAGE_OFFSET, ptdump displayed 0x80000000
instead of 0xc0000000 for the first kernel page,
because 0xc0000000 + 0xc0000000 = 0x80000000

Start the walk at st->start_address instead of starting at 0.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/5aa2ac513295f594cce8ddb1c649f61947bd063d.1565786091.git.christophe.leroy@c-s.fr
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/ptdump/ptdump.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 6a88a9f585d4f..5d6111a9ee0e7 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -299,17 +299,15 @@ static void walk_pud(struct pg_state *st, pgd_t *pgd, unsigned long start)
 
 static void walk_pagetables(struct pg_state *st)
 {
-	pgd_t *pgd = pgd_offset_k(0UL);
 	unsigned int i;
-	unsigned long addr;
-
-	addr = st->start_address;
+	unsigned long addr = st->start_address & PGDIR_MASK;
+	pgd_t *pgd = pgd_offset_k(addr);
 
 	/*
 	 * Traverse the linux pagetable structure and dump pages that are in
 	 * the hash pagetable.
 	 */
-	for (i = 0; i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
+	for (i = pgd_index(addr); i < PTRS_PER_PGD; i++, pgd++, addr += PGDIR_SIZE) {
 		if (!pgd_none(*pgd) && !pgd_is_leaf(*pgd))
 			/* pgd exists */
 			walk_pud(st, pgd, addr);
-- 
2.20.1

