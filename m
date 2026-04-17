Return-Path: <linuxppc-dev+bounces-19821-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB2EF8E4B8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 07:45:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxn3c1DQnz2yh4;
	Fri, 17 Apr 2026 17:45:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776411916;
	cv=none; b=Nohe16+BhtQgl1S+hpkeU57R2h0a0Kj0/feNzphH6+mxVYkSAMNmEe9aqF3uRJ/46VjyYjui/2k82KU/Dj4pnQQbLivwo2wcairREzMOuoIkLSgTnECHoZbowrPLQxNtsqOxQW9CCAGyukAXt/TSNAS/dLZp8vtCT07DHTfSGO+eg6myfmWwI7lJ1JBqOiTnSmo9/K8eznjceCbKJXJxfOA6kHdpJhQuKthom9juUIXby4mvO9UGvBrOKZZMFhq25h8kghEtzaJsRrOxo6FkjMLJmqHCeooTtq61nzaeoLP78ZDvWwseArGNdoV1/DhMlAyDBqLGSg/v6vFnhDLGxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776411916; c=relaxed/relaxed;
	bh=WdORREwd/qrPPIN50XQT21c6ML3r9KasGOu3bolyemY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=befvmCc2hDGY+U9VWIfQpm3Yy/+RYuUbB2ZiKv/kp15eTo1w7w+Z9FeocAzqYHImL+pSMeK05hZJ7uM1h46fhuW56DYOIbY8/yxaIGwGQArgMx5aO3gKshe96ALDqlyrmW82njRleyWLFfM70H7xbQCWn9ElX8fNoX9GZMeTufUzUYaiyD4MRlXr6/y0thAWhOkYlrCkztIHxRm1xlpUKc/0tc4s/kxemd5lQZiwkAG3aCU85R5euEdNtfxiFZc/GSdCsZzgH6OWGcZbkt1RJIrLhkpXGQEAAPsnW1AN97YtN4HH7sKw+R4dSiz0i/SFmaSFdPjEX+TftVfe6oHH0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxn3b0bRYz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 17:45:14 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowABn9gkD5eFpnx3YDQ--.24269S2;
	Fri, 17 Apr 2026 15:45:07 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] powerpc/powernv: allocate sensor group names to fit the OF node name
Date: Fri, 17 Apr 2026 15:45:05 +0800
Message-ID: <20260417074505.16178-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:zQCowABn9gkD5eFpnx3YDQ--.24269S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry5Ar1rZrW3WF1rWFWfKrg_yoW8CF45pF
	sYkFnI9a18ury8Ja98K34j9a1fKan5AFW2gr1UJ3sayFsxZr9FvF40yF1YyrZrJr4rGw1j
	gF43Xw13CFnxGFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDOz
	3UUUUU=
X-Originating-IP: [111.196.245.116]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

opal_sensor_groups_init() stores each sensor-group name in a fixed
char[20] field and formats it with "%pOFn" or "%pOFn%d".

The node name comes from firmware and is not bounded to fit in 20 bytes,
so formatting the fully qualified group name can write past the end of
the embedded buffer.

Allocate the group name string to fit the formatted result instead of
storing it in a fixed-size array.

Fixes: bf9571550f52 ("powerpc/powernv: Add support to clear sensor groups data")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/platforms/powernv/opal-sensor-groups.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal-sensor-groups.c b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
index 87fd6d7769e9..f940c223f1b5 100644
--- a/arch/powerpc/platforms/powernv/opal-sensor-groups.c
+++ b/arch/powerpc/platforms/powernv/opal-sensor-groups.c
@@ -23,7 +23,7 @@ struct sg_attr {
 };
 
 static struct sensor_group {
-	char name[20];
+	char *name;
 	struct attribute_group sg;
 	struct sg_attr *sgattrs;
 } *sgs;
@@ -207,9 +207,12 @@ void __init opal_sensor_groups_init(void)
 		}
 
 		if (!of_property_read_u32(node, "ibm,chip-id", &chipid))
-			sprintf(sgs[i].name, "%pOFn%d", node, chipid);
+			sgs[i].name = kasprintf(GFP_KERNEL, "%pOFn%d",
+						node, chipid);
 		else
-			sprintf(sgs[i].name, "%pOFn", node);
+			sgs[i].name = kasprintf(GFP_KERNEL, "%pOFn", node);
+		if (!sgs[i].name)
+			goto out_sgs_sgattrs;
 
 		sgs[i].sg.name = sgs[i].name;
 		if (add_attr_group(ops, len, &sgs[i], sgid)) {
@@ -225,6 +228,7 @@ void __init opal_sensor_groups_init(void)
 
 out_sgs_sgattrs:
 	while (--i >= 0) {
+		kfree(sgs[i].name);
 		kfree(sgs[i].sgattrs);
 		kfree(sgs[i].sg.attrs);
 	}
-- 
2.50.1 (Apple Git-155)


