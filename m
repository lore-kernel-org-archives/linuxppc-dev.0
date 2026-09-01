Return-Path: <linuxppc-dev+bounces-26415-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0648FC61DD3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Sep 2026 18:09:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZDQG2BScz2xmh;
	Wed, 02 Sep 2026 04:09:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788286150;
	cv=none; b=DTMyFm5qXuWW0R+Qv+y4N0TZ7jEcfB7i1ragxhuQDH8meBDImm6hp708/BqWX5pYJx0S0JglqxLPRcOl1KBFS/B7uZPjOF35M53Z5u2uXajD33N5dfJRGKlnGBbtRxDlU+5HjE9ywhSAKnh5/xkRQUIvulrw6TBwNcFO5my06OFmB8lzm8uwXbNYraJl+mcXqCistkGoiqeCbV25ejxGoe7LuLbEuPXKcRdaA3o6AY7mpVzOx3zt5qBwCL2Ub9N5OtJEF5RoCGuLTnE+TbZxdQq4HmZ8ZLSiu7D3RJFgtVavXDe6f+QV8v1e53pK7pJTsuxp3+LWcU0suwF+xcinhw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788286150; c=relaxed/relaxed;
	bh=Kro9rIuwjhdZe5bK5iR4jUTVyRmXlpYdmOpIb5p5QSA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZSV4556M+VxCMygtMd5pvOt93qW7cY/L8urbNhtlZgrvXPthVoWwE7VRWWjY9u6ahfg3GSszApH10jDk52FOoW/e0LCHrUuIikZ0YR3jV3I8lQcskYdD+ygz6KaNjQOHuk3l8dlfD4Se+udjCG5zzaUgrmoJGgR4RH1o1NP2n7xcsfgC4Z6dTWsvHq6tq177d23HVq9TSoFjuWEG7rINrzc8ygao+DrHDPZLoYuDOCPjoPkvcwuJf3cSpj59bthmyIu+yXt6zebhNFxUPe2Q6p3BT7sz94o2kxItIgs1hbQf0SzAxz3YMDPnbKfZvFssiXYBZa0HKI12jTCPIZqrSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s7Ri/wwb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s7Ri/wwb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=nnmlinux@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZDQF1x8Cz2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Sep 2026 04:09:08 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681I1VCO1903524;
	Tue, 1 Sep 2026 18:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kro9rI
	uwjhdZe5bK5iR4jUTVyRmXlpYdmOpIb5p5QSA=; b=s7Ri/wwb4Yt8/+tHXQpnMc
	0DNZ4qNVUfGFUTj2Tmjkgjsu9+q55Skd6AD4CwdvPNl4JN1+2/F2/z/VRFScBzJ1
	g8YnWqsJmVGRrv4JNUOevQpmISY8N3lODfmp60f0ui0VjcTvUm7pUsZ9Bdtb+K0G
	okQdlOe5nD5W6g+I+2ZTiakOwKlYlHUfBcpzsKEaSh5mrzg4AQcvWC2JfnQTVCx6
	WecJi1EoZjlC6J8GyDYA5MQ19GjPHu7yklrA2xz/mf20MWLG21VJgs8LoPSX0N3H
	WlrQprQFnr0sFdt9cfgJRpwbpyHDcaKWTOdo9WYjkj5hnOAwTl/Q/QWbS9ac9iMg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq54smnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 18:08:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681HuJR3011804;
	Tue, 1 Sep 2026 18:08:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqdc5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 18:08:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681I8pRg51905006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 18:08:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F00ED2004E;
	Tue,  1 Sep 2026 18:08:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2674C20040;
	Tue,  1 Sep 2026 18:08:48 +0000 (GMT)
