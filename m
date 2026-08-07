Return-Path: <linuxppc-dev+bounces-25572-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C52C5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 12:45:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGkPn08yjz3c3v;
	Fri, 07 Aug 2026 22:45:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786073574;
	cv=none; b=CMEBfnYpH8YZEBct3m8csydLNvoDnW0GRO7UHfMQHlp6kuw0Fw0Lde7zo195wguuxZqlVJr1n7wRVnNwUUDegpxXI1GoashyeUZS8GAequxvuxmMZai9YVOGFDJkd1RR3geHpqLGxHvlPEO5FxtsREYHWJDCMhwvwW7Oc7G7g+TIpPIDed7+TrhzKGH/jYhz835clmAkGSFRD3S8tnzPpbuia4DNOJEgt466wPTkZZSL9Uo2BZ3Jd1Av9Er/VK3bBtjEIp8UMjp5WbcATMQl8kWO1zgZxxnXsR+NbcLS9DJJXgIf1yT3afIG4VJxdpc9q8g8Ycpx2Qan6+mG0AXjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786073574; c=relaxed/relaxed;
	bh=Dh4cIrz8HmWRFFfm7F7KwJo9th2Ts0j7kEL1Thid5/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBWedIbyN6EnlNj9GP9cNqsIPlAVUo0P+fHFyxZ51a73cTPczVntM5ohFCXwrDu0bQGStfkMRdBa0AfS2KhqbHfIExAHXjQn4z74xB21z9aPEoUO8I4S7AtZmRVhiHD2V0eTogsnJJ3mTRjWzarNhgs8j0aTxqWlogq/nXiHDKdC6Nn8oifB/N6ZxuPVMDAZ35n+niorFuWBXVYu6J5iOPRyEmPZzGKddj2aWXAoJXImuSvva95r5xFYFyUMaH5MtKieO31VV0l6rYCXXR9Be+X4nXJA5xpA2N7ekVn/SXh0NwoglEuyB1sFjD+23nlebThlC9HNshdoXZTyBDwVkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org) smtp.mailfrom=kylinos.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kylinos.cn (client-ip=124.126.103.232; helo=mailgw.kylinos.cn; envelope-from=liuxixin@kylinos.cn; receiver=lists.ozlabs.org)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGV8b2cLcz30FB
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 13:32:46 +1000 (AEST)
X-UUID: 7bdf7e04921011f1aa26b74ffac11d73-20260807
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f61ed87a-0635-4b1b-a825-fb1b5a117086,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:f03fcac0b6e1544fac7e5a23d12f90c7,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50
	,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,O
	SA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 7bdf7e04921011f1aa26b74ffac11d73-20260807
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 132895520; Fri, 07 Aug 2026 11:31:32 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 1/4] powerpc/perf: hv-gpci: bound sysfs hex formatting to PAGE_SIZE
Date: Fri, 07 Aug 2026 11:11:14 +0800
Message-ID: <prpppc01hvgpc.1786072274.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.1786072274.git.liuxixin@kylinos.cn>
References: <cover.1786072274.git.liuxixin@kylinos.cn>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py

hv-gpci sysfs show paths format hypervisor counter bytes with sprintf()
into a PAGE_SIZE buffer, and only sometimes check the length afterwards.

Each byte becomes two hex digits plus newlines, so the output can grow
past PAGE_SIZE. Checking after sprintf() is too late: the write already
overflowed the sysfs buffer. One path had no size check at all.

Use sysfs_emit_at() so formatting stays within the sysfs buffer. If a
field cannot fit completely, return -EFBIG rather than silently
truncating.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 arch/powerpc/perf/hv-gpci.c | 77 +++++++++++++++++++++++++------------
 1 file changed, 52 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/perf/hv-gpci.c b/arch/powerpc/perf/hv-gpci.c
index 76495744f..14a4f414b 100644
--- a/arch/powerpc/perf/hv-gpci.c
+++ b/arch/powerpc/perf/hv-gpci.c
@@ -136,6 +136,7 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
 {
 	unsigned long ret;
 	size_t i, j;
+	int len;
 
 	arg->params.counter_request = cpu_to_be32(req);
 	arg->params.starting_index = cpu_to_be32(starting_index);
@@ -177,17 +178,23 @@ static unsigned long systeminfo_gpci_request(u32 req, u32 starting_index,
 	for (i = 0; i < be16_to_cpu(arg->params.returned_values); i++) {
 		j = i * be16_to_cpu(arg->params.cv_element_size);
 
-		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[j]);
-		*n += sprintf(buf + *n,  "\n");
-	}
-
-	if (*n >= PAGE_SIZE) {
-		pr_info("System information exceeds PAGE_SIZE\n");
-		return -EFBIG;
+		for (; j < (i + 1) * be16_to_cpu(arg->params.cv_element_size); j++) {
+			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[j]);
+			if (len != 2)
+				goto emit_failed;
+			*n += len;
+		}
+		len = sysfs_emit_at(buf, *n, "\n");
+		if (len != 1)
+			goto emit_failed;
+		*n += len;
 	}
 
 	return ret;
