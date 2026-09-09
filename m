Return-Path: <linuxppc-dev+bounces-26964-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED641C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 15:56:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg55m3fq2z2yvT;
	Thu, 10 Sep 2026 01:56:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969404;
	cv=none; b=N/Dhg37ISnIdqSxXUhNlMc64V+gfvCY1P/v1IWHXhPeLqzMwekKz5sKuHTKix8MyxUsLHR8HBqeZWFyG6tMZOjg2fwTjUqjr+2Hrr5VB8z03aSBsRu+1q/4Sfq8xT429WCa3scspE5DBM4T69OBIEoomxuQekzXq1Ct+kiW6h2pmGQrDeb+OOHQOmi9/ys7ynTQlSB14HKtRYMtX6tTr2QCo705hysKvm3XdW62w9svMLkEgoXQGMyA2ybHH0HQriPkvqnywIhrrL8atxTBXM0lS+QrDe2Zoew+968RE8qIRzLxq2RdwhMMkyzJ/dbfw3pV38FXq13L6cbFxSUTxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969404; c=relaxed/relaxed;
	bh=M1i9HkCA5SibhqxKrLMuCe+6wm+knIMfN2K/CAmeUZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcA68lkQ8MuZ44m8s0IxRQNYvSV3pXXR+QlVrCRdRDBHSQ/E64gRji8Fy0OFSmrM0TPaPT46KkMrRIQgxNe+6kAojmNrwwlKENXQdc8PIjH2cyxUtLQ3sP97F9HUdt284yLQGKgkprLxPPE40xjq/5GU7RE4iP6QyeOi5DhMpLWCQ7NDHxgfVRok4LqfEfej+mHNqaQ1ooQi4GLVpoBnP15ISwTAPNYFxkLNYh7G5JBBzVA96x+QlBUuS0qI9tcoseWyCtImsUtGukS2HrMq/dVTIrlPeFsdNm9GJ5RayxPdKKtvlXObQJtLsHl1KjLZQfuh3USkL20BpGsFzRZt9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HCkpsK/h; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HCkpsK/h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg55k5Ts8z2ywy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 01:56:42 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1p3Z2666403;
	Wed, 9 Sep 2026 15:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M1i9Hk
	CA5SibhqxKrLMuCe+6wm+knIMfN2K/CAmeUZo=; b=HCkpsK/hVuVV8YCMqjg9aS
	QI+707ePalZpWpCkqHV2z3OagP3zEWjswjECg4y1rfqUcYzoW/bQ1Cq9jwNQemHU
	zjtjZGjnLB88GyOl+TfLcRoM3C5aB8LAgH0Wuo9ujVgoJy0Y9k1cGExS9TMke5/2
	d6rAQ/EPvXCu4O6+gC7vVnY1aFiZ5rdPkjSt4HlwZHVyxn5oynEvrtTqTZrRjgKd
	g7/545ViBSj4obDUt5seecZskBAXzxSZfdxxMcXbxUW8cIzMB+aJSrQ2KsFRy+gd
	v3ECiUqbk2SZM4rTwmAtSmams60miQkZd8w4ddoczASADCg5pgmJSiTJjELeoYiA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrxj4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:56:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FuEL6001921;
	Wed, 9 Sep 2026 15:56:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwswb8d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 15:56:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689FuOWw31195606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 15:56:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF6922004E;
	Wed,  9 Sep 2026 15:56:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FC282004D;
	Wed,  9 Sep 2026 15:56:14 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 15:56:14 +0000 (GMT)
Message-ID: <1fc2f486-36b5-4a95-a210-e70d78b67338@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:26:10 +0530
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
Subject: Re: [PATCH v2 08/22] coredump: move the negotiated mask into struct
 coredump_params
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
 <20260820-work-coredump-sparse-v2-8-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-8-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa181ab cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Zvs0_6I7fa5tafyXOHkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX4UW7byvbLb9X
 yl44TRsxPTfuW61RIeI4fNU9HNiGkR9tvJBssLdA/OcuST64Mg9+/U35E/kuiZ+bay9kqTzGUqL
 XTmR28QxZQ99e7jm4lbPv9jgcumtccs=
