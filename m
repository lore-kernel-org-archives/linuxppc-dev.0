Return-Path: <linuxppc-dev+bounces-26302-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D81BC624A5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Aug 2026 15:08:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYXRy4r6Lz2ygW;
	Tue, 01 Sep 2026 01:08:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788188894;
	cv=none; b=NRT1gijdkzaB9nE9ZqMI3B1uRL7AAbLqieS4JetH3dvHhkEKgCRIT4Wc/Fjh0PBXTbbIRrsRmOFAJQY5LISdQHPn2x4WKcaI9T4ACIDqfmi864Ouxh/Fb99YI2RQqssTtbZND4IwImxU4j8ZjEqJYk9q+Vyl+yuQLJqml9enAU7rIn3nC5Dy3QSMo14PCU4giXU4tgcNceLO/7jEOFDOfmA+B58Cw+e+NgBkTY/c7pr3wJAAygcMFrdTumaSIcsWzTptX66+0S0xBBTsi7sKilT4hwXFRd2H7VpU6KUQc9SV/TF5x3vI0/37wR1bbr7e6Oqu/1D8W1Z7i/ruo9D0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788188894; c=relaxed/relaxed;
	bh=vE5FF2CdePUGpBgV9uGIt+GYuQbv1cVkc1FoDiUDl2g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StAl0isal8T+SX4um+6H04iAFDdUn6SyY7KK+4JZ0JYDa25/at6AktRk5rvqIIPm2hV5lj6H6UQetWbqJJybam4MF1sPTECK/feAdD8ahdHdhubUYUCrbc9VuHwlKkiwjzmDLCCxUH+mjpdKz6mZBJXteWcBYbGmmBeuyI/3S8tXnn/Dldh7zSKEbPzXzwq42pvXCiU0aKO3IxB7BOjhA7nwIZHEwpdcSJb7/YHBgJ/VeRZetuZdirGxFBANYrtA85KoOll6wpSlsNEIetrSVvjM5du/W0GQpgAVa/5cCR+iazX8G4Ds+pGW54s86QcgZKJU+NFAui5UHrd/lIGEeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K61bLBIb; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K61bLBIb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hYXRx4cvBz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Sep 2026 01:08:13 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZDpH2583044;
	Mon, 31 Aug 2026 15:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vE5FF2CdePUGpBgV9
	uGIt+GYuQbv1cVkc1FoDiUDl2g=; b=K61bLBIb7/QA8BPXI/4XKVzZACDqGT3ft
	T5hgJ8Jr9iZNpBGqFQOzO7wd4H3vkvGvXD+Kc7nLTM3g3jaC3qQDyrK1Z20QOKb1
	YOei02Qi/WbC53CJQXsBOItmoS4KKQ9/04ShbBCY+CmboOpN9Xyk+DavO8qnneqO
	oLAEDffyLKQ/psd7iky0z4vS0PHipONkul5YRQ3oLofgWOx/u//hrTKkN77iBEJ2
	p+FddPl4AskytL3t1Zeo788Ezd0edbqbo/wjRjkkhcyjHoaWUrpU5nmBbNdspvXS
	0b4ELrYfcopXPHpWHRvXJEUlLPM/4/aJwhuqKuPIYJbilwBxLLC0A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t1x16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuQRi003281;
	Mon, 31 Aug 2026 15:08:01 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq6qpx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:08:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VF7wr025494050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:07:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83C075805E;
	Mon, 31 Aug 2026 15:07:58 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BBFF58051;
	Mon, 31 Aug 2026 15:07:54 +0000 (GMT)
Received: from 192.168.1.50 (unknown [9.67.102.143])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:07:54 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        ricklind@linux.ibm.com, davemarq@linux.ibm.com, bjking1@linux.ibm.com,
        shaik.abdulla1@ibm.com, Mingming Cao <mmc@linux.ibm.com>
Subject: [PATCH net-next v6 01/15] ibmveth: Add MQ RX hypercall wrappers and call definitions
Date: Mon, 31 Aug 2026 08:07:12 -0700
Message-Id: <b87d16ce8e52934877234af6085e47a89571c9ae.1788102125.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1788102125.git.mmc@linux.ibm.com>
References: <cover.1788102125.git.mmc@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9598d2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=KXd6cQgdxoXwaerD69QA:9
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX0Jg/q2bzH0eL
 hsIeVZop5D/ThKnYl9AiDLbIxkM3fEGC7Nooby/X3tZrPvVKhd9ZN+feZCCT7R6aTXs/6O2NT8q
 cDR9BPWhz1QsE8rW2i+VF+dy1I6Wr50=
