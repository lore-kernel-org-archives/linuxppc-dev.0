Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BD9606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 05:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BBkRLJ9t
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFXrG2vsWz30NF;
	Thu, 29 Oct 2026 16:30:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793251838;
	cv=none; b=gU0ziNqZ4rzD+zYjOUVk0YRVpmFLtQQLHzHX9gnY2tkFbu6wmZR+oQ4cDbXHku1fpKGvI7pw+abD/BnzQjsTzi3fknHx3CibM5GJMLGICY3jWhQlHhvJiOo48Mz/2XdoxlluvmxfU5H3+2vLIg02jtA9c/WXIoNV9+oVnr85RoF/PFvymNh3uMbkVkTJE+r9/sBjudsVSsgoUyJ3br0BSis9GamAk9QC0LoisfIvinx7PBCmrHaoVl+shz/2UpSeu0YJw8seChRD0ijGGVpDNLRUYH4jy8b9OLPB4YHHju3ZzhYzXQHlsdhwT+IM3FzAk9yej8pbxNrcsEAFtPBrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793251838; c=relaxed/relaxed;
	bh=aaGFXjlWznnwtHjFBVxR5yr0lhNmkbRMpFW9Kta8BMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bj+nl9miRts+6b/GCfrc97WyJYx/BwMzbKbNYuKl18pr4QrvuLC9wF/56/AqglCsvlImtBcw6UD9r8Odf1bI9X2LUwt3ZefYENMbPDforQ8qBIaoki3JFFJAJBXN0gXzESM6mnLbqEbvo5UKSw/8KUxUbRB8EZqmycvfbuWDdSh6PxSWYsCnFdjOxuCnQj74YW+PN0qLq6igONHpmQNQ0/ZCNsvCQsjsPwmWM7borvooqkI2+qrlyLLZ1mGACePHeuupFGX97HeDGOW6g4yW47n4BooUFHeGDdVttIZdaJmHDr+IdzhMiTMTwWfDuQRlaDaG6YWiBGdDixpjqrWvgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BBkRLJ9t; dkim-atps=neutral; spf=pass (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=BBkRLJ9t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.2; helo=m16.mail.163.com; envelope-from=yaojiale02@163.com; receiver=lists.ozlabs.org)
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFXr94RW0z30MZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 16:30:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=aa
	GFXjlWznnwtHjFBVxR5yr0lhNmkbRMpFW9Kta8BMc=; b=BBkRLJ9tZR6uSVjOgB
	rAHBRSnc0ILF+NcxLsofyApktFj6JdH8fa7L1+4FJiW36BbnGWZKJ9bIw+WERW3F
	saaYHTbm/Uti6cZUWA22V/XYm+RrxeN6spJ/L5ZxXHOpzbh0BV0lID9/tgb0JMQd
	ikEl+EGcFMviyI91CJW1UUTLQ=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3P2nN2eJq1iVeDg--.22839S2;
	Thu, 29 Oct 2026 13:29:50 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] powerpc/eeh: NUL-terminate force recovery input
Date: Thu, 29 Oct 2026 13:29:48 +0800
Message-Id: <20261029052948.2525048-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P2nN2eJq1iVeDg--.22839S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrtF1xtF4xWw1rAF1kZFy7Jrb_yoW8Jr15pr
	n0kFZxtw48JFn3J3WqkF43Z34jgrs7Zryaga1kW393Zr12vryq9ryUuFyaqr48tryIgF40
	qrs0kFyUKwnrGw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjhFsUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ78N2ri2c7tOAAA3C
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

eeh_force_recover_write() can fill its entire stack buffer from userspace
and then pass the unterminated data to strncmp() and sscanf(). This can
make the string helpers read beyond the buffer.

Reserve the last byte and initialize the buffer so every accepted input is
NUL-terminated. Propagate copy errors before parsing as well.

Fixes: 954bd99435b8 ("powerpc/eeh: Add eeh_force_recover to debugfs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 arch/powerpc/kernel/eeh.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index bb836f02101c..2d7898ef6b8c 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1728,10 +1728,12 @@ static ssize_t eeh_force_recover_write(struct file *filp,
 	struct pci_controller *hose;
 	uint32_t phbid, pe_no;
 	struct eeh_pe *pe;
-	char buf[20];
+	char buf[20] = {};
 	int ret;
 
-	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
+	if (ret < 0)
+		return ret;
 	if (!ret)
 		return -EFAULT;
 
-- 
2.34.1


