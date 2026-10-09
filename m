Return-Path: <linuxppc-dev+bounces-29086-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39115CA5FED
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Oct 2026 06:17:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j1GqS5Nv0z30Ng;
	Fri, 09 Oct 2026 17:17:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791526644;
	cv=none; b=Tjw0pPZEE2zzHrGOwgF/d7YLMuFBxLXy7InRfG4flOCOWwH0JvC+rEAdnlkfebeFnb78E9x0077tjJwYxyTXcOzeuAuWs8p/LYtyaJKtvWqCCxQ0qjF/F/zyyWIAUDX2ZGGi3zjW8jGZTGP4w+fMOjA/3n+BvPyeBupJ2q7liLgxPW3l2+kY6fMaI/UMhopjUZfcscqbXUCth3uX4iP2+xl0MBiJmwi60YwQkju2Oy7XdbubyADHqoJkk9F/FmKS6jIEhvWQ4wDnyZYTIqEDDmdQdR985M9iggvTFWHpnWZiqGCBBNRRzy25/foveUDcGPiMFiWkfC4fxAaFBlUPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791526644; c=relaxed/relaxed;
	bh=wmdKiXBjTMC2CeFgnDjaEhOFFOvsw/zWml+KVBIoTco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RRo2sjEIEU+ApGzVBtY9/g2ldUmdXEsJi/kKtzvxNOFox5FIaNHqbYOo2g0pUl5DmALccfhPAmKO1irs+PLAVnAlW09LZinGKyQjCuAJmVtC0mbOLzqmmkNOUXQp8GNTgSSkliM+3zumCyELsjA1yJiyDDc1OCTdLhTZWddtxneWHaEqIC1WWg/C1s5qSepJACBwov8NFefvBF1p54ue1G6RFQhxxkoFs3DzGnG8kRLZqkeREmQnkFLN631/JgVMthSBL5xBH8NGmaBP4Oc931Tsb2v5oaJqHwI3UjXdi61vSkbCKW+FPkyZi/YZquO18XW88LmezFNDDMeYUE1gnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BYqHwDaz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BYqHwDaz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j1GqR63Yvz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 09 Oct 2026 17:17:23 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993aRmO1404835;
	Fri, 9 Oct 2026 06:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wmdKiX
	BjTMC2CeFgnDjaEhOFFOvsw/zWml+KVBIoTco=; b=BYqHwDaz0xnkmMRR8olgle
	ncCHaTtVoiub+KHg6nCg/ZMY6mfOSAdjzBumrdwMkmStuj3vKY8bvkTYRRB5G2iv
	n5SZALSZDNim4ydC6wzjtwNM+n7X5lM9XALITLzDDNysf0p+rd6sqCo7yXjgpX5G
	zc9mg25JNy6udxHjRrAaMhv8rPa5coMOlxl0pWs7m/IHqgo9R+iNY0JtYm2V23OB
	9VeRDzDc3xb45dtUvzTrxhlMMxCNHR4UmP5AwvQzlFba2o2dx4wcEH6hNp4EJz+t
	nc5aUhDwQ5cKNjKuVwtQz8SIzyDtbiPtJv39TAuK5YEiPwQwbuFoQu6Hir2OUG2g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw8us4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HmVI290664;
	Fri, 9 Oct 2026 06:17:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dtn21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996H7GB41091354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C386B20040;
	Fri,  9 Oct 2026 06:17:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA09320043;
	Fri,  9 Oct 2026 06:17:05 +0000 (GMT)
Received: from [9.124.216.87] (unknown [9.124.216.87])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:05 +0000 (GMT)
Message-ID: <bc9beebb-930a-40c1-aa6c-2ea5b7e4d363@linux.ibm.com>
Date: Fri, 9 Oct 2026 11:47:04 +0530
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
Subject: Re: [PATCH] powerpc/pseries: fix device_node leak in drc-info lookup
 error paths