X-Proofpoint-ORIG-GUID: b8IcQojnFCUF8xW-4mDZidAPtRx5Gyck
X-Proofpoint-GUID: FWH5cKMJQcfPeIPF-QSSH5LqIHzlzoX4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXxhMxNsGbMRdm
 lLvQd/Cn/wPa7jmjugysKhew1dYTkSmq1oVyU19xg4l+nFXERI4D/whEZI5W9f3g9daqSY5tkyS
 iefvdJ/ftTsRfp7I7ftqZFOO2RKOIFGXcR6tyN75zlThR14H5NHyFyH1xoqlpTLa4vS5TnW2QNU
 XdoYNmq5s/Kvw0s6pwpWoRAzWqmwwJ0ky/lj3YxeYxIOrpaOhTTWVihgV4N4PRrIupSJlKw7v9m
 0THunBfz7Oh2L2Ds2Bx7v9ucWNi8IdgjRlOj+X4Z67XyNehLLQKeC1tnymdir0p8NFKiSjGlO9K
 QIdYnUbJydYJkgamPdqP1D8VrZQ7h73gj6LRdVlNh6gSGdHcracP9NRM+Rw0POuLpI/wX+1+WiU
 pu/B3OYb/DChzhhM48kOH9iOzg9aGohbmTMPq8ULqsC2Cdn17VXf6Pv/uKGhsrnAJNtwaN44HrL
 HqMN4YC+aMA2TB/MYuQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310130

Single-queue ibmveth only needs h_register_logical_lan() plus legacy
buffer add/free calls. MQ RX uses per-queue handles, so the driver must
also be able to register/deregister subordinate queues and post
buffers against a specific queue handle.

Add the PHYP call IDs for:

  H_REG_LOGICAL_LAN_QUEUE (0x49C)
  H_ADD_LOGICAL_LAN_BUFFERS_QUEUE (0x4A0)
  H_FREE_LOGICAL_LAN_QUEUE (0x4A8)

as defined in PAPR 11.20.00. The gaps at 0x498 (reserved) and 0x4A4
(reserved for H_FREE_LOGICAL_LAN_BUFFER_QUEUE) are intentional; this
series tears queues down with H_FREE_LOGICAL_LAN_QUEUE and does not add
the buffer-queue free hcall.

Raising MAX_HCALL_OPCODE for these IDs also widens KVM's
kvm_arch.enabled_hcalls bitmap and the range KVM_CAP_PPC_ENABLE_HCALL
accepts. Neither is user-visible: KVM implements none of the three, so
the ioctl still rejects them, and the bitmap rounds to the same five
unsigned longs, so struct kvm_arch does not change size.

Add ibmveth.h wrapper helpers (h_register_logical_lan_queue(),
h_add_logical_lan_buffers_queue(), h_free_logical_lan_queue()) with
argument ordering and return semantics matching the existing ibmveth
hcall wrappers. h_free_logical_lan_queue() uses plpar_hcall_norets()
like h_free_logical_lan(). Also add h_register_logical_lan_with_handle()
so queue 0 can capture the PHYP queue handle in MQ mode. Both new
registration wrappers use plpar_hcall() rather than plpar_hcall9(), so
they do not read unwritten stack slots. Both new
registration wrappers use plpar_hcall() rather than plpar_hcall9(), so
they do not read unwritten stack slots.

This patch is intentionally plumbing only: no runtime behavior change
yet. Legacy firmware keeps H_REGISTER_LOGICAL_LAN and the existing
buffer hcalls. The new wrappers are used only when a later commit sets
multi_queue from H_ILLAN_ATTRIBUTES.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---

Changes in v6:
- both new registration wrappers use plpar_hcall() instead of
  plpar_hcall9(). They do not need nine args, and plpar_hcall9() was
  reading three unwritten stack slots
- Widen add-buffers-queue and free-queue @queue_handle kdoc: handle may
  come from h_register_logical_lan_queue() or
  h_register_logical_lan_with_handle() (queue 0)
- add-buffers-queue Return: also H_FUNCTION (MQ firmware missing that
  hcall)

