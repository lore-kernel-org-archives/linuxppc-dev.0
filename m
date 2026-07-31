Return-Path: <linuxppc-dev+bounces-25147-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E2BC55165
	for <linuxppc-dev@archiver.kernel.org>; Fri, 31 Jul 2026 00:48:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB6qf2ML7z2yjq;
	Fri, 31 Jul 2026 10:47:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785458878;
	cv=none; b=l3RtVsCOW5/ME/odsA3aBDS0o2SHsjF5pXsCjp7SflGSMnQ7QXQH9L67O3tJeRcTAk47ryX+b0oBL6GVUsu7HVlRJGLAq8vv4N5/Xc0I5a+artXj0u1oG9Mh6Xfu52zfKe7n3feVZ67MD7xLJzS9luv9t5NLIIxLnWDayRz7HZXsMdN23BYX/Wz0sUgpvquQw7sr7EEo3GJz79GtEr5pXVK2zTbw4JXfjqcoYrJvTSoX3m8WUWMdS2yIIutD47gIPba0NQxjeCcOlaJDs18fu2jQitQJY9bzNbGzymKv2iXgcPTZkK1r4tSxfvaR9TtLGJqDR0CJO8pIXLxIOqaxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785458878; c=relaxed/relaxed;
	bh=7XIwhdn2muqEGo+kVgkbNH0lzAmLbCdWBfdDmBuKrI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4tcH92BbqgFFs9kKac7UnYVPDwdvEpy4HhsxKpuPp3JiMGOf5Xdw4WdN1FsWo8FKI+qzwldAXv7+IjQl9N+s3XfF7S7jeQINTJi7gY3PFzd6Q6l4QkgpdXmLCj29ncfYn8aaIu8dGZSpATjFXRFyV82Ela5nO2qV06ANcuE71uxP86xKvn1r7ACjaGT5cjtIrb13NeaEZ0NcA2NtzSqh5VRa+G7RUJjMGvcwl3m4Pa6pqzB1LS6MxdwKLFo+xPJwGDfwAMffx8CwcH0/5ns62lx3BAa7YWBtKn1sAFmRthmG5JBfA/t7pK5LYVl/9pEK5c6927RZDtosiGTJK46Ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QhUIsMFU; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QhUIsMFU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB6qd41tBz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 10:47:57 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UNHcU6184557;
	Fri, 31 Jul 2026 00:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7XIwhdn2muqEGo+kV
	gkbNH0lzAmLbCdWBfdDmBuKrI8=; b=QhUIsMFU3+yrz5ARYJppvIWDWQPGuHTnG
	SIMFYInv/e2njTGb4z+gU9/Z4Xwadf8UsZPqxhGhTJLsYH80Yw/seMA+8hAUpf3E
	BKNcaknj2uuAH6lkes3q48dVYAsnMjV/hvXxZwfmhhJORxywEsJk82NAdmG4ngaF
	Kdrt2uTsowlNcJ2C6Fr4NNjcCw4cKBdpl0b+Tw7uOCYoy+Vn+ysIR3Ngnr0noY/g
	099aKWf6+cEcSRyVr5inHMPOElXLQy6gfcMGUtMNdyoVqSYTPZbKoT6HIAOlD3F+
	ppvq0PU6Z3CGh4HvK5baYXSa+xxLDPI51s72n6LGOe+6xbryuKfUw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7tkb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V0fHpC018141;
	Fri, 31 Jul 2026 00:47:46 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwe04k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 00:47:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V0ljJ260490212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 00:47:45 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E270458058;
	Fri, 31 Jul 2026 00:47:44 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA38658057;
	Fri, 31 Jul 2026 00:47:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.44.71])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 00:47:43 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
        ricklind@linux.ibm.com, mmc@linux.ibm.com, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, davem@davemloft.net,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        simon.horman@corigine.com, shaik.abdulla1@ibm.com,
        Dave Marquardt <davemarq@linux.ibm.com>
