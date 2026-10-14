Return-Path: <linuxppc-dev+bounces-29452-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C51CA9EBD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 03:57:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4HTT2fSmz2yYK;
	Wed, 14 Oct 2026 14:57:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791950237;
	cv=none; b=KE2BNNN0fUx+eaSfbH8dVb8jGjbdfdUTuP67FrCF05mudW/aibXRos51T4qSSF1trP3eKPOR/YFKA846B7AyGDwuAXx5ST9dC24quNpo868vm2E+3bOomnNFlKhmpDh6d/nq087Uvg8grzqidxFrEjgQzgQENY6ZvtMMkeo1nQXh/RehwUmYGvRKkXA3VTXCIEy20XIwb4D8ctXIgS2yMk9ToFKl4dPpYDTzL1XTUgzBmUHCmvoeWTH4IZFuW1UKnqx1rMcI73YH/j+JzPdvKvQ4Mh5KzsMkpBwe5BJT72bBRbOfUVv8jzj109QsSUN0fE4S7g8fUwbRpgKSEUf0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791950237; c=relaxed/relaxed;
	bh=3SyPmFDYob2ruhwr8GRj3ud/DauePfVfA3w89L1+hLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXzOpqdRU8ADN5EO41KWNeTVXC+izzHhhUceJ7kwEpyKA5XfcMFCkulOsr/CIptSBaOYWomhHI9HLfnRMZD5x4RsPDHO7/EpHdLH9q6c/SLsTnXYQV+p/ppkX9+hM2Wg0Y3n2+5r3EVAJBDWDzOZ1L8B/s3bvexhm7OZaTD8nwXgCsFQSA73+odGw6ZeLstlUgrwyAK9nOfhsx3mAdZB/hSLTezFyE9DKt5cGBToBmGH5i5bztRRDexea0gqOyp9H+vZ0wW2XhcTP0nUZJdTxi55JwhYjGla+hRiz3arx849WwzHdYr2OCJ6XfiqQSzCnBg2VbcbZ42HdYUplvXdQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gkJNN/Qj; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gkJNN/Qj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4HTS0R5gz2y2B
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 14:57:15 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DME0QN150374;
	Wed, 14 Oct 2026 03:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=3SyPmFDYob2ruhwr8GRj3
	ud/DauePfVfA3w89L1+hLw=; b=gkJNN/QjxTI02nmq6TZd1kn4ceK1vVM2Ew5S1
	caeWncNymVa/MbadcBIrKTZAaq6nk0D+KL/Z4VyXeqQgYSINDG6zz7zO5KxK0JCK
	99ztORkB2XNAW+GaupLDyI1PtGDux1yjeHsKkScy0IHvRRvGWN7BSdVM67DAsbYm
	+4Y8kZ/KMNIGER8UV1SpCbzVUcBYGw8GONXsDITclL4BxEQ5TtD0m9C+I6ijgZU3
	qSRRsi9YyW6FAq6YcqVCxKvKCfOV/BZf2+rkdGx/NkL9bifs12ilPNYRnP8/YSD0
	ZiQq7XX6Myb1UGoWs7qpdYR2hkbtLD+2qZCwEGmyf9C+WW7Ig==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhj86g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 03:56:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E1PYQW3211950;
	Wed, 14 Oct 2026 03:56:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2yk2mq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 03:56:51 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E3ulRS31851140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 03:56:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E7732004B;
	Wed, 14 Oct 2026 03:56:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9DC22004D;
	Wed, 14 Oct 2026 03:56:44 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 14 Oct 2026 03:56:44 +0000 (GMT)
Date: Wed, 14 Oct 2026 09:26:43 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, ritesh.list@gmail.com,
        kprateek.nayak@amd.com, yu.c.chen@intel.com, vineethr@linux.ibm.com,
        vincent.guittot@linaro.org, npiggin@gmail.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        peterz@infradead.org
