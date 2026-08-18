Return-Path: <linuxppc-dev+bounces-25958-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F21BC5DF7D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Aug 2026 11:01:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hPRbn69h8z2yCL;
	Tue, 18 Aug 2026 21:01:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787050917;
	cv=none; b=lmsqrcR8QAl4j5Q0/fTInb3si/Z/jibyMFYcQ6fJkQREIobWAUkXq6QbYTCCi/V9+hUu00WMrrcNC3VVxRXtrp5+6RlE3Cy9Ou4xBTyRGpItQuMHVJDzNSnPSB766ME+CE9zNY+EGWThg+0wo2yLNdOMk1G+WQyoJbjrJRzLH4x3Snuegv1KOj1unFbBn42Zl3JPofEoraXEc0/BK37cTBIhfh8iWxAmqCW+u7Wr/Qy+keFyIcGXJzPoZVq7OQ0UeNEsCq4olCfMyDB9UtmxUuO3dxAor7B2BH+AvnlpHe4Iv+ohxjfibIht2ElwVI4Y2o3bfGLLro8lZVsPz3RdIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787050917; c=relaxed/relaxed;
	bh=nibI5XimbEwRFLDcexWPnfVU2M2uwslF1/Lf0tz+Bj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RGJrcDothDN1XZfcF6A/luj/nyemLDVjrIHY70xDyUAcjamwjrgEJBXeQ7Hux3s9Sv8ANXI6XKRW4Akha6f/8y3fRgpKPIQt2gNT66SRLumfcPmR1TxZt88hKD6GQJtrnjB6gZRq03DbVXQnsfTuyOWo7bKLzVdI1dIM6nLwaL5cF95ajBj4RsEQmIWI4dZ3Or1lhKMJVz+Zqrqu9NRRrwmN0D5tCBigP8tZeY91AdXmX0BuQsgwNEipYO0Mn1Qvm7q6UALYCYFeoGev5rOmg5yY+itoH++rqvZ16Shuz4Fv97wJyVrivkQjx1lWndrP2EUrI/SqnVGFe0ddhBxcbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RmYrtV2Z; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RmYrtV2Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=anushree.mathur@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hPRbm4JKCz2xns
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2026 21:01:55 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IAW2Zv4122589;
	Tue, 18 Aug 2026 11:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nibI5X
	imbEwRFLDcexWPnfVU2M2uwslF1/Lf0tz+Bj4=; b=RmYrtV2ZrZYtzDMd30axr3
	LhIaBkD9yDKja+Kdcc4zKXWQAG+Uj3/jbw4hOPh10/zZCwJm2zZk5WredT2g1DA9
	zGGCysq8Zr1g03IGxAkCleJa9YnMcL2qBBwII7chvk+++prfP+pYPEkJfVPXfW7M
	9cA5Ddch+upDHFsVMtV24Ifccb4RtzyF53LdXYyjtkZP4BswaCSKULNY3HQZAeR0
	INswmfBg9TS/sC4TSFRaKBzslXtgKbC3GIgfEAeXfdOTHjZmAKzGSbunDnAPS6V1
	Uhl7R3324MtoiD1SW8BMD9xQ91WO/sAWjnibk/VUn9w8vWkmDbmJ6FQxR1gLuu6Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkyjkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:01:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IAuTix008710;
	Tue, 18 Aug 2026 11:01:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354yajyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 11:01:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IB1dH629098598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 11:01:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98C3858083;
	Tue, 18 Aug 2026 11:01:39 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6589658085;
	Tue, 18 Aug 2026 11:01:34 +0000 (GMT)
Received: from [9.61.248.46] (unknown [9.61.248.46])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 11:01:34 +0000 (GMT)
Message-ID: <df9d8419-43cd-4e95-a030-f7b0bc420a93@linux.ibm.com>
Date: Tue, 18 Aug 2026 16:31:32 +0530
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] powerpc/eeh: Add RTAS-based error injection
 support on pSeries
