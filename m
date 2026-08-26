Return-Path: <linuxppc-dev+bounces-26093-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E694C61DC2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Aug 2026 09:12:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVJnG47Ckz2y32;
	Wed, 26 Aug 2026 19:12:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787735522;
	cv=none; b=P1MaGvn0TTS1KnOat0gMElPUj4DA7S/l+ByobyT/FtuKF1jHNDwj26PJSZ9XEmORPAYlLxv7rchNCyR66Y0HBAYelGGxc+4vpPjhLGmN2tmj9+CyBE5dmdiKzSb6D/nXly+AG2OKQj+QcXicbiFFSDUxdZ1cm7Q/eOZ57nNC8kk+vVeBhrCKcVrKoCaK213CA6AJ65HLTaQ2/l4MDG8g1dcmJJaijJpM6FBrX92xPJUOpDkE7AZQR6Pv/dVhkh5f4G1L57xHs+Zpsnw+H5uuhNceheI1XaBVux7hNTYPxJoCagaGlxCG35Tbb02pY2zu90kTPqZuU1MOq2fjdn24FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787735522; c=relaxed/relaxed;
	bh=qzmRDW5+BT1TUmpDV2FLEMCRGhZscH6iP64nSTGwFpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXOexUICDtHZA0Hnjpm4YV44GpnFURQMU2npgOpbm3yEKPzueSAPxY3paov4mM9KWWj3rEMLvhygBUYgsTC4tCWo3kSNEBMzLo2S16Qy10iIHg9pDxynpUUIs84AuI2TIJ8dJjwpEoff3Y0SNbuJQyMQUS/soxwIYX72jSeZEVdhhXVrE94yU0OB4fIQe+bLqUihNiQ71qjoV5cm9hcIZWd9MCAtGtUsxQlj2ch/3slL5Rmd+LQkZ8dG7so61QMb8qUcs2rpNAt2dIr8GELKtVJcD7lbhC1x+j5zSA1UT4Zr5eNnMkWzaumqlSE71zkBTjGGZ9Te5AptOlX+s1Dn7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PF9WOn1p; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PF9WOn1p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVJnF3vThz2xGw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2026 19:12:01 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6WHPQ2087678;
	Wed, 26 Aug 2026 09:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qzmRDW
	5+BT1TUmpDV2FLEMCRGhZscH6iP64nSTGwFpI=; b=PF9WOn1p9/hvxQbKYsa2z9
	VMsM5XeWkoneVn4Xziczl1x9bwPo4Js47pM2if4yskz69Wwg68ORqm8GTN9gdZzr
	MZHhRJEtzHFASdilDoYE1SiVzn4j7O77f5Sg+C+TSnL/Ri4lIwM1yVMONqyVKhEO
	FfNQli0cIrWo+UDJprW+I4C2joh5mO5BgnwXlVlIV3iHbTZ+g8nY2iA5UMpyTUsr
	nD54ZAtEyYQHvmn1SUTMxo2tUDCUj8MHjKKm/nNOhvmP+1EZdhpXZ+kUn2CHOf1k
	24afUEfQwogoc5XGxrecGsiaM7Tm221HQkkUk6SbQMqM3D3HwfekznNqdhXtaEmw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726enkks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 09:11:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67Q8uINp012053;
	Wed, 26 Aug 2026 09:11:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkh91es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 09:11:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67Q9Bf0w34537872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 09:11:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3F422004B;
	Wed, 26 Aug 2026 09:11:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B12420040;
	Wed, 26 Aug 2026 09:11:38 +0000 (GMT)
Received: from [9.123.12.89] (unknown [9.123.12.89])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Aug 2026 09:11:38 +0000 (GMT)
Message-ID: <f1b9207f-5366-422e-8060-5afd00019012@linux.ibm.com>
Date: Wed, 26 Aug 2026 14:41:37 +0530
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
To: Anushree Mathur <anushree.mathur@linux.ibm.com>, mahesh@linux.ibm.com,
        maddy@linux.ibm.com, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        gregkh@linuxfoundation.org, oohall@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        tyreld@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        ganeshgr@linux.ibm.com, sourabhjain@linux.ibm.com, haren@linux.ibm.com,
        thuth@redhat.com, Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