Subject: [PATCH net-next v4 01/14] ibmveth: Add MQ RX hypercall wrappers and call definitions
Date: Thu, 30 Jul 2026 17:47:04 -0700
Message-Id: <1bb2ecd260f27171c534b9beda377b75ea1790ae.1785457143.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1785457143.git.mmc@linux.ibm.com>
References: <cover.1785457143.git.mmc@linux.ibm.com>
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
X-Proofpoint-GUID: uzAMUsGqEcBVuQZEudFXCqq2ah_YqKv-
X-Proofpoint-ORIG-GUID: 2VAV0ftKqVeRRtOd9jaeZiShYF-8-jcP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfXzJLcpIJhMg24
 BlB+J+GWPrfJibsF0f45qefnxQXL+VK+osWwNj+aTta7afgFaXUFIsXAvnYuBBGsS1KeZ+o0cit
 yFb1fwrvN14TzcGMalOfjFyPfaqp2SZoscFUgi8HzvvlZTLVKiI9yYKmsQ0SoUytPuI4nf59xKJ
 YAE5XApyoyw2PyDrOcQgCC7MgK487N9uq1kocBDuze1NnOI1G2+SEshjd/5nfwZV8gZsCwluLrS
 uDtQiprT+Lqg1h6Fg3Y9saAZaswyZtgW0eDq9d7901SHSXHXPkvcvCHV80pIhukmlenOYX63Lbo
 lIjEWNyPnFVyZPkOuknlutRXSVcr9Co0CsfQ0DHhPQxJAoq79a5Q035sJAerrWE4dmf9Pp4qvpv
 CgKr3loLFWoMqhNzQfnChfer1CMJkkYmgp+HemH94nMAZ1pZkTZVDUcL4z97GnD6imKu+fE+QKU
 c77tcUTH4Cx5Q1zScCA==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6bf0b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=zgFZsV-58I_ewvCFsDoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAwMyBTYWx0ZWRfX8a7NDQ1cIlAa
 umg6nbqsavrFup23Srg/BeRrC4WspPrYPt1XgMXSWZFXFxwdagifzDoiA4Kx3hHEhzSEh5kGNfj
 uNsjuPTcvxc/64cC8QtovN8lHc3puvQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310003

Single-queue ibmveth only needs h_register_logical_lan() plus legacy
buffer add/free calls. MQ RX uses per-queue handles, so the driver must
also be able to register/deregister subordinate queues and post
buffers against a specific queue handle.

Add the PHYP call IDs for:

  H_REG_LOGICAL_LAN_QUEUE
  H_ADD_LOGICAL_LAN_BUFFERS_QUEUE
  H_FREE_LOGICAL_LAN_QUEUE

and add ibmveth.h wrapper helpers (h_reg_logical_lan_queue(),
h_add_logical_lan_buffers_queue(), h_free_logical_lan_queue()) with
argument ordering and return semantics matching the existing ibmveth
hcall wrappers. Also add h_register_logical_lan_with_handle() so
queue 0 can capture the PHYP queue handle in MQ mode.

This patch is intentionally plumbing only: no runtime behavior change
yet. Legacy firmware keeps H_REGISTER_LOGICAL_LAN and the existing
buffer hcalls. The new wrappers are used only when a later commit sets
multi_queue from H_ILLAN_ATTRIBUTES.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v4:
- Document @queue_handle and @irq in h_reg_logical_lan_queue() kdoc.
- Wrap h_register_logical_lan_with_handle() prototype for readability /
  checkpatch.
- Drop unused H_FREE_LOGICAL_LAN_BUFFER_QUEUE wrapper/opcode (no caller;
  buffer return is local harvest + queue free).

 arch/powerpc/include/asm/hvcall.h  |   5 +-
 drivers/net/ethernet/ibm/ibmveth.h | 137 +++++++++++++++++++++++++++++
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index dff90a7d7f70..d79baf2e3827 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -362,7 +362,10 @@
 #define H_GUEST_DELETE		0x488
 #define H_PKS_WRAP_OBJECT	0x490
 #define H_PKS_UNWRAP_OBJECT	0x494
-#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
+#define H_REG_LOGICAL_LAN_QUEUE 0x49C
+#define H_ADD_LOGICAL_LAN_BUFFERS_QUEUE 0x4A0
+#define H_FREE_LOGICAL_LAN_QUEUE 0x4A8
+#define MAX_HCALL_OPCODE	H_FREE_LOGICAL_LAN_QUEUE
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index d87713668ed3..c88dbeb7cd96 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -66,6 +66,143 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
 			    desc5, desc6, desc7, desc8);
 }
 
+/**
+ * h_reg_logical_lan_queue - Register a subordinate receive queue
+ * @unit_address: Device unit address
+ * @buffer_list: DMA address of 4KB page for tracking registered buffers
+ * @rec_queue: Buffer descriptor of receive queue
+ * @queue_handle: Output queue handle on success (may be NULL)
+ * @irq: Output hypervisor IRQ number on success (may be NULL)
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
+ * @ioba12: Buffer addresses 1 and 2 packed ((addr1 << 32) | addr2)
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
+static inline long
+h_register_logical_lan_with_handle(unsigned long unit_address,
+				   unsigned long buffer_list,
+				   unsigned long rec_queue,
+				   unsigned long filter_list,
+				   unsigned long mac_address,
+				   u64 *queue_handle)
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
2.50.1 (Apple Git-155)


