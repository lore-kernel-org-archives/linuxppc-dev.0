Return-Path: <linuxppc-dev+bounces-19822-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181F1F8E4B8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 07:48:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxn7S2xKdz2yh4;
	Fri, 17 Apr 2026 17:48:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776412116;
	cv=none; b=e1n2zxUbMjwYug9PlzoSq8uvwmaub9DQ+3QYJC6+FfX4FBuMpn6MQIr0B597sjFFNgUMRL/945OI6ft627QbYomAt6yYRxTYDB4+IJhvoaKc5slXSL9EvbHHy6nJnHWwvuiT2ZEa1CjIo6jlFAvijVw1sa0Sd+7X88A8Gvbj8e4Qk5u7E8Arx0Im8E/0+C/ZL7RWRPvaXY2DpeGTPfrqHanK5JAPiTQBX4w0fvvDPhDSbQ7Yejo6RhdmojcfiJXurP4STzZPltMzWRbrRgmJhQjW+nEDET3B6I9lylwFt9bKzBScBFbaMnJjSOOTp1YULrP8Os9tHsG044zsSi/JBw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776412116; c=relaxed/relaxed;
	bh=XDAThG0yRn/HWC1IcfrgXuB/3VOoHTEOJu87Gp3N/oM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BC/s3q/5CD6T/sd6FfxKn27J3V9YXr2PlN9NPgUhgZubZFAxWGWIkyS6/Z7gXCexznSzTCMLB2GglgQvN7iMFroYYkSKukgSUUr4xFucToz73cn+mx53yFrdPcE9+lelOxwxsg8H1DlSoV3Ign5RJyA/Ct9RX09VQ9lVSj5C6u1jrtnOnYhv23+mi39hv0MMkRnhegkZtYSSrUv0gOgtJQN3MElGzDTZ7KtasgyALBUjK//8Z/dVZZLjl1bIl2k4Ve9X6hSWkt0Bz31T9nUOKfJXbH3Yum4bNqGdlEA43v5i9O7E1S9G/GRKn5QcF27kroZpScLKfDd8sSikWMiCIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.25; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxn7R3kWFz2xpt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 17:48:35 +1000 (AEST)
Received: from localhost.localdomain (unknown [111.196.245.116])
	by APP-05 (Coremail) with SMTP id zQCowAC3RgrL5eFpAzHYDQ--.61365S2;
	Fri, 17 Apr 2026 15:48:28 +0800 (CST)
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
Subject: [PATCH] powerpc/perf/hv-gpci: bound sysfs formatting with sysfs_emit_at()
Date: Fri, 17 Apr 2026 15:48:25 +0800
Message-ID: <20260417074825.22967-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:zQCowAC3RgrL5eFpAzHYDQ--.61365S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr13Wr15ury7Zry7ur17Jrb_yoWrJw43p3
	WfKr4q9rs5Xw17CrWIkF1xZw15W397A347WrW2g393ArsxX3909FyUKFyY9ry8GFWrCa48
	urZxKrs0krnrJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

systeminfo_gpci_request() and
affinity_domain_via_partition_result_parse() hex-encode hypervisor data
into the single-page sysfs read buffer with sprintf(buf + *n, ...).
Both helpers only check PAGE_SIZE after the formatting loops have already
advanced past the end of the buffer.

Switch these appends to sysfs_emit_at() and stop once the sysfs buffer is
full.

Fixes: 71f1c39647d8 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show processor bus topology information")
Fixes: a15e0d6a6929 ("powerpc/hv_gpci: Add sysfs file inside hv_gpci device to show affinity domain via partition information")
Cc: stable@vger.kernel.org

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/perf/hv-gpci.c | 56 +++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 5cac2cf3bd1e..325b80f01629 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -11,6 +11,7 @@
 
 #include <linux/init.h>
 #include <linux/perf_event.h>
+#include <linux/sysfs.h>
 #include <asm/firmware.h>
 #include <asm/hvcall.h>
 #include <asm/io.h>
@@ -134,6 +135,7 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
 			size_t *n, struct hv_gpci_request_buffer *arg)
 {
 	unsigned long ret;
+	int len;
 	size_t i, j;
 
 	arg->params.counter_request = cpu_to_be32(req);
@@ -176,9 +178,17 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
 	for (i = 0; i < be16_to_cpu(arg->params.returned_values); i++) {
 		j = i * be16_to_cpu(arg->params.cv_element_size);
 
-		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[j]);
-		*n += sprintf(buf + *n,  "\n");
+		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size);
+		     j++) {
+			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[j]);
+			if (!len)
+				return -EFBIG;
+			*n += len;
+		}
+		len = sysfs_emit_at(buf, *n, "\n");
+		if (!len)
+			return -EFBIG;
+		*n += len;
 	}
 
 	if (*n >= PAGE_SIZE) {
@@ -465,6 +475,7 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
 			int element_size, char *buf, size_t *last_element,
 			size_t *n, struct hv_gpci_request_buffer *arg)
 {
+	int len;
 	size_t i = 0, j = 0;
 	size_t k, l, m;
 	uint16_t total_affinity_domain_ele, size_of_each_affinity_domain_ele;
@@ -483,22 +494,49 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
 	 */
 	while (i < returned_values) {
 		k = j;
-		for (; k < j + element_size; k++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
-		*n += sprintf(buf + *n,  "\n");
+		for (; k < j + element_size; k++) {
+			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[k]);
+			if (!len) {
+				*n = PAGE_SIZE;
+				return;
+			}
+			*n += len;
+		}
+		len = sysfs_emit_at(buf, *n, "\n");
+		if (!len) {
+			*n = PAGE_SIZE;
+			return;
+		}
+		*n += len;
 
 		total_affinity_domain_ele = (u8)arg->bytes[k - 2] << 8 | (u8)arg->bytes[k - 3];
 		size_of_each_affinity_domain_ele = (u8)arg->bytes[k] << 8 | (u8)arg->bytes[k - 1];
 
 		for (l = 0; l < total_affinity_domain_ele; l++) {
 			for (m = 0; m < size_of_each_affinity_domain_ele; m++) {
-				*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
+				len = sysfs_emit_at(buf, *n, "%02x",
+						    (u8)arg->bytes[k]);
+				if (!len) {
+					*n = PAGE_SIZE;
+					return;
+				}
+				*n += len;
 				k++;
 			}
-			*n += sprintf(buf + *n,  "\n");
+			len = sysfs_emit_at(buf, *n, "\n");
+			if (!len) {
+				*n = PAGE_SIZE;
+				return;
+			}
+			*n += len;
 		}
 
-		*n += sprintf(buf + *n,  "\n");
+		len = sysfs_emit_at(buf, *n, "\n");
+		if (!len) {
+			*n = PAGE_SIZE;
+			return;
+		}
+		*n += len;
 		i++;
 		j = k;
 	}
-- 
2.50.1 (Apple Git-155)


