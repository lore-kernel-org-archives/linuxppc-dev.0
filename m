Return-Path: <linuxppc-dev+bounces-22316-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C77CCD6E79
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2026 08:52:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZN2W3tN9z2y8p;
	Tue, 09 Jun 2026 18:52:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780995139;
	cv=none; b=g6WpYQaZnsnYS0F4xU8N43EHyZR0ATF+0exPDQ+5KKBrPs7qno7nBIBsu6zVMLh3Tl1Mg7GyUp6f2G2/5zokTqNzkHcycerzk6X1wV1GzDOwpVG3nwdZSHtPun71HT8Fnmzfbc5FsHHUsaWo9YqiN2Aao/H8u6yy/R1ou4tYQnBdgRaKdIMYEva49p1MRMMquJUBWWhMlstUL6veVVh2PqcWG4Re/BwIKuhA40q/sD2V+aHXX7BbWIOkQoUmrJ7/38awmry9PfzkxFXYZE+ewbL1lwx5dp8YERPK+RFHfT3gUQlBYGUgeeJinwCvVDjdqtA5yvbFmGrWLtKA0HBt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780995139; c=relaxed/relaxed;
	bh=hzQkxtLiQbdGFSPIIPPk/CiCMxvTXLlsB5s/Ud+eU1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HU2EaP5rFazQuyLy+aPeEHDDLLyY+oSiSILyyKQs4PLXEj2V29yuywuBBXvbruuAiyOxqCIxtKyda35gIdHyb2pGEJBR1sxKTMZ4UKNg7VygKtFaGI/ds3uEXuHnIEdwLKzAAimjqbcpckckKWo5dwqO/U8NDMC0wscqOSMdbA141xuCagoN9o0HSue1FEO7lULjNF9witnOh+5Lek/HIqhiKBeIfd9lXWGRhg2Tp+FJ8YlqrQMyellCqAYmXoAA8yXHiUCroXV/bpp36xKzGuSHqp1BNZ2BqBcHhLIrENfS+FcmLICGpBt4xDk02ypUu+B7FVT4XTZpITyYtvCRhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O+6FtgrJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=O+6FtgrJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=adityag@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZN2V4WXfz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 18:52:18 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658N9jpR2451177;
	Tue, 9 Jun 2026 08:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hzQkxt
	LiQbdGFSPIIPPk/CiCMxvTXLlsB5s/Ud+eU1c=; b=O+6FtgrJ5O/BQorDeShVu2
	1aclM9gJgpmB7UWGT7xk+pt+le+PdN99ZtH5BeXQrJdRGX/RxlBBLehHIY7dp3xW
	bcqubr7QPF3nWjNSK0epyGhoLvrXplGfF4etGk5QlHsrA/XuUIaKYLjLZlMB3Bt5
	k7tBQUapNPuPTgnWFkGsb0zWvTZP/j0l0Z+E8NcUDheSx/3nyto7vGdI32KOKnZH
	NyIcTp4rXjb2YUf53Yu6E6+JNdczLiykz3XfIKcujWe6uqAkqsgOA9xCBak07C0I
	tSSio5kCVEakVudKmMV2a3QNec7rGKCvAF1NlSaV2wOebpM2BdISm3Z6T1C3LjXg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qk8tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 08:52:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6598nd0H006203;
	Tue, 9 Jun 2026 08:52:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy8xu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 08:52:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6598q4fp35717512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 08:52:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84C0C20049;
	Tue,  9 Jun 2026 08:52:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 406EE20040;
	Tue,  9 Jun 2026 08:52:01 +0000 (GMT)
Received: from [9.123.10.203] (unknown [9.123.10.203])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 08:52:00 +0000 (GMT)
Message-ID: <f6766e0b-2c69-42cd-b628-76eb3a770852@linux.ibm.com>
Date: Tue, 9 Jun 2026 14:21:59 +0530
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
Subject: Re: [PATCH v2 1/3] ppc/pnv: Add null checks for OpenCapi PHBs
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Anastasio <sanastasio@raptorengineering.com>,
        sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        stable@vger.kernel.org
