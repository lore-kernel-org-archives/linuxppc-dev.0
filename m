Return-Path: <linuxppc-dev+bounces-26967-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38B1C79FB6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 16:01:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hg5Bq32xMz307v;
	Thu, 10 Sep 2026 02:01:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788969667;
	cv=none; b=BwHxgSaR7F4D2X423lQkSUybq1F3pKUgvxiM7daAojf/Ip0l9GtWWs3oukWK/M6PN/RbXwne9K+r4/HlUcVHRGamcau9XHw6tVf6MNZXSOocqjM1E0O4FyQRMe6r5KD1B19SQARttcnCozo5aZBQK1p8gUjrBpm8BhbpDFgzNzyj4SL0/v4fACSg0FPxqai9eek9DT86YDLBKVKLvmO3zECHLbbXVCubawh0iCrs2IZLvPcRjKP97NO7hOMhNTUIR8Fquep7in8478P2cWKX4MI0r367mp5MbnkvBd0jjoMwZ50VwlsmqJeZLdB4dVQUpMy8dCPa4LSJm4It3U4IBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788969667; c=relaxed/relaxed;
	bh=00JU/j/v+DQy0zd7AxUZ9dWcvelnFmS2j8kJVfQrbIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kac8ghJMHIm1DhYMVFAcRQbVGxOgHzhm+Aydzwai2v/KL5a+60pAftn823S69necaDoJwsyxjlAOwxfjXbGBC7WTSFDzkKW00Zsg0zK7EqWqJnDLGpMdzarJteOHqQsUvMEm5Qgrhf1ZahWEOVT0mlRtmCHf7x+L//BmSMikX+YeKn2RjV7ysHUT7ShyWKSY541pve16wTpJE1h3zE6RoZz1uyZ+bPlL86dr0cFrrqYA0zC4x9tY4uovz+f2HfjwxIaCDVRxwQL3eVpJRvL7f2HhB5KBAgP7tHshb/LSNZVGtXecauqxSsPcUzS5s8uNU5GMfMYvV71m9QftBpy16g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TCRP94SY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TCRP94SY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hg5Bn47SGz302T
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 02:01:05 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689B1RXR3817363;
	Wed, 9 Sep 2026 16:00:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=00JU/j
	/v+DQy0zd7AxUZ9dWcvelnFmS2j8kJVfQrbIQ=; b=TCRP94SY0JQW+S+PR540yU
	u/lnGUruItr+yZJ8X2SS9trYAqJ5WEcHubrqfQjfVHOhb8tVlMTk1YiNZHOyWMQZ
	Fp/90cFh4QWFO6uSqV8YSFTGD4nlRRLPlL3Fh2NLOMFzNK9zNXZcu7EQ1yJY0O2f
	p9RnrmEihlwh4ZzfrFyPCw1Skf2yfri9pRZb5qYGP1b+yeeM9A3K6a/3Y0Bry9re
	G1dP/e8+Smt9Zvmv5itpSwDcz3kNGNNUK1GkSx00YAnG+MHFjfPeJIVH/iJ76zIH
	m8keWUtjRQwuhs2Bx+ITGBT0CbU8jYF5uD7lWfhMHN/WYUeqGm2vEBQLa8vr6Zkg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf46y64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:00:48 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 689FuLt0015882;
	Wed, 9 Sep 2026 16:00:47 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yjy97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 16:00:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 689G0jcA35717428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 16:00:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E333B2004D;
	Wed,  9 Sep 2026 16:00:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CA3C20040;
	Wed,  9 Sep 2026 16:00:35 +0000 (GMT)
Received: from [9.61.255.18] (unknown [9.61.255.18])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 16:00:34 +0000 (GMT)
Message-ID: <96f4e19c-26d6-481c-b7b3-0a2aa244c834@linux.ibm.com>
Date: Wed, 9 Sep 2026 21:30:31 +0530
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
Subject: Re: [PATCH v2 11/22] coredump: always chunk writes
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
 <20260820-work-coredump-sparse-v2-11-ba32dd718c51@kernel.org>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260820-work-coredump-sparse-v2-11-ba32dd718c51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3nsD3dyD9YpDNwrNy79mh4k3ZJgZAoAH
