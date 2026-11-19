Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A495606A336
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 06:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c0ftBqp1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVTW06rcgz2yQl;
	Thu, 19 Nov 2026 17:45:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795070732;
	cv=none; b=Li/5urXs1w7+vq2EOqPN55eQ5nGCliIVvrpNfqdScWKHfXlZBo0YqvztwrSbhAQHDxsZcryF2Nuvs+nTO2Bt+nBWOGhFp2miQ+R9rgz+It2lPJb0IeRiGc8E2r9IT3ee9odGIayGqazF12VLnfWYDrRXab1HjjT6Pmz3ht6r7WWFYkZIerE+3JpjZ34a1oRGm/zgN5qesSl3BtlqYDljv5JYzfnIQtoJUz45Xzwv70mK3+lcrEQsb4fECmMe4Y2Zor2ioUBVuzRZuAr3ajOJjRzoWLlaKhw1m6HUBOVNohtc/S/iKHUHP4zWmy1GVqRR7JgOzPLAI/aBqBsidpFXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795070732; c=relaxed/relaxed;
	bh=FSruOjh0fLceRFxyf0RDLABEXCSb4s/y/6N7UYnOh5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPhsJkHD76aMtj7BQcmeO/czPyyhizXrHjRDY5oRqsT77tTbeBd8buddOmRaB0hN2FCLul1jrWgqH2QbhPdUM+1PnLjznhnkhSJtZNLohBqp53lzVTnRIiZfFZHNIdNXamfOasERVqKhMeTsrNX+M9aiWscvBMT/C3fVraJ7bka9VF6IC6TeCD7kWJ/Xqz52buuZwB20pcQ+yNROiLRN2p94Q0W2f6T364OV99x9CU/OioXu1v9+Y1A2WMhQimVcb6HY60BuU0fdzszVnuKSCajokH7qYLQDXg1E0nP91OYJXlLLTS68hVuPm+YoXvpzCE/qoH1exypvKX4I0ydl3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c0ftBqp1; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c0ftBqp1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVTW00pK7z2xLG
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 17:45:31 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ4igip1960096;
	Thu, 19 Nov 2026 06:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=FSruOjh0fLceRFxyf0RDL
	ABEXCSb4s/y/6N7UYnOh5k=; b=c0ftBqp1FXNC/jLzEoQsFvegPmYnN+JFpOV9V
	sPaBaNZyl6zUXgKTAqzYxznRo3UdbJGekcxpQ8CUNRbE2F1/+7XXw8k5kB6z7JaE
	viR4bQ7/rT634ZzXluE5dvX5EvVYksi7+JEhB1GLgTUlXs4+554x+hpK03EIUfVQ
	GiDYUXdavMooYO6nDfI1zvslxg3Gd/eBobJxaCaDQKbarT6Ze3cEpwk4lvYsGczB
	chaCY9JuSu7/yJF79ThMpnm4aUGjSVk4GLEPilwAGXujLy5lm4DavJz3Id+dbr24
	QXfWyU5UnysFKEPX9damKPyAdTC0oFh8RWfo5bq+5HZFbeFPA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105vxu71-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:45:06 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ51t4C2162884;
	Thu, 19 Nov 2026 06:45:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvnvxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:45:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ6j1VL27984412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 06:45:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7B412004E;
	Thu, 19 Nov 2026 06:45:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31C4D20043;
	Thu, 19 Nov 2026 06:44:59 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 19 Nov 2026 06:44:59 +0000 (GMT)
Date: Thu, 19 Nov 2026 12:14:58 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, christophe.leroy@csgroup.eu,
        maddy@linux.ibm.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, johan@kernel.org, sudeep.holla@kernel.org,
        ritesh.list@gmail.com, tim.c.chen@linux.intel.com, yu.c.chen@intel.com
Subject: Re: [PATCH 2/5] cacheinfo: Support unified caches described by
 d-cache properties