To: Krzysztof Kozlowski <krzk@kernel.org>, Haotian Zhang <vulab@iscas.ac.cn>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <20261009035445.3079660-1-vulab@iscas.ac.cn>
 <20261009-proud-dog-of-stamina-476677@quoll>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20261009-proud-dog-of-stamina-476677@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: b3av1LbhKli-V4JFecKGNkvIQKC-xXol
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX4UO2MeIkEIbY
 6w0gbhwqcbtC0dr/HmCalplCb1S2nFPHhVqfxlde3OTNhYi11p5eylj4J9ZOMRYr1DV/G0ALBqS
 5fOqK/VdF/JE7G8WFEPMLDbREMIT0H3JI4TXNBIcUch1A2ymMucJt80hZtTzlzXCveSoBW0vZLu
 4L9lC5Mm/1ZnPKbPD22gZxaJORJkma7htHq3n1KnSBIKGLUKFC43lCxojdYpLAzQqnXuj1LEJOW
 SdkL7isrVoXxM1DjmnvahsKc4NHpaAdgZcX7bjTyHHsXbrWUU3hnrO4xMARuH4/3fmWIlI9T+Tv
 4VwvtwMXpjQyMaoU0xBfUFwbNqSxe8DY/2FYxC1dANdrMF12Z4y9J1tyHzUeQrWIW7MiKnT24YR
 cyMkxxPE1qQwlLLZRyZbNhFWUtm30NOpIMR/QPUTScOKFGQDqjAgnSRFwqH6yZ1cjg3Rfo+RKwW
 BPhFnJtzcjgKevcf9Zw==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac886e6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=L1tC7fPenBsYHk0p1uUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX9+S5+sU8sSDl
 +llM6kQ3SauIoS4jAEKAYfG/Lu8FxtaAd9ptYEM1s3V0uQ1or2onW+8oMHgmRtKdlGQW1E/w/Cm
 Q5Wh4KC6lfkgvCt7IzaEv29OUKF4+e4=
X-Proofpoint-ORIG-GUID: cZU5Yt2q3RgLQES-ibUbBcuYG8FPQa8Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090024



On 10/9/26 11:40 AM, Krzysztof Kozlowski wrote:
> 
> On Fri, 09 Oct 2026 11:54:45 +0800, Haotian Zhang wrote:
>> cpu_to_drc_index() and drc_index_to_cpu() acquire the /cpus device_node
>> with of_find_node_by_path() and then walk the ibm,drc-info property. When
>> an entry whose drc_type is not "CPU" is encountered, the code jumps to the
>> err label, which is *after* the err_of_node_put label, so of_node_put() is
>> skipped and the reference taken on the /cpus node is leaked on every such
>> exit.
>>
>> Jump to err_of_node_put instead so the device_node reference is always
>> released.
>>
>> Fixes: e83636ac3334 ("pseries/drc-info: Search DRC properties for CPU indexes")
>> Assisted-by: DeepSeek-V4.1-Flash
>> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
>> ---
>>   arch/powerpc/platforms/pseries/pseries_energy.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
> 
> 
> 
> Multiple things here:
> 1. Your team ignored completely previous feedback.
> 
> 2. You use multiple identities with this email, thus I actually doubt we speak
>     with actual person.
> 
> 3. Finally, same feedback:
> You sent multiple independent patches, to multiple independent
> subsystems. The amount of these patches clearly suggest this was
> AI generated and most likely not tested.
> 
> More importantly, you sent all this work without properly organizing
> relevant patches into patchsets. This makes reviewing difficult
> and might cause multiple reviewers to address the same issue.
> Replying to the entire set is impossible and requires handling each
> patch independently, instead of applying or discarding the set.
> Maintainers also won't see the bigger picture of your work. Quite
> worrying.
> 
> This is on the verge of hostile patch: bomb us with so many
> contributions, we won't be able to handle them in efficient manner,
> like responding ONCE to ask you to slow down.  Considering all this
> is untested and LLM generated, I have even more doubts whether this
> should be considered for review.


Right, this is one of the concern I agree. A lot of these patches
are not mentioning how it is tested out.

One should at least mention how did they observe it and tested it and fix
does test what it meant to fix.

> 
> Please read kernel documentation BEFORE posting more work. It will
> explain you how to identify subsystems, how to organize your work per
> subsystem (so a patchset grouping multiple patches with a short cover
> letter), how to document usage of LLM and how what you should not do
> if this was posted in a good faith.
> 
> Best regards,
> Krzysztof
> 
> 
> 
> 