To: Narayana Murty N <nnmlinux@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        thuth@redhat.com, Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfX4w88tRCvCA23
 nT9aLHUfgvyDcSYvpW5eH0EB8PnsC1M6KcW7TGZRhD59OLTLYUbHvRZpsrgym/ZnhqZLR7TmCuU
 AXmT6A6kzRYTFBkWH0IcFqqT4aC78SkYQSUMpncRAJBLTjRvOyN21+AmcBz/74QwDJ1Af5S3Kdm
 47owyprpSSkYRl22sgQHASwAM6+QxXi+Mt0+FEbTELtm+LyWV59ByOzALCPPr3uWD+4COeOj/Jh
 ZCLDsorj5dE9HSfAVUyXohdcWbQoH+Su6vtARRddfHHU34PFyvdp/vFfSzs3zrWcMwQVaDGQEux
 nodgtg17OT8OrmOi+18cI5a6aFJDq5bNYCpFO7hFvsNraDwokVKJNNfnam5p1QP6yq3ZBUEyBDZ
 BLYnAkO7lFJpwY/BHFPQzWoY8W9s4qP8ihWoss1A/0DKJS1/BcsygQP7tDWz7a5gXuipcO9ao1r
 zd3cZwEuh9tcC5XrSow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA3NyBTYWx0ZWRfX53G604Nsankv
 BVwNem5qtVK5rKyb+M3nSvBM+RYAy/IOQVIeX02lZStv5CPFi0eMn4Pdb+Z/PlRm3UKvgV0rtuX
 KL3LgoqgfLqh9YyZqQKaNQ4hjkMRnqk=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a843b96 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=9z2L4a-QSasgYVkcvlUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -eZJLo3NktlySKUjOfEjT4XRkA7LTz7A
X-Proofpoint-GUID: cutLkvwqpPo4JCWMnxSLA9NliL3R49ZL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180077



