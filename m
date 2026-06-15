Return-Path: <linuxppc-dev+bounces-22659-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9398CD98DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 20:16:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfLwd1jGBz3bps;
	Tue, 16 Jun 2026 06:16:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781554561;
	cv=none; b=QbTkVpF4lbvKYBCNrQY7KZD9WdHOC0VCoLAoMuubHe2SymvgedVxAZtOStWzJVPt2iMZEEqRVwO0hIlmCxn20f4b4vhkBVHBagFxK/DACPGklQNORePPkLNWIvm4972UWmG5mnJl09eur+oMsP0TjLl1c1J+CoNO/vEKalTNyuyOw6bqz0Dl9fj1zoy+okSqVJEcer7a6vMdP1mnhac3bBC5XEJlt7dhuk97OYNME88mnZhMS6Nu6iaF4FDaqfcxJ/kwo+PiGDnI6hVbkOWHgn8yZ5FjFEZVZelPLwUmesdW9+kOqX0cm3+uKETIhg1uGOq7RFGdcBR9Owe4bKNmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781554561; c=relaxed/relaxed;
	bh=7P7va7+meqsTAlaUbyol4cF226BVTGW/q7MbSdKdAgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k6aUL5vi9CNXtHXv5XvrNEdppCqpl+k0o0YTavLhBnYjp1vzyd9ITR8iXnRsLh6F1g3xat0mf97hzCsULniWs/UTd14GQea3GC2iG43mx54hpwnLBbqe3u4HW/T2PxMOicGqVn0ubTfFbi39dvsu/T8gqExn+v2TlMnnFENBTGVvQhXCb2Rcr/f8F7nSVtHBCQ+kcTUEFnp+Oj4IphUQLtnYWQqoo0WRHG87i+oWNj71uGmTwaAPhPn+v2qZXFkYNWi+qR8EnXMz937ogr3dMLjWf4glo/iVqCr2gxIxzzqtqVbyN+nzupArTKE4HPLIUs5rpHXk3puEyvD5CenBxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B4vavR3a; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B4vavR3a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gfLwb58D5z3bp7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 06:15:58 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FJIc373334969;
	Mon, 15 Jun 2026 20:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7P7va7+meqsTAlaUbyol4cF226BVTG
	W/q7MbSdKdAgY=; b=B4vavR3aglW4JcMCblM3EGpyTII1n8qpy+OnrT814/y+ck
	5Tv1+QpzXukhSyc03LV/23aADvo41pcE3lyLL09tkMxQZh/pCcTfOEh5paRqAW2B
	EKCifyvkwF6Hy6bTEXtkKEnrzrxl7E+cbNzxFq649qNn9L+dzjLYpMoDyqVyme8Z
	m7TVQAv4adhcwASGmEmdBTY5DNOIO3YNCpyqeF3gUoHX091cWS94wTsYy2STSwdX
	7xSvJDTnik9IGA6Pgsls1zrwqGT3asz5xucKYo+SeG2rZFyk6LWG7rLcTA8baqtc
	tqh4Q9CIhRWUbNEJ2SH84sXVLMcAGhtdygiSjWKg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0j08y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 20:15:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FK4a5k025420;
	Mon, 15 Jun 2026 20:15:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk06qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 20:15:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FKFclU7078406
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 20:15:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC31958045;
	Mon, 15 Jun 2026 20:15:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3046858052;
	Mon, 15 Jun 2026 20:15:38 +0000 (GMT)
Received: from d (unknown [9.61.47.236])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 15 Jun 2026 20:15:38 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin
 K. Petersen" <martin.petersen@oracle.com>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas
 Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Brian King
 <brking@linux.ibm.com>,
        Greg Joyce <gjoyce@linux.ibm.com>,
        Kyle Mahlkuch
 <kmahlkuc@linux.ibm.com>