Message-ID: <av6a6sRqMgMXE73n@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20261118163639.890546-1-sshegde@linux.ibm.com>
 <20261118163639.890546-3-sshegde@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20261118163639.890546-3-sshegde@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SeR4n5E2OBjnYr677JqchPglOanyLkkp
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afe9af3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=K4R5E_SnrvZsdrH_wFIA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: wEh1Gb-1JoTJfr_s99OxbTuq4N4692PE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfX510pW7mFYO7w
 PUhF6xk1JvFm2hzRmg1s9w1mobmI4OyWcA6imoAXJYY8v/Fhkr/ZShgjTSzuEX4Mr9SqJACkeps
 Mn1SB4yEwseY+4qW9CY+f4TLHfq/dkY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAyNSBTYWx0ZWRfX2JpfxNPmybsj
 BN3ts8lPcCDesEAKA73vzdVwdscKakKzhLxZlWCVzY5ux/4nJItKdwh+yw8sUMnF1t/acou2URJ
 SarrgAVf9QC54UnmHDhP4ErnRbQ8esy1aFRD5MyyhQ0JZEYbupNmahXjOxibK3xCiqtC+ocJ4NG
 olIg/7G9MZQ2hPYHun0IVG94s+oSKxhq8NPyBgVsa0mXOTynchtxLazWnUS6vJb3LmTjBBjkosE
 /DX7SxD+t5xkA9IWRocehiflmY/TlL90sU9S8N1q9A71Qmg1UWMtb4K3/zw8U0NoVjViffCgQe6
 8QLBhq1HkBCvtrS10KdmQM0Nq9Y7vWfPwz1IhqAgfYWa01X9O7Mzo4T6aVpLMNuCc3KY01XUcfE
 W8K3kHAVsV1tPcdW8PyaRB7eFN3aDE3WycavAozETm+awTrTFb1zaYm+SRLrbVgxh6AzC+tCCJ3
 m5Qy0mOD6WJLa708SmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190025
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-11-18 22:06:36]:

> PowerPC device trees commonly describe a unified cache using d-cache-*
> properties.
> 
> For example, Power11 L2 and L3 cache nodes have cache-unified together
> with properties such as:
> 
>   d-cache-size
>   d-cache-line-size
>   d-cache-sets
> ---
>  drivers/base/cacheinfo.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 10a9bbce899e..4a23377e9312 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -148,11 +148,21 @@ static const struct cache_type_info cache_type_info[] = {
>  	},
>  };
>  
> -static inline int get_cacheinfo_idx(enum cache_type type)
> +static inline int get_cacheinfo_idx(enum cache_type type, struct device_node *np)
>  {
> -	if (type == CACHE_TYPE_UNIFIED)
> -		return 0;
> -	return type;
> +	if (type != CACHE_TYPE_UNIFIED)
> +		return type;
> +
> +	/*
> +	 * Some device-tree bindings describe unified caches using
> +	 * d-cache-* properties. Select the data-cache property set
> +	 * without changing the cache leaf type.
> +	 */
> +	if (!of_property_present(np, "cache-size") &&

Is it better to check if the device node np is NULL before doing the
of_property_present?

> +	    of_property_present(np, "d-cache-size"))
> +		return CACHE_TYPE_DATA;
> +
> +	return 0;
>  }
>  
>  static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
> @@ -160,7 +170,7 @@ static void cache_size(struct cacheinfo *this_leaf, struct device_node *np)
>  	const char *propname;
>  	int ct_idx;
>  
> -	ct_idx = get_cacheinfo_idx(this_leaf->type);
> +	ct_idx = get_cacheinfo_idx(this_leaf->type, np);
>  	propname = cache_type_info[ct_idx].size_prop;
>  
>  	of_property_read_u32(np, propname, &this_leaf->size);
> @@ -172,7 +182,7 @@ static void cache_get_line_size(struct cacheinfo *this_leaf,
>  {
>  	int i, lim, ct_idx;
>  
> -	ct_idx = get_cacheinfo_idx(this_leaf->type);
> +	ct_idx = get_cacheinfo_idx(this_leaf->type, np);
>  	lim = ARRAY_SIZE(cache_type_info[ct_idx].line_size_props);
>  
>  	for (i = 0; i < lim; i++) {
> @@ -194,7 +204,7 @@ static void cache_nr_sets(struct cacheinfo *this_leaf, struct device_node *np)
>  	const char *propname;
>  	int ct_idx;
>  
> -	ct_idx = get_cacheinfo_idx(this_leaf->type);
> +	ct_idx = get_cacheinfo_idx(this_leaf->type, np);
>  	propname = cache_type_info[ct_idx].nr_sets_prop;
>  
>  	of_property_read_u32(np, propname, &this_leaf->number_of_sets);
> -- 
> 2.54.0
> 

-- 
Thanks and Regards
Srikar Dronamraju

