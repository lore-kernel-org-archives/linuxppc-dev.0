Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1914606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 10:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aFK4U/57
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY2Cv47P1z2xQD;
	Mon, 23 Nov 2026 21:26:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795429579;
	cv=none; b=PuMX8hu2iWsNDE7gvroZN9egohGSRdYLfch3EfGWxgHmyyTS5fIpez4IbIuAYnVFON1M3/syRTVk3cG4S3z5NDT66uJeCuKf3g//ub0w7tZU3LZiYVexOMBwdpgmrLKI9VM232m5V8/kJRUVJgvd3mfC194EyEVaQHz4AqtLJJWpbUT5yqfpWGYFVlBJxcIwx9N6iCBiBe6ojnlTS6U9s0NzC7z166S0YQ2TtchqJ8u0yRotvHh5oDTKhyw4RbAgvgD2HrcTi6p6f2zbEIJ6a53n4gu7NnrFlAcQ7Iii6e3PgHQpwcWO3SvJoXzOLCJO1akQEz0o9NGGq+7nkzKRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795429579; c=relaxed/relaxed;
	bh=Ol6ZqQoWlmXtvtDZk9OZ1/FMafpXtEHt9A6+uNED36E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jVq2Sy0mHOEjXXFSLscqJNnwFg+e+z0taBKvVsdRUwbTX17FPy5+ary9rDTY7R2Pl6BlnYnSddc6Je/rG0fKps8ckmEekdhIInKU3BMbsI0Mj0PQTa4BAo5IPX1sFrHW9QVkej6UgRCS2JNZtjqMmSMHRx7/Tp679a6Q1EevJS7NKhp20KF26NYtmV7itXS6WzB6aKNBVeNBieWta8NF1AWiN/Sch/PTPyd9Vv9ZF9dtObnGdrN5Znw5jSmKHERBx7EAZRe4IFfO/vbQBVq3x9Yu0bD74zJgZCs8qN0rKei9FehQRlKIUjQbINWI/2oSzRQnbm3/AkFU7CHMwS8SDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aFK4U/57; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aFK4U/57;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY2Ct36d2z2xBb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:26:18 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9YlYd1984060;
	Mon, 23 Nov 2026 10:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ol6ZqQ
	oWlmXtvtDZk9OZ1/FMafpXtEHt9A6+uNED36E=; b=aFK4U/57VlpMc81BlCJvaZ
	QU9mOL0VKhpTwMqvz4ALbfHZ4Io6XzkEoMY2VU4A4kmrca4j1FF6DmvrNYGd3SVr
	bzmY0poD254upLiAvc0BFkYMK/IzrFbkbtmubkTJmKgR42oWoTFwDBMtnmZxMXrq
	DBFXGWCfG6Hfl0o/AFbghNW4UzAbjNLWHvFA8LlXfl3Whl57KyT6ePRv+tLMVH1G
	BCW4E+cs5d8WvZ/PyfFLwBt/vgtHPF5el3TJxVALoo1BeXUcG3NGIsFHS770IKjc
	H0QQKoALY//pMu4t+Jw469WoF+V182tLOFBMxVGP8oVp1TFubYD4hI3ePpMUdxNw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4a75m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:25:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9JXHn3089194;
	Mon, 23 Nov 2026 10:25:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjxb57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Nov 2026 10:25:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ANAPYAg49152504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Nov 2026 10:25:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848D52005A;
	Mon, 23 Nov 2026 10:25:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A9762004E;
	Mon, 23 Nov 2026 10:25:31 +0000 (GMT)
Received: from [9.123.4.64] (unknown [9.123.4.64])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Nov 2026 10:25:31 +0000 (GMT)
Message-ID: <871f6da6-6fbe-4971-93e6-d66776e3ad6c@linux.ibm.com>
Date: Mon, 23 Nov 2026 15:55:30 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] powerpc: Add RTAS based error injection support
 for pSeries
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Alex Williamson <alex@shazbot.org>
Cc: sourabhjain@linux.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, sbhat@linux.ibm.com,
        harshpb@linux.ibm.com
References: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20261023073642.59657-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfX+Jj8xqdOtFWd
 iEWQJiJ3SLfwiQiDhORiwwr8JEt2caVQyOTiBQqrVw9l9rcKtpBsvzPqquayjyhzwe0NYBo/X9a
 5aAFAZz84eJ3QH7of3skBSUqZktruho=