X-Proofpoint-GUID: 5Ftz_v8DnqJwrQicAaxaxCLwd-1LE4ML
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa182b0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=uNwIYxRw8H9XJLvQjW8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfX63FEwKXn2pEz
 lbN9cHVZiZXHc6txdAexnXMJtgrSfc5kgQl/RQL8aZJ3oiw7NqTF/WCwpFMjKmwq5NLNAZGgf7Q
 Hos7o2aQf/uCGOISPuipeIO0MunRkNE9zvUd5wusnjKNruB11Hx/j+gFzlJp3hJieicpYa+eeNs
 VkPI2SMmIPn7I8IL8WFtQVjvsWoy1UeU+NFUVDQ9KSshErJfbe9cDG4v706+PSGMOWzSjuy2imC
 9rWzGxzVCn+WakqwhrsdV1oF+VDabMe2ZSGc8J+rU+SeWGZOzqQ4nHzexEQxcNU7ZreEcsXHjqT
 vnXmtYO1/SidK4tC78nZhlCXtSFAnu9ZuG6T+KEDlEJGJ1VsWRB5SVXl0be+AWY/znuXep8HXml
 ttmhJajuNA1n59oxzUkxRDb3KE0j9eapA5s1nPeKFV5w3rVkfbJFceEiLji4I9KbtpKV+mI6BiC
 6wZ/lWkQABb3bef66Dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE3MyBTYWx0ZWRfXxpDMqZtbveKw
 EOHJ1ijEo1wcbWvww4tsJatXr/zaCikRtHGXSA8SYhI/DW4OjGh4H87T7udcjzwwogzipPCpPGc
 TkIi4XOACd8bpzimfR/h+x2eYMoJeMY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090173


On 20.08.2026 4:39 AM, Christian Brauner wrote:
> Right now dump_emit() is the only coredump helper that writes buffers
> larger than a page in one call. For elf notes that can easily blow past
> PAGE_SIZE. That's annoying because neither pipes nor af_unix sockets
> take such writes in one piece.
>
> If a signal arrives while the writer is waiting they drop a short write.
> With the coredump records work coming up that means header and its data
> are desynchronized. A write that fits in one pipe buffer or one skb
> doesn't suffer from this.
>
> So split all writes up, including elf notes, and cap every write at a
> page. The coredump socket already raises sk_sndbuf far enough for a page
> to fit a single skb and pipes always work that way.
>
> That means dump_interrupted() is now checked once per page. So a large
> coredump stops earlier (good). An empty write no longer issues a
> zero-length write. The rlimit core check stays where it was. It
> continues refusing whole writes.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   fs/coredump.c | 37 ++++++++++++++++++++++++++++++-------
>   1 file changed, 30 insertions(+), 7 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index d837819031ff..d61f36239f91 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1215,19 +1215,21 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
>    * do on a core-file: use only these functions to write out all the
>    * necessary info.
>    */
> -static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
> +/* One write, never more than a page. See __dump_emit(). */
> +static bool dump_emit_chunk(struct coredump_params *cprm, const void *addr,
> +			    int nr)
>   {
>   	struct file *file = cprm->file;
>   	loff_t pos = file->f_pos;
>   	ssize_t n;
>   
> -	if (cprm->written + nr > cprm->limit)
> -		return false;
>   	if (dump_interrupted())
>   		return false;
> +
>   	n = __kernel_write(file, addr, nr, &pos);
>   	if (n != nr)
>   		return false;
> +
>   	file->f_pos = pos;
>   	cprm->written += n;
>   	cprm->pos += n;
> @@ -1235,6 +1237,24 @@ static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
>   	return true;
>   }
>   
> +static bool __dump_emit(struct coredump_params *cprm, const void *addr, int nr)
> +{
> +	if (cprm->written + nr > cprm->limit)
> +		return false;
> +
> +	while (nr) {
> +		int chunk = min_t(int, nr, PAGE_SIZE);
> +
> +		if (!dump_emit_chunk(cprm, addr, chunk))
> +			return false;
> +
> +		addr += chunk;
> +		nr -= chunk;
> +	}
> +
> +	return true;
> +}
> +
>   static bool __dump_skip(struct coredump_params *cprm, size_t nr)
>   {
>   	static char zeroes[PAGE_SIZE];
> @@ -1247,13 +1267,16 @@ static bool __dump_skip(struct coredump_params *cprm, size_t nr)
>   		return true;
>   	}
>   
> -	while (nr > PAGE_SIZE) {
> -		if (!__dump_emit(cprm, zeroes, PAGE_SIZE))
> +	while (nr) {
> +		size_t chunk = min_t(size_t, nr, PAGE_SIZE);
> +
> +		if (!__dump_emit(cprm, zeroes, chunk))
>   			return false;
> -		nr -= PAGE_SIZE;
> +
> +		nr -= chunk;
>   	}
>   
> -	return __dump_emit(cprm, zeroes, nr);
> +	return true;
>   }
>   
>   /* Flush the accumulated hole before writing data. */
>
-- 
Thanks and Regards
R.Nageswara Sastry


