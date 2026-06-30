Return-Path: <linuxppc-dev+bounces-23198-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB78DC43602
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 14:53:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqR3t1jvWz2yft;
	Wed, 01 Jul 2026 00:53:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782831226;
	cv=none; b=LegZsf7gmN/tj3fUEQSXrZXqXYADBInadf9Fo1JzlEeXLIgQySWxAUBXaQ8TbQGz+JXaszZKuvLMvpPrbWAxja/NUQM5F846575kbTzE3KzdmfVamKz2zKu7QhDnuESVvnDdxCIyoejVKoqS3QTsDATR+mZA8YYa/ViOp9xpc1NrEFkTxfuQlVVkkxYcCozVcfO+BNdSwAYK8aWamejFu14kxGcOAMKt7YJ8cGVBQOs3eB14WuWnZ+zH7lTCR84KbcZr1s9X2lIgI0++fSoDumkraTqBz/lKMxKKDFdgrHi5a7qa0yKltYXiGlU5NbdvM53AhLP2iKVzwuKv+/Rg5w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782831226; c=relaxed/relaxed;
	bh=xyVghz0BdLLck4MWcY4YY/JnDc/q9kOQqZCD96Q900o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hnu8/4okKHiqPrf22EfrEqTe5MwQE9WcFy1If6nKJ0ihKoJ86EehVNGtHu4i5SfawDdh5QDSfW5iLvxV9zDjWG9TYc3CtCOBcbJmOvQyYN8enY+MwaIWnJQreJef2g4rSwh0B8f5uJKhYAvbGtR3y/v5k5eWnyq0Fhes3OaGT0/mv1Lc91DcI9mou0FAPSLor0/hTgFKumpA90DCzq/P9adEgdkvwLk4ZF2a9Z+BVhMTkzkkkFwXN3vSqNVNiwgEkN5bFPEZyKFEunH/VECPwIpZskI0O5o1PEUD5nCqFZ2+3vtM1YGPi44Pp2wP2+k6EfghvXnsXaS1DqqVfygNxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HBP0FPgi; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HBP0FPgi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqR3r6crhz2yMl
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 00:53:44 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIJJ32233391;
	Tue, 30 Jun 2026 14:53:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xyVghz0BdLLck4MWc
	Y4YY/JnDc/q9kOQqZCD96Q900o=; b=HBP0FPgid+SlsbCykmWKOQri0AWIFq9hl
	TI5cNbYGl7OOhNFoJHsf6n4KZH8/w6fXu7me5h0xlNJ64p6e4f8w0sjCcpjjv8jc
	pIm6g7q/evR+6cZxNzVctrjUn1+scu19ha+uVUVyadpHZN2yiVqM1z/BLf/B+D7x
	U8nINtecR0zhTVpjLo46lBqqILDvZ2eoSPIinpgrl9z1GsTwaNd0C84wPTSwvI/V
	BLbQjs/kBMfpxBaLogTKO0X5Ch+qqzYXcUFvwHrLd5rQsbPF75jly2PgS8ZX/mix
	quS/B9koYsanWv+veVUk0aetAEMFgnwouUsxMHGdkNYHTwLd4jKhA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5qdj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UEnflO000654;
	Tue, 30 Jun 2026 14:53:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhapf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 14:53:35 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UErYWs17302132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 14:53:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C2D05805C;
	Tue, 30 Jun 2026 14:53:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8D0A5805D;
	Tue, 30 Jun 2026 14:53:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.117.151])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 14:53:32 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH v1 01/18] ibmveth: Add MQ RX hypercall wrappers and call definitions
Date: Tue, 30 Jun 2026 07:53:08 -0700
Message-Id: <9395d1ff1f5cbc64843c184828850352ff9af909.1782758799.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1782758799.git.mmc@linux.ibm.com>
References: <cover.1782758799.git.mmc@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX8R2mW7oO3d+g
 +VSInXLrhbNGwoTyR7ssSGYv5eaUMV3MgVP0gRlpzKdaVuxK3FnodUQ6lEnkCo46jBI9zQif/fX
 i619J7RQQcEEXrT1MzUoM//QgRCntzW10S65iTzJUtn1xgdlTHXOL3OxJ0YQ/qVdFLedbXrJJlD
 SYpuKUH/aXMaCiu4Kjc6VEiFVBQETnIQVW8s95ptXSAhzeEQhQ7b7VExFRsmDMVA9fhgOEmjCYO
 tUKxyzGiEJmTp2HAY88JkZ1TRGtbH0HUzKJV8ZsuxKkE5Jsc5TuBL2gwEdPzlwvkf/Unc9KurrR
 ATAjG/miL5AT3v9jcFp38qFlKOO02XqXS3w2F8bu5GqHMwkYeEK5URU7nO0fFKI38hMOALOfS57
 h1QRA52EwgFBuQfSZmpbjuwV1a2m5zsV6cNgxmJwa0FpriMXbywy40ffYJpL0mXOG5pSIX1l1YW
 ZJsM1MjmoQXeQUTzSpA==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a43d870 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=MvuV-DllYkNUqFi9bgAA:9
