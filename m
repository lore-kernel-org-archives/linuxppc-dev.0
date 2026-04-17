Return-Path: <linuxppc-dev+bounces-19823-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E999AF8E4BB
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 07:52:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxnCt4kFnz2yh4;
	Fri, 17 Apr 2026 17:52:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776412346;
	cv=none; b=S6FPBb98LxTE5q/4cle6on4BnpjE2XeruGGNppunKonUmkc8SATQ533a8GGPqmcyuBwb7GOQQReYiXullY0czjE2Zd+v5nCyyWpfqn9OiPfqh981h85gzqvclzNt+UGHojJlmob/vJMD6lfDW7L/Zz/km8Gx2tPPc79D6d7JYhY1PNnZQHIXfpVmBUDep66DWUHCQYWWb2qWcNqVuoif6oBdUVaBHuxNntc0fF9biNlizvmrnM+4BDrjQdd8LALVbhqEhcV8XBo5wXKP+S3xvMuR7K79mMonOzUZYL3u5/4ivH2eFo8w+40kZNILbL7WInH79oG0Ek9GfELKR5mMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776412346; c=relaxed/relaxed;
	bh=WS7YPZVmugcljsO7oz8p4pAwkAo3QzRxiyGqxUf02hw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SWvB4nOnnF2mTrlwK2jKN1Y6+NrstnwmlM6pzNtTmF7CGmVlmszqyAV/N8jTWsOafhfbF9oYELBDMGB7NKyJdm6wQ/BkLfPRtpXZT8xHwgYjx/Rbx1fKchjdwU7o7BiK3GY/WgRieJoGQpXPeGvRWIQAoHW/4zjdirtKYaP2WzjXhXKI37UaYpjadoGWa7Trhw+zRRvKlnSHKX2SVFFGQiOZ3Zp++AvgV8WcCHFUpVcQcTlP6aac2uqnNjDW9loq4PAfE+aokgLTVFkjKQnW92I/YGHZxSc5IrC0u2nTj5duFPgdRxeQrVYe8/fQN/rE6vQcQBglbk/u+lA38wcajw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxnCs4svKz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 17:52:25 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAAHlwqm5uFp1EfYDQ--.22343S2;
	Fri, 17 Apr 2026 15:52:07 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH] powerpc/eeh: NUL-terminate debugfs command buffers before sscanf()
Date: Fri, 17 Apr 2026 15:52:05 +0800
Message-ID: <20260417075205.29738-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
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
X-CM-TRANSID:zQCowAAHlwqm5uFp1EfYDQ--.22343S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uryxXw15tFWfGryfWry3urg_yoW5JrW7pF
	n0kF13Jw4vqrs7tFnIvF45Zr40grs3Jry3K3y8G397Zr13ZrnF9FyUGFyYqrWkXr4xZF40
	qrsxCFyqvrnrWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUgXo
	cUUUUU=
X-Originating-IP: [111.196.245.116]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

eeh_force_recover_write() and pnv_eeh_ei_write() copy raw userspace
bytes into fixed stack buffers with simple_write_to_buffer() and then
pass those buffers straight to sscanf().

When userspace fills the buffer completely, the copied command is not
NUL-terminated and sscanf() can read past the end of the stack buffer.

Reject oversized writes and reserve one byte for a terminating NUL before
parsing the command string.

Fixes: 954bd99435b8 ("powerpc/eeh: Add eeh_force_recover to debugfs")
Fixes: 4cf174455899 ("powerpc/powernv: Drop PHB operation post_init()")

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/kernel/eeh.c                    | 11 +++++++++--
 arch/powerpc/platforms/powernv/eeh-powernv.c | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index bb836f02101c..681701ffbf33 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1729,11 +1729,18 @@ static ssize_t eeh_force_recover_write(struct file *filp,
 	uint32_t phbid, pe_no;
 	struct eeh_pe *pe;
 	char buf[20];
-	int ret;
+	ssize_t ret;
+
+	if (*ppos != 0 || count >= sizeof(buf))
+		return -EINVAL;
 
-	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf,
+				     count);
+	if (ret < 0)
+		return ret;
 	if (!ret)
 		return -EFAULT;
+	buf[ret] = '\0';
 
 	/*
 	 * When PE is NULL the event is a "special" event. Rather than
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index db3370d1673c..88a4acc11186 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -71,15 +71,22 @@ static ssize_t pnv_eeh_ei_write(struct file *filp,
 	int pe_no, type, func;
 	unsigned long addr, mask;
 	char buf[50];
-	int ret;
+	ssize_t ret;
 
 	if (!eeh_ops || !eeh_ops->err_inject)
 		return -ENXIO;
 
+	if (*ppos != 0 || count >= sizeof(buf))
+		return -EINVAL;
+
 	/* Copy over argument buffer */
-	ret = simple_write_to_buffer(buf, sizeof(buf), ppos, user_buf, count);
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf,
+				     count);
+	if (ret < 0)
+		return ret;
 	if (!ret)
 		return -EFAULT;
+	buf[ret] = '\0';
 
 	/* Retrieve parameters */
 	ret = sscanf(buf, "%x:%x:%x:%lx:%lx",
-- 
2.50.1 (Apple Git-155)


