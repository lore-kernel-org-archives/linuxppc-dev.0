Return-Path: <linuxppc-dev+bounces-24572-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC136C4452F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 03:39:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h435d0Q9Sz2yDs;
	Tue, 21 Jul 2026 13:39:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784605140;
	cv=none; b=iuzaOwDfKs5uGvXGnvkVXssoyqqeFZSU128/xPrVhl4JuEPS5kn2FuNZLyKCORkgVhXaISGNtf1HkvPXmLe5w5GNw3P3nFXJ4b8E2gXuhHewii1qrI5DxngydpPFEA/kQBHoJz6HM8SmJN1gzhsDOjTV8DnLdci1uhEEQmctGa7DQAmpmQmrOUt1D5gM4B35bjxfReHnLb3Q2tVgIXIyFyh6lzE1WG2X7YH4bKyIjpNHyNYJRLieDdWJUJzChnib5U+TR3zG5CNo5M6d7AMl4QAQ9CykBFbGARUqHX+bHwcblXKCGdg4nz+DyxnjDUEmRI8a2INPXcWfQUhIkQL/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784605140; c=relaxed/relaxed;
	bh=0nkRFPWs7ypJ8mmFZcCGQvcXbrLN1TMIZR/gWJCYUGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kXGahJ9TUnePffx8rmWYAz4ePtFGQ6+DLVaHcRr+f76+hrW3CQtZ5SHHqm5RYOokyWovkp1aZ0LaPvdVi7Sh1CM5IhcIplOb3zLuUsXqyl0MvTXM9ktNuAAbckVrZMmqf1rz6dS42fc8XoUvvBX36tspbOm2p6J1/xOAcuqHi6rRRgQMPa1+CIQ/oQ3TMHSyLR6jP5zidiXTFYSBTAtHZ+GaA5coFys9tDNW8QKnS55a2SI7MjHZrGNQogzL7TXaNhG85p0czi9QUp/tgiGs3LbFJv7ZOs9UHdRNKPLy6++1ayBJ4cC+w4WvaXXEp3q727v8eGLZMAkvz21RfkV9hg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ahacBNPn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ahacBNPn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h435b3GlFz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 13:38:59 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDu0P3482046;
	Tue, 21 Jul 2026 03:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=0nkRFPWs7ypJ8mmFZcCGQvcXbrLN
	1TMIZR/gWJCYUGg=; b=ahacBNPn4ygthAo8oTe09Y1sBpfcIrsUF+vOeB/LIP2a
	fSpwGiBJNDbP3xzP876ROJH0kCi1mQvvv2ws0jWAmXall3bWpnBmwRB0axKxqC5J
	Llo3pRNuPZ7QqAlL8OXRQYFmN04p3OKkevwQFZ5NLYZ+Odc3ywinDt57/tkyfCDC
	JbGEgZ2+gpkDzdmX76Aq12QREwM2kp8rattF8bUDBhhX12R9zNLBBuWmeujn6+kN
	zmQLHSeryMWEAG5JHVXxxIpXt8ftBBzyDt/XG63sjNlIy/K3Nu6x6KQejA5+poGG
	bjGb5hSHeS4Tky2z13wKnDwKYKe8ZKiNVaGUAzUDuQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k2bh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:38:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L3YdGN027703;
	Tue, 21 Jul 2026 03:38:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah0gvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 03:38:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L3cXUB59048194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 03:38:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CB432004B;
	Tue, 21 Jul 2026 03:38:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB48D20040;
	Tue, 21 Jul 2026 03:38:28 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.218.117])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 03:38:28 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, gregkh@linuxfoundation.org,
        oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        nnmlinux@linux.ibm.com, thuth@redhat.com
Subject: [PATCH v3 0/5] powerpc/eeh: Add RTAS-based error injection support on pSeries
Date: Tue, 21 Jul 2026 09:08:00 +0530
Message-ID: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5ee9c0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=K5h3zDdfNZjlG3FZbBEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfX3xaBNO9eQQvF
 Ax8GBj8gUvpr9h4GapV1A/MEiLxYNCp1S+svcwsmKF2w9I7jQzmpCDKemebT+BK3lzz1Hw3rSwk
 fL5yuh/F5LgZ6chUMKk3GL8DUT4K1e5+LUqsWj+mjHjgAhpxKQT/IjXLFFeJ7MT2OPXbVNmadVM
 KsKJ5TVzZaYm/7M/SbnsOebfnvfhRJOE8xzt6Ct76B3FZeWNlv1mFaofuR8ivGv/YfSG0DdrPYt
 ITIyDTQ3LDVT37OCrA/12hbXRkfz0nrJoRE8ApPmVHY42Do4Eyz2CEvUd7SfDX72Jw9dtFAI1XU
 qYsV8JNaOXhAgOr7G0WDPZ6siYCqmt3S51aWpMYhsImu79WuFajWvHhAIUCbVefXzEIEez5SiFO
 8qUfuxbC+kaXiIfe2sGzKzcHFK7RRQI3n9cnB55y+PsYXYmidBrg5jVhuWsIj9wO9VRzw9cLgUj
 T/QcQi4p/EgAPItc/8Q==