References: <20260721033815.5300-1-nnmlinux@linux.ibm.com>
 <df9d8419-43cd-4e95-a030-f7b0bc420a93@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <df9d8419-43cd-4e95-a030-f7b0bc420a93@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8eadd4 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=3ZwucR2MOHLG0_Ajg7wA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=z2U-W3hJrleVIN9YIjzO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3NCBTYWx0ZWRfXxTmIvWddfmn+
 g+fV7O4PkFRhMEXSdOYEoEv3aWJRBXD7/OHFVxUEopSxkm8X3901s8Mqg59rBayVU5vqYHYbnUh
 wcIMJE+bNH0KcmBORn+jXq2UWT0nud8=
X-Proofpoint-GUID: 4z74f_ddkSyQjN3RzKC_Qk9oXsvwSNOt
X-Proofpoint-ORIG-GUID: t52cOJ--9R-3M2jxlPZ81rSZ5-RsMe5N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3NCBTYWx0ZWRfXwzkOHwKXJVxR
 tg87hbIPP8TFrPPMkeIToUmOZRWxIhxAOYb1PtgG+1UHVw1k/TFoZKeSdO+F/3eFzIQOTHbbj1n
 GEs2A8JZlkqCgs3JHyyU3wL2Pz6Pu3flfTg73xklTgo0BfcUsuYa+kpxgAGk7n59foF3WToaSB5
 4G70GLn5nbi6GS4OyrbuXpGKpW5YZby01g86wCCukQsRz0umNznjKERdctEeiobulT73giAMd4R
 L0j5KkzYRE5TfKOtWcpuSsd2hEA2x6fT0KRXxNI3cLkLjgBN5SZe67nFDBjm8Hh4rtUH7TReS08
 AunhvWEvFJmjONBepwvEbfZlPBqs91uv6rpKLR21EYL50tveGBV3XF2oi6H6Buvav7Nf+71Kjke
 zHhjb7w03TN7m/rz0j6baX+fPun5J4sp8kdx4qydgJk5NwM0WRvMLxHudSrfAaBTFYl8I1Q7ped
 v3vTLnPWTUOmZy3BBDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260074

Hi Anushree,

Thanks for testing the series.

