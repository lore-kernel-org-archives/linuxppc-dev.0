Return-Path: <SRS0=doUU=ZI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA88C432C3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Nov 2019 17:03:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FCB2168B
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Nov 2019 17:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDhxz+S6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FCB2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47FhPL4HXfzF4M0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Nov 2019 04:03:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="UDhxz+S6"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Ffkw5Sr0zF3tM
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Nov 2019 02:48:24 +1100 (AEDT)
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id F2E84208CE;
 Sat, 16 Nov 2019 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1573919302;
 bh=jTWzCOQwRiWhKbKWMLAjSFDku8KDuyLw1gEEl2r4qbs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UDhxz+S61siUR1I4oU5T9jTB/nUT0iW6aOGzQPPRaTDqUrbeF/WJNCsLJEdWivqqA
 6TN2OS1DhXG04Io1830XiOvy5NegJZ7+8QjUA+q8IAtT1ndo9SaF38/YyaKYBJRH1m
 xWOASGdqSx1Bnz7pZUTCD82hy874Gq6MzXanP6w0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 048/150] macintosh/windfarm_smu_sat: Fix debug
 output
Date: Sat, 16 Nov 2019 10:45:46 -0500
Message-Id: <20191116154729.9573-48-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

[ Upstream commit fc0c8b36d379a046525eacb9c3323ca635283757 ]

There's some antiquated debug output that's trying
to do a hand-made hexdump and turning into horrible
1-byte-per-line output these days.

Use print_hex_dump() instead

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/macintosh/windfarm_smu_sat.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/macintosh/windfarm_smu_sat.c b/drivers/macintosh/windfarm_smu_sat.c
index da7f4fc1a51d1..a0f61eb853c55 100644
--- a/drivers/macintosh/windfarm_smu_sat.c
+++ b/drivers/macintosh/windfarm_smu_sat.c
@@ -22,14 +22,6 @@
 
 #define VERSION "1.0"
 
-#define DEBUG
-
-#ifdef DEBUG
-#define DBG(args...)	printk(args)
-#else
-#define DBG(args...)	do { } while(0)
-#endif
-
 /* If the cache is older than 800ms we'll refetch it */
 #define MAX_AGE		msecs_to_jiffies(800)
 
@@ -106,13 +98,10 @@ struct smu_sdbp_header *smu_sat_get_sdb_partition(unsigned int sat_id, int id,
 		buf[i+2] = data[3];
 		buf[i+3] = data[2];
 	}
-#ifdef DEBUG
-	DBG(KERN_DEBUG "sat %d partition %x:", sat_id, id);
-	for (i = 0; i < len; ++i)
-		DBG(" %x", buf[i]);
-	DBG("\n");
-#endif
 
+	printk(KERN_DEBUG "sat %d partition %x:", sat_id, id);
+	print_hex_dump(KERN_DEBUG, "  ", DUMP_PREFIX_OFFSET,
+		       16, 1, buf, len, false);
 	if (size)
 		*size = len;
 	return (struct smu_sdbp_header *) buf;
@@ -132,13 +121,13 @@ static int wf_sat_read_cache(struct wf_sat *sat)
 	if (err < 0)
 		return err;
 	sat->last_read = jiffies;
+
 #ifdef LOTSA_DEBUG
 	{
 		int i;
-		DBG(KERN_DEBUG "wf_sat_get: data is");
-		for (i = 0; i < 16; ++i)
-			DBG(" %.2x", sat->cache[i]);
-		DBG("\n");
+		printk(KERN_DEBUG "wf_sat_get: data is");
+		print_hex_dump(KERN_DEBUG, "  ", DUMP_PREFIX_OFFSET,
+			       16, 1, sat->cache, 16, false);
 	}
 #endif
 	return 0;
-- 
2.20.1

