Return-Path: <linuxppc-dev+bounces-24985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB4BC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 10:01:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h97CT5cDXz2yjg;
	Wed, 29 Jul 2026 20:01:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785319301;
	cv=none; b=DManURgH4n6FKD9I2167nY6kmW2GVtVrGu260GMKvuiApwcasp6w+EDNDH0/lsonVKpY/MjzkkEKiaqw+UxGgan2eE5KXYeBG+dfb9U7pHB6EsPvmGRGhF4MySylVS97FZ5HPr/yt3hmeJDr4EC3OUCR5z7PqaSLZmTlreWZe4eUmSMmUpGWpa79difT/OQzOvVCyPNkFOKNT6ZW3IMmkBuSzzBJAtajqgdtu3tOFr+Qy5SNL+7kbQP3a5qdxrWZeqMrNr8kT0NVFUx66VcAN51xK1greg1fsKjUkVMlHSP21F/gtQaAzgvVq4QUMQQHvUmE+vbJMkyN/P1LGcaQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785319301; c=relaxed/relaxed;
	bh=LTmFaXhpt40lYGqGqgZ8ok2Rp0EH8EmRKwMyT7Ija0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUY0QwL4kJ8sDBwxd6Ag8oOKMT2N5HvAJMDr5LTF4aRLFc93qlaID9CKabOBShRK5dAaVebNwqixhuCZXfYypHp1x47I4EhYEn0f7A5i1EmZKgMo7j06UrqG1Q+P7jvEpVYLHfOlFJX5mAuJp47VSAAdzOvZpljDDhd/JMuPYrSLFIQ1M2+/Cu6um7M5mucAFINcdrShHiO/xHWCP/StsBMAkzHVnnEz0hYsaQFs8Tme88tDWufovkmQWD0LhQ/+Vpy1MwNdt7pS1RI8xGRIc7VmLH+oYhvAZshiAVAkkzsL8JPHxZxApziZkH2yTw089tYTERV0F4rFC9HHnyx+2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LOUn3BeY; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LOUn3BeY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=sourabhjain@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h97CS5Jtdz2ygW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 20:01:40 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T7lj8K3507842;
	Wed, 29 Jul 2026 10:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LTmFaX
	hpt40lYGqGqgZ8ok2Rp0EH8EmRKwMyT7Ija0c=; b=LOUn3BeYn1pu9pZMMoxiDk
	ZOXWcDP0Q961Q2BdhQC9eRlsV1gjtJ5Bxq9CHBH/qJ+LD39z6WMt5kmbCduYfUXH
	W/owTfx8r9NXwJSVrqfEGRkJmNfPzJpoOuTVa1WOO1sBXs5ugUf7aPcf7eNFrHdp
	AxakFX6hqZn2+ofhpYBStkuARpImWjQnerBONbR/Te37K71RgfqY8BF6L6ZvzSpI
	R7xSDrdqMvZAnD0UGWU7oRl1pW6/NtHnkI4qcM6MTP8kfDtC785xkTujRsU18aV4
	1v9t8uW3fQ8maWyziK5CgqjMpckkSaqdtU6b0gw7vPQWFD401K0h55+pgrALmyAw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0ns8n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 10:01:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T9uZ2n024618;
	Wed, 29 Jul 2026 10:01:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw69hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 10:01:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TA1NX143712830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 10:01:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73BA820067;
	Wed, 29 Jul 2026 10:01:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 267CF2004F;
	Wed, 29 Jul 2026 10:01:19 +0000 (GMT)