References: <20260608153948.GA36499@bhelgaas>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <20260608153948.GA36499@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a27d43a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=jDEF8yXcYhEeGhTqFzAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uy5uA-4LAkQXosgRLeYKG9__XiD3wO41
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3OSBTYWx0ZWRfX1LnRsX/NslW6
 10Kx6AfRwuDC7yqNSV+PtaezZSUOJDVDq6q3XnXnzbRlJRjpCtT1oklrDK7q+VkLgMaKH/HX1Tk
 sMxdgQi3xva78lBGS65KWRSTw2S6Fd5lInhoYTGOOzyPAsxwXD45x4qiM6Z+CaUAoup/Yl5kgFO
 PPEyoQaMcSgn+LDoqb6OxTi6dBbzzaMy4mx4LUFNNeY9XkI3issRge1Wd4NF9gUdP5HWdtS8oW/
 5/2/qPQq67is8P7wW0AgUKPOncjeXYW64q+Be8cFrMgYeStTk6VYNod/tAyQUqRq6qW6O7J08KB
 fpbt0rn3Y+vu4duyRQc2nD6ppmvz92i7kPjiipGMS+EzX041vQw00sgXaUB0b7ywyIgTFyPpkju
 TqGxWethQMS3UEjpwL6yo9YYTh+pTT27uZunERfXhZ2Xg91zVHY8fajLwTfP6TAIRXwPFZNsHwU
 3TeaMPSXZI3DsLHaPqg==
X-Proofpoint-ORIG-GUID: l1yAjDp3acC5UYb8nk8EW-AoTRozIh-V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090079

On 08/06/26 21:09, Bjorn Helgaas wrote:

> On Wed, May 27, 2026 at 11:38:14PM +0530, Aditya Gupta wrote:
>> For opencapi phb direct slots, the .pdev for php_slots will be NULL
>>
>> Various sections of the code in pnv_php can do a null dereference and
>> crash the kernel.
>>
>> Originally, the issue was hit during boot:
>>
>>      [    1.568588] PowerPC PowerNV PCI Hotplug Driver version: 0.1
>>      [    1.569722] BUG: Kernel NULL pointer dereference at 0x00000074
>>      [    1.569811] Faulting instruction address: 0xc000000000b75fd0
>>      [    1.569890] Oops: Kernel access of bad area, sig: 11 [#1]
>>      [    1.569963] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
>>      ...
>>      [    1.571492] NIP [c000000000b75fd0] pnv_php_get_adapter_state+0x60/0x154
>>      [    1.571604] LR [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154
>>      [    1.571690] Call Trace:
>>      [    1.571725] [c000c0000688f990] [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154 (unreliable)
>>      [    1.571783] [c000c0000688fa20] [c000000000b78bd0] pnv_php_enable+0x94/0x378
>>      [    1.571951] [c000c0000688fac0] [c000000000b7912c] pnv_php_register_one.isra.0+0x11c/0x1e0
> Drop timestamps since they don't add useful information.
>
> Indent quoted material by two spaces to reduce wrapping.
>
> Run "git log --oneline drivers/pci/hotplug/pnv_php.c" and "git log
> --oneline drivers/pci/hotplug/" and match subject line style.
>
>> This occurs for hotplug slots on root buses where bus->self == NULL,
>> such as OpenCAPI PHB direct slots. An added debug print (not part of
>> this patch) confirmed it was opencapi:
> Style "OpenCAPI" and "PHB" consistently in commit log and subject.

Thanks for the review Bjorn, fixed the description and have sent the 
patch again as v3.

In v3, I have sent the patch #1 independently for rc, and will send the 
rework patches (patches #2 and #3) separately, since I have to do extra 
fixes for pre-existing issues pointed by sashiko.

Thanks,
- Aditya G