+
+emit_failed:
+	pr_info("System information does not fit in sysfs buffer\n");
+	return -EFBIG;
 }
 
 static ssize_t processor_bus_topology_show(struct device *dev, struct device_attribute *attr,
@@ -470,12 +477,13 @@ static ssize_t affinity_domain_via_domain_show(struct device *dev, struct device
 	return ret;
 }
 
-static void affinity_domain_via_partition_result_parse(int returned_values,
+static int affinity_domain_via_partition_result_parse(int returned_values,
 			int element_size, char *buf, size_t *last_element,
 			size_t *n, struct hv_gpci_request_buffer *arg)
 {
 	size_t i = 0, j = 0;
 	size_t k, l, m;
+	int len;
 	uint16_t total_affinity_domain_ele, size_of_each_affinity_domain_ele;
 
 	/*
@@ -492,27 +500,44 @@ static void affinity_domain_via_partition_result_parse(int returned_values,
 	 */
 	while (i < returned_values) {
 		k = j;
-		for (; k < j + element_size; k++)
-			*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
-		*n += sprintf(buf + *n,  "\n");
+		for (; k < j + element_size; k++) {
+			len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[k]);
+			if (len != 2)
+				return -EFBIG;
+			*n += len;
+		}
+		len = sysfs_emit_at(buf, *n, "\n");
+		if (len != 1)
+			return -EFBIG;
+		*n += len;
 
 		total_affinity_domain_ele = (u8)arg->bytes[k - 2] << 8 | (u8)arg->bytes[k - 3];
 		size_of_each_affinity_domain_ele = (u8)arg->bytes[k] << 8 | (u8)arg->bytes[k - 1];
 
 		for (l = 0; l < total_affinity_domain_ele; l++) {
 			for (m = 0; m < size_of_each_affinity_domain_ele; m++) {
-				*n += sprintf(buf + *n,  "%02x", (u8)arg->bytes[k]);
+				len = sysfs_emit_at(buf, *n, "%02x", (u8)arg->bytes[k]);
+				if (len != 2)
+					return -EFBIG;
+				*n += len;
 				k++;
 			}
-			*n += sprintf(buf + *n,  "\n");
+			len = sysfs_emit_at(buf, *n, "\n");
+			if (len != 1)
+				return -EFBIG;
+			*n += len;
 		}
 
-		*n += sprintf(buf + *n,  "\n");
+		len = sysfs_emit_at(buf, *n, "\n");
+		if (len != 1)
+			return -EFBIG;
+		*n += len;
 		i++;
 		j = k;
 	}
 
 	*last_element = k;
+	return 0;
 }
 
 static ssize_t affinity_domain_via_partition_show(struct device *dev, struct device_attribute *attr,
@@ -555,12 +580,10 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
 	 * to buffer util we get all the information.
 	 */
 	while (ret == H_PARAMETER) {
-		affinity_domain_via_partition_result_parse(
-			be16_to_cpu(arg->params.returned_values) - 1,
-			be16_to_cpu(arg->params.cv_element_size), buf,
-			&last_element, &n, arg);
-
-		if (n >= PAGE_SIZE) {
+		if (affinity_domain_via_partition_result_parse(
+				be16_to_cpu(arg->params.returned_values) - 1,
+				be16_to_cpu(arg->params.cv_element_size), buf,
+				&last_element, &n, arg)) {
 			put_cpu_var(hv_gpci_reqb);
 			pr_debug("System information does not fit in sysfs buffer\n");
 			return -EFBIG;
@@ -587,10 +610,14 @@ static ssize_t affinity_domain_via_partition_show(struct device *dev, struct dev
 	}
 
 parse_result:
-	affinity_domain_via_partition_result_parse(
-		be16_to_cpu(arg->params.returned_values),
-		be16_to_cpu(arg->params.cv_element_size),
-		buf, &last_element, &n, arg);
+	if (affinity_domain_via_partition_result_parse(
+			be16_to_cpu(arg->params.returned_values),
+			be16_to_cpu(arg->params.cv_element_size),
+			buf, &last_element, &n, arg)) {
+		put_cpu_var(hv_gpci_reqb);
+		pr_debug("System information does not fit in sysfs buffer\n");
+		return -EFBIG;
+	}
 
 	put_cpu_var(hv_gpci_reqb);
 	return n;
-- 
2.43.0