X-Proofpoint-ORIG-GUID: WyUkKcqFqe-GxPlsllvJJmqG7jl7fjBf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDAzMCBTYWx0ZWRfX0cTlhAa/28rM
 ciWjGfO6IKPH1VhYrYzK3J/YxMRitYK8QYpjxY39wDpRR5qDq8X/E83IELj2DbnqYk3Pn4hPmbd
 nkfiFuB/9T4AkR70xVc/BcKlmcu7pcs=
X-Proofpoint-GUID: _yM9isfFaTJDkTG9XrA7OWselN_etD8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210030

The pSeries EEH error-injection backend currently implements a limited
software-generated MMIO failure and does not use the error-injection
services provided by RTAS.

This series replaces that implementation with the PAPR-defined RTAS
workflow based on:

  - ibm,open-errinjct
  - ibm,errinjct
  - ibm,close-errinjct

The implementation opens an RTAS error-injection session, prepares the
firmware work buffer, performs the requested injection, and closes the
session on both success and failure paths.

The existing EEH userspace ABI is preserved. EEH_ERR_TYPE_32 and
EEH_ERR_TYPE_64 continue to represent generic 32-bit and 64-bit IOA
bus-error injection requests. The pSeries backend maps these values to
the corresponding RTAS error types, while the PowerNV backend
explicitly maps them to the corresponding OPAL types.

Additional generic EEH error types (EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT,
EEH_ERR_TYPE_CORRUPTED_PAGE, and the cache/TLB corruption types) are now
defined in the UAPI header and mapped explicitly to RTAS firmware encodings
by the pSeries backend. Platform backends that do not support a valid
generic type return -EOPNOTSUPP.

No existing userspace ABI values are changed.

The current injection path can be exercised for VFIO-assigned devices
through VFIO_EEH_PE_INJECT_ERR. The guest or userspace VFIO application
continues to use the same generic EEH type and function values,
independent of whether the host platform uses RTAS or OPAL.

The series also handles the unusual return format of
ibm,open-errinjct:

rets[0] = error-injection session token
rets[1] = RTAS status

rtas_call() now returns rets[1] as the status and places the session
token in outputs[0], preserving the normal kernel rtas_call()
convention.

sys_rtas() is intentionally unchanged because it exposes the raw RTAS
return cells to userspace. Userspace therefore continues to receive
the session token and status in their PAPR-defined positions.

The RTAS work buffer is allocated during RTAS initialization below:

min(ppc64_rma_size, RTAS_INSTANTIATE_MAX)

using the same accessible-memory limit used for rtas_rmo_buf. The
kernel populates the buffer through its virtual mapping but passes its
physical address to firmware.

The complete open, inject and close sequence is serialized with a
mutex. RTAS busy and extended-delay return values are handled for all
three calls. A session token value of zero is accepted, and session
state is tracked independently from the token value.

The patches are organised as follows:

Handle the special ibm,open-errinjct return format in rtas_call().
Allocate an RTAS-accessible error-injection work buffer.
Add pSeries RTAS parameter validation and buffer encoding helpers.
Implement RTAS-based pSeries EEH error injection.
Explicitly map generic EEH error types to OPAL types on PowerNV.

Testing was performed on PowerVM with firmware providing the RTAS
error-injection services and with the corresponding QEMU support:

https://lore.kernel.org/qemu-devel/20260520095446.64206-1-nnmlinux@linux.ibm.com/

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>

Narayana Murty N (5):
  powerpc/rtas: Handle ibm,open-errinjct return format
  powerpc/rtas: Allocate ibm,errinjct buffer below RTAS limit
  powerpc/pseries/eeh: Add RTAS error validation helpers
  powerpc/pseries/eeh: Implement RTAS-based EEH error injection
  powerpc/powernv/eeh: Map VFIO EEH error injection to OPAL

 arch/powerpc/include/asm/rtas.h              |  26 ++
 arch/powerpc/include/uapi/asm/eeh.h          |  24 +-
 arch/powerpc/kernel/rtas.c                   |  68 +++-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  36 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 367 +++++++++++++++++--
 5 files changed, 483 insertions(+), 38 deletions(-)

Change Log:
V2 -> V3:
 * Fixed ibm,open-errinjct return handling to correctly process firmware responses.
 * Allocate the error-injection buffer in RTAS-accessible memory instead of general kernel memory.
 * Pass the physical address of the error-injection buffer to firmware (previously incorrect address type).
 * Accept session token zero as a valid token (previously rejected erroneously).
 * Handle RTAS busy and extended-delay return codes for open-inject, and close calls.
 * Simplified the validation helper — reduced complexity and removed redundant checks.
 * Simplified the buffer-preparation helper for cleaner, more maintainable code.
 * Validate that all required RTAS tokens are present before attempting to open a session.
 * Added explicit generic EEH-to-OPAL error-type mapping for the PowerNV platform.
 
v1 -> v2: https://lore.kernel.org/all/20260527072433.94510-1-nnmlinux@linux.ibm.com/
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
-- 
2.54.0