X-Proofpoint-ORIG-GUID: khUfhjhd0bLQQ1AK7eW2f3qhMBOTFpZa
X-Proofpoint-GUID: XdlbTI9Wr_JBJ4U8I9V5hxgqtptqgQFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX2IsPz1cSw3Bs
 wsfaO3c/+cr/8ALaVpaCZOU2H2GU5fX7M5rV7rUCKPmpXVN0IvfABPZZUSsb9xzlQ9W3PlpC2Mq
 5AyMPgld6z58xKpp+PtnI0xqfublgYk/VV4iK8PZI22+mF/ZVsIbuJKk1ydgY/DfJkjsOxDaChD
 jhWQygUiQkdirX8Epwt8XBZUQAxAVFoYO9kmsCJJ/9tVBf6PCfru6nDCyrCOhKlVCVgQeKwQ4RC
 PMK6Eop1u2B9gUlCsj3Z5igtPxgiH0cITNsZlUbbjjYyFMqPqL1WI2dCEXaKaPYPoAN5Nv5zhRM
 JHl3e9NnBJ885zZw6sjdzrWMAlhjbb9SB8b/SZYV88GOXLWsZJDfvCweMGi9XxpmaW1MIXVWO9W
 M17TBFUiniw/UpaBJORevN8JVy9ihSRhuzhRyXOTk1RklLA3s2IvkKKSbFFBBHQksgzD5E8knKY
 Qd+2AtVFardE/mZDNbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090173


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> The coredump server negotiates a set of COREDUMP_* options with the
> kernel. The core dump path cannot see them though.
>
> Move the mask into struct coredump_params to make them available.
>
> No functional change.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   fs/coredump.c            | 15 +++++++--------
>   include/linux/coredump.h |  2 ++
>   2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index c696b46c97ff..156688be3df0 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -100,7 +100,6 @@ struct core_name {
>   	unsigned int core_pipe_limit;
>   	bool core_dumped;
>   	enum coredump_type_t core_type;
> -	u64 mask;
>   };
>   
>   static int expand_corename(struct core_name *cn, int size)
> @@ -245,9 +244,9 @@ static bool coredump_parse(struct core_name *cn, struct coredump_params *cprm,
>   	int pid_in_pattern = 0;
>   	int err = 0;
>   
> -	cn->mask = COREDUMP_KERNEL;
> +	cprm->mask = COREDUMP_KERNEL;
>   	if (core_pipe_limit)
> -		cn->mask |= COREDUMP_WAIT;
> +		cprm->mask |= COREDUMP_WAIT;
>   	cn->used = 0;
>   	cn->corename = NULL;
>   	cn->core_pipe_limit = 0;
> @@ -860,7 +859,7 @@ static bool coredump_sock_request(struct core_name *cn, struct coredump_params *
>   		return false;
>   	}
>   
> -	cn->mask = ack.mask;
> +	cprm->mask = ack.mask;
>   	return coredump_sock_mark(cprm->file, COREDUMP_MARK_REQACK);
>   }
>   
> @@ -1129,7 +1128,7 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
>   	}
>   
>   	/* Don't even generate the coredump. */
> -	if (cn->mask & COREDUMP_REJECT)
> +	if (cprm->mask & COREDUMP_REJECT)
>   		return;
>   
>   	/* get us an unshared descriptor table; almost always a no-op */
> @@ -1137,13 +1136,13 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
>   	if (unshare_files())
>   		return;
>   
> -	if ((cn->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
> +	if ((cprm->mask & COREDUMP_KERNEL) && !coredump_write(cn, cprm, binfmt))
>   		return;
>   
>   	coredump_sock_shutdown(cprm->file);
>   
>   	/* Let the parent know that a coredump was generated. */
> -	if (cn->mask & COREDUMP_USERSPACE)
> +	if (cprm->mask & COREDUMP_USERSPACE)
>   		cn->core_dumped = true;
>   
>   	/*
> @@ -1151,7 +1150,7 @@ static void do_coredump(struct core_name *cn, struct coredump_params *cprm,
>   	 * or usermodehelper to finish before exiting so it can e.g.,
>   	 * inspect /proc/<pid>.
>   	 */
> -	if (cn->mask & COREDUMP_WAIT) {
> +	if (cprm->mask & COREDUMP_WAIT) {
>   		switch (cn->core_type) {
>   		case COREDUMP_PIPE:
>   			wait_for_dump_helpers(cprm->file);
> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
> index 7b38ee2e7913..dc7a05b1bb0a 100644
> --- a/include/linux/coredump.h
> +++ b/include/linux/coredump.h
> @@ -26,6 +26,8 @@ struct coredump_params {
>   	/* Snapshot of dumpable at dump start. */
>   	enum task_dumpable dumpable;
>   	int cpu;
> +	/* COREDUMP_* options negotiated with the coredump server. */
> +	u64 mask;
>   	loff_t written;
>   	loff_t pos;
>   	loff_t to_skip;
>
-- 
Thanks and Regards
R.Nageswara Sastry