X-Proofpoint-ORIG-GUID: 0BOzDIWOqChANJJOYi8MeNJu44_sQLlV
X-Proofpoint-GUID: V9LBy-6dj6ALN0TNzV68_AHiOwvT5KML
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX73JeXLQUxmiw
 NxVdS6E+0+gZY1qrphD9T5WC+6V9bJvS63y3FMBFX75v1xoy+xECTcfDIWrM0aBPJCr8jNpP6FH
 mpWiDMziH1lz7YZ84JTzItVU1bk5aHg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139

Single-queue ibmveth only needs h_register_logical_lan() plus legacy
buffer add/free calls. MQ RX uses per-queue handles, so the driver must
also be able to register/deregister subordinate queues and post/free
buffers against a specific queue handle.

Add the PHYP call IDs for:

  H_REG_LOGICAL_LAN_QUEUE
  H_ADD_LOGICAL_LAN_BUFFERS_QUEUE
  H_FREE_LOGICAL_LAN_BUFFER_QUEUE
  H_FREE_LOGICAL_LAN_QUEUE

and add ibmveth.h wrapper helpers (h_reg_logical_lan_queue(),
h_add_logical_lan_buffers_queue(), h_free_logical_lan_buffer_queue(),
h_free_logical_lan_queue()) with argument ordering and return semantics
matching the existing ibmveth hcall wrappers.

This patch is intentionally plumbing only: no runtime behavior change
yet. Legacy firmware keeps H_REGISTER_LOGICAL_LAN and the existing
buffer hcalls. The new wrappers are used only when a later commit sets
multi_queue from H_ILLAN_ATTRIBUTES.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h  |   6 +-
 drivers/net/ethernet/ibm/ibmveth.c |   3 +-
 drivers/net/ethernet/ibm/ibmveth.h | 158 +++++++++++++++++++++++++++++
 3 files changed, 165 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index dff90a7d7f70..bf2f1b0356c4 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -362,7 +362,11 @@
 #define H_GUEST_DELETE		0x488
 #define H_PKS_WRAP_OBJECT	0x490
 #define H_PKS_UNWRAP_OBJECT	0x494
-#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
+#define H_REG_LOGICAL_LAN_QUEUE 0x49C
+#define H_ADD_LOGICAL_LAN_BUFFERS_QUEUE 0x4A0
+#define H_FREE_LOGICAL_LAN_BUFFER_QUEUE 0x4A4
+#define H_FREE_LOGICAL_LAN_QUEUE 0x4A8
+#define MAX_HCALL_OPCODE	H_FREE_LOGICAL_LAN_QUEUE
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..af287eeafc0c 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -584,7 +584,8 @@ static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 }
 
 static int ibmveth_register_logical_lan(struct ibmveth_adapter *adapter,
-        union ibmveth_buf_desc rxq_desc, u64 mac_address)
+				   union ibmveth_buf_desc rxq_desc,
+				   u64 mac_address)
 {
 	int rc, try_again = 1;
 
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index d87713668ed3..45cfb0d054e3 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -66,6 +66,164 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
 			    desc5, desc6, desc7, desc8);
 }
 
