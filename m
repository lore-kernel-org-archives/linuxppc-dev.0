Return-Path: <linuxppc-dev+bounces-25022-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7659BC53200
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 15:24:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9GMr6tT7z2xwP;
	Thu, 30 Jul 2026 01:24:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785338664;
	cv=none; b=Sf1pYXo2k8NoGEw9uP+EWsxqGHutmMt0GI07DBCbJp2CrcBtzatQsNUyR5OG8nWGfUGKxCHe3TBQY7EoxJv+vqQ+WLi31YJPVEKW2Kwapr/fmlrVLeUFjy3GfTQ+HFA9/noFhJ26d+BGKqygrmASCLEDhCd0z3jf0KeqmkrHwOVnyMWUuo/JXkNJ4cI1n0wpx9RtUUuCKBK0dZiT+Klg7g6VW2+unv2sf96KsknwOozfbJxlFhm/1fP8lLzvpTbP7Vk616R6La3S/lHayVhfATwEeVTctJK0XZVlg31pLtGzagRxixuZOQNJZ3BuuXw9GQP6oADPXSddQxF2d3I4Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785338664; c=relaxed/relaxed;
	bh=7Y851Sl6c1317PScn03Hr9nj2cJhPDVUt3qis4OFyxM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ne9o9QZs6iUy+oqRW+rV0AQ4ygm1znIuD/cmrZ4gZ4c779PFQVjvB673Etv0SsWB0OvrDEppBpBHuDwoUKXZzHB77zpaKWvhZf0/6PfwEBbcCpx33iJ1MWL7uy9J3WRZ+78piwT3x4Y6AfCeWbkTK1Se7X7B5o1Z26EG+92yswVXEWlSWwSMGe5f8IeUvBEH0/sriDBKjMxnWXQW0dQ5fPC2aAWGs5UyNtxbDwD4bM0tLy/hJbCd5ekdfNxBn2X/hNJdNnAseEsbIO0FVA44O+GgrzT03uT7yDNNM1nyjW9DTt+wmB3/0WIDHGixEeZk1znEDkrGTD3OCXjJ2GHSUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qFQKpxf6; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qFQKpxf6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=davemarq@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9GMq41wTz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 01:24:22 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TFHgFL402486;
	Wed, 29 Jul 2026 15:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7Y851Sl6c1317PScn03Hr9nj2cJhPD
	VUt3qis4OFyxM=; b=qFQKpxf6VfzENcxKvq7yxuNFy/pR5LpgEr7+e1yX3HV366
	NuxNOjzWDpuOntSdqagNUuXWRwNO+n5ZWjIZSm8y1TgPqn90lCCfJH75dcBA41LE
	e+Eho6UZmwh9XSpB2cDUH0ckaFh3ZWtNr78Yn2rA4uavniBFtBV4MbUco8mwSjak
	iASFn7CSXWM7Q1b3Wgm9nnVdghVVcmS/vL3agCvr+1ezZUgFSO79Fhmanuhtuimn
	3yh34pSPC5mr+TDtrG44p0YsnwpyFG/jzW72GRPVqiiGgFjt7VBPNY7kOQscxrXR
	/5gkWk6gPLEyiiJ4xoNhaAfQXc7mIfJaDUE9A7Yg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd2meu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:24:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFBc3h001559;
	Wed, 29 Jul 2026 15:24:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fk79bm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:24:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFOHkZ28443348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:24:17 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9E7058056;
	Wed, 29 Jul 2026 15:24:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1C6358052;
	Wed, 29 Jul 2026 15:24:17 +0000 (GMT)
Received: from d (unknown [9.16.41.19])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jul 2026 15:24:17 +0000 (GMT)
From: Dave Marquardt <davemarq@linux.ibm.com>
To: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com
Subject: Re: [PATCH v2 10/33] ibmvfc: add logic for protocol specific fabric
 logins
In-Reply-To: <20260723000149.969416-11-tyreld@linux.ibm.com> (Tyrel Datwyler's
	message of "Wed, 22 Jul 2026 17:01:26 -0700")
References: <20260723000149.969416-1-tyreld@linux.ibm.com>
	<20260723000149.969416-11-tyreld@linux.ibm.com>
Date: Wed, 29 Jul 2026 10:24:17 -0500
Message-ID: <87cxw5vmxq.fsf@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: x3igD5_si39orQ0-ATocC7y2UIbFWhO7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX6NF9i1sjrNIy
 thC2ir3wU+3uh7gsXzw4qvn/unsTZ3boYxpxmMrr0oEOf/p1Z0KXJZ4ZpEaUWQyY5odnmqzUwTN
 nRKQ3+jn0ATsqwXqDFJ2x21cBRCg4zs=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6a1b23 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ypPWuq4yIia8aLVxQa0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMyBTYWx0ZWRfX512gsMEHG/Qj
 NszMyvM1ArMfFA/RtETbKgY+/o/ssdt0Kg9wpQUHthQX80gx5HjZb6NC0Wp2tvWJ9UcTgdIHsfj
 GHX840H+tlDonSUaqHgTJKEfC5m6w6xreBWhY38z6sHWEsPFv95ZoddMtZQfj3ZHLC0wFp83gk8
 CPHzDvUAvE+NwkViZiqvXaMuzgOPaO+sr3Upy2fN1NpgTosE2lo0Qa14OjFJTmfpV4tAF8x6csJ
 JaZJkfhdM2z9IUY9umqNM8Dez/pACpkJveQhZ+o3SRPwcpWCprcybqGvhUMnWx9cjbeHutt6qaI
 0CGIFzgOISsHcYI9JihlH6mdG+arVJFZ/QLfvFx3bXsR/bLLcuVdX0v2+8gCS5e9gfbYNZfXTxy
 5A2YDruP5ptlovzMZA/kczrDBaQ4758f1J4/TXdGCKrC/YORPwVVnxOaaN4MIwBv4dHkNxj/5Pg
 3SPATdUz1e4XroOKu7A==
X-Proofpoint-GUID: x3igD5_si39orQ0-ATocC7y2UIbFWhO7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290123

Tyrel Datwyler <tyreld@linux.ibm.com> writes:

> @@ -1530,8 +1538,14 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
>  	login_info->max_cmds = cpu_to_be32(max_cmds);
>  	login_info->capabilities = cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN);
>  
> -	if (vhost->mq_enabled || vhost->using_channels)
> +	if (vhost->mq_enabled || vhost->using_channels) {
>  		login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_CHANNELS);
> +		if (vhost->nvme_enabled) {
> +			login_info->capabilities |= cpu_to_be64(IBMVFC_YES_NVMEOF);
> +			login_info->capabilities |= cpu_to_be64(IBMVFC_YES_SCSI);
> +			login_info->capabilities |= cpu_to_be64(IBMVFC_CAN_USE_WWPN_ALL);
> +		}
> +	}

Should setting IBMVFC_YES_SCSI be conditioned on vhost->nvme_enabled?

-Dave

