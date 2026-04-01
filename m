Return-Path: <linuxppc-dev+bounces-19169-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ED810F6FD9
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 16:03:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fm8sv1vWrz2yql;
	Thu, 02 Apr 2026 03:03:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775059411;
	cv=none; b=cC8dw+gtryW6Casuow2V4M4Ysso+SfCOVINZB8fgPfjzjAlgaIzDCjO72u4CUX560ir2lFrQ8mmRzNabP/II3Lv14G6aoAtkNcirIi4+1AXC7SDFfSwa05drbwbdWHZe/2Z4hVnnkwVbOE91KPir/2ZbQWC5FYu3Z1fUy6yL1Z8BhyKhS4IAJv4zFNkbnPozZQX0PjCdbuuJ3E8J3Mc97vdMubWXamXNGVaSExWBxSUiPb+M2/EviH6PHT5GmXOVtCdqc4u2m5+TOw+LBbITNzl3RGQhnXuByXHHMkR8ZXC1e+kPol2C419yYh0iqZ4GTyuojugPSaLgqtlZnwveWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775059411; c=relaxed/relaxed;
	bh=1r3vmCb4YDlzZ/bs34e1+PQ/MoUtk7gLij0kPF4SA3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BamMe/i5ijHFohyjl6nDFKrWchFg+x7cxiYZAU5FavMHovlfsI+XKwXhYOErZ8TQ78OIE+3BivYcSJY+d0GiuwaRHXangBGW8yIOsj9vDsri5SYrAWxptYl5ftRVZBHRMP59pQfYrN/GEeA9niR+SUl9qHOOJiXZT0mRXFMiu+343tV969aTIEeFbAzua60BKvVmgth9kn321+L37Iu4EntxIbUbwqRT0qmKgYsHRhX+mG/xL1ES3FXMLhQ3K0gQa/6R59NC2eiFCDKz+2QBk8UU/CEAcVJ+nxoWuSaY7lbAATAGY2diItI7lcE0ELXYqrFj4v9P74ivAICyIaNwgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=pengpeng@iscas.ac.cn; receiver=lists.ozlabs.org)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fm8sp6dgMz2yj3
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Apr 2026 03:03:23 +1100 (AEDT)
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAB3HmrEQc1p2BThCw--.34405S2;
	Thu, 02 Apr 2026 00:03:16 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	kees@kernel.org,
	srikar@linux.ibm.com,
	nathanl@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] powerpc/pseries/lparcfg: size the scratch buffer to the system parameter payload
Date: Thu,  2 Apr 2026 00:03:16 +0800
Message-ID: <20260401160316.88551-1-pengpeng@iscas.ac.cn>
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
X-CM-TRANSID:qwCowAB3HmrEQc1p2BThCw--.34405S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww18CrWUGFy7ur13WF1fCrg_yoW5JryxpF
	sYkr47KF4kGas0yFy7KF15Xr45W3Z09F1UWw48tas7Aa4aqrnIqF17Kr1Fvr48Gr1ft3Wr
	Zr9Ikw1rWFyDAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoq2MUUUUU
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

parse_system_parameter_string() reads the shared processor LPAR
attributes into a firmware buffer that can hold up to 4000 bytes, but it
still tokenizes that payload through a fixed 1026-byte scratch buffer. A
single long key-value fragment can therefore overrun the local parser
buffer before the next comma delimiter is seen.

Allocate the scratch buffer to the current payload size so tokenization
stays within bounds.

Fixes: fff9846be00c ("powerpc/pseries/lparcfg: convert to papr_sysparm API")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 8821c378bfff..c09f474c241e 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -385,8 +385,6 @@ static void read_lpar_name(struct seq_file *m)
 		read_dt_lpar_name(m);
 }
 
-#define SPLPAR_MAXLENGTH 1026*(sizeof(char))
-
 /*
  * parse_system_parameter_string()
  * Retrieve the potential_processors, max_entitled_capacity and friends
@@ -407,27 +405,32 @@ static void parse_system_parameter_string(struct seq_file *m)
 		const char *local_buffer;
 		int splpar_strlen;
 		int idx, w_idx;
-		char *workbuffer = kzalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
-
-		if (!workbuffer)
-			goto out_free;
+		size_t workbuf_size;
+		char *workbuffer;
 
 		splpar_strlen = be16_to_cpu(buf->len);
 		local_buffer = buf->val;
+		workbuf_size = splpar_strlen + 1;
+
+		workbuffer = kzalloc(workbuf_size, GFP_KERNEL);
+		if (!workbuffer)
+			goto out_free;
 
 		w_idx = 0;
 		idx = 0;
-		while ((*local_buffer) && (idx < splpar_strlen)) {
+		while ((idx < splpar_strlen) && local_buffer[idx]) {
 			workbuffer[w_idx++] = local_buffer[idx++];
-			if ((local_buffer[idx] == ',')
+			if (idx >= splpar_strlen ||
+			    (local_buffer[idx] == ',')
 			    || (local_buffer[idx] == '\0')) {
 				workbuffer[w_idx] = '\0';
 				if (w_idx) {
 					/* avoid the empty string */
 					seq_printf(m, "%s\n", workbuffer);
 				}
-				memset(workbuffer, 0, SPLPAR_MAXLENGTH);
-				idx++;	/* skip the comma */
+				memset(workbuffer, 0, workbuf_size);
+				if (idx < splpar_strlen)
+					idx++;	/* skip the comma */
 				w_idx = 0;
 			} else if (local_buffer[idx] == '=') {
 				/* code here to replace workbuffer contents
-- 
2.50.1 (Apple Git-155)


