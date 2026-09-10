Return-Path: <linuxppc-dev+bounces-27045-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A400C88E41
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 23:15:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgtnK21j7z2y25;
	Fri, 11 Sep 2026 09:15:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789082117;
	cv=none; b=Lb+h9WkQcOlLdON7RgQyrsp9+Js/AjuPYT4jw/M9uXPYOKMj1ajNaMMhCeY0ez1F36eTJl8KeoemZLr+4MTl9t5eef1ldXeTifRsXITPZgY7wlf2w8p2MFbTD7YCjtwc5Y0pnzMsKwlDwYmoZ6K7b0IXvMqujngXhPAMpEY/HwadszogO2kWUjiDceiyKhun7Y0Nhh9tIzzQiA4Bs4JG7/SD5AQci/jLjRP9sMnl1HRkbJPu5ehs1yTk5vchWP4WQgFbwPU73CycayBAy2TUqs8+JLfSW7EjNUeYrMUf2B67wekjCbhuPCMc14GV7ebUf5RxaiNpPsA2gVsYIrkWKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789082117; c=relaxed/relaxed;
	bh=r3j3xedzHQVA7rrsaFy0FEdi7de45zllsDG3cCCc7Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ci4KI85VX5zDdAPQQavkNzwKy1c+AOPYVcwT606T1gQ10bnycrH/jjP0kKHKg53JWFTX9CQ1jIZikMt9gJRp+IuvVCBthAm8KOang+whs4RYySqwPrvGOQHrqvKkuitX8thVdOZRHA43PGc7DJMlXDeXsQ8UiJfDqDTLZSOFZZPjm7fkuigi05pCHgRTwlZZzr/qI7lDNx8TZ3yw97//jEiO+gTFWKzLqWjJsj3R7fDPHhtctkRKho1HPaXV9nWniJ3MI0TFEpb360P1Eb6DC3uyNEVfTBDVK/R5sydYEwXjwImCNgaZVMhrtbd+CxFli7V/7MbW5FRe36MAxXDCjg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hOlCr26r; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hOlCr26r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgtnJ1CpMz2xlJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Sep 2026 09:15:15 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALVbkK4091985;
	Thu, 10 Sep 2026 23:14:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r3j3xe
	dzHQVA7rrsaFy0FEdi7de45zllsDG3cCCc7Rk=; b=hOlCr26rcNtgont0xb/Ip2
	KhIzOW2i4J9qvNxXccOoUHPXJwHQ5IVd0tQ/2ZKEBtYJtmiW5fj0Hn9jE8n0DfpG
	znPAMSbh5NEuXB2Vug73UyYV96wCQCJAiEZAJG8glACCDPITeVrstB2bgG44Cmz7
	SIZmt82Iv6Y6MIzorgb6Hv1d+YPL0vtIXwTnNHDU0wtBNiCNDTdEnFt8aqz/FjhA
	neXg3HN/ZMNUA8ULrdUSRMoFGrKb8X/J2nxGuUnZoDCaziZrm/xNpO6MOqxIfSCW
	rNBpKr8QEM3tlT1uVyDwnY5kC37yqMAt8SPa3iDAuhPTWS06twYa4p8ftZrtN2wQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qr3dy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 23:14:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ALZ2WX619451;
	Thu, 10 Sep 2026 23:14:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvvrb3h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 23:14:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ANEtjw3605478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 23:14:55 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A93858056;
	Thu, 10 Sep 2026 23:14:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64AE55803F;
	Thu, 10 Sep 2026 23:14:54 +0000 (GMT)
Received: from [9.61.103.123] (unknown [9.61.103.123])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 23:14:54 +0000 (GMT)
Message-ID: <d9521b14-c126-4c52-ae3d-96ee0e35fea2@linux.ibm.com>
Date: Thu, 10 Sep 2026 16:14:53 -0700
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
Subject: Re: [PATCH v8 2/9] scsi: ibmvfc: add NOOP command support
To: davemarq@linux.ibm.com,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <mkp@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Brian King <brking@linux.ibm.com>,
        Greg Joyce <gjoyce@linux.ibm.com>,
        Kyle Mahlkuch <kmahlkuc@linux.ibm.com>
References: <20260909-ibmvfc-fpin-support-v8-0-b27183b055af@linux.ibm.com>
 <20260909-ibmvfc-fpin-support-v8-2-b27183b055af@linux.ibm.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20260909-ibmvfc-fpin-support-v8-2-b27183b055af@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa339f2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=JdnPdPiFg7rkUO83TIAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CklMNVxuauknLggUjWdAYpqXqF5ySy2N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI5MCBTYWx0ZWRfX9CReIHCV+jMX
 0y4qdne3EKFA8M93WR0ircv37LofkyL0Uv1ayJhgmDaxHbPwSL9Ai2yMSVsY7/BBx9TMDOn/ZDt
 3k6bqyyYFc4/USR8O97ZdAImE1b6SgoISHd67CiYm+WwjVJsZ0Q4hHeha5fEDnoWSqbY3c5bUvZ
 vl3unn76FW5kDlhmZWUmQPaHiIppwODqbDrJXx9uCZXCLzPqHu5SFeJmcmIqyroYlqKwrZFIPl3
 dDtB/y+MjxVD3TPmr69QY9/u8oUmNPKvNE/UzXfEW4DR1AKWYsnfPiiqIkGUmhiqc//BOvnJO9R
 GzNhR5CjmffXovv7kSCCGUc6yICzbrBhKoW3hcKuxD8SNOpiiEMMSLgUK8YGBDZYESzYaqUTHef
 XB/6Kjpaf+3hIRgsEZE7zYTahl+nf7rPjeRZpqBuuMR8jbK7lMxI/mWq/WjFNKE+QX+dEXthV4r
 ddbU9vaRGa7n+CQJHUA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI5MCBTYWx0ZWRfX8nLKlamHg6mW
 LEduDsjoXX2AzAylT9k2fiu/GCBULhg2qn2RI/33E/3S3C2VJyEH1aoclKIgRIEnJ7gS9Yhs+n8
 BsfuZxQvcu0L1WOsAMvtrWbjjc1CMbc=
X-Proofpoint-GUID: Jrcyqk8ofyac8oGM_TIYoTrKFnSt4h6Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100290

On 9/9/26 12:07 PM, Dave Marquardt via B4 Relay wrote:
> From: Dave Marquardt <davemarq@linux.ibm.com>
> 
> Add support for handling IBMVFC_NOOP format CRQ messages from the
> VIOS partner.
> 
> Advertise the client's ability to handle NOOP commands by setting the
> IBMVFC_CAN_USE_NOOP_CMD capability in ibmvfc_set_login_info().
> 
> Handle and ignore IBMVFC_NOOP format messages in both ibmvfc_handle_crq()
> and ibmvfc_handle_scrq(). In both handlers, log a rate-limited error if a
> NOOP is received while in the IBMVFC_ACTIVE state without the partner
> having advertised IBMVFC_SUPPORT_NOOP_CMD.
> 
> In ibmvfc_handle_scrq(), also fix a typo ("Got and invalid" -> "Got an
> invalid"), add a missing return on invalid message types, and guard
> against null event pointers before processing CRQ responses.
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>
> ---
Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>

