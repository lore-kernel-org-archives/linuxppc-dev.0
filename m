Return-Path: <linuxppc-dev+bounces-25141-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA359C55165
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 22:54:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hB4KC5lzcz2xrL;
	Fri, 31 Jul 2026 08:54:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785452095;
	cv=none; b=exZmNIJvuMeZfFIaYR1iGNrThbIbSfwThL0rrMqUCERKAn1gOyjftxw5cRlf9s/QptuGQDIqoh160CnC4QPpxetBs20j7yhzEd+mpwElPCJsjDZerePN2PizxnIPsPtZU9/7+QFedkIXgquKKjTeyW4bf6SFxlcRsAB6sOnwRk5PmGhCNyxmWGGFJ311Ku+Z8EzePh2xYN8nzO/OVPznoyyO/ruPGUvnr/wFxcjS0Sew+07zOq4cKnm0GF/e+vY/DdC9NXgwiJrYpkajghPVpcUpqxPVVCvkB/+ddNW8qGpyphsGOQ1P/XlwUCu09ZDK1p063E2aAbqxg46wSus5Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785452095; c=relaxed/relaxed;
	bh=zGnH5hX5bNR1M5EEd5b9XJmSA2y7Zxwj+Dstt66u1eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTqq4c8Tjjk40/GarkyWSOUUmCS6mHgzbNWcupJAWxwZjwSCy4GNCi6c6DnTfIzmGiXrt1UYCGysLhBHsN2OLHAXT0LSvp1b7PVlMOH60R6MeaoTNMIFFYvPJJ07ieXVtzy57XiFyvJX4Zz0o4ax9J1HJ1tpDnX2TqtiNcIisr9z9P5DGzsrXZs7525ebqisZSc1G7NPf6doNhkCQ7Eh5hnIKFWlCFGI3Hrh12aW5JjRcQbaPA3NB8uFIRvmQyPbLmfywoOtzhj0neSpNVhsBjLcuvEfKktQAZUXXbhGhj09Lk23nX+IUnzdl0gfYPCTWEnQSQlkTFPhFzKUPeiE0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H2m+8LQb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=H2m+8LQb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=tyreld@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hB4KC0M6bz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 08:54:54 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UJmVFw2081860;
	Thu, 30 Jul 2026 22:54:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zGnH5h
	X5bNR1M5EEd5b9XJmSA2y7Zxwj+Dstt66u1eQ=; b=H2m+8LQbizzMC/fZeG2uhJ
	md9yuc9hJKb9ng6c3OtyUQ3RPWASgN9xW+ihWkQSqXQcVL6PsfJA5rfcveSyQVWJ
	FYUTyzCbdkYoPrNmvDNq5K0ifvWZxGmMp1jpljr7gLZQmmvDKgE/6uo/V98ilc4t
	OjcjT+bjVzJUn8F/+OGp6qpbaXa6M2QzNPxssRvaak5bA5j7UjyXMi8MMOZpTpZF
	GDILWKrEOBRZl81cRIpPdwIOGOswRrir/MUH9y+5ia/8Q5QWLu4vRV7Fm8t7GLqX
	LiyPXfo6x02jfFskBqFBQNnnNS1ybujOchnTWmxzCtFUtpYQI5LKFVaj1SRWG3Jg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyct6th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 22:54:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UMfLjv006956;
	Thu, 30 Jul 2026 22:54:40 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhndfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 22:54:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UMsdo115729250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 22:54:40 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE2DA58056;
	Thu, 30 Jul 2026 22:54:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1F1E58052;
	Thu, 30 Jul 2026 22:54:38 +0000 (GMT)
Received: from [9.61.73.28] (unknown [9.61.73.28])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 22:54:38 +0000 (GMT)
Message-ID: <75acb590-7bb3-479d-888a-b4e7d6a3aa41@linux.ibm.com>
Date: Thu, 30 Jul 2026 15:54:34 -0700
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
Subject: Re: [PATCH][next] scsi: ibmvfc: Fix spelling mistake "Deleteing" ->
 "Deleting"
To: Colin Ian King <colin.i.king@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260730222951.352872-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Tyrel Datwyler <tyreld@linux.ibm.com>
In-Reply-To: <20260730222951.352872-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: _Z3hVZbTYoG3su98RmwO8AYjURRlLnEO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDE2MyBTYWx0ZWRfX8lvnKvqWULxG
 ObE/NvLWGvCuCJiXhUmLJO4/P63B0V3xxVsOaeG2XEIi4TQGLsb5MysbGLijmUrXNgoPIctBj67
 Y8tJ2bXwDKU590Xy9V7jpluFjhVqI58k9UvtD/HqkUFKnYGisTJe4MQYlU68l/U6C9ARa2pgt+2
 si0HxpGc40z+pNdOEdhXB3HOORDsUiHBJ9L7dUtsz1nD2pHWOb2bf5t/uDyU1jEjIa2mUUIqJiX
 GrqVqyaiISAuWwCjEB6U+kb1OfPV2TZ1DkjYMw2N3VbZ6UoVPbWjH6AZlqvqH1QSsaBoaiTKG3m
 txL0hQMZajgUskzy9RbLUabpg/Ct4TXv+durS3EvyLyJLDs1MnP9ntTePb3tVh7JNg1Vk9AK6Zl
 W6C9LvNwpxQpdXfkKwltzcLvh32sPNHWyASr0/70zhKsFQ6vDmCtJ3+dX/LnTrQ2Cdk9cci9qe+
 6cbLStkr1JbeJTUPMTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDE2MyBTYWx0ZWRfXwWrQkI2fwfIJ
 PGHr9cd9oJNMrazhCTmFMBdJIPOpw8/SmaT3K2g6xBc5sGtZauRkaeWeG9GKaeH8U4nzHbXxw8d
 /f7Ufm/mxp/IaVr30BefGhnHdhocfXU=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6bd632 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=pGLkceISAAAA:8
 a=pdSM-NVmPh03PByMKzIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nci1EEkgEFiP9mTlgqezP6e0B16QFWAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300163

On 7/30/26 3:29 PM, Colin Ian King wrote:
> There is a spelling mistake in a tgt_dbg message. Fix it.

I'm going to have to resubmit the series that introduced this that is currently
in staging. I'll fix it up on the resubmit.

-Tyrel

> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/scsi/ibmvscsi/ibmvfc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
> index dfa231b6cc47..93b9f699c2e5 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
> @@ -6141,7 +6141,7 @@ static void ibmvfc_do_work(struct ibmvfc_host *vhost)
>  
>  		list_for_each_entry(tgt, &vhost->nvme_scrqs.targets, queue) {
>  			if (tgt->action == IBMVFC_TGT_ACTION_DEL_RPORT) {
> -				tgt_dbg(tgt, "Deleteing NVMe rport\n");
> +				tgt_dbg(tgt, "Deleting NVMe rport\n");
>  				nvme_rport = tgt->nvme_remote_port;
>  				list_del(&tgt->queue);
>  				ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DELETED_RPORT);


