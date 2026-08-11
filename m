Return-Path: <linuxppc-dev+bounces-25717-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C46C5B56A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2026 04:23:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJz540lRCz30Bt;
	Tue, 11 Aug 2026 14:23:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786422200;
	cv=none; b=DKzCH/CGpK1G1qymFMsPdnJvtOabBAs2ouNGecm4IO6/tTL5hVEIz1/2l4M7R4wEmCk884uPMSoLeXJB14/5yDLnQOsSGO6JxJk3gHYC0TsBxCC8o71vHE0kyGv1zDlKUoiVj2bYrnqqcd2m4rqQ3T7uVjcpFhWvdyJh5qkTMiAXUrlPLLlPV48FLEAjDK6RcJg0c412PIND8dBc9gZ+3CtdydjHPx6ynQJodhXXmX5q8z15/mChL3DIDx+qXzVVeQefOVh0jyJPOsAxAbmoY/8/kwEiFKka+/amzsd+0Gbqy6Cf5UaZ2NDHlc9opf0bOVggwvEKwZ4KDYNzerNIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786422200; c=relaxed/relaxed;
	bh=VOaIwkaxwacg2X/k6KlkBM/881r7wvgZqaaDMVUJj+g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cUZGyg1xewJKPg+zKsr/0PlITf3kUN0BtZ2x3NFCMtPFEcO3CAeEesAH+LNWQIcItCPk7+MdVL806hK/7BQ0XDZXURDPc3NcL8DbeDpQaeY4+09nO/uriAGq6ILL8nUdnSAlcLRLia4f2/hhXVF5K08jNM7/FfuMkvLOgowCqe3reAprTPuahAimJ9Er0+m/arfZaUl/b/7625sZINEbllFqNQnyuOULbZKJj233eq2heEcjLNp/D7CqnDKiegebrX3iJVVxBuCqwy9/bSWsSL7j26VSGGB5wfe8ZgyY8p896Lrf1rae6Q87ZXc7cz7LEXHW3wexWs3eEMYQ9pjWnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fCDPROh5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fCDPROh5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJz53200Kz30BC
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2026 14:23:19 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67B0MIcQ3036438;
	Tue, 11 Aug 2026 04:23:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VOaIwk
	axwacg2X/k6KlkBM/881r7wvgZqaaDMVUJj+g=; b=fCDPROh5B9BiwwzwUxlZ0p
	/XTRKPOkFQXGiCMYvYd8W6Q3IAsHEpNI42EVnU7TSGzL34MtxKgyBabcic8bWgVw
	RExJ4VkSYtlCqQKH44GWcFOPmSSsl6C2cBxvKnd8jCDCduk7ayANww0SeL4xnvlp
	x8ebbPxyy+0IE31/gCcDotPu+r/nwsB7gUXrDOGjPgsWl7+0FZKQ5/3faMI7Cz+9
	TXWpEKv6yOfNy4gN6GlmO530JNW0rrJjkh3TOlRts9Fq81ezn5ZdqVOEPEgDDHnu
	8L06fpA6Up/xxwzXzbDosm7u4zme7l3jZ4U307USG3BfY26e1SmosMzB756hVSTQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2tpdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 04:23:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67B4BIPv018940;
	Tue, 11 Aug 2026 04:23:09 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjqhhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 04:23:09 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67B4N7sT6161202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 04:23:07 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C28258052;
	Tue, 11 Aug 2026 04:23:07 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6B6E5805E;
	Tue, 11 Aug 2026 04:23:04 +0000 (GMT)
Received: from [9.123.12.38] (unknown [9.123.12.38])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 04:23:04 +0000 (GMT)
Message-ID: <627c5c2f-a0b3-4fba-811f-7b4ed4c74dbb@linux.ibm.com>
Date: Tue, 11 Aug 2026 09:53:03 +0530
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
Subject: Re: [BUG] powerpc: userspace processes crash in ld64.so.2 when
 running recent linux-next kernels
Content-Language: en-GB
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, ajd@linux.ibm.com
Cc: LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.com>
In-Reply-To: <75419f88-eab9-444b-bf97-28a9765819ad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7aa3ae cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ooee5C11TIdXIoiR4BMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: uvObd9Lph9ADs967J5aV-AEQPGlBVQsC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDAzMSBTYWx0ZWRfX83+QPcr4DCYE
 xhbWKYnXXJMFoM06mzEMr0C898pl/ceQ3DJHleVEjAhEEvFd90FSHys7A26NJ352l+ijg7CNbXH
 3DgOxdMdRFT8RsxXj8GDBMqRFIh9a9J6KTI22JenN1NXWTOmuAxN5l5VKWpj+/mdOu9zXZ7FQVc
 j2qd6a94TJlu6qQ8TUobzNIL0aakXdyzci1fsqe8b6xq3jAvacSX0a1PKFbUuDwFq0nzS3gUgCl
 qDZGoNqWAmRsbCg+YEE+F7iz5Mme50gTzEdMglNsoWxKBmF/rm8rgNipE/8QHD9QPKw/3BTBRlo
 DeT84C5qwzRi7z0/I6dXHiKONxS40e21/eDh/VjA/+n3h6B1bhsKTiY3erYrFA61tPBQPSRwZqv
 EvrhmNngw4LizQIAAIlrHtfwnYODbiwQfwDR95bk+/mhvUIlB7sgFWavkkTcUKbqoVutRNobmU8
 jTC+d/qDf4A6CIwABnQ==
