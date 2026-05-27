Return-Path: <linuxppc-dev+bounces-21554-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA36CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 07:25:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQLkF2PW1z2xLs;
	Wed, 27 May 2026 17:25:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779866725;
	cv=none; b=BAdTs10E+EFHttPgJ7kgi9A2ZMgeR993xJpb72iRU4734jnLOCFN+qSxbdGuQbJUC/YMcpjFVWK7RJhf3n9l9rJsONKqo43If8aCskBTSZdvDFduRBn6PqhN/iixWp/urBjHxjUeArozvYc46IHWdUusc3TJM2P4mie2PkpOg/WsAaWMcn3WasscIAqH7aLA/yVcc0s7Pn3KHUGKOqgsDJhb0P8omWvlF+DkecTJ7vp2k1Lw1LLGfowY5bSjHS2vMFHqkpv6rBqHrsqHjka3Cv7GdlYtrukoEtULOaGCjNuEdxu8gSsW7msy09UrgvUbdy3buvsXcI2kXUsLP69/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779866725; c=relaxed/relaxed;
	bh=ZjAeZXhtnFIxSlUYq/Y2bPQV1t8xNu8hmj9ELxBSMCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DStny7WLPrENjvpwfRu2nc9eZCDcJ+uCF9aggnKTSkwR9rirDZo4NFkP/5Za8cvbnD06bdxnrGRclwElzkjr9DMHAlegmp39Bg9cce8Vyllhll3ds/t4pRJufx9PK2D3N1JS8NTd/xoExEdwz0Hxbh8JrHCvtTQLzhLhJT7N23tvy2bIJqR0Rp05N1BRJkzOuDlXpDfm6X3XCnnUPIWYB6uGbrgQClc0g67Ib5T8Q+MJR550s+AwjqlH3PtJfqPivOcKXklWc/abtC1oVMEWugS/vZRUVzm7lfClEkvwhbA03BP8oEKMKnpGZx//qthWBlIbdnLsB3vwBYxoUDWDmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kgSylear; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kgSylear;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQLkD0l0Zz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 17:25:23 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QL4pw0346654;
	Wed, 27 May 2026 07:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ZjAeZXhtnFIxSlUYq/Y2bPQV1t8xNu8hmj9ELxBSM
	Cw=; b=kgSylearaoKnJliVjcGVMUYh2cfgTuIe8ylmUYee2ASEV24Ut5K6NhKGp
	4KHcwef5NzlTjXL9fH11ur55kMPNZC3yxqr2SxJarcHUSDYpptyvLOm0C/dQJGvu
	tw0oYXD/yTjC4C/vV2ODFBqM5uNAnB8bpjtSur1UPL+zYcsWn2YNiZcnDxjUuFxb
	KcLcJBwwloj3G+Yc7pGZeypg32pc1ARaga0MsMLQLjVHXuMq400XgHWbmsFPTldM
	gWnBN0ecOAuACLwoA1iLet73X3N5IGIvgbLit/hU9goBKUnWEwSOKdsYHYQCE00e
	Qbjl+OQpgeGqq3I6329P2057a5mfQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nur75a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:25:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64R7O6R8014075;
	Wed, 27 May 2026 07:25:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb1whd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 07:25:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64R7P1hA25166376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 07:25:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 483B720040;
	Wed, 27 May 2026 07:25:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0893520043;
	Wed, 27 May 2026 07:24:58 +0000 (GMT)
Received: from dhcp-9-123-0-29.bl1-in.ibm.com (unknown [9.123.0.29])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 07:24:57 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v2 0/5] powerpc/pseries: Add full RTAS-based error injection support
Date: Wed, 27 May 2026 12:54:28 +0530
Message-ID: <20260527072433.94510-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA2NyBTYWx0ZWRfX68uIXn/FVhQH
 dd4LQgJA2pCLfaYMs1bKJqU9GFGbxF417bdMKCtxbP5S8WGlNlKi4vS9su3KQRgoTejPXH9neh7
 HBoETyDlMqPbMAtCe66vwujQ912eYPRQ2NMulG5MrtV9cgeQ7oQb5GIeRwrY91M50zHtm6CBY3I
 QMMX+MZP8n8uStXZ0GKD02YJvU+LrxTsCRMHVemm7MHXBcYuPM1A0KbDZe9XtDqwhsME1NJYi2+
 Up7pMEDYBrGqLwjnrxKxrhy1Y2ZLxA1XMRVQFgPtZWcZR+5NvqQO339ugQrJBvpl7e0DA315bjm
 YoHEoFJRfV6sJgOvdaicTFI7cJp0552UtG/C/2APcUFF+SKXcmplaTy2TkMkt0Oi261d5s43mdr
 Zx3flmr6kCn4gdCpRCq6Et1QhU3HsVjTFduTuFC1PTATBVbqQKS16AT6Yl6GA8JhUCUvrtkSAYb
 USwYyhwX590DSVwOWFQ==