Received: from [9.39.25.41] (unknown [9.39.25.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 10:01:18 +0000 (GMT)
Message-ID: <eaa8e565-377a-49d0-937f-b769d0b7f8c7@linux.ibm.com>
Date: Wed, 29 Jul 2026 15:31:15 +0530
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
Subject: Re: [PATCH] ppc/fadump: collect dump if the collected size is lesser
 than reserved
To: Shivang Upadhyay <shivangu@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adri.vero.dev@gmail.com, adityag@linux.ibm.com,
        anushree.mathur@linux.vnet.ibm.com
References: <20260714173010.615682-1-shivangu@linux.ibm.com>
 <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
 <afd516619eea338039a6defb123ffaf38cf82949.camel@linux.ibm.com>
 <72589eca-2e97-4a2f-8665-b2a817a04722@linux.ibm.com>
 <7618bf3e48f6770a803f8350d0b3b084c23042fa.camel@linux.ibm.com>
 <7eb8ed5f-0652-4675-9369-913a17463093@linux.ibm.com>
 <4e7bd9342efa0cbdd162445a994f73c9ad473645.camel@linux.ibm.com>
 <93bd50eb-0205-4ed6-a3cb-a29bda61db3d@linux.ibm.com>
 <dfb0705e5b3a7a3f2f06d842b68910e6eca742f9.camel@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <dfb0705e5b3a7a3f2f06d842b68910e6eca742f9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX4L4fCixIGb4c
 yi3ogM1u1TqeXZaPEyeJUaJQjbNftKFdaMn6kyVH7XUxSaj+gmNZKtNDAKfzZCQduLq8/f7sZje
 4zYdurgZMiq8BtDhdNCIUjCHeNO/qcI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4MCBTYWx0ZWRfX/kZHjxW8mthU
 acSZeck0EWOb7niq5tCZZ0T/cxBBwluW4Ib7nwydlKTV+MbLqitKJZSOn0rFIxXlBtuUwq9xvrc
 IMH4BgNhhaxyT1d4lyZGZEYMGeuvHzy4v/VDTWo4WCzo6FW1kyPl+drn8IJSYl27nrbgBs3VmGI
 VoOI6Ox5iT8jWIBW0Uo4TjrFVaSg6daOoipD9W038eX7dc6vGls8UhypEgM3nhB8902QYGSJRdX
 SYUhsOARk3cPvKF7j7eBCyOXNVGJZT76YarytXVDZKygB3iQ5Ig3uPXgvrwne9KQtACjjknC4oU
 AkPisYidUe+DVrwRbQj7Tc6UZXgNpDiXb6vAc7rXhiIiMAVE/OmlkCx6rdanopyUv0hwjxmOA/+
 XxXHvVLL3QN2TE7/1TXdYJpi05OaaxkzK4A2d3leB/Rh1APENgNCi7BCjwD+uuNUeIry++5aYkH
 +ee3iAqhSCbeeNHni8A==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a69cf78 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=CKJmwcugJmyXTtnzU-8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jjhKo9s7L8IguWHZt8aok8JUCA_1nSje
X-Proofpoint-ORIG-GUID: qVq7_MksKETXxXdo3U-aGdj-YD5qph_r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290080



On 29/07/26 13:59, Shivang Upadhyay wrote:
> On Wed, 2026-07-29 at 13:43 +0530, Sourabh Jain wrote:
>>>> But the firmware not copying the entire Real Mode memory is also
>>>> a
>>>> problem for
>>>> the kernel, isn't it?
>>>>
>>> I think it should be fine. Firmware will report it status flags,
>>> right?
>> I don't know. Does PAPR says anything about the error code
>> corresponds
>> to when memory to not copied completely?
> As much as i could search, I didn't see this case metioned there. I
> think if, fw is failing to copy full content it should report one of
> the below errors.
>
> - copy from [x...x+size] to [y...y+size].
> - x + x_i is not valid
>    - leads to invalid source address.
> - y + y+i is not valid
>    - leads to invalid dest address.
>
>
> But anyways, As the source/proper description is not available, we
> can't prove much here. Would it be appropriate, if I just make this
> case for CPU_DATA area?

It would be good to first understand how the firmware (PHYP) handles
CPU register data when maxcpus differs from the number of online CPUs.

According to PAPR, the firmware should only include data for online CPUs.
However, when min=1, desired=1, and max=2 CPUs, we observed that the
firmware reported NumCpus as 16, which is the system's maximum CPU count.
This makes it unclear how the firmware handles this scenario.

- Sourabh Jain

