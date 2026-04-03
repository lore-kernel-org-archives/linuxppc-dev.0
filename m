Return-Path: <linuxppc-dev+bounces-19307-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96A3E88D94
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 08:51:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnq842JQGz2yYJ;
	Sat, 04 Apr 2026 19:51:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775292692;
	cv=none; b=l7FVPolLOKdGN2lx76n3nMY18Zs8sc36K84Iop4eGoPzrRB/GjVi3sqZhzkhr8ThC4fxzDYeggnkZuiFdRoO9a7vKh+++mLULfdzPZl3FDprrI4adXUH2juUMLuDPQLwzglj+T8XjWIOFtIen32xp3X55h1WYaxOa97LWenjOEzTB+XrwEuoY0OUdK5Cv0qsdYLkxH5C+Ire3WOdHBhe/pF/TgPVkBqCCn61zO4442TAwkkjJPavR9K4gx1XgZkmQQlfby+v8zJd+Kpn+P88r3g57hhrmq/2u3nZcs7nr5Jbq4f9If740zzeScWurClMiOBKkVJ+Iq5iq8cb8OLSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775292692; c=relaxed/relaxed;
	bh=1mpD1bDbjcLnXe+o1oUFx3zEgJ5MkrONX/rIQiw//RE=;
	h=From:Date:Message-ID:To:Cc:Subject; b=BdoreYHSh6OH05haGUbjCfDwDYeRkJ6IxqkcWcrgUiGBeG/LyIiE/MyJrmoOF/5OGOsHq7ToDfrofdt3AKOkpeX/4u6VIv/lmUlj5kHBqnNRsStx8n4PytL9OJgtjU7JCEppDAdjaSw9z1nt+7Bdj/CJM5rvpqHD1ci99GaqzPrheAOLez4r5LxNQqwPRbjMALhu2/o2zMER/t4zW++atGtOVJ5+4ptXhxEtNj6RkN2edzVO66BCiDki+EIxaCn6YsF8p3IwURQdciAC71s9S11il+ZrF9p+cVoTkL4OWhQY2DAfJSmzNc5hCU3kKV/EozSoDKEslXHIblP6KTnqcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnq826MQNz2yVB
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 19:51:28 +1100 (AEDT)
Received: from 0005-powerpc-boot.eml (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAD3hAgH0dBpKbVzDA--.7742S2;
	Sat, 04 Apr 2026 16:51:19 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 3 Apr 2026 16:56:36 +0800
Message-ID: <20260404101005.5-powerpc-boot-pengpeng@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] powerpc/boot: validate compatible entries before comparing
 them
X-CM-TRANSID:zQCowAD3hAgH0dBpKbVzDA--.7742S2
X-Coremail-Antispam: 1UD129KBjvJXoWruw13CFyDKry7Aw1UKrW7Arb_yoW8JryxpF
	Z0yF9Fy3yrWw4UAay3KF1rWFyYvwn2kF4Utw4DW34kArnFqFy0gF1jkF1YvrW8WFySg3yS
	vFWrKw10vF4fWaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_Grv_XF1l8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIF
	xwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x0JUmjgxUUUUU=
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
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

`dt_is_compatible()` reads a raw `"compatible"` property into `prop_buf`
and then immediately calls `strcmp(buf + pos, compat)` on each string-list
entry.

If the current entry is not NUL-terminated within the returned property
length, `strcmp()` reads past the end of the local buffer before the
following `strnlen()` has any chance to reject the malformed property.

Validate the current entry with `strnlen()` first and only compare
bounded, terminated compatible strings.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/boot/devtree.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 58fbcfcc98c9..d93822f61831 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -343,11 +343,16 @@ int dt_is_compatible(void *node, const char *compat)
 	if (len < 0)
 		return 0;
 
-	for (pos = 0; pos < len; pos++) {
+	for (pos = 0; pos < len; ) {
+		int entry_len = strnlen(&buf[pos], len - pos);
+
+		if (entry_len == len - pos)
+			return 0;
+
 		if (!strcmp(buf + pos, compat))
 			return 1;
 
-		pos += strnlen(&buf[pos], len - pos);
+		pos += entry_len + 1;
 	}
 
 	return 0;
-- 
2.50.1 (Apple Git-155)


