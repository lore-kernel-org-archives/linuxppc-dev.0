Return-Path: <linuxppc-dev+bounces-29695-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA9ECCF2D6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 10:18:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7WjR2TFsz2yfD;
	Mon, 19 Oct 2026 21:18:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792405131;
	cv=none; b=ZJonIPAkegRi3PuADyU9idYU37gTFc5mtZ1DcZj1SWCZl9hUu0niX1TOfqvtapCU+YTd1+LXmVIML/xQBgP1PG4nrULOQgm4P7F/EkgcklMj0lD5bffcWtV3AWOC4NMBWx3AOeahW6NjwQ/DqaylfR5N3SKm3B9vm7Q/GCfWsTKyAcZJ188IN7cBc6SEt1HXZ67RqHmAeUZ+uZ5PXdA2nfRGFMo/djq0C0LsY4LWjWnpJOlf+6Vau2T5NAn+4SdecF2hlhRU2rskxYUr2+e95aFvnqT/HOKXa0r9czu5qdVCNt7h0ZwpIzvU7YLRKPt21PvqHZ0tAHAgwYUASRUiAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792405131; c=relaxed/relaxed;
	bh=AZRIjgfpuiLLxeESXFHgolbsIEeOTWB/NtCgdFmbrS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fG4PnNnvsWNkkNY6c5jZ9Jh5MBGfyEXQs5tRsEkFcVBYCVGPeOcsZbe7Wnd6L7o5S9rfetRewgzs4rYMCi6dh7jnOi97LVRM9C1f9NavJDS2nyhhJJXww5izgqni/55SLJ720T2RX1U4Lg+1zZKfcvu3LAKrMvh8tNGucYZP96jRwNtYvD6jq3iNRDVgGVf1ytyI2SHJEUf46wZJkmriOERwfN1BRBdkjOP7tsnwGhtj1rX7tuHdtfBB1+spl8WkWX5xrVKfkP+jBTWtL/g3kndW2iqp2tNpGGIpmbxwnlIwVxS7L4smK/JfYPxxtYbdNriWjnEctwHMGxyvCBVvUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BsmLlEq+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BsmLlEq+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7WjQ1gRRz2yb9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 21:18:50 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8i7bB1636666;
	Mon, 19 Oct 2026 10:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=AZRIjgfpuiLLxeESXFHgolbsIEeOTWB/NtCgdFmbr
	S4=; b=BsmLlEq+8+dvqQEdXU7u8fRfoaZbz6AB0OwVGwjI7ma0l3JVzxo8xgt5M
	0gQxpuKJSj3O8Psh+Vp0zOj4Gc5V2+OvXjN9WE3DWU2fe2tFlv4mmteCsAVuyTV1
	vaLdHOwLp3cjueFctAyakkyu2oTh9UGBBc3c6chU+fbkshZXtyVzXa8VrPmut2Ab
	fAWrwCxqX5VdA1g1D7zwCS6ftCCmaifustJwJVr6m//is3JRU3XC4y84yNjg8zmf
	+rz/Y11L6kuMndqvOksXrTbHOyh+x0l6Cd42dcCVh4+a9NgJ/yteD5UhckN8UXxk
	ZcNmw7GFk0wC0wuay/Q4tJzdvUZeA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0ptjjjv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:18:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69J8Z0Db3891577;
	Mon, 19 Oct 2026 10:18:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcp1ycy6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Oct 2026 10:18:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69JAIYwJ41550086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Oct 2026 10:18:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D77C20067;
	Mon, 19 Oct 2026 10:18:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5C342005A;
	Mon, 19 Oct 2026 10:18:30 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Oct 2026 10:18:30 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
Subject: [PATCH v5 0/5] powerpc: Add RTAS based error injection support for pSeries
Date: Mon, 19 Oct 2026 15:48:08 +0530
Message-ID: <20261019101813.45085-1-nnmlinux@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX0bbyeYSYQ26d
 CeACZ0vYx6TAegIHIHDRgegNVmwXDYdPB8etuq14jYS45Q+fQuLMU7Dfw3XL+tTwi5ARCYR3W+H
 9iMWDF4PkDtIybbIlt1Tkaj4RoYIuJulyCBZwcX2/Rxnf+i+g7LkkmIKwCG/5Ag5wgMJS8oRdEV
 paTg6eqtWKXyXSBaHvoPSrNPklF/3Rber4RbjxxI2PtP00TdhMnJmCfS1mdv+aWVx7n/d2VpidZ
 +KZ1VsrkdR/qGBUp04Uw8czF5F1AJG2EfNoQQuDjwZCqTMHHJN08BzDKbWf6ib+lhX4RHJ3HDFv
 6BN4bFW56LClxSs6uSe9lSUih+X4zeekTXvrdA/oXLo1gtQG0+Y2CUEhlEY0A3dBQpAMFJFURdn
 1t2DnK6yKKyU2VRUH9lRbQARFVL0REc3WlWhB9nR8AnO79Tkom6poLela6UxTUGu8kGMFCHPEnS
 jz6znit75Z/p3RFkgCA==
