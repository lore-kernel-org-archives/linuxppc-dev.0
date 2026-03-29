Return-Path: <linuxppc-dev+bounces-18968-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0655010D1495
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 03:22:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fk06x4jW8z2ygh;
	Sun, 29 Mar 2026 14:22:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774754181;
	cv=none; b=J23tCUjmhhaehYVfcgZlX2IeScmQ1JC1RGkXhU0KPNpeoJHRShY5k670O3Ynm+bYl3qqb3wvbID8FM28r9WQRKDyBHBZbn/h5TyH5UvrLSX1ctjdhxnyhChOvbd8T5xZ6BuyTsdpP98+FeD0HITfauTv9WhactFzYRUlCdBhojzCTY25G6YH9gSDpNCXxrkag/dQDqLGlb11QfR8MzhvcjOUbaiFjvsQ/6vc1eu54q6A44MDyvY9FDsHTuF5rQ5dd6U71qIDU2JZcmlWK8EfQ8OoD60dV6UShAYa6Wz5oWGWTMCgDqibHE4vnRG9ehNub574FYtSHjQV9eiSpfhc4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774754181; c=relaxed/relaxed;
	bh=AREMtQmtnVYaAKQXTfzm/2glMLc5k8refDYVvosexCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsiU9TNRDJUIH4x47xq+UOEnFMb5IDjkIp7hcL9H8dxgPjGSi6ld87yYLrfun/zCSlcCZX3wot1ppqNxMtbdPjXXFkU/CyQGeoDh4mY9JdUyZE+hi6mFoMw7VqkfFgn06QmHCokXHrBtE5Mmv4jh6eEh3CH5uhL8ulDKC+IzEjVCrBlxlu1eYxxxa2sveYGljL4kn5S/wEOBUUFweq6Vkk0itsP6luzfnJecRsK0whmX57J0FBSeOUPGszSqXujFk9jmIp2/gA11NEDFSFa1qn7c4QkpN4Efai+Jmnf5JOHXEHW5tCennO6n+KgRqYgLkXXpCZMhrOYaLbo/HOkkwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 386 seconds by postgrey-1.37 at boromir; Sun, 29 Mar 2026 14:16:20 AEDT
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fk0041vNcz2xVT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 14:16:19 +1100 (AEDT)
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAAHsGv2l8hpdOd8Cw--.37861S2;
	Sun, 29 Mar 2026 11:09:43 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: npiggin@gmail.com,
	chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] powerpc/pseries/lparcfg: bound shared processor attribute parsing
Date: Sun, 29 Mar 2026 11:09:42 +0800
Message-ID: <20260329030942.26639-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAAHsGv2l8hpdOd8Cw--.37861S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XF15JFy8WF4xWryDuF15Arb_yoW8Jr17p3
	Z8KF47Kr4kGa4FkasrJF17XF4j93Z0vF4UWw40yasxAa43Xrn0vFsagr1Fvr4xJr1fGw4r
	Z3sIgwn5Wr9rZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUU
	UUU
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

parse_system_parameter_string() copies the shared processor attribute sysparm into a fixed local work buffer one byte at a time, but it never checks whether the next byte still fits. A long token without an early comma or NUL can therefore run past SPLPAR_MAXLENGTH.

Stop parsing once the local token buffer is full instead of writing past the fixed destination.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 8821c378bfff..1bf2312f3e04 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -418,6 +418,10 @@ static void parse_system_parameter_string(struct seq_file *m)
 		w_idx = 0;
 		idx = 0;
 		while ((*local_buffer) && (idx < splpar_strlen)) {
+			if (w_idx >= SPLPAR_MAXLENGTH - 1) {
+				pr_warn_once("lparcfg: shared processor attribute token is too long\n");
+				break;
+			}
 			workbuffer[w_idx++] = local_buffer[idx++];
 			if ((local_buffer[idx] == ',')
 			    || (local_buffer[idx] == '\0')) {
-- 
2.50.1 (Apple Git-155)


