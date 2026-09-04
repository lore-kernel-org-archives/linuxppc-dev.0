Return-Path: <linuxppc-dev+bounces-26527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89F67C61DD3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 06:15:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbmRN13Y3z2y2b;
	Fri, 04 Sep 2026 16:15:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788502528;
	cv=none; b=LCSQSFOVTYMBIFZLfrJWkGQVXmV1sFe049w1aPe3FK8B5jHYDS8z0fpx/Z+ejaQU4wvw3II6VnaH3zMthWGbe0lJrIVUQYsj+/zcWY6cEbS0nj0ihrXW2QdHietMAZxIcCkTxApENDr+ZGZ0+DOTWKpCa45N5ITpl8k3SkEpUTpZq/WZdINRD3deSx+tN6sc4W+jcZJPAE8BaXnHATtwKaYBoBLaq8puDL0Vq4XWbUYU4nOjAOLVQgfYT1NcNlBwvmTG2+/SwbJPwcBLLjMhEhM8sgBvMrbSG3UsFjO7UTyeoq8xy4pNCnvOF07FiWvuRB2FGA8bq3z/YZvpnA9x/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788502528; c=relaxed/relaxed;
	bh=Zs+bfGsceV55tHLs8SsiQNaKNP5DpPT1h08NiQJeLmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFUYyjFQvLA2pW4I6fq9oGol0qsunIXJtGwfD6zHcgQDjYdYZfoRIG4zuQiPxulsmswiN2k37vniEBkf8EBq2Kznrl9rXFTykj1jhrzthRShRHdhnmpcf0VZim62fBOa6VxMnuSbDQhn8ovCRHwPAbpKQZu3Ve8K2qA1XhEd7scmb3BK2Xt+hZVviCp0rHTlxNQJGoh7PlpIheDaeoctrMj1PI14tzb1hwvPrwrTwUyWK1NiOMsEHwk3VQ7luE4zFhIBo65IO8DGU7AYmI3vYgA+GM/uX0mpC0By00mEKdfpInhn6NPNzSm26u+lPKjbvpYK+Uz3qJJ0IQh/xCt26w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kys6+e3P; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kys6+e3P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=rnsastry@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbmRM1hzvz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 16:15:27 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464K3D936887;
	Fri, 4 Sep 2026 06:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Zs+bfG
	sceV55tHLs8SsiQNaKNP5DpPT1h08NiQJeLmw=; b=kys6+e3PJSyHnYq7fzDLKK
	nxLoSQyOeIuSz7fD0Ow2wo/BXlRMIbVS6yBRRyhFObp8nq3uUnD4rdNJRl3m8XRB
	MtHaeTcn2YXyCNpDfUrfGO+HR0rByklLHb53cnAtI1DHSR7jp3HunwOQjFIn9wtM
	JiCvtCgb8OqmdQt0O+oPEN8brRAoQpW42S/LVPmn8CJvSptbxlcd8NA3H4zzLusn
	e03052eoKEdUcYP7kf1VFv8FBPdhHEpPTAt0Fq9lSx0djTsNypV3/Em0gICsGuvc
	KTc09bRS4ypLaGls3YFcHPky8CPkX8aFHRCPqoao+5m8AUZZU7c2Yftu+zGLOslQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx611yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:15:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6846Bhbb004591;
	Fri, 4 Sep 2026 06:15:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjauwc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:15:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846F9M939059788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:15:09 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FC7B20043;
	Fri,  4 Sep 2026 06:15:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 495B720040;
	Fri,  4 Sep 2026 06:15:03 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:15:02 +0000 (GMT)
Message-ID: <2e33d09e-fe99-4ba4-a5ef-d456a8a1c039@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:44:59 +0530
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
Subject: Re: [PATCH v2 06/10] pseries/plpks: fix self-reference in plpks_var
 initializer
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-7-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-7-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9a61f3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=t0uVcPVhsug3MTqwcVsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: lXQqJ2oKxUgKTmmqJZbwtT8LYI6mYxWM
X-Proofpoint-ORIG-GUID: 4Qtsx4D5r3SaZlfsNS9vwQHV4c8k5Yw5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXzewx17SIbfep
 XZajJR3uK4eI1HZkTdj3yqOq5Gal/aSviAHOYZOxpwRmKOPvxsXeKhsm78IhopyNRsl6aju8ful
 1hK+USxRsvnqRQT2+EzrCEGdotf5vPM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX6D6bRr6lv8g/
 +3ELmooVlxITlqaqQNWsJo2mck5veSTyJccfRXaGdXxVUWCEctgjto6xub+Mj1B1ajzWDaXSL9r
 Joeer+aOdicq962qTo3v6cNDVAub3NE4hEGypc3qZ+yfK5w3MN/gIQKBfB9+MRpItvN0ebqbCjE
 +TwZLlgbKc8b1mjoORNLML8T12ZkUv3SVCQunQjphKbnQX+6W9qnyNtHBBOan5nQc/br9k61HjN
 +P4jK9HGLUPc4INMFvIL9eycQzVto1ZMBjtupsngBKg2Jnib0PgSZtZjDMEorHeOmA7d5YDGdFi
 n5LNq0RJlNpWCUxr4DUuSZK5p38RNt899NHb+gYujFYNJqdOQ/FnLydQ3ehMWdE6P8idVWAK0aD
 gRLKlWYQdRg4bF3nx0rpXP6454J6Nce4L8ujm+JezL8T4ShrKkPFrBiiMpEqHMocg9w97IfVs3u
 zMbwvSODqY49lp4ojTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> In plpks_gen_wrapping_key() and plpks_wrap_object(), strlen(var.name) is
> used to initialize var.namelen within the same struct initializer. This
> references a member of var before initialization of var is complete.
>
> Use the compile-time length of PLPKS_DEFAULT_WRAPKEY_LABEL instead.
>
> Reported-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested on ppc64le PowerVM LPARs on firmware with wrap/unwrap support,
with and without Secure Boot enabled.

Verified that PKWM initialisation and trusted key seal/unseal work
correctly with the compile-time label length fix in place.
> ---
>   arch/powerpc/platforms/pseries/plpks.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index b553f7b130b6..d582c786ccad 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -939,7 +939,7 @@ int plpks_gen_wrapping_key(void)
>   	int rc = 0, pseries_status = 0;
>   	struct plpks_var var = {
>   		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
> -		.namelen = strlen(var.name),
> +		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
>   		.policy = PLPKS_WRAPPINGKEY,
>   		.os = PLPKS_VAR_LINUX,
>   		.component = PLPKS_WRAPKEY_COMPONENT
> @@ -1034,7 +1034,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
>   	bool sb_enforce_bit = wrap_flags & BIT(1);
>   	struct plpks_var var = {
>   		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
> -		.namelen = strlen(var.name),
> +		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
>   		.os = PLPKS_VAR_LINUX,
>   		.component = PLPKS_WRAPKEY_COMPONENT
>   	};

-- 
Thanks and Regards
R.Nageswara Sastry


