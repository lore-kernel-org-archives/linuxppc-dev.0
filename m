Return-Path: <linuxppc-dev+bounces-19925-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C68AF94CC2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Apr 2026 04:49:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0mx10TgZz2yZN;
	Wed, 22 Apr 2026 14:49:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776833396;
	cv=none; b=B0pXA6xCzZ8TkWGjGEh103PoaIP6V+3ZRhHqoXJU5RbecjQS3mMPNWUZDhTtQHZodqNu1bNang43YQ/YTKTzeSS5XaddUqXYplJj3dvDosnIFHW3+LYLJAD41iz04OAmohpd0Z+N9Ta4B1lmIdCUAwZejtVXv6aDEvmCXTSYqUFMHZNmUDrdfoTploUOwIGnbprw+jjkTQdF186ZFG+8lz3x6e1M0qrbTqNAK3xmfCwBqoXEDP7Ub9C/TJghhw7I6Jmid9fQm3Fe3eCy3mRiIod0d5VhCUmhPHEA7+I5E60Unit69vfcVre3SbAO7ABnDp+Q5x3Ro8Ms7aKKr1o+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776833396; c=relaxed/relaxed;
	bh=xyO9lcFOa/B7lzH+5glUJdxPtE81+vdtyN6UH3mxcV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqdgGkZrJ+gxqRc+G60siq2KF+aTt1pHnIH9NFluuY2PewmlcdY9HkTL45XrfLbu+zFFrXt9zvISZQgFKdcQLjhhPPdaaTjRPlEpVLHcWcHD55tS0ZOCGt301kyOx4uKYuV8ykmDyNxJsBdbsetaNnd0Hk2ZDpywKoa2ui/X+3Wx5Gt1Ao+aV77e32jzA5y6WlTa0gtK+RebM6nDjVX3E+gY7jUilK84fOYQyyw+axmeXLR1g71H3itl1oBeCFLuUCPaPK27XXdOR2wSbM0BF6AsXGWhmsHoBTm4MERYStDCVQot+1RPo6F1+1mMPiTcrQnDYVM+p9XaI1SoghDtHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LEiJQ/dU; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LEiJQ/dU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0mx00Cn6z2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2026 14:49:55 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIlpce970327;
	Wed, 22 Apr 2026 04:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xyO9lc
	FOa/B7lzH+5glUJdxPtE81+vdtyN6UH3mxcV8=; b=LEiJQ/dUQudKh1HDt2w78e
	g14MsHAgLNtT/SGVS1mKc21tHGIFeVgZjxJYY6zIL3DZF3v/lGzfNrNb6zSVpJj6
	H7XllaOnnQ6YjcgqV4hJLp57AL3KW4eFR18V/c6SzfFgE/AJDUvXwLBnfvvVb6Rw
	noErrpk/+GBI0iyYF+VrbeCbOA8rdr+tfC8FBnsCjeYW4PO8SW2wjGR10NsgsKdR
	lDg/D8a1PjS/0KFyXMWYbZRnggXb/v0CVcGqJWJ+gLqPeh1th/v+Egb4GvQhBFpj
	3nW6aespZMI2Dr1IgEfUndgshvxiPNCxMMszD6S54e+yreYlw+G9nx0tevvsVsDw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu3hhr0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 04:49:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63M4ZSkq001191;
	Wed, 22 Apr 2026 04:49:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky0tb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Apr 2026 04:49:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63M4nYg745351244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Apr 2026 04:49:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0307720043;
	Wed, 22 Apr 2026 04:49:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64D5320040;
	Wed, 22 Apr 2026 04:49:32 +0000 (GMT)
Received: from [9.123.14.230] (unknown [9.123.14.230])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Apr 2026 04:49:32 +0000 (GMT)
Message-ID: <e12d9620-4581-4867-bb8e-3a68f74d6045@linux.ibm.com>
Date: Wed, 22 Apr 2026 10:19:31 +0530
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
Subject: Re: [PATCH] powerpc/pseries/lparcfg: size the scratch buffer to the
 system parameter payload
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, maddy@linux.ibm.com
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, kees@kernel.org,
        srikar@linux.ibm.com, nathanl@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260401160316.88551-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260401160316.88551-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: CUynIvg6OF1Okb36_nayh_yPMFqePo9P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA0NiBTYWx0ZWRfX53Lr7Dg/apNb
 02wGc1+uD6SzfK9fAEyhpR2Dc/m2zz9WzDOxgJ8k/sdWq3PqQHYSXsE7SJ8bj3fbm6kZiWuBJRr
 7sj3m0nbOiAemjHYRQBYUTH/3m+G+/TEdcfoIiWm0VrAsPFwIu5DAuLhGR0tDpsaQgBFPevHJbU
 XtHXWnSQMbcdmjZMT3zSLi9lXCF7VoB2KzSC1+p0zg6v3n2H6+d6miTHgACN+vsWF0lTZIUgUdj
 lr5+ISSZaNVxhSfUmqIy7er6qXG4S9VhrUbyDXJarMAbgcZ3I9pvjbmu4Xw6bjOlmL0pE0gJMCb
 LXFnpboVJWtOVNLA3UA7iREiRvjSDuQRQuf5Q/sYO73h9sFZyCJMcucZ0SWPk5+L1ga7evOhHI0
 NnLiZabXJS67dYeAYiKwqqvTviRfey/Kj7cH2UYzcjc1FDWrGjBBGZooXBADEZa2PRKnJ9ZmX6P
 UlmFy/KFKOeD62Czq3g==
