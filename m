Return-Path: <linuxppc-dev+bounces-25477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46109C55ABF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 05:28:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFwmk5S2qz2yh4;
	Thu, 06 Aug 2026 15:28:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785994118;
	cv=none; b=GKQi477pdMypB7H3s9SGi7hYKQaNLWPW16qjGbrtW5ABLjFkYca8MgGZ+T6oT1uwmd3y6oe/tCVKSEzDf5iG5cPNdN0ZYOQsDMFKj+e5wtvpmH0aQm37OgjbW+wRao2n3ubxbmL9h9Msb4b6H0AA9n1NAgzQIkPeH0oBptD5HCAmUXEtfJ7QAuLYNCMCJm20le5bYkhr4lsj+dGL6GuMFHw+Yn9qndHkvzZmFRIYWuFp+PE9TUmtdMczpRaHlhA7E7AeshJ46A3saWAY91i2x/HXgSr/V1ermdbHpGvGEo8dw1ZySkMQpI3Gnd94YUFQuyM8Kw1jhxvZ6vTNo/K3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785994118; c=relaxed/relaxed;
	bh=ZGY3C4YMNFITS4/neg/qQRae7zDhrY4NYXElDGhkDiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNaSGYBuu/v35N+f0cJ7+nkK8bmVpBEDPVSGvZZXpLeK6vjzpcZkNQGL4/NOaMiO7aydxyULoqwBgnb7lcv4Q8X9KLVX0aAGGGYOYLeiq8LF9Tj7ovx/Be7kCV8OBcOrc+hYchNcZFYjO1qhLDDn8EfI/y4Nxall9BvPELK/r1r3abAatCd2gPpVlov5uGCW32tgbSGQamRVcWSX3yoZkIYhnATV8zPSoMedrTILhRtMa7ZtJuC0ztS5ZATipS5WnfBk+sac6m4/5NKRUDZec/xNyNiayikg3lflzWJBwq125NW8E3SUvKWDmE8pUABD5lNov4dtzEkoENcgzm00Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YOdQATMK; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YOdQATMK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mmc@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFwmk1JgSz3054
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 15:28:38 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Nn2LC1068575;
	Thu, 6 Aug 2026 05:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZGY3C4
	YMNFITS4/neg/qQRae7zDhrY4NYXElDGhkDiU=; b=YOdQATMKsKksJsrIs5fdVR
	bp1BGtrktdijAsKswngg54LcwXzHnZw7EuP8yL6YK7Zqqdl/3zJ+Hqx6sfsUvF2d
	69Nu8djMU654NBpSb/b/ghoCcEa8nJvFKcgaDaxiwnuK50mnYEnXgg3wxx/c7lGt
	16+RPjAeGcRRvuxH0mymBbbttsE0qRfkUi5VFkH/lkfZCycNTGACMQMby+pph827
	19olL3qH52MP6jQhTl7NG4FPiSTHM7r3cA6NbcW0XWu2DWX0TsLRf03MWfdDIH0c
	XFFxxOxTD+0ZihM4cirA+X+vjaLwacbDqnPwU0/tmpzMmRnuZOWr+Iy+F08G5cLg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a46gys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:28:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6765QKmN024383;
	Thu, 6 Aug 2026 05:28:33 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbghkxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 05:28:33 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6765SUgP52822424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 05:28:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9319D58068;
	Thu,  6 Aug 2026 05:28:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2222D5805D;
	Thu,  6 Aug 2026 05:28:29 +0000 (GMT)
Received: from [9.67.83.170] (unknown [9.67.83.170])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 05:28:28 +0000 (GMT)
Message-ID: <22d2d33d-9118-4ccc-b5d0-0d41c2021eff@linux.ibm.com>
Date: Wed, 5 Aug 2026 22:28:28 -0700
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
Subject: Re: [PATCH net-next v1 0/6] ibmvnic: honour flexible in-range MTU
 values
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, haren@linux.ibm.com,
        ricklind@linux.ibm.com, nnac123@linux.ibm.com, davemarq@linux.ibm.com,
        vaishnavi@linux.ibm.com, bjking1@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
References: <20260805224401.58791-1-mmc@linux.ibm.com>
 <20260805193832.645bdb30@kernel.org>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <20260805193832.645bdb30@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a741b82 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=7dpCjRRtK3qBi1irl1gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 3FwmCuCqgCwBk1BaamNstPr3DnM7Llwv
X-Proofpoint-GUID: Q0H02W6Q0fjIgEAiOFKUhMoBG5rawV4r
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzOCBTYWx0ZWRfX4sHbJURhXWM7
 JxemAeNzx0UT/qtdmvOG6ATIVJfFvF5wdu+rkvEuq/St4V3Kqk9Vu8qGDLEqBaygRyxpBzYKKgk
 s8X+rphZkWzJtNc4rkjLUjmpdreVFWA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzOCBTYWx0ZWRfX9py2RWP4A5IF
 vCmrzyolw6y4+3h0hHq1a6jrc3p/4+S3p6M1KWAiH/0X/uB+GXM5BP2Iqyx6C5uCgmG6A0lkAYs
 3Kdl41YrQRdPtOQPXBL23wbGNQoMMCRnDG4Gu6N+lYEOLtzkjBVKlFb+WB4dlS0jTZjrW27DcBP
 ZeFEjFmYM2jR1azjAO4Wtyfd4WDyWPqNWcqdOfxkP3gj5Zq2WJTDr4rS4O2YmQ2F0N/LMCCipwd
 UuvpdXDvGSS/IpysKwfhwf4CJ5BjtBLB/zjJQiZzualRmL//N7HbGWwxX1bMPW/VDI8tAXna+LR
 Hd/yzj9VldPtyPEohdYKpJvjqWzd2/VeNMVBX8BTiLQM7htzaKyxG5ORsHXdwBQUNAf/0bPC+n1
 rYaNR9UUUPmK97En82lOKhJ9u0RKkbBQSrBha2FOmR3O8PxLf8c9fuwo9EA41IX+cqL37jQav/B
 WBYdiOGJQWGHQRbzIjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060038


On 8/5/26 7:38 PM, Jakub Kicinski wrote:
> On Wed,  5 Aug 2026 15:43:55 -0700 Mingming Cao wrote:
>> Subject: [PATCH net-next v1 0/6] ibmvnic: honour flexible in-range MTU values
> Warning: drivers/net/ethernet/ibm/ibmvnic.c:1031 No description found for return value of 'rx_pool_entries'
>
>
> please DO NOT repost this until your previous series is reviewed and
> merged. Please read:
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
> There aren't supposed to be more than 15 outstanding patches form one
> person or company to one tree. We are flooded with AI-assisted code
> so reviews are slow. Your place in review queue depends on your
> credibility with the community so please help review other patches
> or just wait your turn.
Hi Jakub,

Thanks for the feedback.


Sorry for violating the outstanding patch limit. I wasn't aware of that 
rule, so thanks for pointing me to it.
I understand the review queue is already quite busy. I'll wait for the 
ibmveth MQ support series (v4, 14 patches) to progress through review 
before reposting this one.
In the meantime, I'm working through Sakashi's review comments on the 
ibmveth VQ v4 series.

For the ibmvnic MTU support series, I'll hold off on posting a v2 for 
now and will address the kernel-doc warning in the next revision.

Thanks again for the guidance.
Mingming



