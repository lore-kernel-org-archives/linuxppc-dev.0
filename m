Return-Path: <linuxppc-dev+bounces-26974-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D2FC79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:04:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg5G94TzBz2yvT;
	Thu, 10 Sep 2026 02:04:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969841;
	cv=none; b=bEP9JL9shNSaDH6wXMHkQai2JWdStaig6qjqB+bDnd6bn4170/llacf4zdhqt2oJIhWrNtJ/9WQMvySHslj0BgY7/sfqYhoNYzrlihpbJt9KF/UhHtiZX0EJAmt4UdTFqwE5ue7xqOE19WfO4UOXqZdrybz1kMPGMiboy9aHtUEM19U+p+qUNf90jd8OS5ttlPBX24HD6dRVI5FvUI/cVpKCsidJ4s6J/6qe73A9ok+tNxArTbHZByYzXfnKfvN7vsBA75jtm8r/2eyPBfG6J+YYioE40vHbLu88SBCJgdwsuaCbY0DOLCtdmSd7hPLvop9iJ54fisMEdZbfhOHLJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969841; c=relaxed/relaxed;
	bh=zpZ5q3Lvg1xWvJoeiUqhzWHsHj4i78kGVmqWnhEJ2ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BBDF/tN2nP5g/UGBVRbGReTGD5/Zg3LP5/jp6EQY7c8YaefC7JnpvcZzrjrnddgEHby3x1qKfp8Q/yY5gaaeJdA71rZVihX9sHCcYL6kkNw41PWvRulpbOnsKYAJ5XcoVod9JooCzqgEfYgse3ssIKRVA6w2Jd1Ub/gGAh1YB8Vjiuz820R7ZHVH3y9GuDaWV1vKJdn6VqwuS/Cp5J1lFl9TyjPmAjey42QERWb8y5Nk7k6Cqtva8DB+Vh4C/KXmiZY73UNe0Hz1r0pePiHg23Durj3HKxE+VKfICF//qgRkwcDLLD2TmbiW4alLEKH0njChvrpl54v0syGLn6Fw8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xj49+7p3; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Xj49+7p3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg5G46hmSz2yvK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 02:03:56 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1OVk3817316;
	Wed, 9 Sep 2026 16:03:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zpZ5q3
	Lvg1xWvJoeiUqhzWHsHj4i78kGVmqWnhEJ2ek=; b=Xj49+7p3CQIuyMjDzhWkDT
	acXUrW4z2wbuxUl1UruUzOsA5UKUkywcX/lbZXAC/BgZ8KXUQNyP+p0oMSNzS4hQ
	P45VUu9cxHi7naxbGFwhijuYCkVBlZ4/UNxhRI8addOAULPA8e+GpAdP8TfT94ik
	RCPluT2QfPcfyAzQSXLp/4IgAtnhL4WopnVVq7XMnwcrR91fgUQdp/cFWaCujzZe
	9NlMY2hQXmjP1zvuM0WGm8P1xeyBHxlYVZN0VNsUJCHLlN8h2cjCTu3AAYnrLK44
	8kGqOYAvX3IBXr3SujjrPkJmDLFLvMLXKzQJMl4QprzKfOs9asabigzWoiqHRTZg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf46yqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:03:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FuDmP021631;
	Wed, 9 Sep 2026 16:03:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymgk1f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:03:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689G3d2m33947968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:03:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F38802004D;
	Wed,  9 Sep 2026 16:03:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 220BB2004B;
	Wed,  9 Sep 2026 16:03:27 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 16:03:26 +0000 (GMT)
Message-ID: <7ec296b3-d8d7-4f91-b11a-a45fb00ff09c@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:33:23 +0530
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
Subject: Re: [PATCH v2 15/22] tools: sync coredump.h header
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
 <20260820-work-coredump-sparse-v2-15-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-15-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 6aQP7RI23GsyiSTQxkmoZ8lYiasD9746
