Return-Path: <linuxppc-dev+bounces-17996-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5989FD88D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:14:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvTG2TCVz3cBP;
	Wed, 11 Mar 2026 13:14:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195282;
	cv=none; b=Mu4bsNOVZssak3Ty1dyuuOvLw1HIYRDgCevtKlNnsC4dvG7fF4NdqCRiXPRiGjLSh94zBvmG+sjVbhUWYq/o6aJSCDUDqRMVIeB2fE4E7a6dDHfgPs6GgZ9LjfdKjz4J3pbCeca4biUC0Tem0kYLsmdkyQFTycXmtQi7UUn1zfOqDevK5xelVgo3yCmRAcKx6mEQxLAGid5GUjeLrDI86bB7Xyl7dGyDnzTlDpWix7PH5eFOTh/RpJ3Zf/ByHOPCKm3zT/0d81lc/dGh9BR5hmr5F8KQsjf9DoTt/gr/5fjSVEl2ImtqsmR1QvlgNFP/PpxKagz0Pgny8uANR5Llmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195282; c=relaxed/relaxed;
	bh=+DV6LliBUfdyPJjIwW+FG4fh2a9F1Ch2hP8+oBbZj9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WfbhESHyywhwjX/SNd4Bokb1SovstSHneYsvm9+e/AO6dhpkVCVZ/s7wiPhivCDNzE87DukBhlCRfqa8qT2hiGka6oDWZ3bbWyDIsP5h5o/xpu0iTpj0xAyyb/qHeexl6z9u97t92tloDKWQNj+ZpPBQh8N6/j6rPL+oiO0qMvGyUVNbPYSWh9XXS1zMPk/HWCyrYYgPUXbHcGuJUB5ilt6IRxOCrw19hUVdipJI1YzpNtJbsfQyQPRl1pc5IXKs61fMlmINAuppVKHhw4GQt7xA/P3c0J7l/lbXvzpLYak2jWDgy2a2d+OJ8zjg6pQSsFH3eV9Q7bpoyDOeJN5vuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=djxlG8l1; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=djxlG8l1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvTF3hQDz3cL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:41 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AMIKkh1599036;
	Wed, 11 Mar 2026 02:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+DV6Ll
	iBUfdyPJjIwW+FG4fh2a9F1Ch2hP8+oBbZj9I=; b=djxlG8l1mBUi89L254y3xJ
	VzXvBfSKM/Y85ABnG+9ChyjUhFz045TjiahtVUwrPmVQovvaszchTCwpyS3mgWZZ
	ulmwSGa7MoVWm16PzS/RhQcB/abyE5vjKtOov2wVore7k7LkD5pvA/siHVnpN5do
	H/KkFEaDI1jQBKJ6c8JoHIDwWsQibrgJ7eTbul8MrwyLr19XgJT6ATM5xHDPeDGJ
	0xwxtIympOx8DSXAUAzLAhzcJz2Q9je9ZId5A36sbxgAG/jPMW+vPx4O1+Z2aFVL
	KBPs20wK7ExRyKDuEbfcjSsBCGX+LZStyNqcDvP8ixj+xBNBjKvijYux2f/dxeGg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcundbp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:13:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ALfMwM015714;
	Wed, 11 Mar 2026 02:13:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1223d2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:13:57 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2Duhp60424612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:13:56 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 143602004F;
	Wed, 11 Mar 2026 02:13:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAA202004E;
	Wed, 11 Mar 2026 02:13:52 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:13:52 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] powerpc/uaccess: Fix inline assembly for clang build on PPC32
Date: Wed, 11 Mar 2026 07:43:51 +0530
Message-ID: <177319508335.269267.12539814985617156070.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8ca3a657a650e497a96bfe7acde2f637dadab344.1770103646.git.chleroy@kernel.org>
References: <8ca3a657a650e497a96bfe7acde2f637dadab344.1770103646.git.chleroy@kernel.org>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: tkmjbTxIIX-p8uZhCvZeZaxyOZhu0dNu
X-Authority-Analysis: v=2.4 cv=Hp172kTS c=1 sm=1 tr=0 ts=69b0cfe7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=pkHXuqzuWi_d4ceyA14A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX0weK41uve5bs
 yGxEE6ur2NfillcnvJoTs6p/M4N/ryOCFPzkSBHsUiLCBPJcRc9nQ1DaUxxs5+wYCwaLATx6k7p
 nfNZzMbZ2bdkR7Hvno9ZGP0Z3KRD9uPM+C62z039epBlKIFvRWAGYtURC+hkbsdaZuyyxhENBpH
 Y7bd9qRsiwp70J95E1uBdYWaZjXPiDAT/tgfq5EKtsne48rMJhx0FXNg90KcBrNjs0PlaIlAs3q
 jvGDYzJLDsxfND9puMxt2slSbREIPi/zgm7eFBchi8bRhDgEpa2jCcWMfn/ad1R6JrF8kmwTOBm
 vS5IgmV9MumXz4u3f+tBRQIg7YgUvH3ntjNHoQ9ZjChC63QN2X4vYJagMU+KIZx8lqJTwH6HqHc
 y5TYie6qojS/p39q+dKq31uavLg4oHlgJJH1IkvJEHpwDRlLS1jdTqmB72TJ0/mA+OnG8pe9qw+
 +d63y80mtG6Cr/bMd7A==
X-Proofpoint-ORIG-GUID: xMBYQeEfyAkITEHbdVqYFxpdLGGN0Ima
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Tue, 03 Feb 2026 08:30:41 +0100, Christophe Leroy (CS GROUP) wrote:
> Test robot reports the following error with clang-16.0.6:
> 
>    In file included from kernel/rseq.c:75:
>    include/linux/rseq_entry.h:141:3: error: invalid operand for instruction
>                    unsafe_get_user(offset, &ucs->post_commit_offset, efault);
>                    ^
>    include/linux/uaccess.h:608:2: note: expanded from macro 'unsafe_get_user'
>            arch_unsafe_get_user(x, ptr, local_label);      \
>            ^
>    arch/powerpc/include/asm/uaccess.h:518:2: note: expanded from macro 'arch_unsafe_get_user'
>            __get_user_size_goto(__gu_val, __gu_addr, sizeof(*(p)), e); \
>            ^
>    arch/powerpc/include/asm/uaccess.h:284:2: note: expanded from macro '__get_user_size_goto'
>            __get_user_size_allowed(x, ptr, size, __gus_retval);    \
>            ^
>    arch/powerpc/include/asm/uaccess.h:275:10: note: expanded from macro '__get_user_size_allowed'
>            case 8: __get_user_asm2(x, (u64 __user *)ptr, retval);  break;  \
>                    ^
>    arch/powerpc/include/asm/uaccess.h:258:4: note: expanded from macro '__get_user_asm2'
>                    "       li %1+1,0\n"                    \
>                     ^
>    <inline asm>:7:5: note: instantiated into assembly here
>            li 31+1,0
>               ^
>    1 error generated.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/uaccess: Fix inline assembly for clang build on PPC32
      https://git.kernel.org/powerpc/c/0ee95a1d458630272d0415d0ffa9424fcb606c90

cheers