+/**
+ * h_reg_logical_lan_queue - Register a subordinate receive queue
+ * @unit_address: Device unit address
+ * @buffer_list: DMA address of 4KB page for tracking registered buffers
+ * @rec_queue: Buffer descriptor of receive queue
+ *
+ * Registers a subordinate receive queue with the hypervisor.
+ *
+ * Return:
+ *   H_SUCCESS (0) on success
+ *   H_PARAMETER if parameters are invalid
+ *
+ * On success, hypervisor returns:
+ *   R3: H_SUCCESS
+ *   R4: Queue handle
+ *   R5: IRQ number for this queue
+ */
+static inline long h_reg_logical_lan_queue(unsigned long unit_address,
+					   unsigned long buffer_list,
+					   unsigned long rec_queue,
+					   unsigned long *queue_handle,
+					   unsigned long *irq)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	long rc;
+
+	rc = plpar_hcall9(H_REG_LOGICAL_LAN_QUEUE,
+			  retbuf, unit_address,
+			  buffer_list, rec_queue);
+
+	if (rc == H_SUCCESS) {
+		if (queue_handle)
+			*queue_handle = retbuf[0];
+		if (irq)
+			*irq = retbuf[1];
+	}
+
+	return rc;
+}
+
+/**
+ * h_add_logical_lan_buffers_queue - Add buffers to subordinate queue
+ * @unit_address: Device unit address
+ * @queue_handle: Queue handle from h_reg_logical_lan_queue()
+ * @buffersznum: Buffer size (upper 32 bits) | count (lower 32 bits)
+ * @ioba12: Buffer addresses 1 and 2 packed (addr1 | addr2 << 32)
+ * @ioba34: Buffer addresses 3 and 4 packed
+ * @ioba56: Buffer addresses 5 and 6 packed
+ * @ioba78: Buffer addresses 7 and 8 packed
+ * @ioba910: Buffer addresses 9 and 10 packed
+ * @ioba1112: Buffer addresses 11 and 12 packed
+ *
+ * Return:
+ *   H_SUCCESS - All buffers added successfully
+ *   H_PARAMETER - Invalid parameters
+ *   H_HARDWARE - Hardware error
+ */
+static inline long h_add_logical_lan_buffers_queue(unsigned long unit_address,
+						   unsigned long queue_handle,
+						   unsigned long buffersznum,
+						   unsigned long ioba12,
+						   unsigned long ioba34,
+						   unsigned long ioba56,
+						   unsigned long ioba78,
+						   unsigned long ioba910,
+						   unsigned long ioba1112)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	return plpar_hcall9(H_ADD_LOGICAL_LAN_BUFFERS_QUEUE,
+			    retbuf, unit_address,
+			    queue_handle, buffersznum,
+			    ioba12, ioba34, ioba56,
+			    ioba78, ioba910, ioba1112);
+}
+
+/**
+ * h_free_logical_lan_buffer_queue - Free buffer from subordinate queue
+ * @unit_address: Device unit address
+ * @buf_size: Size of buffer to remove from pool
+ * @queue_handle: Queue handle from h_reg_logical_lan_queue()
+ *
+ * Removes a buffer of specified size from the subordinate queue's buffer pool.
+ *
+ * Return:
+ *   H_SUCCESS - Buffer removed successfully
+ *   H_PARAMETER - Invalid parameters
+ *   H_HARDWARE - Hardware error
+ *   H_NOT_FOUND - Buffer pool does not exist
+ */
+static inline long h_free_logical_lan_buffer_queue(unsigned long unit_address,
+						   unsigned long buf_size,
+						   unsigned long queue_handle)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	return plpar_hcall9(H_FREE_LOGICAL_LAN_BUFFER_QUEUE,
+			    retbuf, unit_address, buf_size, queue_handle);
+}
+
+/**
+ * h_free_logical_lan_queue - Deregister subordinate receive queue
+ * @unit_address: Device unit address
+ * @queue_handle: Queue handle from h_reg_logical_lan_queue()
+ *
+ * Deregisters and frees all structures associated with the subordinate queue.
+ *
+ * Return:
+ *   H_SUCCESS - Queue freed successfully
+ *   H_PARAMETER - Invalid parameters
+ *   H_HARDWARE - Hardware error
+ *   H_STATE - VIOA not in valid state
+ *   H_BUSY / H_LONG_BUSY_* - Resource busy, retry
+ */
+static inline long h_free_logical_lan_queue(unsigned long unit_address,
+					    unsigned long queue_handle)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	return plpar_hcall9(H_FREE_LOGICAL_LAN_QUEUE,
+			    retbuf, unit_address, queue_handle);
+}
+
+/**
+ * h_register_logical_lan_with_handle - Register primary queue and get handle
+ * @unit_address: Device unit address
+ * @buffer_list: DMA address of buffer list
+ * @rec_queue: Buffer descriptor of receive queue
+ * @filter_list: DMA address of filter list
+ * @mac_address: MAC address
+ * @queue_handle: Output parameter for queue handle
+ *
+ * Registers the primary receive queue (queue 0) with the hypervisor and
+ * returns the queue handle. This is needed in multi-queue mode to use
+ * h_add_logical_lan_buffers_queue() for all queues including queue 0.
+ *
+ * Return: H_SUCCESS (0) on success, error code otherwise
+ */
+static inline long h_register_logical_lan_with_handle(unsigned long unit_address,
+						      unsigned long buffer_list,
+						      unsigned long rec_queue,
+						      unsigned long filter_list,
+						      unsigned long mac_address,
+						      u64 *queue_handle)
+{
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	long rc;
+
+	rc = plpar_hcall9(H_REGISTER_LOGICAL_LAN, retbuf,
+			  unit_address, buffer_list, rec_queue,
+			  filter_list, mac_address);
+
+	if (rc == H_SUCCESS && queue_handle)
+		*queue_handle = retbuf[0];
+
+	return rc;
+}
+
 /* FW allows us to send 6 descriptors but we only use one so mark
  * the other 5 as unused (0)
  */
-- 
2.39.3 (Apple Git-146)


