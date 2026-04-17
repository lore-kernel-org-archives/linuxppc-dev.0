Return-Path: <linuxppc-dev+bounces-19820-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE2AF8E4B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 07:39:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxmwp4312z2yh4;
	Fri, 17 Apr 2026 17:39:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776411562;
	cv=none; b=FcvXM895pcdyD+N60wL+/rhYBT60yhbwpYTnvcYZ+U42Al5B3wsB1SzHf8XlGddTE5zy1mcpPvUg2LhOYm5L6jxMZF1MFcDAVSGO+18EqSok3Dw8dhKCXgUeddZTk3IJwHjdJMYOe7ATd/66SrR7zt41IK0pbsOLRqhVEQG541oFQAYJOWf91Cl6Rf/P495nAj9EGdt1IaroUG68YYZQaVvABaoCOToBm+WqivhNDm5vQIy9Y6EZcf/iVc8hm6uVnlw6Z9e8EvskWqdzgVAOrLViiUwUYeGhxBvqw3kpI9RoyJAv++BWyq2L0U47ZzpoP7XOvNl4VY45L3dTgOB7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776411562; c=relaxed/relaxed;
	bh=j0/gV7yocmu0fgy6XiEhkYdc+nmzFc1Knwg28nisQ+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eitwZIWQ0Z4l4MbJnjTMB1kumM+gOjXinZRNcKtvhXb7Te14QU4I/KQbUGAXZijpndjnywk2cV+pNyG5Oj5MkjkiMGITyHUE3SLMIgemDPoz/PWehBP2vE3i4qKesTmEGq5eizlZevDPefi0Ia/wjBA6ayG2PRM5tIgbKWEk8xmPfltVaQeOutx/TZAjeXs6HkuD11WKJ7a3jNBbm7DhhFcjjJJSaAc54Dqq1Tdkt0whL3kd4dB5mKdKRNXJXL8plaBM/WYdgIOt7W2TekDOxjJfyTXijaS3Fe2ljOFdC2jhCjoTnP/UXgqNCFpakCBzM6x+n9Sn3g67wUUV+R8H+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxmwn3Q2bz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 17:39:19 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowADHVQmd4+Fptf7XDQ--.39774S2;
	Fri, 17 Apr 2026 15:39:09 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Jiri Bohac <jbohac@suse.cz>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/fadump: reject empty bootargs_append writes
Date: Fri, 17 Apr 2026 15:39:07 +0800
Message-ID: <20260417073907.4985-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:zQCowADHVQmd4+Fptf7XDQ--.39774S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry7GF4kCF15tFWrAFy7Wrg_yoWDuFX_Jw
	nrXFZ3Grs0qa12vFn0yFWYvr1xKanrWFy0kw12v3y3AF4DZa17Zw4fAFn5ArnrJFWkArZ8
	CFyIv3s7Z3W0gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-Originating-IP: [111.196.245.116]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

bootargs_append_store() indexes params[count - 1] when stripping a
trailing newline from the sysfs write buffer.

kernfs passes zero-length writes through to the store callback, so an
empty write makes that newline check read before the start of params.

Reject empty writes before looking at the last input byte.

Fixes: 683eab94da75 ("powerpc/fadump: setup additional parameters for dump capture kernel")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/kernel/fadump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 4ebc333dd786..03ab5565e420 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1479,6 +1479,9 @@ static ssize_t bootargs_append_store(struct kobject *kobj,
 	if (!fw_dump.fadump_enabled || fw_dump.dump_active)
 		return -EPERM;
 
+	if (!count)
+		return -EINVAL;
+
 	if (count >= COMMAND_LINE_SIZE)
 		return -EINVAL;
 
-- 
2.50.1 (Apple Git-155)