X-Authority-Analysis: v=2.4 cv=WNvqzXsR c=1 sm=1 tr=0 ts=6ad5ee7f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=nRuRIvvYaH7j1KTK66wA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MCBTYWx0ZWRfX2jyl2Kx60xTl
 5xMGLSx4GgL9O2lkAt6JSzA8Sy52KHYGhSOjZVRtMBmszc6IuWp613TSGxs9IQatfBtbm8teUtf
 6FhTOk2PB9dXAOi8oS+zsxA/oLTjTh0=
X-Proofpoint-GUID: DK1hFeDTdI7iE0f0Btd29-_i9_rQ-0Nr
X-Proofpoint-ORIG-GUID: m3td926ngq_YMpChgO-Es49Zf6_usKlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190040

The pSeries EEH error-injection backend currently implements a limited
software-generated MMIO failure and does not use the error-injection
services provided by RTAS.

This series replaces that implementation with the PAPR-defined RTAS
workflow based on:

* ibm,open-errinjct
* ibm,errinjct
* ibm,close-errinjct

The implementation opens an RTAS error-injection session, allocates and
prepares an RTAS-accessible work area, performs the requested injection,
releases the work area, and closes the session on both success and failure
paths.

The existing EEH userspace ABI is preserved. EEH_ERR_TYPE_32 and
EEH_ERR_TYPE_64 continue to represent generic 32-bit and 64-bit IOA
bus-error injection requests. The pSeries backend maps these values to
the corresponding RTAS error types, while the PowerNV backend explicitly
maps them to the corresponding OPAL types.

Additional generic EEH error types (EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT,
EEH_ERR_TYPE_CORRUPTED_PAGE, and the cache/TLB corruption types) are
defined in the UAPI header and mapped explicitly to RTAS firmware
encodings by the pSeries backend. Platform backends that do not support
a valid generic type return -EOPNOTSUPP.

No existing userspace ABI values are changed.

The current injection path can be exercised for VFIO-assigned devices
through VFIO_EEH_PE_INJECT_ERR. The guest or userspace VFIO application
continues to use the same generic EEH type and function values,
independent of whether the host platform uses RTAS or OPAL.

For IOA bus-error injection, the VFIO sPAPR path normalizes a Linux BAR
resource address to the corresponding PCI bus address before dispatching
the request to the platform EEH backend. The no-address form is represented
by both address and mask being zero.

The series also handles the unusual return format of
ibm,open-errinjct:

rets[0] = error-injection session token
rets[1] = RTAS status

rtas_call() returns rets[1] as the status and places the session token in
outputs[0], preserving the normal kernel rtas_call() convention.

sys_rtas() continues to expose the raw RTAS return cells to userspace.
For ibm,open-errinjct, it validates that at least two return cells were
requested before entering RTAS and uses the RTAS status cell for
last-error handling. Userspace therefore continues to receive the session
token and status in their PAPR-defined positions.

The pSeries backend uses the existing RTAS work-area allocator for the
error-injection parameter buffer. The work area is allocated only after
ibm,open-errinjct succeeds and is released before ibm,close-errinjct.
RTAS work areas reside below RTAS_INSTANTIATE_MAX, so the physical address
fits in the 32-bit RTAS argument passed to firmware.

The complete open, inject and close sequence is serialized with a mutex.
RTAS busy and extended-delay return values are handled for all three
calls. Once a session has been opened, ibm,close-errinjct is attempted
even when parameter preparation or error injection fails.

The patches are organised as follows:

1. Handle the special ibm,open-errinjct return format in rtas_call().
2. Add pSeries RTAS error-injection validation and buffer helpers.
3. Implement RTAS-based pSeries EEH error injection.
4. Normalize VFIO sPAPR IOA error-injection addresses.
5. Explicitly map generic EEH error types to OPAL types on PowerNV.

Testing was performed on PowerVM with firmware providing the RTAS
error-injection services and with the corresponding QEMU support.

The corresponding QEMU v5 series is posted here:
https://lore.kernel.org/qemu-devel/20260901174110.45356-1-nnmlinux@linux.ibm.com/

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---

Change Log:

V4 -> V5:

* Addressed the v4 review comments from Sourabh Jain.
* Return -EINVAL when ibm,open-errinjct is used with an invalid
  return-cell count.
* Validate the ibm,open-errinjct return-cell count in sys_rtas() before
  entering RTAS and use the common status helper for last-error handling.
* Rework the pSeries helper description to describe the validation and
  RTAS parameter-buffer construction first.
* Rename rtas_type to rtas_err_type to distinguish the mapped RTAS type
  from the generic EEH type.
* Keep common error-function validation in validate_errinjct_args() and
  remove the duplicate check from prepare_errinjct_buffer().
* Protect PE device and BAR traversal with pci_rescan_remove_lock.
* Rename pseries_errinjct_mutex to errinjct_mutex.
* Allocate the RTAS work area only after ibm,open-errinjct succeeds and
  release it before ibm,close-errinjct.