Subject: Re: [PATCH 0/4] powerpc/topology: Introduce llc_override debugfs
Message-ID: <as79e9ZRXp28QLkG@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <20261012102037.2477378-1-sshegde@linux.ibm.com>
 <0cbd60fcf328ffcb317739f60d327da3af6145f1.camel@linux.intel.com>
 <dfd8312d-a59c-4480-b054-d94d2e66110e@linux.ibm.com>
 <4d0f2f4631f2f836bb1aec140c2c8e3e11d7ba20.camel@linux.intel.com>
 <5f107344-7ddf-402e-809c-7229ff6fb6d5@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <5f107344-7ddf-402e-809c-7229ff6fb6d5@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxNCBTYWx0ZWRfX5/BcnfZQgv0l
 ml3C+7XXI5kaph27yFTd4zzUTYlRErKeRauJFVd2TEaUcNKYYYSS6b+1Bmg+nzzxJm+w/9jZOIf
 gu4jNmqW2TVRAGCJ4DFjsRstiR7URA0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxNCBTYWx0ZWRfX4/yatxwiFPxO
 NUaM9Hd4WxgnVBMIs7soHVA4rVbG9JxyYD4rbL0VCNI8F/dObhYeXQ11BWFZp132HIuPipsTO/k
 R30yGKCH1nJIcAJ3Ojfo+RJ88vzr5pjCh1pyK6ZDSOJnhjd6yfJ91jWrcTaIgoF7i7fs6coGChU
 aC+3jUazSMVt8OKghRcSRq1cHLxXv3rZr+uW57wqLwJ8YSgh5Scag1nhWKRL91qZBjUvXzzEkzO
 HlgegW9WWMBOmdcX+yv2iigxJgx8v1oNsVqNBXS1zs+pevKoMzH/bojs9k05V7YebVeb3MhBuzp
 NyUuNGHW7cBmoHBFnO7uyrvovCF5I8Byo3QEhBxTUu92hqP4HSpO2NkzuP254ijVIr1mWrzvbSc
 tkZ6k0WbWymQ6vfqrMfIFD1qLXP25GkIm1rYkxwLtSum1SSE7S/Y+ICwcZReM0uDFxA2Y9G3vAQ
 To73ZpwFXSU1v2OakuA==
X-Proofpoint-GUID: Asy4W-E04gs761vcQhbCV1L4xL7cEaqm
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acefd85 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Uhm1o-73ascBbd6UxXcA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: xE-0b0eWmCyVk7Z1RUkQVKXJV0TyXqkj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140014

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-10-14 08:46:11]:

> On 10/14/26 2:14 AM, Tim Chen wrote:
> > On Tue, 2026-10-13 at 15:28 +0530, Shrikanth Hegde wrote:
> > > 
> > 
> > - SMT: patch 3 adds SD_SHARE_LLC only to MC/PKG, so for "smt" the
> >    flags are as before. I think it is possible for P9 to have
> >    shared_caches between two cores:
> > 
> >    /*
> >     * P9 has a slightly odd architecture where pairs of cores share an L2 cache.
> >     * This topology makes it *much* cheaper to migrate tasks between adjacent cores
> >     * since the migrated task remains cache hot. We want to take advantage of this
> >     * at the scheduler level so an extra topology level is required.
> >     */
> > 
> >    the CACHE level also has SD_SHARE_LLC, and highest_flag_domain() picks it, so sd_llc spans
> >    cpu_l2_cache_map. shared_caches is only set when that map is wider
> >    than the core's threads, e.g. a P9 core pair sharing an L2:
> > 
> >      CPU:               0 1 2 3 | 4 5 6 7
> >      cpu_smt_mask():    core A  | core B
> >      sd_llc (CACHE):    0-7
> > 
> >    The ids follow cpu_smt_mask(), so 0-3 and 4-7 get different ids
> >    while sd_llc and sd_llc_size cover all eight, and
> >    cpus_share_cache(0, 4) is false, which is incorrect.
> > 
> 
> Yes. I doubt anyone wants to try this experiment on Power9.
> But yes, functionally updating the flags is needed.
> 
> @srikar,
> That is also the reason for having the disabled. By default on P9,
> llc will be at CACHE domain. But, one may want to experiment with =smt
> which i doubt anyone will ever do.
> 

I think P9 is a very valid point, but I don't think we should look at disable
as an option just for this.

I would say, lets keep it simple now, just have an option rather a toggle to
have LLC as MC/PKG for experimentation purpose. Switch the toggle and it
does back to regular LLC mode. Also we don't know how the future Power
Systems LLCs will look like. So keeping it a simple toggle, will reduce pain
and increase our flexibility for the future.

Whether the toggle will switch to MC or PKG could be decided based on the
experiment results.

-- 
Thanks and Regards
Srikar Dronamraju

