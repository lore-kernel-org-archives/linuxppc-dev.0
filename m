Return-Path: <linuxppc-dev+bounces-20842-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7300DCD37B6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 09:06:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFndC36RPz2xlV;
	Wed, 13 May 2026 19:06:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778663183;
	cv=none; b=m5GKIMNy4zaKY588Zkec8Ife3HdQQNk8TZp3RdzlppmIAsao7MTmeeSdjIK2pbocM2AiaP9L0gdiGgPGfV7nU2YPb6NTD4qvXZ/TLdQrLOF5nwXDU1RiFilIV/GqHizR7LFzbcZaHtiyuqXwDqLew662lWJMiQN7cGQFmdyXf0bibSSTjW3Bkl2vTHmgBlhij6c5IXzIN7Y66YxPg6V0JOmgEjL7zt/4NhKxGK3wH8EnKDeQBHWzM6M4Z0gslXlnHlepRCnF48POPeh+6QM0hiAGh1gYMS45rWJVY12rItG2EUOMGVJhvIbncK4prCs3Jheum5B2uQVTxbilDDoSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778663183; c=relaxed/relaxed;
	bh=A2TXYQaZgIB0HYqEhGeB3su6RVy9mc4qpOzuN57P6Xc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ewFmj6oWC6g08bzmQSnr6qP4DGhStOefSRzxOe3A/Bsa7ljHpgUEaTr7rjBBymz9hfTA6dukPWGqThsSk6h5XJOVtbEH7ycTqjTbjwa9gHVypANjhQj4OWx1JBWSHx1yYwApFLvdJi3WLnWn3gXYTP2s+yGE7CocEqZA0mSOzue8kaTKw2CdWZoRQvMGPvC8c4/VRUxCAyZa4DAC5+j12/j1/DsYa+fUIOX7xH1Yk+GEvmxhxUdL48isjAACWPf8Oc0+KU34OG3jsI+E6RJKnnu4V7PBxYUQhn55BLJuOW0e/vkd9QEIA6DM4otq3Z8n2XbELeOsZNXh3xTtJDBLjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DhcqKJ13; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DhcqKJ13;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=vaibhav@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFnd96DK4z2xGX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 19:06:10 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D2Bov72607040;
	Wed, 13 May 2026 09:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=A2TXYQaZgIB0HYqEhGeB3su6RVy9mc
	4qpOzuN57P6Xc=; b=DhcqKJ13hzyH1qzI7Eg4dZTaNzvpYcSfRrbrjY6faLHNOQ
	HF9Ts3LPYX5J2DipQM17HpCW0KLQsDzmw9CE18hlighHZJ9noD0sZwP41nfinhvo
	zMHP1z7uN7pWzZJlVsOpeEsH5NrtJEtkFsfA0bj9elcopV+jy/ZEzur0EC2BQKyC
	umwPjeBXBRC4Ltub7Y4Bcu7ZnlhDQ0X7WbRoI9cEJUJO4zIE97XsHr5tKPBwNWf0
	3+cZsVdHb4pmQoU4Ca8FJbmUjkMaW0/6BsuCKPiZ7tDJ4EM8xarwttsyiuBdrOPI
	/tWn4oXzSfhBRU6x4KpHBYjduXH30PZSShzPZIaA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv56wt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 09:05:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D8sVZi019927;
	Wed, 13 May 2026 09:05:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgq0wm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 09:05:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D95Z6U31654434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 09:05:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E757A58063;
	Wed, 13 May 2026 09:05:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA56358043;
	Wed, 13 May 2026 09:05:30 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.28.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Wed, 13 May 2026 09:05:30 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Wed, 13 May 2026 14:35:29 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Fix the vector number in comments for
 h_facility_unavailable
In-Reply-To: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
References: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
Date: Wed, 13 May 2026 14:35:29 +0530
Message-ID: <87fr3vvfvq.fsf@vajain21.in.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4OCBTYWx0ZWRfX4NKFR68aEEY9
 MT5BC/Haj/A+/QhrSThWjF2pFhSeodWlnHfqUWmfruHW0yW0pyiq+2WTa/ZDe31aaAKpZDJPOAM
 9VmJb82CTPD/p9rWSvJhVx8Kiyl6CFZ3txZy8XM5xB7IOmrvqa3pLq1ViI6dYN55M0ZUj2GKCac
 mnlpUR+tfOaEGzwcxQjszzq/7Mbnx14V58JpdRlLeEfptFYuE9wvoZNNDFtISOwHAZghwZo6Gty
 xVjFWyfghTmZzjC3ihUHTuiiuJwlCwUWBfeccNC5TOX0QOxoX/FtHvB6zbPWIbFfmwALa5iV8Lt
 UOG81tdbstyA7jBiujhsb+UhUUx8Uee/tOrv8EeaA1yn4ybAQ5EYqhsSdlCsqBdP8R1hdGkrYFn
 2P2SWZLGMUhDD/RdkD6J3Z4lA126MKkOl9PJSbGIzxs0Pbtxp7G34bLgod7yqkf9Rl9B19+K7hj
 5Tjwf4j9cYQz1Lswcog==
X-Proofpoint-ORIG-GUID: iY8g_XiTtjAGt8YpAwJn2RvSWDZ1MKJd
X-Authority-Analysis: v=2.4 cv=Jc6Ma0KV c=1 sm=1 tr=0 ts=6a043ee2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KsF5BuLE4_TF5G8aTxwA:9
X-Proofpoint-GUID: gbGZGvxfS6iab2NYBAba_4jDp6B1z2Ug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130088

Hey Gautam,

Thanks for the patch. Since this patch doesnt have any functional or
code change can you please put a 'trivial' suffix to it patch title like
[1] or some other suffix indicating its a non-functional change. That
way maintainers can easily pull the patch without worrying much about a
regression.

[1]
https://git.kernel.org/powerpc/c/d2827e5e2e0f0941a651f4b1ca5e9b778c4b5293

Gautam Menghani <Gautam.Menghani@ibm.com> writes:
> From: Gautam Menghani <gautam@linux.ibm.com>
>
> The comments explaining the h_facility_unavailable interrupt have mentioned
> the vector number as 0xf60 instead of 0xf80. Fix this typo.
>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index b7229430ca94..2696fbbca3b6 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -2498,7 +2498,7 @@ EXC_COMMON_BEGIN(facility_unavailable_common)
>  
>  
>  /**
> - * Interrupt 0xf60 - Hypervisor Facility Unavailable Interrupt.
> + * Interrupt 0xf80 - Hypervisor Facility Unavailable Interrupt.
>   * This is a synchronous interrupt in response to
>   * executing an instruction without access to the facility that can only
>   * be resolved in HV mode (e.g., HFSCR).
> -- 
> 2.53.0
>
>

-- 
Cheers
~ Vaibhav