X-Proofpoint-GUID: 8-28eVAx0p_kdJ9Nz-mpTWfJpUSnvtIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MCBTYWx0ZWRfX4BX9X2PlNixa
 vwWVib4OyAJusRE4Y/kV7xrYKgdVvLX9ArNkfZ7CVkn8ZtvWRKIw3HlYPSwno5Mj40kEEyMPWeo
 0fZt2++3oq3IexmbUHyUYmSTPD9dijnR0JA9GIMLQzVk1NRuyO8eFnionWFX9PR9VlvAu9wyc6J
 hVUs8yTYcg5ZJJb8uSjU++Qj+BGUf80AflbozdgARfz0PW6Z8YHCOaCl4v4zwTjuHDKDK355aMT
 /YIzHZHV2Ap/PTtypxx/oQbfwM0BuEMwC00TuQqDrpAR4dDSk5gM6bjZJqZHqkRYCXt98Al0/T8
 LXW4zzSv9MabBA5UZuXC5LE4TJhwZgfilZomCGpPwmHSpjRMGNisT0hhvzo9+XXFK7M4KHZa4Iy
 88mADzT912Zt5oOg+sI6WXLMxpUrYTHKCMygdZh/FF7QJpoKgfO4YZ5/0NEJzbjQx/6oy42/MtS
 J/8vX4nG7m82RcmU2/A==
X-Proofpoint-ORIG-GUID: YFGL0QbuKQJ4Uq37_o-vRZxLHbmSNu_6
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b0414a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Z3uMWUZynzQKCD0EPKIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230040
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

HI All,
     Thank you for the valuable feedback, I addressed the all review
comments in v7 (ressend) posted.

https://lore.kernel.org/all/20261123102237.95860-6-nnmlinux@linux.ibm.com/

Thanks,
Narayana Murty

