Return-Path: <linuxppc-dev+bounces-26153-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD15C61DB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 17:22:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hW7cD3953z2y2L;
	Fri, 28 Aug 2026 03:22:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787851324;
	cv=none; b=I7iXRs6K0yR2rqU6/1syHzR1lePy85aq/lEK9UJ8AMLcmAxHzTjnnZsMmcQYT7j78aoCw4rWfcZ8z6vB5CbMyYknC6YyMHrJnEk+JTb3c5oknoEN9egGVbvflc0NOB1UsqMjA0RmF8VBd8fFTDxuFQOv43BN2SR7HFMc8hRCtXSNWVuOys+RoTbel9ZQO3kUPUB7JYjkeW91jgTQH2+bsmPfcvHKalOF1aTIOvLjJCiTbenFIsWbc/N0Tuzko9kbER1QVM+VnvP6H6ob7SGFiwq96PtmF/fD2PrwnZE0C14nBOdZX4hLOmMkSMvIfrCvkjzP/bkl2WwQhhmh1M865Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787851324; c=relaxed/relaxed;
	bh=sSPtitX0y7O3RQSiQoWw0AvbMFqAH3MSD+rPerN0RJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fq/aLL9g2XMNkm7dMePzCqMv9BLKFM2apY+4z+D+qriUgxbdbmz9PDXSQoZEwYdgzauX3P5LAsW20nvRGU4qgHCFZxav+e7M9/6Sd2LUbI+KloU0npqRA9qpq7+kEhqBvqNayF8HB+OPPZ0/JNYC62A/wcYXyZB9yu1Qxnqim2suUR0Z7dFo9G3g4Pw4P+4U76zUzQe72woHPRnWyabbfbTRN2egzqtZ594W2fFjIY6Wg6iuK1Jb8NiRNcd3cmhymtkjyn/iXm5/hIqexlF0jF1CdYGVSKudbjP0vERtPlTIsbRi0eDTvaUd3I3oSGUptS2zMzWnDNyzrKEla+vkXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M/iqms/3; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M/iqms/3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hW7cC35yCz2xtt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2026 03:22:03 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RG1ejm3375721;
	Thu, 27 Aug 2026 17:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sSPtit
	X0y7O3RQSiQoWw0AvbMFqAH3MSD+rPerN0RJI=; b=M/iqms/3Nld+4T0sgqfauT
	dh/tGOCnEn52t3E0jJnad9kqbKdrG+GQXpC5fyeCyuvPpv69h02nHKYbhB3YB7wa
	OQGYPLQeEV+m9HKCKw3ac76kFa7utTP1PTrKri6QTFvjf+TCOr4xzeHHPZPR2i7S
	uWcuYlDkI6n0vZjr1WKfb5itt0ecpjo6JD4dLROwsEKK5G6lDYygGlKwcmMTvzL8
	wRaXFCyvakZLr/uPCO1FJ88B45dKZ01ytEf7S1ZV58KgPdhrO0t5LnYOs6jnhnG/
	3+SYQaXeawy1asdTh35qYz3wE9DWf2nlXulSZ5//V9mePTuXVWmNZV8yOdcYbr/w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j6vuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 17:21:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RHBRN2004261;
	Thu, 27 Aug 2026 17:21:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfwhdct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 17:21:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RHLuR345679060
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 17:21:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 825002004B;
	Thu, 27 Aug 2026 17:21:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CE0A20043;
	Thu, 27 Aug 2026 17:21:54 +0000 (GMT)
Received: from [9.39.21.111] (unknown [9.39.21.111])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 17:21:54 +0000 (GMT)
Message-ID: <2086848f-f28f-42fc-80d4-e75af00fc9fc@linux.ibm.com>
Date: Thu, 27 Aug 2026 22:51:53 +0530
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
Subject: Re: [BUG] Interrupt timing warnings in pSeries guest on PowerNV host
To: Timothy Pearson <tpearson@raptorengineering.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
References: <1435664226.21087.1787157496274.JavaMail.zimbra@raptorengineeringinc.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <1435664226.21087.1787157496274.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0NCBTYWx0ZWRfX7B1CSiLSb1r7
 DBQEZ05AjZYIG0mZFScdafn1gWrDipNZD5D3vwLJjO8vIFEZ8Z0feVBBGlnhfm/G7vlB1irAX9A
 Qtj+bdQuwExTfnfqD89VeOjuyMp5JqA=
X-Proofpoint-GUID: TdOzwGsqK7jA3wryfGAWWT_fbT_ifnkg
X-Proofpoint-ORIG-GUID: Od6Hi3a8um_d3jYsvJrOfvoPWwK1gamT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0NCBTYWx0ZWRfX5/vzhuBpn0Wm
 1Yml89cby1X+pt/Qg4O0VUseo/6SxUG8Y3xzP3C8Oav1qb1nEUaUdlqSyYd0++4xsMrA/V5P/2e
 50RtuvvtmFN9evisNrjDeLqsFS4vMlrEHR+if1SUp5ahpinVXUURhHKDoc0Tl19ojdO7CPKMvqP
 BgVzMMC00xYxHJUB4kPSyXwt/wJ7dZxAmpS75b+8V52u8ahlikrbg1dbf78QCkovW/TCxFVaoTi
 0vCCH5UNOBU0dPkMRUnogSMKScX0pIRXkcHLNZsPhAIcNv8CXhq7PUwoBFbSmPxCJuimlxw9HAV
 jyf/LigccnO5KKEX18QDVIQCACemNxEgwhL2k9m0Ve5IxLZz4Reqv3/Z0yE47Y/pJiebgDJ0JDF
 +dY63kK20bRGXXvhIzD8SfV70uQhmtZ3TPKG1DGTGD52jFxD0oIb340AQrCLi0WFv7nJfGxZy9z
 k+/qmT5H+EjHFdQWAEQ==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a907237 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=XmxjCujfbg9H6cv3ABQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270144

Hi Timothy,

On 8/21/26 10:08 PM, Timothy Pearson wrote:
> On a POWER9/PowerNV host, when running a pSeries guest using QEMU, sporadic interrupt timing warnings are observed.  This is on kernel 6.12 (Debian Stable) on both host and guest, system load is moderate, the host CPUs are not pegged at 100% at any time.  The guest has only one virtual CPU core assigned.
> 
> [11622.031047] hrtimer: interrupt took 12354614 ns
> [46723.139964] hrtimer: interrupt took 8522695 ns
> 

         /*
          * The next timer was already expired due to:
          * - tracing
          * - long lasting callbacks
          * - being scheduled away when running in a VM

This message used to come if the timer expiry was in past and it was tried 3 times and still
can't catch up.  Very likely it was due to guest being scheduled away.

This behavior has changed now and this particular trace has been removed.
https://lore.kernel.org/all/20260224163430.870639266@kernel.org/

> This *may* be related to the dropped / late interrupts I have reported in earlier messages, but it could also be a separate issue.  QEMU version is 7.2.22.


