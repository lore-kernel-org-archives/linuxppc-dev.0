Return-Path: <linuxppc-dev+bounces-26959-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4559BC79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:54:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg52z4gs4z2yvT;
	Thu, 10 Sep 2026 01:54:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969259;
	cv=none; b=TKO2+Ka9jVDbyfbM1KUdJQxSx05PvLkftg/OC2fypW2E8GPFQWyCr9aRBuOBgEs5vVjJPMiP3xKdM4cD6YKHvxrj/GukOGNz62Cg4Hj8CSBbNu22hy2yspijr8XRqcv3NdnO41geaPbuRbQt3sVmTQ+R5EJxYMYg9b6Enm3PHl9+ZQqixN8R01E5iLPJEv+T5YJ9NR3Hh5sTQ7DQKiRMzPTMYuLX6eVLjVqZWCt69LyMpccruSumRLA6gQL2NJs9zngIrhV6HmcVx4LApiFgtJfepppcK6AAtFNPgqbpggsKxJ9J2MVDq1Z9R3tJnPAZov0cJzsuTlXcSMiZKRkq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969259; c=relaxed/relaxed;
	bh=BfSLsWbhj6IaZ4SNPZI6rghzWGlnOFGLaT0WoDWd/F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqZRssXN55Q829pP3heF3vkuAQj641u0lie9aYoZglsFTuYQq026co8+HGn49D9NcW+EvSuVyp/hdhRBahT8bSmIuEiMm/IKuvwqEaqzdBYYVyOMgSi8ss8NFF3Wt109kQnCdkrdIChNIcxTigQOMCgohZSELTTpodtIfJaGJTd9fdVKxDxvLP+IhxgSVCcg0xFztTZyUJpHt6U7uURnGXWEZ8W29f8JU8rhNHwPUqh/5+3it8nEjb5EyZj1MnsLP5peu1ha08nh7CF8gB+HXKOuLD6Zd6I3ebSzWCzaoBmEnX/9hTYoCn/BfVlNgMMHrxzWt/dat/o5UBO4GpwCwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rFy4ABfo; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rFy4ABfo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg52y4V4Dz2yvK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 01:54:18 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1VHe3802317;
	Wed, 9 Sep 2026 15:54:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BfSLsW
	bhj6IaZ4SNPZI6rghzWGlnOFGLaT0WoDWd/F8=; b=rFy4ABfoh4eHNarDqA4Oce
	2J7gbMBH4CFDnR6mGAvwZPxjqm8Ed+sFDBP5r8uLwaFKFfBDmLMoN9TRtvK8CFoG
	Ll2U/9QKofCuF5dOe+ZJLqrkFVL4CkJVmhn0FwUyWeY8lQW2FOO4zNWBbX8pHAmd
	IXDGQbcBtEFNyUt1x3R0yCaC+nuhQ98hZPP+WAiEOAtoskTTD3VyTNWxj7TJ3d3o
	lyMN2DN8r10Zh/vJj+Ms+JxnNDq2acmdGz8Ao2nBXqLXmY6Mc+vt6LBu3DMM3R2/
	7IJKseRxSRFfM+nOyVRhOjP61hnH2HaOhzSINKtPMd0zOPWhMY95uYgnWdd0UHkQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkxyd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:54:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FfHPL030411;
	Wed, 9 Sep 2026 15:54:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqk98b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:54:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689Fs2CM47513858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 15:54:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D0B720043;
	Wed,  9 Sep 2026 15:54:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2BBD20040;
	Wed,  9 Sep 2026 15:53:52 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 15:53:52 +0000 (GMT)
Message-ID: <335b35d4-c8c9-4453-bf8e-0b1650d90f2e@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:23:48 +0530
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
Subject: Re: [PATCH v2 03/22] coredump: set the minimum send buffer size
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jacob Lalonde <jalalonde@meta.com>, Josef Bacik <josef@toxicpanda.com>,
        Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
        "Liam R. Howlett" <liam@infradead.org>,
        Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Omar Sandoval <osandov@osandov.com>, Jacob Lalonde <jalalonde@fb.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <20260820-work-coredump-sparse-v2-0-ba32dd718c51@kernel.org>
 <20260820-work-coredump-sparse-v2-3-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-3-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX111mlzSK7dLH
 AzIOnE1Oiswmd/ml1MHooNK96Jks8teAErxOPugWNBFt7WjdPiuz0rvE9EDYs31TKExlklp451T
 rncb17Te4eCGRINaSqj8T6Xqkv9S3h0=
X-Proofpoint-ORIG-GUID: AnSIL4jHWFOgr-A1ayJ_vQa372N_SrpQ
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa1811d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=PjksA4QEkjs4iweiPkkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX2ULqPz4mUGwj
 aUC17TmSMzwvp2OY65UMNDM0WI/7MGIAbm7QqwQKl6De4dymoQiBq7AHGZ6amm45djaAQoR1eZP
 VtTBgNYVRt1IkWdI040wCuzQjoAujK5Qtm+kLkbt2BHymBcidhiPAobf/d6lxq2UADZ7zmks7yA
 WjQJnK0PvCPna6rXENPblTVUHePD4aFZWxVT7I0RH8Sj7V28FPS1u1D7+UO91B+qo1zxOBC4srZ
 h/deht+Ex6D1sAvOaJkIliLRlfcLWKjP8QDWC+TB4t4/HicxcyU5EE5Q933crnIh9Cw54d0IQvR
 sakJIVOp1R1fi2BeH94gIyP0LErXdqaWPNxgh5+dwetNOejnF/0bgCSV5uUGL9j8vSa5HB7wQ9U
 sDFYWXTvK6I0RYWPleCjbmbXKRPfhLJlJc1uMzwcTwCx/U332d6o2kXxrdK3hdgLWwGc0GGJFmZ
 +mn6UaETfeRyYjPOz9Q==
X-Proofpoint-GUID: iGDXdF9uRxGhfeKK4m4ZTFTZH1Hki_zQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090173


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> The send buffer of the coredump socket is subject to the limit in
> net.core.wmem_default. af_unix uses sk_sndbuf / 2 - 64 bytes for a
> single skb. That means a send buffer below that would split a page-sized
> write into multiple skbs. Raise the send buffer to leave room for a
> page-sized write plus the header. The default value is well above that.
> So we really change it when it's below our minimum.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   fs/coredump.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index ac4e922c9cb9..24a6405ea242 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -665,6 +665,9 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
>   }
>   
>   #ifdef CONFIG_UNIX
> +/* af_unix halves the send buffer to size a single skb. */
> +#define COREDUMP_SOCK_SNDBUF_MIN (3 * PAGE_SIZE)
> +
>   static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *cprm)
>   {
>   	struct file *file __free(fput) = NULL;
> @@ -690,6 +693,10 @@ static bool coredump_sock_connect(struct core_name *cn, struct coredump_params *
>   	if (retval < 0)
>   		return false;
>   
> +	/* Don't let a page-sized write split into several skbs. */
> +	socket->sk->sk_sndbuf = max_t(int, socket->sk->sk_sndbuf,
> +				      COREDUMP_SOCK_SNDBUF_MIN);
> +
>   	file = sock_alloc_file(socket, 0, NULL);
>   	if (IS_ERR(file))
>   		return false;
>
-- 
Thanks and Regards
R.Nageswara Sastry