On 23/10/26 1:06 PM, Narayana Murty N wrote:
> The pSeries EEH error-injection backend currently implements a limited
> software-generated MMIO failure and does not use the error-injection
> services provided by RTAS.
> 
> This series replaces that implementation with the PAPR-defined RTAS
> workflow based on:
> 
> - ibm,open-errinjct
> - ibm,errinjct
> - ibm,close-errinjct
> 
> The implementation opens an RTAS error-injection session, allocates and
> prepares an RTAS-accessible work area, performs the requested injection,
> releases the work area, and closes the session on both success and failure
> paths.
> 
> The existing EEH userspace ABI is preserved. EEH_ERR_TYPE_32 and
> EEH_ERR_TYPE_64 continue to represent generic 32-bit and 64-bit IOA
> bus-error injection requests. The pSeries backend maps these values to
> the corresponding RTAS error types, while the PowerNV backend explicitly
> maps them to the corresponding OPAL types.
> 
> Additional generic EEH error types (EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT,
> EEH_ERR_TYPE_CORRUPTED_PAGE, and the cache/TLB corruption types) are
> defined in the UAPI header and mapped explicitly to RTAS firmware
> encodings by the pSeries backend. Platform backends that do not support
> a valid generic type return -EOPNOTSUPP.
> 
> No existing userspace ABI values are changed.
> 
> The injection path can be exercised for VFIO-assigned devices through
> VFIO_EEH_PE_INJECT_ERR. The guest or userspace VFIO application continues
> to use the same generic EEH type and function values, independent of
> whether the host platform uses RTAS or OPAL.
> 
> For IOA bus-error injection, the VFIO sPAPR path normalizes a Linux BAR
> resource address to the corresponding PCI bus address before dispatching
> the request to the platform EEH backend. Address normalization is
> restricted to memory and IO load/store functions whose addr argument is a
> BAR-backed PCI address. Config-space and DMA functions are passed through
> without translation because their addr arguments represent PCI config
> register offsets and IOVA/TCE addresses respectively. The no-address form
> is represented by both address and mask being zero.
> 
> The series also handles the unusual return format of ibm,open-errinjct:
> 
> rets[0] = error-injection session token
> rets[1] = RTAS status
> 
> rtas_call() returns rets[1] as the status and places the session token in
> outputs[0], preserving the normal kernel rtas_call() convention.
> 
> sys_rtas() continues to expose the raw RTAS return cells to userspace.
> For ibm,open-errinjct, it validates that at least two return cells were
> requested before entering RTAS and uses the RTAS status cell for
> last-error handling. Userspace therefore continues to receive the session
> token and status in their PAPR-defined positions.
> 
> The pSeries backend uses the existing RTAS work-area allocator for the
> error-injection parameter buffer. The work area is allocated only after
> ibm,open-errinjct succeeds and is released before ibm,close-errinjct.
> RTAS work areas reside below RTAS_INSTANTIATE_MAX, so the physical address
> fits in the 32-bit RTAS argument passed to firmware.
> 
> The complete open, inject, and close sequence is serialized with a mutex.
> RTAS busy and extended-delay return values are handled for all three
> calls. Once a session has been opened, ibm,close-errinjct is attempted
> even when parameter preparation or error injection fails.
> 
> The patches are organized as follows:
> 
> 1. Handle the special ibm,open-errinjct return format in rtas_call().
> 2. Add pSeries RTAS error-injection validation and buffer helpers.
> 3. Implement RTAS-based pSeries EEH error injection.
> 4. Normalize VFIO sPAPR IOA error-injection addresses.
> 5. Explicitly map generic EEH error types to OPAL types on PowerNV.
> 
> Testing was performed on PowerVM with firmware providing the RTAS
> error-injection services and with corresponding QEMU support.
> 
> The corresponding QEMU v6 series is posted here:
> https://lore.kernel.org/qemu-devel/20261019162541.68440-1-nnmlinux@linux.ibm.com/
> 
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
> ---
> 
> Change Log:
> 
> V5 -> V6:
> https://lore.kernel.org/all/20261019101813.45085-1-nnmlinux@linux.ibm.com/
> * Addressed v5 review comments from Sashiko.
> 
> * Patch 1:
>    - No changes.
> 
> * Patch 2:
>    - Fix false BAR matches against unassigned or disabled BARs in
>      validate_addr_mask_in_pe(): use pci_resource_len() instead of
>      resource_size() (which returns 1 for zero-initialized BARs), and
>      explicitly reject BARs with IORESOURCE_UNSET or IORESOURCE_DISABLED.
>    - Move validate_errinjct_args() and prepare_errinjct_buffer() to
>      Patch 3 alongside their callers so each intermediate commit builds
>      cleanly with CONFIG_WERROR=y without unused-function warnings.
> 
> * Patch 3:
>    - Include <asm/rtas-work-area.h> for the RTAS work-area API used by
>      the pSeries error-injection implementation.
>    - Introduce validate_errinjct_args() and prepare_errinjct_buffer() here
>      alongside their callers (moved from Patch 2).
>    - Fix eeh_break_device() visibility: keep it under #ifdef CONFIG_DEBUG_FS
>      to prevent unused-function compiler warnings when CONFIG_DEBUG_FS=n.
>    - Add pseries_eeh_func_needs_bar_addr() to identify error functions
>      whose addr argument is a BAR-backed MMIO/IO address. Guard
>      validate_addr_mask_in_pe() in prepare_errinjct_buffer() with this
>      predicate so config offsets and DMA/IOVA addresses bypass BAR
>      membership validation.
>    - Demote the validate_addr_mask_in_pe() diagnostic message from
>      pr_err() to pr_debug() since invalid user-supplied inputs do not
>      represent internal kernel errors.
>    - Update prepare_errinjct_buffer() kernel-doc comments to document
>      function-specific addr semantics (MEM/IO = BAR, CFG = offset, DMA = IOVA).
> 
> * Patch 4:
>    - Restrict address normalization to error functions carrying BAR-backed
>      PCI MMIO/IO addresses (memory and IO load/store). Config-space and
>      DMA functions bypass normalization rather than incorrectly returning
>      -EINVAL.
>    - Fix false matches against unassigned/disabled BARs in
>      vfio_spapr_eeh_normalize_addr() using pci_resource_len() and checking
>      IORESOURCE_UNSET / IORESOURCE_DISABLED.
>    - Remove the misleading ", injection may fail" suffix from the
>      pr_debug() message since the caller returns -EINVAL immediately.
>    - Update commit description to accurately reflect function-specific
>      address domains.
> 
> * Patch 5:
>    - No changes.
> 
> V4 -> V5:
> https://lore.kernel.org/all/20260831065441.48654-1-nnmlinux@linux.ibm.com/
> 
> * Addressed v4 review comments from Sourabh Jain.
> * Return -EINVAL when ibm,open-errinjct is used with an invalid
>    return-cell count.
> * Validate the ibm,open-errinjct return-cell count in sys_rtas() before
>    entering RTAS and use the common status helper for last-error handling.
> * Rework the pSeries helper description to describe validation and
>    RTAS parameter-buffer construction first.
> * Rename rtas_type to rtas_err_type to distinguish the mapped RTAS type
>    from the generic EEH type.
> * Keep common error-function validation in validate_errinjct_args() and
>    remove duplicate check from prepare_errinjct_buffer().
> * Protect PE device and BAR traversal with pci_rescan_remove_lock.
> * Rename pseries_errinjct_mutex to errinjct_mutex.
> * Allocate RTAS work area only after ibm,open-errinjct succeeds and
>    release it before ibm,close-errinjct.
> * Ensure ibm,close-errinjct is attempted after a successful open when
>    parameter preparation or error injection subsequently fails.
> * Remove caller-side RTAS work-area address check and truncation, relying
>    on RTAS work-area allocation guarantees for the 32-bit RTAS argument.
> * Remove unnecessary error message for unencodable 32-bit IOA address or
>    mask and retain the buffer-ready debug message.
> * Remove eeh_pe_inject_mmio_error() and its declaration after removing
>    its last caller.
> * Reorder the VFIO address-normalization patch after the pSeries RTAS
>    implementation.
> * Remove the one-use VFIO error-type helper and check IOA error types
>    directly at call site.
> * Treat only addr == 0 && mask == 0 as a no-address IOA injection.
> * Limit address matching to standard PCI BARs and add debug message
>    when supplied address does not match a BAR.
> * Expand PowerNV commit message to explain generic EEH-to-OPAL type
>    mapping and rename opal_type to opal_err_type.
> * Preserve -ERANGE for unsupported PowerNV error types.
> 
> V3 -> V4:
> https://lore.kernel.org/all/20260831065441.48654-1-nnmlinux@linux.ibm.com/
> 
> * Use the RTAS work area allocator instead of adding a dedicated
>    global error-injection buffer.
> * Keep sys_rtas() raw return-cell semantics unchanged while handling
>    the special ibm,open-errinjct return format in rtas_call().
> * Treat ibm,open-errinjct with fewer than two return cells as invalid
>    rtas_call() usage instead of interpreting rets[0] as status.
> * Use normal Linux errno values in internal validation helpers instead
>    of RTAS status values.
> * Simplify the pSeries RTAS open/inject/close flow.
> * Keep close-session failure as cleanup reporting without overwriting
>    the primary operation status.
> * Add VFIO sPAPR-side address normalization before dispatching IOA
>    error injection to the platform EEH backend.
> * Normalize IOA addresses based on the IOA error type, not only
>    selected function codes.
> * Keep the generic EEH ABI values unchanged and keep pSeries RTAS and
>    PowerNV OPAL mappings explicit.
> 
> V2 -> V3:
> 
> * Fixed ibm,open-errinjct return handling to correctly process firmware
>    responses.
> * Allocate the error-injection buffer in RTAS-accessible memory instead
>    of general kernel memory.
> * Pass the physical address of the error-injection buffer to firmware
>    (previously incorrect address type).
> * Accept session token zero as a valid token (previously rejected
>    erroneously).
> * Handle RTAS busy and extended-delay return codes for open, inject,
>    and close calls.
> * Simplified the validation helper -- reduced complexity and removed
>    redundant checks.
> * Simplified the buffer-preparation helper for cleaner, more
>    maintainable code.
> * Validate that all required RTAS tokens are present before attempting
>    to open a session.
> * Added explicit generic EEH-to-OPAL error-type mapping for the
>    PowerNV platform.
> 
> v1 -> v2:
> https://lore.kernel.org/all/20260527072433.94510-1-nnmlinux@linux.ibm.com/
> 
> * Addressed all review comments from Sourabh Jain
>    * Removed unnecessary empty line in rtas_call()
>    * Enhanced comment to explain PAPR specification requirements
>    * Corrected misleading comment about output handling
>    * Improved else block comment for better code clarity
> * Fixed kernel test robot warnings
>    * Fixed kernel-doc warning for __maybe_unused parameter
>    * Confirmed sparse warnings are false positives (correct endianness
>      handling)
> * Added PowerNV platform abstraction layer (new Patch 5)
>    * Maps EEH error types to OPAL-specific types
>    * Simplifies type handling by direct variable update
> * Improved code comments and documentation throughout
> * Added Reported-by tags for kernel test robot findings
> * Split into logical 5-patch series for better review
> 
> RFC -> v1:
> https://lore.kernel.org/all/20251205094510.4671-1-nnmlinux@linux.ibm.com/
> 
> * Initial 4-patch series
> * Fixed PAPR ibm,open-errinjct output format (token,status order)
> * Added pr_fmt handling for EEH subsystem compatibility
> * Implemented comprehensive validation helpers
> 
> RFC:
> https://lore.kernel.org/all/20251107091009.43034-1-nnmlinux@linux.ibm.com/
> 
> * Initial RFC implementation
> 
> Narayana Murty N (5):
>    powerpc/rtas: Handle ibm,open-errinjct return format
>    powerpc/pseries/eeh: Add RTAS error injection helpers
>    powerpc/pseries/eeh: Implement RTAS-based EEH error injection
>    vfio/spapr_tce: Normalize EEH IOA error injection addresses
>    powerpc/powernv/eeh: Map generic EEH error types to OPAL
> 
>   arch/powerpc/include/asm/eeh.h               |   2 -
>   arch/powerpc/kernel/eeh.c                    |  10 +-
>   arch/powerpc/kernel/rtas.c                   |  78 +++-
>   arch/powerpc/platforms/powernv/eeh-powernv.c |  22 +-
>   arch/powerpc/platforms/pseries/eeh_pseries.c | 375 ++++++++++++++++++-
>   drivers/vfio/vfio_iommu_spapr_tce.c          | 140 +++++++
>   6 files changed, 585 insertions(+), 42 deletions(-)
> 


