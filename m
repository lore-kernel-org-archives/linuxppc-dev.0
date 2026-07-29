Return-Path: <linuxppc-dev+bounces-25040-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB671C53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 18:48:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9Lv807zWz2xwP;
	Thu, 30 Jul 2026 04:48:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785350899;
	cv=none; b=f26MB9Oi/CeA3yITN/qfSIfautuRNBY4LOAJjHy4X1g5Y0lVZD3amdJdkwmFobrz/BUdoRj5NtUUQ0MwjnaImDGLzBew7ff5SYoyPlVFCKI9eNFD+nYWDri+WOyBHqYqgrwejAuHOadhT0EPhJq3Wlg1Jly1v3Fd+N4dSYfWJ7+MatVJyieyLbiwF3t4J8Hs9kIgNiveZl504tNVpjNKa9yfUU1ZY6s9uq53BojZqmso1xOPjnQ4vYUIXO2L3UlpSgDqZ5pr3lGqUBrhS6OFYveUim49f/ILAQXpRH8UvwvqIB4Z/QhhWOATCKLd6QTiIlTY4be7+t8mV3Ol8AnTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785350899; c=relaxed/relaxed;
	bh=cx5VdKtVAyKFl73vD1Z51vWNfi2Lt73eQCUYiqvdrOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LiCJKnenAr4RdZWQTLlbW/+TV1RlsUH+BT/+aqUASfcUwPlPo1LMMyPXDNtyFMEpWDQoP7CGpSLsBXC/mGWoAeClnpS8WjsfMvieYRlB8KgiZn85+nMx+jjWOn5utFKAASF60UUStCdP0I0rSS7PGbd+HFoOv2vLRl2YpVX30NSnqdHXasK7UKKzZje0VaPpWUSIy0kHWwO4vjOPb/18goBRBx1sfLep31pjZ3eZzrHgL0W7kjepI1ZQJxoTQ0oTDRVHONfVB60SWTd8HkFAEbk9XIse2iddgEo+LmRV/bxP2zcULOZS2N/cHpVsih1HM66epu+7ck6tjNhF7S7B/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dXQDoyWr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dXQDoyWr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9Lv64vhZz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 04:48:18 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TIlia4732663;
	Wed, 29 Jul 2026 18:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cx5VdKtVAyKFl73vD1Z51vWNfi2Lt7
	3eQCUYiqvdrOs=; b=dXQDoyWrKi6fudCWXLmqwHpY5Hx+HEnednurVMKF6nyGrS
	BmZOjwAHyB6J2OwW9LQJc3z3k2qCXqKT8I0zmo8GDsxlab25Qwn+M9s/GbdfUxdZ
	/6TwvteUy3hya6hahLDl/PPlNeg4FbiWm9qDv30RjoBF5+TkHGxaUebcurY/kizj
	bPea8i4eeKBkGqBOVtQI6jegHt4kp3IsGzTBo2bLUM57dX2pTiwRYzA7XxX3O2W5
	z/aQreHJfjbPKx3gQYlCBJlx1jLG4lY9mH1jbHSmCvy/ip048sYIvpN0jqLKjb0A
	OgV1KxRZYC0/J4b60xLOd/Mu769dre53u2sdyBbA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nud65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 18:48:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TIfUT6006377;
	Wed, 29 Jul 2026 18:48:12 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y7qp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 18:48:12 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TImB7730212658
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 18:48:11 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E48658053;
	Wed, 29 Jul 2026 18:48:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA63458043;
	Wed, 29 Jul 2026 18:48:10 +0000 (GMT)
Received: from d (unknown [9.16.41.19])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 18:48:10 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com
Subject: Re: [PATCH v2 30/33] ibmvfc: implement nvme-fc IO command
 submission callback
In-Reply-To: <20260723000149.969416-31-tyreld@linux.ibm.com>
References: <20260723000149.969416-1-tyreld@linux.ibm.com>
	<20260723000149.969416-31-tyreld@linux.ibm.com>
Date: Wed, 29 Jul 2026 13:48:10 -0500
Message-ID: <878q6tzl79.fsf@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDE0NCBTYWx0ZWRfX/EN+nfO5ODT2
 tidL+oQdoI0M2NSo7pQKP8F2jtXDLyf8yh+oKNbMYvuNAYB8M2vkKNBCCHlaEDphqAi52Ps5XT/
 FtiqIthvhEzn36XeY9Ksltbc5Y3kYt0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDE0NCBTYWx0ZWRfX6q1Sqt7DhQ4P
 zMqGfP0PBIKZNXwEHLxNRPYOAUbGZGl+UWykCUNtHGN6vRbS6HnelRIOsabQnCLZEE6HI60hklT
 bFzRAQ1HB8HVH0Es01SDd7PUYdLyzWZ3kkTxwRvVm56NhmExkjjqb8I6NnNH9moCbH5qrf6Ewfl
 gfuK3dUkMm6ZZ3vxI5JeBvKNJ8HG6mCfSydv0N3AEcvuy08JA1wq/kw9HNjIev5qzjZVBp1FUrx
 +M7z7aqtzvnA8n4mKYa29OcxOq9T5/UP5SPHUeja7uE3dAkOLMhiAPLxpJ8Icy0KnCgAFoP/QVq
 vP0BKF+Xnj8XFdlb3oWQDPnLdjHWgSntaELbtxyNOphlIumEHtfMSLYV8LQLkkU0CEcI2JznTnQ
 VbSVffQUh4vGmO+fszzB5CaLMm46pJnSbZQMkNr5s8SOHE540Wi5+jAojuBW+AQ0iHbv4HdPUtg
 9XZhhYTpxLO+ZiJDOjg==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6a4aed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=mLul2hC0Gid57qSl7OMA:9
X-Proofpoint-GUID: DOa0ISyLvq6hd9O_Nr1IVg5EZhj5WPAE
X-Proofpoint-ORIG-GUID: DOa0ISyLvq6hd9O_Nr1IVg5EZhj5WPAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_07,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290144

Tyrel Datwyler <tyreld@linux.ibm.com> writes:

> diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
> index 45c7bcf69201..bc975f632da2 100644
> --- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
> +++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
> @@ -1539,7 +1539,7 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
>  
>  	login_info->ostype = cpu_to_be32(IBMVFC_OS_LINUX);
>  	login_info->max_dma_len = cpu_to_be64(max_sectors << 9);
> -	login_info->max_payload = cpu_to_be32(sizeof(struct ibmvfc_fcp_cmd_iu));
> +	login_info->max_payload = cpu_to_be32(sizeof(struct nvme_fc_cmd_iu));

Do you know that sizeof(struct nvme_fc_cmd_iu) >= sizeof(struct
ibmvfc_fcp_cmd_iu) just by examination? I was wondering if using MAX()
here might be less prone to future breakage if the structures change.

-Dave

