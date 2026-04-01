Return-Path: <linuxppc-dev+bounces-19165-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FAF10F6FD9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:03:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm8sr36jsz2yjV;
	Thu, 02 Apr 2026 03:03:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775059408;
	cv=none; b=Ka+9ofnZWIuaGBeznt+HOA/bwphXipQ91pZFJcvmKKgsuyzSll6yEq3eU2KKtVMs/b6A8jd48AKyvKIKuoTDtwNn8NBOOD7MXf67HajxR4ALiz907D7J6HiX6Op1JvpFxKjqfrPUuiUee5SG91m2zRaCxJeekpDctLpE4pwlJ8XSzYtPCaB/OkaU6sq/EqhO4MbAdPTTlYZ1psZBz3MnV5eXfKvD6krSoHA6JL1/fCm6FmacRz42E27dsCb6osT5OI5+n61xq9DmMlFNM4CD3OaBFHIGLnfxXGqZF6xVIQgiN1G0yepUMl2abZi6dzAmXDyIGxbfSCP+po6pOqhioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775059408; c=relaxed/relaxed;
	bh=maK/wuz7hYU/pSyGYWCmniHyismxH0QLM+3rWruQVhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdP7MXhpSse8KIDSeu4QvqQzJ+hGsu8hDxp+dH1QvYljZEs7uuTg+m5IPBO8RTK/kuu/17w37eDBuGSyC7lcASX/Kmd0PgPIqFdl7w4kqAMFmuKYkzydOGud08LbfZ0LLHZhB2p0KITsvKfkaFwUy0BLWS/8QZ9/m5M705EC2xoft9KwA12hpgZ5KQsbL22LEM7fMr71K3sp6siBBfMABpXeutFRyBmfhOe/btirPo/+yRo/PWRcb81eUO6ENLA4QYHmhniVpBj9X7azy7o3x4pgxb08a/EhW3xt/ir/I80YSFB4OXCLgGUJvRDgvv6fwQZHjvWHk4uvndS9QxbklA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm8sp6Vsyz2yhZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 03:03:23 +1100 (AEDT)
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAC3XWnEQc1p7hThCw--.21092S2;
	Thu, 02 Apr 2026 00:03:17 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	srikar@linux.ibm.com,
	sshegde@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] powerpc/rtas_flash: bound validate-flash message strings
Date: Thu,  2 Apr 2026 00:03:16 +0800
Message-ID: <20260401160316.88567-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAC3XWnEQc1p7hThCw--.21092S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFy3WF1furyUJF47Gr4DArb_yoW8JFWfp3
	sYkrW7tas8JFWrJF9rtrn3uF4YgayDJFyfWF4qk34kA3W2qFyvgFn5W34xtr4qgF1ktr1r
	ua1DtF1YgF1Yg37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbtxhJ
	UUUUU==
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

get_validate_flash_msg() appends args_buf->buf to the userspace-visible
status message with a plain %s conversion. The firmware validation path
copies a full 4096-byte buffer through args_buf->buf, so the status
message builder can walk past the end of that fixed buffer looking for a
terminator.

Limit the appended message to the validated buffer size.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/kernel/rtas_flash.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_flash.c b/arch/powerpc/kernel/rtas_flash.c
index 583dc16e9d3c..5b3c6f3a11cd 100644
--- a/arch/powerpc/kernel/rtas_flash.c
+++ b/arch/powerpc/kernel/rtas_flash.c
@@ -455,8 +455,10 @@ static int get_validate_flash_msg(struct rtas_validate_flash_t *args_buf,
 		n = sprintf(msg, "%d\n", args_buf->update_results);
 		if ((args_buf->update_results >= VALIDATE_CUR_UNKNOWN) ||
 		    (args_buf->update_results == VALIDATE_TMP_UPDATE))
-			n += snprintf(msg + n, msglen - n, "%s\n",
-					args_buf->buf);
+			n += snprintf(msg + n, msglen - n, "%.*s\n",
+				      (int)strnlen(args_buf->buf,
+						   args_buf->buf_size),
+				      args_buf->buf);
 	} else {
 		n = sprintf(msg, "%d\n", args_buf->status);
 	}
-- 
2.50.1 (Apple Git-155)


