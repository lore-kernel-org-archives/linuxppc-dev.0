Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E230607180E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 23:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XQz50uvW
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNmsm5P2Tz2yMP;
	Tue, 10 Nov 2026 10:57:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794268620;
	cv=none; b=cI7XYlNEi2m2+Ufk1lo+tH7y3LTp+3wVN9EWpIk71wxm3Xrfnk+4PlMPhgQsRGDvTspCiQyjFb++vsgoZhAGs7o4PXrlcARltgfSwxMKpoX5dBsb3ir+Orx4nrOq60YLOlde/IaU9GDjdK6jmcTRzEnWpsqiCa6lBjIXSdpn46UNYuaXAnBQJz1vJi64qmTiqrKKDBFYZgu984NvWcylAEK11YMSbtqCQHAPWi26F68ZHcVTrJJwix+jxaEPrtb6+GEIpY+ydjyom7UEpXqpDrdGgVWpW4jD0DSrWKySX9CQFEULPPM1UL/2ZrRuJQjYIT8lokbAxDdIHJ/G/frXLA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794268620; c=relaxed/relaxed;
	bh=/wzyInIm8OS+TfeVGIGf5m1zs0cKoc4wXGU9YGh2U4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HG2Vc3F72tyE91u4XTBvS+e9c0tF01Dnp20rxn6xQ94h8KlFcEXxssPSdimHfQjDSUgNtYtERGmtgLgC1VHeBDpsNW+WurLU+BhQ6J+WHa9trgYga3Etbi8b8d0mjN/WHcPqXLibvWhKSJW0y+9OaFdymaQBUonqT/0PPcmVDGDY7woWszjac0C2dCaGV7ubAL9nC/MRJTFUjwedtiLKsCbaIoJpiR73r95to7QtxiwhzW9GrhekrIYAVrw36j+fPTeCL2kJ/JhuEEszCfuB+0XJCFnwZhgUsMYbktr40RU2/Xr/4OvbnPqQteRJ94oePruUDtBTW1W8rvrdIxQLKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XQz50uvW; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XQz50uvW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNmsl63RLz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 10:56:59 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LEEdQ502489;
	Mon, 9 Nov 2026 23:56:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/wzyIn
	Im8OS+TfeVGIGf5m1zs0cKoc4wXGU9YGh2U4g=; b=XQz50uvWTY+aJShJFJe9f9
	L0BmYuz2cgRANrU3SyL170Nqq6bWzH6pBRUjlYJ6K56rEyrFD9AkOGp1PAckbRL/
	BBbmzAGfD3NhRImMiGCLvGDQGpvKiO4wu0lX0ce8rXYxy1SFY7bdlkPqL1O/XJkI
	y5ApOGkv3/yVDsaQ0dbQ+a2xZXShDPzqAPNTe27F5JwtAN1xE7OrrYVI/9lHscBe
	Xe0OTSH7zsh4POn7UN7KsbA9ieCcKcOFoVh2z5WsQMi8VYcnF1quiGr2U441byWf
	SG9/ic265TQL3OtZbTTH22ZE3UVEuTz6SiGkLAUGpV/xuH0WtNG6ZdKaGSjwsfzw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq6t9yx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9LK05c812485;
	Mon, 9 Nov 2026 23:56:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0y42bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 23:56:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A9NuBSo28443278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 23:56:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7312658059;
	Mon,  9 Nov 2026 23:56:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E69B558017;
	Mon,  9 Nov 2026 23:56:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.169.223])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 23:56:05 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: Mingming Cao <mmc@linux.ibm.com>, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        shivani@linux.ibm.com, ssrish@linux.ibm.com, nayna@linux.ibm.com,
        gautam@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 01/15] ibmveth: Add MQ RX hypercall wrappers and call definitions
Date: Mon,  9 Nov 2026 15:55:42 -0800
Message-Id: <20261109235556.60604-2-mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261109235556.60604-1-mmc@linux.ibm.com>
References: <20261109235556.60604-1-mmc@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=true
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX772qyZmHc8pN
 ZYrDQwg2cqjaMFvNrE29ccXM0X8DeZ7d5n3838ceT+C+Z7aNACnbroyQ9PTEZMKVGfD2/nPoKtR
 e9RsfmNU1h7I+zL4vGZ6hnwSNkTGO4M=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af25d9e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=9GrW9DZCARAA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=g_pQcjD69mu4thz0hlQA:9 a=3ZKOabzyN94A:10 a=47kamO7So9gA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: K0IjsE_3bgwP4AD4VPMm0Vu1gP6S_pqV
X-Proofpoint-GUID: IzdDymo_qrtFc9RbLtDzFK5MgWOGqqKv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA5NCBTYWx0ZWRfX1wbeO/NbTxXD
 HpBgmLTyN1lqcp2zMMLiX+Vrb+dk81KiLmKpaYsyYhT5m/5H42A6m0ijY+1SRkPRgalQToGPkJP
 F19NQYXd7c2TuPtJ4iILQdgBlxW384aZHBdOYFOV9WaBNeZrhkC6eBvlUwaZzGbCgeHxz//rgq4
 QV43j8S0DaCd2BTGHHrPllm7Ad4NYDRSgiG48yAifPiOuraMDvMio2F42BYitZgseqvOImr5ZdM
 JSHZA41OBfZOezUZlwB6qm9Av6dKYHeLhHFdhRp1PEMVW3I9dpNs6/FDJvIYuPJXp5njTGTQPJT
 bQxMjYyittk2uGapnolhLZvhCMAhXdz9Kx5d04fflBr40eD9nmOzKIRd3ZYpLhvNxUxJGCZ6/kk
 +0vvEupv2emyztMy9G0BgTrI2mL/0LtmyNiIq7o+rhHBIU7D+yyRA8O0aG/BczxiHLzLAreI1zS
 bmeYowPeja0Cs+qoG7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090094
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
unsigned longs, so struct kvm_arch does not change size. The pseries
hcall_inst array is also sized from MAX_HCALL_OPCODE, so those
opcodes can be counted. A debugfs row appears only after the
opcode has been called.