X-Proofpoint-GUID: GFhov3K0UmVXEfyAMfX4ZnwEW8QovGEE
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa1835e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=n8dau6vL6JnBemzV1-QA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfX6Ur+0N0pYynt
 vegJ8soGrYaGT+KupMFmH10QLeNcF3UgE0oahEn1xXRDPYCblxxBhkQ33014b8mFxD+JHguh9s5
 6OsURWVYHfO8dscojcNOVExxliVbWkTPvImReR+k0LuWND+Cizy3K7fevpz/K9xZbny9hzWy/Sm
 yQAL9JKmhj348SMDdND8WvXMbqLtDKvPVqQopDurIM7vuvIZtAsakAQwRlP8zJkPtC27EcMfsti
 s7lLrFovjfcW+UCDIvllFQR6shanqkhLefblN655wQ7xxlV9IloQfOJCDjAy1oR/oyOhd3MrBIW
 1Bi4tM6WsdfiNnRC4r3nhVJ5TgI7ew8EWaLI++thiizxf7/uqeCy9PGiBqloV4PbViJ/tN7i5VY
 gW/ZZnkR/MYPn1x/IiwwzU+cwkgiHOKv7BmnTCmoGSm6wQBo1rgvorA8mepj7BWg2rWGpd48ptE
 /Kp4wjQBP50MvLYpRSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3OCBTYWx0ZWRfX/W3uIapjP2UV
 EdBAsP0J8GXmhW6MSt9dyqD2/H6Zn1/aY5YnaYUSdwlO6L/hyMfiiqR9aEDKoawKpf0bQ5DVQCv
 t53HB/+NhRx4a12TKg0chm/gk7pjzvE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090178


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> Sync the headers for the selftests.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   tools/include/uapi/linux/coredump.h | 79 ++++++++++++++++++++++++++++++++++++-
>   1 file changed, 77 insertions(+), 2 deletions(-)
>
> diff --git a/tools/include/uapi/linux/coredump.h b/tools/include/uapi/linux/coredump.h
> index dc3789b78af0..f3771861ca48 100644
> --- a/tools/include/uapi/linux/coredump.h
> +++ b/tools/include/uapi/linux/coredump.h
> @@ -11,12 +11,19 @@
>    * @COREDUMP_USERSPACE: userspace writes coredump
>    * @COREDUMP_REJECT: don't generate coredump
>    * @COREDUMP_WAIT: wait for coredump server
> + * @COREDUMP_RECORDS: send the coredump as a sequence of records instead of
> + *                    as a plain byte stream, see struct coredump_record_header;
> + *                    requires COREDUMP_KERNEL
> + * @COREDUMP_SPARSE: describe the holes in the coredump as zero records
> + *                   instead of transferring them; requires COREDUMP_RECORDS
>    */
>   enum {
>   	COREDUMP_KERNEL		= (1ULL << 0),
>   	COREDUMP_USERSPACE	= (1ULL << 1),
>   	COREDUMP_REJECT		= (1ULL << 2),
>   	COREDUMP_WAIT		= (1ULL << 3),
> +	COREDUMP_RECORDS	= (1ULL << 4),
> +	COREDUMP_SPARSE		= (1ULL << 5),
>   };
>   
>   /**
> @@ -30,11 +37,11 @@ enum {
>    * member is set to the size of struct coredump_req and provides a hint
>    * to userspace how much data can be read. Userspace may use MSG_PEEK to
>    * peek the size of struct coredump_req and then choose to consume it in
> - * one go. Userspace may also simply read a COREDUMP_ACK_SIZE_VER0
> + * one go. Userspace may also simply read a COREDUMP_REQ_SIZE_VER0
>    * request. If the size the kernel sends is larger userspace simply
>    * discards any remaining data.
>    *
> - * The coredump_req->mask member is set to the currently know features.
> + * The coredump_req->mask member is set to the currently known features.
>    * Userspace may only set coredump_ack->mask to the bits raised by the
>    * kernel in coredump_req->mask.
>    *
> @@ -101,4 +108,72 @@ enum coredump_mark {
>   	__COREDUMP_MARK_MAX		= (1U << 31),
>   };
>   
> +/**
> + * enum coredump_record_type - Type of a coredump record
> + *
> + * @COREDUMP_RECORD_DATA: the header is followed by ->len bytes of data
> + * @COREDUMP_RECORD_END: the coredump ends here, the header is not followed
> + *                       by any data and no further record is sent
> + * @COREDUMP_RECORD_ZERO: the header stands for ->len zero bytes and is not
> + *                        followed by any data
> + * @__COREDUMP_RECORD_TYPE_MAX: the maximum coredump record type value
> + */
> +enum coredump_record_type {
> +	COREDUMP_RECORD_DATA		= 0U,
> +	COREDUMP_RECORD_END		= 1U,
> +	COREDUMP_RECORD_ZERO		= 2U,
> +	__COREDUMP_RECORD_TYPE_MAX	= (1U << 31),
> +};
> +
> +/**
> + * struct coredump_record_header - header of a coredump record
> + * @size: size of struct coredump_record_header
> + * @type: one of enum coredump_record_type
> + * @flags: modifiers for this record
> + * @offset: offset in the coredump this record starts at
> + * @len: number of coredump bytes this record accounts for
> + *
> + * If the coredump server raises COREDUMP_RECORDS in coredump_ack->mask
> + * the kernel doesn't send the coredump as a plain byte stream. It sends
> + * a sequence of records instead. A COREDUMP_RECORD_DATA record is
> + * followed by @len bytes of actual coredump data. A
> + * COREDUMP_RECORD_ZERO record is followed by nothing and stands for
> + * @len zero bytes. A server that didn't raise COREDUMP_SPARSE never
> + * sees a zero record. Records arrive in order and leave no gaps. So
> + * @offset is the sum of the @len of all records before it.
> + *
> + * The last record is a COREDUMP_RECORD_END record. It is followed by
> + * nothing. Its @len is zero. Its @offset is the size of the coredump.
> + * The kernel only sends it once it has written the whole coredump. A
> + * server that hits end-of-file without having seen an end record must
> + * treat the coredump as incomplete.
> + *
> + * The @size member is set to the size of struct coredump_record_header
> + * the kernel knows and lets the header grow later. It comes first so it
> + * can be peeked. Userspace must consume @size bytes and discard
> + * anything beyond what it knows. It must refuse a @size smaller than
> + * COREDUMP_RECORD_HEADER_SIZE_VER0. @size covers the header alone.
> + * @offset and @len count coredump bytes.
> + *
> + * The @flags member carries modifiers that change how the record is to
> + * be interpreted. No flag is defined yet. Userspace must refuse a
> + * record carrying a flag or a type it doesn't know. Every new record
> + * type is raised in coredump_req->mask as a feature of its own. A
> + * server only ever sees the types it asked for.
> + *
> + * COREDUMP_RECORDS must be combined with COREDUMP_KERNEL, and
> + * COREDUMP_SPARSE with COREDUMP_RECORDS.
> + */
> +struct coredump_record_header {
> +	__u32 size;
> +	__u32 type;
> +	__u64 flags;
> +	__u64 offset;
> +	__u64 len;
> +};
> +
> +enum {
> +	COREDUMP_RECORD_HEADER_SIZE_VER0 = 32U, /* size of first published struct */
> +};
> +
>   #endif /* _UAPI_LINUX_COREDUMP_H */
>
-- 
Thanks and Regards
R.Nageswara Sastry