Received: from [9.124.219.126] (unknown [9.124.219.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 18:08:47 +0000 (GMT)
Message-ID: <787e72ab-3f22-4346-b377-1044f36c5e83@linux.ibm.com>
Date: Tue, 1 Sep 2026 23:38:47 +0530
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
Subject: Re: [PATCH v4 0/5] powerpc/eeh: Add RTAS-based error injection
 support on pSeries
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: mahesh@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, oohall@gmail.com, npiggin@gmail.com,
        tpearson@raptorengineering.com, alex@shazbot.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        sbhat@linux.ibm.com, sourabhjain@linux.ibm.com, harshpb@linux.ibm.com
References: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260831065441.48654-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE1OSBTYWx0ZWRfXzMaMoLSA8UIe
 KJYPIaLFtFLnlMsRPjXXwFRuDezxQ9xrDYDmHWuXrjh/g1yIClIYGyGhmi3p+EeQ1a/l72fFJzU
 IzxPTsLURJg19mGOmY7YFOqx7tEc3rbObI4reNpU1OAkQmm8pLEy/doO/5BWO3mDcXhl/w3vTqR
 PW9NUSOnnLxz6GzPS/rqsewpE6iXXP/ZV0MGfbeA5W+uWi2RIvMJ1bcVl+OpNbdOzEYuyGeK009
 OuXwwiq5vjgvwt+6fF+q5MrAkWVsuFNs7Py74x/10yL7JdcAIKxN8BgFKEoC5seI/+7jtdVIfZC
 dvYHNd3hnQIG5t8Kbr/XrcNJO/JdLMjGYJZR1T7ovRX8iarnDTBp41A69Ztqkhfujg8Edbf2U5m
 0MUDFr5+PzRdDrG808us9dW8daNp/+LqUw3V/Dou5OxVVJ1BYWHvnZyom2YTiz56kLICeLqJ0CB
 6QSVePg9fsSLP/mMvTQ==
X-Proofpoint-ORIG-GUID: _Ed1skDP5KMCLWRVkU1JrdHi0ltYijO_
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9714b8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lUAv5hgTO_wmn5_zhkEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 9SemqtL7EuPF-r-snJsLQTvZJyuHeeZy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE1OSBTYWx0ZWRfXzY7SqQk2RCWO
 2bkjTJbnBER2zzQQIFO4CM5kRp2gzqv76+RAkQkebWVyAp0hD4JuBZLEdS+UmU4vfhq46+OQSeN
 LBTn/qZ3TYzRfDydwJ+/jFH/nZFs5d0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010159

Hi,

I noticed that I missed adding the changelog in the v4 cover letter. 
Adding it here for reference v4 changes from v3:


On 31/08/26 12:24 PM, Narayana Murty N wrote:
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

The corresponding QEMU v5 series is posted here:
https://lore.kernel.org/qemu-devel/20260901174110.45356-1-nnmlinux@linux.ibm.com/ 


Change Log:

V3 -> V4:
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
  * Fixed ibm,open-errinjct return handling to correctly process 
firmware responses.
  * Allocate the error-injection buffer in RTAS-accessible memory 
instead of general kernel memory.
  * Pass the physical address of the error-injection buffer to firmware 
(previously incorrect address type).
  * Accept session token zero as a valid token (previously rejected 
erroneously).
  * Handle RTAS busy and extended-delay return codes for open-inject, 
and close calls.
  * Simplified the validation helper — reduced complexity and removed 
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
    - Removed unnecessary empty line in rtas_call()
    - Enhanced comment to explain PAPR specification requirements
    - Corrected misleading comment about output handling
    - Improved else block comment for better code clarity
  * Fixed kernel test robot warnings
    - Fixed kernel-doc warning for __maybe_unused parameter
    - Confirmed sparse warnings are false positives (correct endianness 
handling)
  * Added PowerNV platform abstraction layer (new Patch 5)
    - Maps EEH error types to OPAL-specific types
    - Simplifies type handling by direct variable update
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

Thanks,
Narayana
> 
> Narayana Murty N (5):
>    powerpc/rtas: Handle ibm,open-errinjct return format
>    vfio/spapr_tce: Normalize EEH IOA error injection addresses
>    powerpc/pseries/eeh: Add RTAS error validation helpers
>    powerpc/pseries/eeh: Implement RTAS-based EEH error injection
>    powerpc/powernv/eeh: Map VFIO EEH error injection to OPAL
> 
>   arch/powerpc/kernel/rtas.c                   |  78 ++++-
>   arch/powerpc/platforms/powernv/eeh-powernv.c |  27 +-
>   arch/powerpc/platforms/pseries/eeh_pseries.c | 328 +++++++++++++++++--
>   drivers/vfio/vfio_iommu_spapr_tce.c          |  90 +++++
>   4 files changed, 484 insertions(+), 39 deletions(-)
> 