Add ibmveth.h wrapper helpers (h_register_logical_lan_queue(),
h_add_logical_lan_buffers_queue(), h_free_logical_lan_queue()) with
argument ordering matching the existing ibmveth hcall wrappers.
h_free_logical_lan_queue() uses plpar_hcall_norets() like
h_free_logical_lan(). Its kdoc lists the hcall's H_PARAMETER meaning
from the PHYP interface: the unit has no logical LAN, or the handle
names no registered queue (already freed). Also add
h_register_logical_lan_with_handle() so queue 0 can capture the PHYP
queue handle in MQ mode. Both new registration wrappers use
plpar_hcall() rather than plpar_hcall9(), so they do not read unwritten
stack slots, and store their out-parameters only on H_SUCCESS.

Name the three opcodes in tools/perf/python/powerpc-hcalls.py
so perf hcall traces show them. The two reserved slots stay unnamed.

This patch is intentionally plumbing only: no runtime behavior change
yet. Legacy firmware keeps H_REGISTER_LOGICAL_LAN and the existing
buffer hcalls. The new wrappers are used only when a later commit sets
multi_queue from H_ILLAN_ATTRIBUTES.

Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
Reviewed-by: Dave Marquardt <davemarq@linux.ibm.com>
Tested-by: Shaik Abdulla <shaik.abdulla1@ibm.com>
---
Changes in v8:
- H_FREE_LOGICAL_LAN_QUEUE kdoc: subordinate handles only (queue 0 goes
  with H_FREE_LOGICAL_LAN); H_PARAMETER means no logical LAN or no such
  registered queue; the with_handle wrapper's R4 handle exists only on
  firmware that reports MQ RX support
- commit message: out-params are stored only on H_SUCCESS; hcall_inst
  counts the new opcodes

Changes in v7:
- Drop the duplicated "Both new registration wrappers use
  plpar_hcall()…" sentence
- Register and free-queue Return: also H_FUNCTION. Add-buffers
  already had it in v6; all three PAPR 11.20.00 opcodes return that
  status on older firmware
- h_register_logical_lan_queue Return: also
  H_BUSY / H_LONG_BUSY_*; the caller retries those,
  and free-queue already documented them
- tools/perf powerpc-hcalls.py: name 0x49C / 0x4A0 / 0x4A8.
  0x498 and 0x4A4 stay unnamed (reserved holes)

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

 arch/powerpc/include/asm/hvcall.h   |   6 +-
 drivers/net/ethernet/ibm/ibmveth.h  | 146 ++++++++++++++++++++++++++++
 tools/perf/python/powerpc-hcalls.py |   4 +
 3 files changed, 155 insertions(+), 1 deletion(-)

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
index be0939caa328..82f22de16394 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -68,6 +68,152 @@ static inline long h_add_logical_lan_buffers(unsigned long unit_address,
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
+ *   H_BUSY / H_LONG_BUSY_* if the resource is busy; retry
+ *   H_FUNCTION if firmware does not support this hcall
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
+ * h_add_logical_lan_buffers_queue - Add buffers to an RX queue by handle
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
+ * h_free_logical_lan_queue - Deregister a subordinate receive queue
+ * @unit_address: Device unit address
+ * @queue_handle: Queue handle from h_register_logical_lan_queue()
+ *
+ * Deregisters and frees all structures associated with the subordinate
+ * queue. Queue 0 is torn down with the whole logical LAN by
+ * H_FREE_LOGICAL_LAN.
+ *
+ * Return:
+ *   H_SUCCESS - Queue freed successfully
+ *   H_PARAMETER - The unit address has no logical LAN, or the handle
+ *		   names no registered queue (already freed)
+ *   H_HARDWARE - Hardware error
+ *   H_STATE - VIOA not in valid state
+ *   H_BUSY / H_LONG_BUSY_* - Resource busy, retry
+ *   H_FUNCTION - Firmware does not support this hcall
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
+ * R4 carries a handle only on firmware that reports MQ RX support in
+ * H_ILLAN_ATTRIBUTES; use h_register_logical_lan() otherwise.
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
diff --git a/tools/perf/python/powerpc-hcalls.py b/tools/perf/python/powerpc-hcalls.py
index ab5867c05d3e..f743e5751b60 100755
--- a/tools/perf/python/powerpc-hcalls.py
+++ b/tools/perf/python/powerpc-hcalls.py
@@ -197,6 +197,10 @@ HCALL_TABLE = {
 	# Key wrapping hcalls
 	1168: 'H_PKS_WRAP_OBJECT',
 	1172: 'H_PKS_UNWRAP_OBJECT',
+	# Logical LAN multi-queue RX (PAPR 11.20.00)
+	1180: 'H_REG_LOGICAL_LAN_QUEUE',
+	1184: 'H_ADD_LOGICAL_LAN_BUFFERS_QUEUE',
+	1192: 'H_FREE_LOGICAL_LAN_QUEUE',
 	# Platform-specific hcalls used by the Ultravisor
 	61184: 'H_SVM_PAGE_IN',
 	61188: 'H_SVM_PAGE_OUT',
-- 
2.50.1 (Apple Git-155)