On 18/08/26 4:31 PM, Anushree Mathur wrote:
> 
> 
> On 21/07/26 9:08 AM, Narayana Murty N wrote:
>> The pSeries EEH error-injection backend currently implements a limited
>> software-generated MMIO failure and does not use the error-injection
>> services provided by RTAS.
>>
>> This series replaces that implementation with the PAPR-defined RTAS
>> workflow based on:
>>
>>    - ibm,open-errinjct
>>    - ibm,errinjct
>>    - ibm,close-errinjct
>>
>> The implementation opens an RTAS error-injection session, prepares the
>> firmware work buffer, performs the requested injection, and closes the
>> session on both success and failure paths.
>>
>> The existing EEH userspace ABI is preserved. EEH_ERR_TYPE_32 and
>> EEH_ERR_TYPE_64 continue to represent generic 32-bit and 64-bit IOA
>> bus-error injection requests. The pSeries backend maps these values to
>> the corresponding RTAS error types, while the PowerNV backend
>> explicitly maps them to the corresponding OPAL types.
>>
>> Additional generic EEH error types (EEH_ERR_TYPE_RECOVERED_SPECIAL_EVENT,
>> EEH_ERR_TYPE_CORRUPTED_PAGE, and the cache/TLB corruption types) are now
>> defined in the UAPI header and mapped explicitly to RTAS firmware 
>> encodings
>> by the pSeries backend. Platform backends that do not support a valid
>> generic type return -EOPNOTSUPP.
>>
>> No existing userspace ABI values are changed.
>>
>> The current injection path can be exercised for VFIO-assigned devices
>> through VFIO_EEH_PE_INJECT_ERR. The guest or userspace VFIO application
>> continues to use the same generic EEH type and function values,
>> independent of whether the host platform uses RTAS or OPAL.
>>
>> The series also handles the unusual return format of
>> ibm,open-errinjct:
>>
>> rets[0] = error-injection session token
>> rets[1] = RTAS status
>>
>> rtas_call() now returns rets[1] as the status and places the session
>> token in outputs[0], preserving the normal kernel rtas_call()
>> convention.
>>
>> sys_rtas() is intentionally unchanged because it exposes the raw RTAS
>> return cells to userspace. Userspace therefore continues to receive
>> the session token and status in their PAPR-defined positions.
>>
>> The RTAS work buffer is allocated during RTAS initialization below:
>>
>> min(ppc64_rma_size, RTAS_INSTANTIATE_MAX)
>>
>> using the same accessible-memory limit used for rtas_rmo_buf. The
>> kernel populates the buffer through its virtual mapping but passes its
>> physical address to firmware.
>>
>> The complete open, inject and close sequence is serialized with a
>> mutex. RTAS busy and extended-delay return values are handled for all
>> three calls. A session token value of zero is accepted, and session
>> state is tracked independently from the token value.
>>
>> The patches are organised as follows:
>>
>> Handle the special ibm,open-errinjct return format in rtas_call().
>> Allocate an RTAS-accessible error-injection work buffer.
>> Add pSeries RTAS parameter validation and buffer encoding helpers.
>> Implement RTAS-based pSeries EEH error injection.
>> Explicitly map generic EEH error types to OPAL types on PowerNV.
>>
>> Testing was performed on PowerVM with firmware providing the RTAS
>> error-injection services and with the corresponding QEMU support:
>>
>> https://lore.kernel.org/qemu-devel/20260520095446.64206-1- 
>> nnmlinux@linux.ibm.com/
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>>
>> Narayana Murty N (5):
>>    powerpc/rtas: Handle ibm,open-errinjct return format
>>    powerpc/rtas: Allocate ibm,errinjct buffer below RTAS limit
>>    powerpc/pseries/eeh: Add RTAS error validation helpers
>>    powerpc/pseries/eeh: Implement RTAS-based EEH error injection
>>    powerpc/powernv/eeh: Map VFIO EEH error injection to OPAL
>>
>>   arch/powerpc/include/asm/rtas.h              |  26 ++
>>   arch/powerpc/include/uapi/asm/eeh.h          |  24 +-
>>   arch/powerpc/kernel/rtas.c                   |  68 +++-
>>   arch/powerpc/platforms/powernv/eeh-powernv.c |  36 +-
>>   arch/powerpc/platforms/pseries/eeh_pseries.c | 367 +++++++++++++++++--
>>   5 files changed, 483 insertions(+), 38 deletions(-)
>>
>> Change Log:
>> V2 -> V3:
>>   * Fixed ibm,open-errinjct return handling to correctly process 
>> firmware responses.
>>   * Allocate the error-injection buffer in RTAS-accessible memory 
>> instead of general kernel memory.
>>   * Pass the physical address of the error-injection buffer to 
>> firmware (previously incorrect address type).
>>   * Accept session token zero as a valid token (previously rejected 
>> erroneously).
>>   * Handle RTAS busy and extended-delay return codes for open-inject, 
>> and close calls.
>>   * Simplified the validation helper — reduced complexity and removed 
>> redundant checks.
>>   * Simplified the buffer-preparation helper for cleaner, more 
>> maintainable code.
>>   * Validate that all required RTAS tokens are present before 
>> attempting to open a session.
>>   * Added explicit generic EEH-to-OPAL error-type mapping for the 
>> PowerNV platform.
>> v1 -> v2: https://lore.kernel.org/all/20260527072433.94510-1- 
>> nnmlinux@linux.ibm.com/
>>   * Addressed all review comments from Sourabh Jain
>>     - Removed unnecessary empty line in rtas_call()
>>     - Enhanced comment to explain PAPR specification requirements
>>     - Corrected misleading comment about output handling
>>     - Improved else block comment for better code clarity
>>   * Fixed kernel test robot warnings
>>     - Fixed kernel-doc warning for __maybe_unused parameter
>>     - Confirmed sparse warnings are false positives (correct 
>> endianness handling)
>>   * Added PowerNV platform abstraction layer (new Patch 5)
>>     - Maps EEH error types to OPAL-specific types
>>     - Simplifies type handling by direct variable update
>>   * Improved code comments and documentation throughout
>>   * Added Reported-by tags for kernel test robot findings
>>   * Split into logical 5-patch series for better review
>>
>> RFC -> v1: https://lore.kernel.org/all/20251205094510.4671-1- 
>> nnmlinux@linux.ibm.com/
>>   * Initial 4-patch series
>>   * Fixed PAPR ibm,open-errinjct output format (token,status order)
>>   * Added pr_fmt handling for EEH subsystem compatibility
>>   * Implemented comprehensive validation helpers
>>
>> RFC: https://lore.kernel.org/all/20251107091009.43034-1- 
>> nnmlinux@linux.ibm.com/
>>   * Initial RFC implementation
> Hi Narayana,
> I have tested this patch along with the qemu patch series (https:// 
> lore.kernel.org/all/20260520095446.64206-1-nnmlinux@linux.ibm.com/)
> and I am still seeing the issue in which I am not able to trigger EEH on 
> NVME Backplane device after passthroughing it to guest.
> I tried using location code with and without mask and address and EEH is 
> not getting triggered.
> 
> 1st command :
> 
> errinjct ioa-bus-error-64  -f 6 -p U2E4A.ND0.WZS0211-P1-C0  -a 
> 0x88020000 -m 0xffffffffffff8000 -k 1
> 
> 2nd command :
> 
> errinjct ioa-bus-error-64  -f 6 -p U2E4A.ND0.WZS0211-P1-C0 -m 0 -k 1
> 
> Getting the following issue everytime
> 
> errinjct: Could not open file /proc/device-tree/ibm,loc-code, No such 
> file or directory
> 
> errinjct: Could not open file /proc/device-tree/ibm,platform-keystore/ 
> ibm,loc-code, No such file or directory
> 
> errinjct: Could not open file /proc/device-tree/memory@0/ibm,loc-code, 
> No such file or directory
> 
> Injecting an ioa-bus-error...
> errinjct: RTAS error injection failed!
> 
> errinjct: RTAS: ioa-bus-error: Argument error (-3)
> 
> This error may have occurred because error injection
> is disabled for this partition. Please check the
> FSP and ensure you have error injection enabled.
> 
> Please look into this.
> 
> Thank you,
> Anushree Mathur
> 
> 
The commands shown below appear to be running the errinjct tool on the 
host. That path uses the host RTAS interface through sys_rtas() and 
therefore does not exercise the VFIO/QEMU passthrough error-injection 
path added by this kernel and QEMU series.

The intention of these patches is to allow an EEH error-injection 
request originating from the guest for a PCI device assigned through 
vfio-pci to be propagated through QEMU/VFIO to the host EEH backend.

Could you please retry the test from inside the guest after passing the 
NVMe backplane device through with vfio-pci?

The expected path for this test is roughly:

guest errinjct
→ guest ibm,open-errinjct / ibm,errinjct / ibm,close-errinjct
→ QEMU RTAS emulation
→ VFIO_EEH_PE_INJECT_ERR
→ host EEH/RTAS error-injection backend

In contrast, invoking errinjct directly on the host goes through 
sys_rtas() and talks directly to the host firmware. The 
/proc/device-tree/.../ibm,loc-code lookup failures and the RTAS Argument 
error (-3) reported in your log are therefore from that host-side 
errinjct path and are not testing the guest VFIO passthrough support 
provided by this series.

Please try the same error injection from the guest against the 
passed-through NVMe device and share the guest errinjct output together 
with the corresponding guest, QEMU, and host logs if it still fails.

Thanks,
Narayana