* Ensure ibm,close-errinjct is attempted after a successful open when
  parameter preparation or error injection subsequently fails.
* Remove the caller-side RTAS work-area address check and truncation and
  rely on the RTAS work-area allocation guarantee for the 32-bit RTAS
  argument.
* Remove the unnecessary error message for an unencodable 32-bit IOA
  address or mask and retain the buffer-ready debug message.
* Remove eeh_pe_inject_mmio_error() and its declaration after removing
  its last caller.
* Reorder the VFIO address-normalization patch after the pSeries RTAS
  implementation.
* Remove the one-use VFIO error-type helper and check the IOA error types
  directly at the call site.
* Treat only addr == 0 && mask == 0 as a no-address IOA injection.
* Limit address matching to standard PCI BARs and add a debug message
  when the supplied address does not match a BAR.
* Expand the PowerNV commit message to explain the generic EEH-to-OPAL
  type mapping and rename opal_type to opal_err_type.
* Preserve -ERANGE for unsupported PowerNV error types.

V3 -> V4:
https://lore.kernel.org/all/20260831065441.48654-1-nnmlinux@linux.ibm.com/

* Use the RTAS work area allocator instead of adding a dedicated
  global error-injection buffer.
* Keep sys_rtas() raw return-cell semantics unchanged while handling
  the special ibm,open-errinjct return format in rtas_call().
* Treat ibm,open-errinjct with fewer than two return cells as invalid
  rtas_call() usage instead of interpreting rets[0] as status.
* Use normal Linux errno values in internal validation helpers instead
  of RTAS status values.
* Simplify the pSeries RTAS open/inject/close flow.
* Keep close-session failure as cleanup reporting without overwriting
  the primary operation status.
* Add VFIO sPAPR-side address normalization before dispatching IOA
  error injection to the platform EEH backend.
* Normalize IOA addresses based on the IOA error type, not only
  selected function codes.
* Keep the generic EEH ABI values unchanged and keep pSeries RTAS and
  PowerNV OPAL mappings explicit.

V2 -> V3:

* Fixed ibm,open-errinjct return handling to correctly process firmware
  responses.
* Allocate the error-injection buffer in RTAS-accessible memory instead
  of general kernel memory.
* Pass the physical address of the error-injection buffer to firmware
  (previously incorrect address type).
* Accept session token zero as a valid token (previously rejected
  erroneously).
* Handle RTAS busy and extended-delay return codes for open, inject,
  and close calls.
* Simplified the validation helper -- reduced complexity and removed
  redundant checks.
* Simplified the buffer-preparation helper for cleaner, more
  maintainable code.
* Validate that all required RTAS tokens are present before attempting
  to open a session.
* Added explicit generic EEH-to-OPAL error-type mapping for the
  PowerNV platform.

v1 -> v2:
https://lore.kernel.org/all/20260527072433.94510-1-nnmlinux@linux.ibm.com/

* Addressed all review comments from Sourabh Jain

  * Removed unnecessary empty line in rtas_call()
  * Enhanced comment to explain PAPR specification requirements
  * Corrected misleading comment about output handling
  * Improved else block comment for better code clarity
* Fixed kernel test robot warnings

  * Fixed kernel-doc warning for __maybe_unused parameter
  * Confirmed sparse warnings are false positives (correct endianness
    handling)
* Added PowerNV platform abstraction layer (new Patch 5)

  * Maps EEH error types to OPAL-specific types
  * Simplifies type handling by direct variable update
* Improved code comments and documentation throughout
* Added Reported-by tags for kernel test robot findings
* Split into logical 5-patch series for better review

RFC -> v1:
https://lore.kernel.org/all/20251205094510.4671-1-nnmlinux@linux.ibm.com/

* Initial 4-patch series
* Fixed PAPR ibm,open-errinjct output format (token,status order)
* Added pr_fmt handling for EEH subsystem compatibility
* Implemented comprehensive validation helpers

RFC:
https://lore.kernel.org/all/20251107091009.43034-1-nnmlinux@linux.ibm.com/

* Initial RFC implementation

Narayana Murty N (5):
  powerpc/rtas: Handle ibm,open-errinjct return format
  powerpc/pseries/eeh: Add RTAS error injection helpers
  powerpc/pseries/eeh: Implement RTAS-based EEH error injection
  vfio/spapr_tce: Normalize EEH IOA error injection addresses
  powerpc/powernv/eeh: Map generic EEH error types to OPAL

 arch/powerpc/include/asm/eeh.h               |   2 -
 arch/powerpc/kernel/eeh.c                    |   5 -
 arch/powerpc/kernel/rtas.c                   |  78 ++++++-
 arch/powerpc/platforms/powernv/eeh-powernv.c |  22 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c | 335 +++++++++++++++++++++++++--
 drivers/vfio/vfio_iommu_spapr_tce.c          | 105 +++++++++
 6 files changed, 503 insertions(+), 44 deletions(-)


base-commit: 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e
-- 
2.54.0