X-Authority-Analysis: v=2.4 cv=UtJT8ewB c=1 sm=1 tr=0 ts=6a169c52 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_1BME7lzsUktJUjD6CEA:9
X-Proofpoint-ORIG-GUID: 3Dp7YJnyifqjgHxN3xgjQFGlToO_8glr
X-Proofpoint-GUID: N_AoMGZFVtcnipI_XeRc5wXTxMKTxE9w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270067

The series introduces complete support for RTAS-based hardware error
injection on pseries platforms. The implementation replaces the legacy
MMIO-based approach with a full PAPR-compliant workflow built around the
RTAS services:
	ibm,open-errinjct
	ibm,errinjct
	ibm,close-errinjct

The new pseries_eeh_err_inject() interface enables controlled injection
of synthetic PCI, memory, and cache/TLB faults for platform validation,
EEH testing, firmware diagnostics, and tooling (e.g., bpftrace-based
tracing).

Current testing scope:
At this stage, the feature can be triggered only from VFIO-passthrough
devices assigned to a guest, and from userspace-exposed VFIO devices
using the VFIO_EEH_PE_INJECT_ERR ioctl.

Key Highlights

Dynamic acquisition of all required RTAS tokens and correct
open/errinjct/close session handling as defined by PAPR. A 1KB
naturally-aligned, zero-initialized RTAS working buffer is populated
exactly per PAPR buffer definitions.

Support for a wide range of error types:

0x03 - recovered-special-event
0x04 - corrupted-page
0x07 - ioa-bus-error (32-bit)
0x0F - ioa-bus-error-64 (64-bit)
0x09 - corrupted-dcache-start
0x0A - corrupted-dcache-end
0x0B - corrupted-icache-start
0x0C - corrupted-icache-end
0x0D - corrupted-tlb-start
0x0E - corrupted-tlb-end

All RTAS parameters use proper big-endian formatting (cpu_to_be32()).
Robust status-handling, printk-based diagnostics, and thorough
validation for invalid or unsupported conditions.

Error-specific buffer population logic is factored into helpers for
clarity and maintainability.

Fully tested on PowerVM with firmware that supports RTAS error
injection, along with the companion QEMU support posted here:
https://lore.kernel.org/qemu-devel/20260520095446.64206-1-nnmlinux@linux.ibm.com/

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
Change Log:
v1 -> v2:
 * Addressed all review comments from Sourabh Jain
   - Removed unnecessary empty line in rtas_call()
   - Enhanced comment to explain PAPR specification requirements
   - Corrected misleading comment about output handling
   - Improved else block comment for better code clarity
 * Fixed kernel test robot warnings
   - Fixed kernel-doc warning for __maybe_unused parameter
   - Confirmed sparse warnings are false positives (correct endianness handling)
 * Added PowerNV platform abstraction layer (new Patch 5)
   - Maps EEH error types to OPAL-specific types
   - Simplifies type handling by direct variable update
 * Improved code comments and documentation throughout
 * Added Reported-by tags for kernel test robot findings
 * Split into logical 5-patch series for better review

RFC -> v1: https://lore.kernel.org/all/20251205094510.4671-1-nnmlinux@linux.ibm.com/
 * Initial 4-patch series
 * Fixed PAPR ibm,open-errinjct output format (token,status order)
 * Added pr_fmt handling for EEH subsystem compatibility
 * Implemented comprehensive validation helpers

RFC: https://lore.kernel.org/all/20251107091009.43034-1-nnmlinux@linux.ibm.com/
 * Initial RFC implementation

Narayana Murty N (5):
  powerpc/rtas: Handle special return format for
    RTAS_FN_IBM_OPEN_ERRINJCT
  powerpc/pseries: Add RTAS error injection buffer infrastructure
  powerpc/pseries: Add RTAS error injection validation helpers
  powerpc/pseries: Implement RTAS error injection via
    pseries_eeh_err_inject
  powerpc/powernv: Map EEH error types to OPAL error injection types

 arch/powerpc/include/asm/rtas.h              |  21 +
 arch/powerpc/include/uapi/asm/eeh.h          |  18 +
 arch/powerpc/kernel/rtas.c                   |  59 ++-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  11 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 423 ++++++++++++++++++-
 5 files changed, 505 insertions(+), 27 deletions(-)

-- 
2.54.0