On 21/07/26 9:08 AM, Narayana Murty N wrote:
> The pSeries EEH error-injection backend currently implements a limited
> software-generated MMIO failure and does not use the error-injection
> services provided by RTAS.
>
> This series replaces that implementation with the PAPR-defined RTAS
> workflow based on:
>
>    - ibm,open-errinjct
>    - ibm,errinjct
>    - ibm,close-errinjct
>
> The implementation opens an RTAS error-injection session, prepares the
> firmware work buffer, performs the requested injection, and closes the
> session on both success and failure paths.
>
> The existing EEH userspace ABI is preserved. EEH_ERR_TYPE_32 and
> EEH_ERR_TYPE_64 continue to represent generic 32-bit and 64-bit IOA
> bus-error injection requests. The pSeries backend maps these values to
> the corresponding RTAS error types, while the PowerNV backend
> explicitly maps them to the corresponding OPAL types.
>
> Additional generic EEH error types (EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT,
> EEH_ERR_TYPE_CORRUPTED_PAGE, and the cache/TLB corruption types) are now
> defined in the UAPI header and mapped explicitly to RTAS firmware encodings
> by the pSeries backend. Platform backends that do not support a valid
> generic type return -EOPNOTSUPP.
>
> No existing userspace ABI values are changed.
>
> The current injection path can be exercised for VFIO-assigned devices
> through VFIO_EEH_PE_INJECT_ERR. The guest or userspace VFIO application
> continues to use the same generic EEH type and function values,
> independent of whether the host platform uses RTAS or OPAL.
>
> The series also handles the unusual return format of
> ibm,open-errinjct:
>
> rets[0] = error-injection session token
> rets[1] = RTAS status
>
> rtas_call() now returns rets[1] as the status and places the session
> token in outputs[0], preserving the normal kernel rtas_call()
> convention.
>
> sys_rtas() is intentionally unchanged because it exposes the raw RTAS
> return cells to userspace. Userspace therefore continues to receive
> the session token and status in their PAPR-defined positions.
>
> The RTAS work buffer is allocated during RTAS initialization below:
>
> min(ppc64_rma_size, RTAS_INSTANTIATE_MAX)
>
> using the same accessible-memory limit used for rtas_rmo_buf. The
> kernel populates the buffer through its virtual mapping but passes its
> physical address to firmware.
>
> The complete open, inject and close sequence is serialized with a
> mutex. RTAS busy and extended-delay return values are handled for all
> three calls. A session token value of zero is accepted, and session
> state is tracked independently from the token value.
>
> The patches are organised as follows:
>
> Handle the special ibm,open-errinjct return format in rtas_call().
> Allocate an RTAS-accessible error-injection work buffer.
> Add pSeries RTAS parameter validation and buffer encoding helpers.
> Implement RTAS-based pSeries EEH error injection.
> Explicitly map generic EEH error types to OPAL types on PowerNV.
>
> Testing was performed on PowerVM with firmware providing the RTAS
> error-injection services and with the corresponding QEMU support:
>
> https://lore.kernel.org/qemu-devel/20260520095446.64206-1-nnmlinux@linux.ibm.com/
>
> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>
> Narayana Murty N (5):
>    powerpc/rtas: Handle ibm,open-errinjct return format
>    powerpc/rtas: Allocate ibm,errinjct buffer below RTAS limit
>    powerpc/pseries/eeh: Add RTAS error validation helpers
>    powerpc/pseries/eeh: Implement RTAS-based EEH error injection
>    powerpc/powernv/eeh: Map VFIO EEH error injection to OPAL
>
>   arch/powerpc/include/asm/rtas.h              |  26 ++
>   arch/powerpc/include/uapi/asm/eeh.h          |  24 +-
>   arch/powerpc/kernel/rtas.c                   |  68 +++-
>   arch/powerpc/platforms/powernv/eeh-powernv.c |  36 +-
>   arch/powerpc/platforms/pseries/eeh_pseries.c | 367 +++++++++++++++++--
>   5 files changed, 483 insertions(+), 38 deletions(-)
>
> Change Log:
> V2 -> V3:
>   * Fixed ibm,open-errinjct return handling to correctly process firmware responses.
>   * Allocate the error-injection buffer in RTAS-accessible memory instead of general kernel memory.
>   * Pass the physical address of the error-injection buffer to firmware (previously incorrect address type).
>   * Accept session token zero as a valid token (previously rejected erroneously).
>   * Handle RTAS busy and extended-delay return codes for open-inject, and close calls.
>   * Simplified the validation helper — reduced complexity and removed redundant checks.
>   * Simplified the buffer-preparation helper for cleaner, more maintainable code.
>   * Validate that all required RTAS tokens are present before attempting to open a session.
>   * Added explicit generic EEH-to-OPAL error-type mapping for the PowerNV platform.
>   
> v1 -> v2: https://lore.kernel.org/all/20260527072433.94510-1-nnmlinux@linux.ibm.com/
>   * Addressed all review comments from Sourabh Jain
>     - Removed unnecessary empty line in rtas_call()
>     - Enhanced comment to explain PAPR specification requirements
>     - Corrected misleading comment about output handling
>     - Improved else block comment for better code clarity
>   * Fixed kernel test robot warnings
>     - Fixed kernel-doc warning for __maybe_unused parameter
>     - Confirmed sparse warnings are false positives (correct endianness handling)
>   * Added PowerNV platform abstraction layer (new Patch 5)
>     - Maps EEH error types to OPAL-specific types
>     - Simplifies type handling by direct variable update
>   * Improved code comments and documentation throughout
>   * Added Reported-by tags for kernel test robot findings
>   * Split into logical 5-patch series for better review
>
> RFC -> v1: https://lore.kernel.org/all/20251205094510.4671-1-nnmlinux@linux.ibm.com/
>   * Initial 4-patch series
>   * Fixed PAPR ibm,open-errinjct output format (token,status order)
>   * Added pr_fmt handling for EEH subsystem compatibility
>   * Implemented comprehensive validation helpers
>
> RFC: https://lore.kernel.org/all/20251107091009.43034-1-nnmlinux@linux.ibm.com/
>   * Initial RFC implementation
Hi Narayana,
I have tested this patch along with the qemu patch series 
(https://lore.kernel.org/all/20260520095446.64206-1-nnmlinux@linux.ibm.com/)
and I am still seeing the issue in which I am not able to trigger EEH on 
NVME Backplane device after passthroughing it to guest.
I tried using location code with and without mask and address and EEH is 
not getting triggered.

1st command :

errinjct ioa-bus-error-64  -f 6 -p U2E4A.ND0.WZS0211-P1-C0  -a 
0x88020000 -m 0xffffffffffff8000 -k 1

2nd command :

errinjct ioa-bus-error-64  -f 6 -p U2E4A.ND0.WZS0211-P1-C0 -m 0 -k 1

Getting the following issue everytime

errinjct: Could not open file /proc/device-tree/ibm,loc-code, No such 
file or directory

errinjct: Could not open file 
/proc/device-tree/ibm,platform-keystore/ibm,loc-code, No such file or 
directory

errinjct: Could not open file /proc/device-tree/memory@0/ibm,loc-code, 
No such file or directory

Injecting an ioa-bus-error...
errinjct: RTAS error injection failed!

errinjct: RTAS: ioa-bus-error: Argument error (-3)

This error may have occurred because error injection
is disabled for this partition. Please check the
FSP and ensure you have error injection enabled.

Please look into this.

Thank you,
Anushree Mathur