X-Authority-Analysis: v=2.4 cv=a6kAM0SF c=1 sm=1 tr=0 ts=69e85362 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=T8gcFfjw_zj36hfkXUkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fvridPnHijkGuQZXFXKX3aThw3_XIlYE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220046


On 01.04.2026 9:33 PM, Pengpeng Hou wrote:
> parse_system_parameter_string() reads the shared processor LPAR
> attributes into a firmware buffer that can hold up to 4000 bytes, but it
> still tokenizes that payload through a fixed 1026-byte scratch buffer. A
> single long key-value fragment can therefore overrun the local parser
> buffer before the next comma delimiter is seen.
>
> Allocate the scratch buffer to the current payload size so tokenization
> stays within bounds.
>
> Fixes: fff9846be00c ("powerpc/pseries/lparcfg: convert to papr_sysparm API")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---

Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested with different sizes of the buffer namely 1000, 1026, 1500, 2000, 
3900, 4000, 1027, 3500 with a sample test kernel module. Using the same 
module injected the text with the above sizes in to lparcfg
Example:

system_potential_processors=8HIJKLMN...GHIJK

>   arch/powerpc/platforms/pseries/lparcfg.c | 23 +++++++++++++----------
>   1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
> index 8821c378bfff..c09f474c241e 100644
> --- a/arch/powerpc/platforms/pseries/lparcfg.c
> +++ b/arch/powerpc/platforms/pseries/lparcfg.c
> @@ -385,8 +385,6 @@ static void read_lpar_name(struct seq_file *m)
>   		read_dt_lpar_name(m);
>   }
>   
> -#define SPLPAR_MAXLENGTH 1026*(sizeof(char))
> -
>   /*
>    * parse_system_parameter_string()
>    * Retrieve the potential_processors, max_entitled_capacity and friends
> @@ -407,27 +405,32 @@ static void parse_system_parameter_string(struct seq_file *m)
>   		const char *local_buffer;
>   		int splpar_strlen;
>   		int idx, w_idx;
> -		char *workbuffer = kzalloc(SPLPAR_MAXLENGTH, GFP_KERNEL);
> -
> -		if (!workbuffer)
> -			goto out_free;
> +		size_t workbuf_size;
> +		char *workbuffer;
>   
>   		splpar_strlen = be16_to_cpu(buf->len);
>   		local_buffer = buf->val;
> +		workbuf_size = splpar_strlen + 1;
> +
> +		workbuffer = kzalloc(workbuf_size, GFP_KERNEL);
> +		if (!workbuffer)
> +			goto out_free;
>   
>   		w_idx = 0;
>   		idx = 0;
> -		while ((*local_buffer) && (idx < splpar_strlen)) {
> +		while ((idx < splpar_strlen) && local_buffer[idx]) {
>   			workbuffer[w_idx++] = local_buffer[idx++];
> -			if ((local_buffer[idx] == ',')
> +			if (idx >= splpar_strlen ||
> +			    (local_buffer[idx] == ',')
>   			    || (local_buffer[idx] == '\0')) {
>   				workbuffer[w_idx] = '\0';
>   				if (w_idx) {
>   					/* avoid the empty string */
>   					seq_printf(m, "%s\n", workbuffer);
>   				}
> -				memset(workbuffer, 0, SPLPAR_MAXLENGTH);
> -				idx++;	/* skip the comma */
> +				memset(workbuffer, 0, workbuf_size);
> +				if (idx < splpar_strlen)
> +					idx++;	/* skip the comma */
>   				w_idx = 0;
>   			} else if (local_buffer[idx] == '=') {
>   				/* code here to replace workbuffer contents

-- 
Thanks and Regards
R.Nageswara Sastry