Subject: Re: [PATCH v2 4/7] ibmvfc: define asynchronous sub-queue
In-Reply-To: <55fd8413-34d6-4dda-8a65-1aefaa8585e6@linux.ibm.com> (Tyrel
	Datwyler's message of "Mon, 15 Jun 2026 12:27:03 -0700")
References: <20260608-ibmvfc-fpin-support-v2-0-d41f540fba5c@linux.ibm.com>
	<20260608-ibmvfc-fpin-support-v2-4-d41f540fba5c@linux.ibm.com>
	<55fd8413-34d6-4dda-8a65-1aefaa8585e6@linux.ibm.com>
Date: Mon, 15 Jun 2026 15:15:37 -0500
Message-ID: <87se6no906.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: wczoI-7ioeSKo1vSn1I7NWqWeujZNvok
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a305d6d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=w5PW5THavAhz0YZFxZUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwOSBTYWx0ZWRfXw8tSEqfnKAZN
 MpmDvrvGL7hfULuDmhLzhAlcVc29gj7hWQFlW/pU10mChvGVjCt/IGoqAVTpTh6BahM1CG9xLby
 KFXv7dHLFAHzNwz0nqzoCAR2SRBOjyfsXvcQ1aUk3V/MgUF7lqvC1ZNK7He8ZtIC23ea/CQkK+i
 6upe/lLm7ElQuNbJERbx2txY+Da063bAftJkefhUkmp+vx3nfQdfkW5/xzPzs3nddi8DllB2f8z
 kvLaudbZXhS71yAXyGPioCoksaN9VpcrfE3kf58z74h/jJ3fV6lISgV+IfQqvM85FUfrBFSa98k
 jXu4vruTjSiTSjkviOIVXMS8Khs0xXOmE9x5ms1ibPhAjuI1tNEpheKame/U5+ngk2QKmkab2Li
 rwoFEfEEjGPq9W0gwwBIkR5e4grJzuu7Jo4s0Q53Bh0+7/u+hQHBNRvyooty3SWCnjSVqaUEs5S
 PWIa6AGmYmxNdHwlygg==
X-Proofpoint-ORIG-GUID: zbcaP4yBrTPJoL76FWoBlJmT-Rko4kgz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwOSBTYWx0ZWRfX5lm14A1MALsA
 XuMR016jw0uva/Xn7QGGmGMgKyjnlGsQtYgg11ZdntCbFjT/7lZ4OIX6mg6lSK303QSanDP2oDj
 G4F3J9A3OYFQnhB8SCxpF+yNiUNE0nM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150209

Tyrel Datwyler <tyreld@linux.ibm.com> writes:

> On 6/8/26 11:30 AM, Dave Marquardt via B4 Relay wrote:
>> From: Dave Marquardt <davemarq@linux.ibm.com>
>> 
>> Adds the asynchronous sub-queue structure, modifies the existing
>> channel setup structure, adds the asynchronous sub-queue to the
>> channels structure, and adds flags needed to tell VIOS to use the
>> sub-queue.
>> ---
>>  drivers/scsi/ibmvscsi/ibmvfc.h | 26 +++++++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
>> index c996b36d335d..f026f30f98d3 100644
>> --- a/drivers/scsi/ibmvscsi/ibmvfc.h
>> +++ b/drivers/scsi/ibmvscsi/ibmvfc.h
>> @@ -181,6 +181,8 @@ struct ibmvfc_npiv_login {
>>  #define IBMVFC_CAN_HANDLE_FPIN		0x04
>>  #define IBMVFC_CAN_USE_MAD_VERSION	0x08
>>  #define IBMVFC_CAN_SEND_VF_WWPN		0x10
>> +#define IBMVFC_YES_SCSI			0x40
>> +#define IBMVFC_USE_ASYNC_SUBQ		0x100
>>  #define IBMVFC_CAN_USE_NOOP_CMD		0x200
>>  	__be64 node_name;
>>  	struct srp_direct_buf async;
>> @@ -229,6 +231,7 @@ struct ibmvfc_npiv_login_resp {
>>  #define IBMVFC_HANDLE_VF_WWPN		0x40
>>  #define IBMVFC_CAN_SUPPORT_CHANNELS	0x80
>>  #define IBMVFC_SUPPORT_SCSI		0x200
>> +#define IBMVFC_SUPPORT_ASYNC_SUBQ	0x800
>>  #define IBMVFC_SUPPORT_NOOP_CMD		0x1000
>>  	__be32 max_cmds;
>>  	__be32 scsi_id_sz;
>> @@ -563,7 +566,7 @@ struct ibmvfc_channel_setup_mad {
>>  	struct srp_direct_buf buffer;
>>  } __packed __aligned(8);
>>  
>> -#define IBMVFC_MAX_CHANNELS	502
>> +#define IBMVFC_MAX_CHANNELS	501
>>  
>>  struct ibmvfc_channel_setup {
>>  	__be32 flags;
>> @@ -578,6 +581,7 @@ struct ibmvfc_channel_setup {
>>  	struct srp_direct_buf buffer;
>>  	__be64 reserved2[5];
>>  	__be64 channel_handles[IBMVFC_MAX_CHANNELS];
>> +	__be64 asyncSubqHandle;
>
> No camelCase please. Kernel style prefers snake_case. Something like
> async_sub_crq_handle for consistency.

Got it. Thanks.

-Dave

