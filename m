Return-Path: <linuxppc-dev+bounces-29238-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD59CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:05:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3BPv6BKCz2yPR;
	Mon, 12 Oct 2026 20:05:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791795923;
	cv=none; b=iFmsYbYslUK9K5JcQmU1VeBTd+7T7dsWae/trfbcItc9AJfacjY+EigQ33UKrI0kt4qNomXn8qm+xYXycbhCQmm24OxViiYEMQHb+e16UsbNvUfV8hy+RGhkvoXqWHERyw35KXTMGsOhIkPeSWWyZUxuvF5q2BKlexMhBOL1KSI2gZv7hAWHxv4uRTtdzaqXZIExpsOk4wXLZCcRI+BklDLXx7cDfnHkEGZIsZ4CjINTBbGETqnHrpofDBKivs13BqSdOHojb9SAi160eE+OIGI+WSPnLvKaF99moriqHjlLJkwXnWWxxvfRP2RPXFo0kFYBdMs3MypOBr5gH0kU9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791795923; c=relaxed/relaxed;
	bh=CqlPhJz1sX/bStLCD096eMu+evQZLyASjyEBTk8Gsys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIwm2uul528cqzaGZY3TXBlPJjICTBQVwz7PNOZsyFtZRkYVkKlxLIj5011zAgZ1cXJ0CSm6SCxxo6NNN+Tb/zJlevtn0hb+Fsn93UGwtRj8w1m4uLzSgdS2/E/zt6Jpdfe5O/UGQLQwQuKwMfezCm6gdHKpDCD5oDJyesC9BHeMNsTVD5Tbe9g2a4LBf7CB+rWYn6dO3C+lK9sBOebuc41gNWETFFIQblvLRd+JklY4gEFxe+R1d7m18lXJpJ/0d7p7TOdBBEHHKcs0yIipmp+FhmAOsNGMFDXNwnJa3Bxw5EA4P6j913jzVKqBfG1apY3T/Swbn+DWm/1QznyF/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ex3TwE2t; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ex3TwE2t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3BPt3jYGz2xwZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:05:21 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iIuA3968332;
	Mon, 12 Oct 2026 09:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CqlPhJ
	z1sX/bStLCD096eMu+evQZLyASjyEBTk8Gsys=; b=ex3TwE2tsOY5/vfKBfv2iK
	v1N0XWlYjRG5pTLperKmQp1CMMeTlhU3fkQwWQlm9Nf38p2YvlEM3B9ErceZVZUw
	zNVBaDwuA/Z3YGX1+iKUGk49eGoFVR8gWkWcNRwXIWYY+OA6wZVpVdwJV8kl8CR5
	i9YFWO4T9Kr8/OI3G+GT5RVsfEFZ7BAqNdA868RwP44v4XnJYFPIXi8EZ3Q6VZQJ
	/4X4nmWNVxhb8tcqDjuUeBQrdEmFkyf1qZmsMLY5LTEpIbhD/JVuWPeF2g78SajY
	rHEv3a/Jz2jUlsfYH4hA/Zoicg1OmSY5yfSj4mlyennBCVDMFc2IaOB6/DkjpXQw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1vyqnj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 09:05:11 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8YvCQ978624;
	Mon, 12 Oct 2026 09:05:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vmjus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 09:05:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C956tX47120740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 09:05:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA9122004E;
	Mon, 12 Oct 2026 09:05:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBDEE2004B;
	Mon, 12 Oct 2026 09:05:04 +0000 (GMT)
Received: from [9.124.215.77] (unknown [9.124.215.77])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 09:05:04 +0000 (GMT)
Message-ID: <35446573-c8ba-414a-8a0d-d682a84d589e@linux.ibm.com>
Date: Mon, 12 Oct 2026 14:35:03 +0530
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
Subject: Re: [PATCH v2] powerpc/configs: Add debug configs for debugging
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        ritesh.list@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260827121309.94434-1-gautam@linux.ibm.com>
 <asyep4EEG-lNR72Z@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <asyep4EEG-lNR72Z@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfX4XxDACEFGuRc
 F0GbsSD+QHI989Q7HMT8RB9P3U+q+W8Uz+U3h+Xjw4snAYzq9eeFUkJK1NdKVOmeG5/cwQkIevl
 OKt2AOQZDVV81+PyMhDuLQphKPIfcWk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzNCBTYWx0ZWRfXyO/tDWO8vaDT
 ufHC1t7HnC9VVLmN81AuzwuQ86Grxo2TXW60BYkjwtgV/TPcnaJukbIJaAU5MpAz0LU6k7cIBWt
 cOEEOaVRSABC3gyUfalFNyJg50RMoL8XWDR9+JGczHXJqhbaMvucBPUupJqvWunk+DWl3fcC1Eb
 fwJFcJiRIYbetSeUXytNAEzpzmzUBTHNwThjOO3VCbXAJqNKCYxjBp55YiRgNVPnCrkUrKZ3088
 FcAGMoIJsCzWoQDTut1vFwgXsjG/HwYySBX4fFSs/6rTKsyMfd4Qb6WLbxzsMT/QMOzjc/LcS3H
 c5+ePdgqwNtMXKpvGKmK43r3AQSAmfo3kU2AApSYN3QJiCzi6ihPFPdjWfsnCBMp9Ljd2eujLbW
 YiYpZUP6o9slWSfvW/H96NhQnQcPefB+1g1g7qyjQV1TKR19jb+9QtNdIUOofSa5trcEH5V25pG
 T3usmJneJ2Wuu7Bq5CA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acca2c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=CyTxvfVHbQM6u8GbU7kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: BpnJB0wFhT3PBczyPt27ATm7HAjAc2ks
X-Proofpoint-GUID: PKemi8W4puwuOrKSOOftae7E9U3yQVtV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120034

Hi Gautam.

On 10/12/26 2:20 PM, Gautam Menghani wrote:
> Hi,
> 
> Can this patch be pulled in? Or is something else needed here?
> 
> Thanks,
> Gautam

Why it can't be part of existing debug.config? Why add component specific
config and merge into def config?

Wouldn't that cause more confusion? If not, could you please add detail in
changelog on how one can make use of these?