Changes in v5:
- Cite PAPR 11.20.00 for MQ hcall IDs 0x49C / 0x4A0 / 0x4A8 (v4 named
  the opcodes only)
- Call out reserved gaps at 0x498 and 0x4A4 (0x4A4 =
  H_FREE_LOGICAL_LAN_BUFFER_QUEUE); decision: do not add that hcall -
  queue teardown uses H_FREE_LOGICAL_LAN_QUEUE
- Note MAX_HCALL_OPCODE raise also widens KVM enabled_hcalls /
  KVM_CAP_PPC_ENABLE_HCALL accepted range (cross-subsystem)
- Rename h_reg_logical_lan_queue() -> h_register_logical_lan_queue() to
  match h_register_logical_lan() / h_free_logical_lan()
- Unify queue_handle out-params as unsigned long * on both
  h_register_logical_lan_queue() and h_register_logical_lan_with_handle()
  (v4 used u64 * on with_handle)
- h_free_logical_lan_queue() uses plpar_hcall_norets() like
  h_free_logical_lan() (v4 used plpar_hcall9 with unused retbuf)

Changes in v4:
- Document @queue_handle and @irq in h_reg_logical_lan_queue() kdoc.
- Wrap h_register_logical_lan_with_handle() prototype for readability /
  checkpatch.
- Drop unused H_FREE_LOGICAL_LAN_BUFFER_QUEUE wrapper/opcode (no caller;
  buffer return is local harvest + queue free).

 arch/powerpc/include/asm/hvcall.h  |   6 +-
 drivers/net/ethernet/ibm/ibmveth.h | 139 +++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index dff90a7d7f70..cb0ea53491e6 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -362,7 +362,11 @@
 #define H_GUEST_DELETE		0x488
 #define H_PKS_WRAP_OBJECT	0x490
 #define H_PKS_UNWRAP_OBJECT	0x494
-#define MAX_HCALL_OPCODE	H_PKS_UNWRAP_OBJECT
+/* 0x498 reserved; 0x4A4 = H_FREE_LOGICAL_LAN_BUFFER_QUEUE (unused here) */
+#define H_REG_LOGICAL_LAN_QUEUE 0x49C
+#define H_ADD_LOGICAL_LAN_BUFFERS_QUEUE 0x4A0
+#define H_FREE_LOGICAL_LAN_QUEUE 0x4A8
+#define MAX_HCALL_OPCODE	H_FREE_LOGICAL_LAN_QUEUE
 
 /* Scope args for H_SCM_UNBIND_ALL */
 #define H_UNBIND_SCOPE_ALL (0x1)
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index d87713668ed3..08504d1cafd5 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -66,6 +66,145 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
 			    desc5, desc6, desc7, desc8);
 }
 
+/**
+ * h_register_logical_lan_queue - Register a subordinate receive queue
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
+static inline long
+h_register_logical_lan_queue(unsigned long unit_address,
+			     unsigned long buffer_list,
+			     unsigned long rec_queue,
+			     unsigned long *queue_handle,
+			     unsigned long *irq)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	long rc;
+
+	rc = plpar_hcall(H_REG_LOGICAL_LAN_QUEUE,
+			 retbuf, unit_address,
+			 buffer_list, rec_queue);
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
+ * @queue_handle: Queue handle from h_register_logical_lan_queue() or
+ *		  h_register_logical_lan_with_handle() (queue 0)
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
+ *   H_FUNCTION - Firmware does not support this hcall
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
+ * @queue_handle: Queue handle from h_register_logical_lan_queue() or
+ *		  h_register_logical_lan_with_handle() (queue 0)
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
+	return plpar_hcall_norets(H_FREE_LOGICAL_LAN_QUEUE,
+				  unit_address, queue_handle);
+}
+
+/**
+ * h_register_logical_lan_with_handle - Register primary queue and get handle
+ * @unit_address: Device unit address
+ * @buffer_list: DMA address of buffer list
+ * @rec_queue: Buffer descriptor of receive queue
+ * @filter_list: DMA address of filter list
+ * @mac_address: MAC address
+ * @queue_handle: Output parameter for queue handle (may be NULL)
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
+				   unsigned long *queue_handle)
+{
+	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	long rc;
+
+	rc = plpar_hcall(H_REGISTER_LOGICAL_LAN, retbuf,
+			 unit_address, buffer_list, rec_queue,
+			 filter_list, mac_address);
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