X-Proofpoint-ORIG-GUID: uvObd9Lph9ADs967J5aV-AEQPGlBVQsC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDAzMSBTYWx0ZWRfX5daGqX6rmPcc
 qBbRqET6shuhCv9WJzs0iMIq/99HPqyhFQPwuRtST2c0ymPHi0aXxJj543wqgZigwkDy0fEB8GG
 SToF+Rap9D2+l6W6rhi6uy6sPjB7EyQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_06,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110031


On 03/08/26 6:40 pm, Venkat Rao Bagalkote wrote:
> Hi,
>
> We are seeing random userspace crashes while building the kernel on
> ppc64le when running recent upstream/mainline or linux-next kernels.
>
> The failures occur in different userspace programs, but the crash
> signature is consistently inside ld64.so.2.
>
> Environment
> -----------
>
> Architecture:
>   ppc64le
>
> Platform:
>   IBM Power systems (LPAR)
>
> Userspace:
>   RHEL userspace
>
> Workload:
>   Kernel build
>
>     make -j32 -s && make modules_install && make install
>
>
> gcc version 14.3.1 20251022 (Red Hat 14.3.1-4) (GCC)
>
> GNU ld version 2.41-63.el10
> ldd (GNU libc) 2.39
>
>
>
>
> Observation
> -----------
>
> The issue is observed when the system is booted with recent upstream
> kernels.
>
> The same LPAR, userspace, toolchain, and source tree are able to build
> successfully when booted with the base OS kernel.
>
> Typical failures include:
>
>   sh
>   fixdep
>   make
>
> The source file being compiled when the failure occurs varies from run
> to run.
>
> Examples
> --------
>
> Example 1:
>
> [ 1277.872746] fixdepsegfault (11) at 29ac0
> [ 1277.872746] fixdep[122982]: nip 3fffbebd8214 lr 3fffbebd7358
> [ 1277.872746] fixdep[122982]: code 1 in ld64.sofffbeba1000+50000]
>
> [ 1277.872793] fixdepcode:
> f90104a8 7ce903a6 f9410060 f9490008
> f9490010 f9490018 39290020 f9490000
>
> [ 1277.872805] fixdep[122982[37214,3fffbeba1000+50000 f9490018 
> <ea628000> 7e731050 f9410030 fa610020
>
> cripts/Makefile.build:289:
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/smumgr/vegam_smumgr.o]
> Error 139
>
> Example 2:
>
> [Sun Aug 2 12:36:38 2026] sh[115552]: segfaultbcd0
> nip 3fffbd73d004 lr 3fffbd73c148 code 1 in
> ld64.so.2[35004,3fffbd708000+4d000]
>
> Example 3:
>
> [Sun Aug 2 12:40:08 2026] fixdep[134469]: segfault (11) at 
> 2bcd0c3ca004 lr 3fff8c3c9148 code 1 in
> ld64.so.2[35004,3fff8c395000+4d000]
>
> Example 4:
>
> [Mon Aug 3 05:44:20 2026] make[600291]: segfault (11) ip 3fffaf3b5004 
> lr 3fffaf3b4148 code 1 in
> ld64.so.2[35004,3fffaf380000+4d000]
>
> Notes
> -----
>
> - The crashing executable varies (sh, fixdep, make, etc.).
> - The object file being compiled also varies.
> - The crash always appears to occur in ld64.so.2.
> - The issue has been observed on more than one system.
> - A fresh OS installation with ample free memory reproduces the issue.
>
> Let me know, if any more info is needed.
>
> If you happen to fix this issue, please add below tag.
>
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
>
>
>

As part of debugging and suggested by Maddy, I reverted the following 
commit:

   263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for 
ptrace")

and rebuilt/booted linux-next with only that change reverted.

After booting the reverted kernel, I rebuilt the latest upstream kernel
using the same userspace and toolchain. The build completed
successfully and I did not observe any of the ld64.so.2 userspace
segfaults that were previously seen during kernel compilation.

Kernel used for testing:

   7.2.0-rc5-next-20260731-00001-g79d9c1ce90a9

Top of tree:

   commit 79d9c1ce90a9873422ca4d6d0124a1d1c10a098c
   Revert "powerpc: Fix exit_flags field placement in pt_regs for ptrace"

The upstream kernel build completed successfully:

   INSTALL /lib/modules/7.2.0-rc7/kernel/net/openvswitch/vport-gre.ko
   DEPMOD  /lib/modules/7.2.0-rc7
   INSTALL /boot

Based on this testing, reverting commit 263e5159e00a appears to
eliminate the random userspace crashes observed during kernel builds,
suggesting that the issue may be related to that change.

>
>
> Thanks,
> Venkat.

