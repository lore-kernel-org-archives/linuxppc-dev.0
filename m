Return-Path: <linuxppc-dev+bounces-21900-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DC4CD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 12:07:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gV8hR42mnz2xy3;
	Tue, 02 Jun 2026 22:07:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780402023;
	cv=none; b=WMLTovwiSCVdm3i77bFcus4VKFN3oFZVskcelQ18LBWc3GpnNFqjzC9e5ChlQtW1+XYG5BBQymB2INiTCyMVLqcSuADhkJyYWMY/U7NZ4a32+SDZf0kuxdX2bYzaWkPoCry/wg+82fnyPWVpfkf4i6u1j8gGPRWdTkv+lOzuQKKIeYPBMYQkQ1uQPhKBKUcC9giP1YUNtQrXlTMF3h/NxDN4NPjgYaE0DsmCYWx93KErtLHDGlslic939vPgLcPV0ArK7N5JafqdSamS39U51+m2X8/UmcRySaDfMDEo5sh/ZzQppwZgR02NK1YR6KhKG1pxohaVm63aRhqoHFkSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780402023; c=relaxed/relaxed;
	bh=WbECGbQlQcCrfawRKmg5JfF1erVYBwWpopIZGKfqjMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvmObyLow+hcBBjCVonVoZH7PYcrxSrrpee5rsJD35O+O6ce1Z8ZpaSAVlGkPf4NKmFJlR7Oj9HhSzRpDrSMD3hE337VrzZpp1MsOuuFpcJ/D2v94CJDdOOILAgB/ZrfIHRRZeG6q4awI4Vfg85rs4aSMDJo21DuoyY6n5V+75tC+0a47L0zOR2bSvJZL1N2NQ8D76dC00+mft0jAI2O6p7GLXG2+R8P7AoJBrODqbFLdSppiTNutFOj4XCA+RxnRknLSJyILM1riAeYhSCRIEMiY8ujkGA86A6bs9lTEMwj5GcgIVlmX/r7qM0LVN/7Ojqk4UeRSBIhz5cyEsfDKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c+WO+MfS; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=c+WO+MfS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gV8hQ4cnJz2xmV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Jun 2026 22:07:02 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6523eAid2012063;
	Tue, 2 Jun 2026 12:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WbECGbQlQcCrfawRKmg5JfF1erVYBw
	WpopIZGKfqjMs=; b=c+WO+MfSCrhWwkHDFHrr0XTyoPIwd4A0EZ+Y4pbRlyAh6C
	mDES61t/7ajkBf1N6yV8xbXBsm5UuK7JIsLcWO8XwerhqEHyLnaqYcOs5e26HuGw
	Tvdy09WDY0WQrJ3ojJkxlZ4fqblrfhuROGgHqJzUrjfUgheLQQdHb9UisPsQqE/L
	d5sDytHmGQUSrTWAT3j7XzdnbcaXo2IwAVa6/z6NyBEBA9NU1WLsu/f4opScZeZl
	5je4DhkEyoWWvSfctsiSxmAgo0gcf8pE0Gl0fMOHwbeS6uaaWMQ+pDRkxSH6iqMP
	crPId8eQkDYSrNAchZFnOkfeGb5AyCU6V0F9kNLQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae5cvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:06:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652BsPWO012143;
	Tue, 2 Jun 2026 12:06:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvu7y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 12:06:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652C6faZ10158342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 12:06:41 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 997772004B;
	Tue,  2 Jun 2026 12:06:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB8A320043;
	Tue,  2 Jun 2026 12:06:38 +0000 (GMT)
Received: from mac.bl1-in.ibm.com (unknown [9.123.11.154])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  2 Jun 2026 12:06:38 +0000 (GMT)
Date: Tue, 2 Jun 2026 17:36:31 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Tejas Manhas <tejas05@linux.ibm.com>,
        Gautam Menghani <Gautam.Menghani@ibm.com>, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org,
        atrajeev@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script powerpc: Update the hcall list with new
 hcalls
Message-ID: <ah7HRzA8ddE7dY90@mac.bl1-in.ibm.com>
References: <20260512084654.57729-1-Gautam.Menghani@ibm.com>
 <61c8d600-72b4-4320-a1ff-18e061569f24@linux.ibm.com>
 <ahoo5dI-6fVlFvvR@x1>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahoo5dI-6fVlFvvR@x1>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1ec756 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=dQQfcrzLAAAA:20
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=jRNdTEU3ykmnNMFuCJYA:9 a=CjuIK1q_8ugA:10
 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: 2APIun1A24ZywhHYFT-YbQOBiZuQrNGe
X-Proofpoint-ORIG-GUID: 4m140wurgwLKOHpaOI8Nky4Xcvr_LT5J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDExNiBTYWx0ZWRfX2i1j5XJ14zmw
 zoOcM30C5MSh7Coa4t6ol8BGPyjjhE0+dTaEV951Mc2MD7pEfTvuPpgDxUyzq/MDnjBJ7yc/tc8
 VnsUMOna+8pKPL627nzXHr+1cEkdxpo2OU7WL5U5BzIFHms7Ggv0dKonCE3wZtJf5B0h66P3ajS
 BpS0Ldpo4DLdLwffP8JG1r2W8opIrCjFfpvpJYVdeyN5dBsN/mZzuZmsHPmRn1F0Gu6MCFofc0N
 0le8LIfWZZWCR/s3IEgG70gu4t1dufS4dAQb3UXhpbMKuqsQ8DI/48MQ65JYZMzJe8N2PPTOxso
 ayAt4l/UDD37yhDkbgmJ1YuivTEzOuY0QVlESkBek3OKjIXMZG25mml1zrnTQ9cxvvBpnc5r3A7
 mDbjIvSfHGv3otACarzFEJhnDQsJkwSerV9oj09wST3x5dXg8l81CgIFrbi8Ypw6kyGUGsxN/T6
 VE9WuG1ocWgtlM7A1Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020116

On Fri, May 29, 2026 at 09:01:41PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, May 20, 2026 at 09:25:08AM +0530, Tejas Manhas wrote:
> > From: Gautam Menghani [1]<gautam@linux.ibm.com>
> > 
> > Update the hcall list with the hcalls in bcc's ppchcalls script [1].
> > 
> > [1] : [2]https://github.com/iovisor/bcc/blob/master/tools/ppchcalls.py
> > 
> > 
> > Hi Gautam,
> > 
> > This patch doesn't seem to resolve the issue where numbers are seen instead of h
> > calls.
> > I have applied to the latest upstream but the numbers are still visible in perf
> > script.
> > Also the command doesn't recognise python-audit already present in the system.
> > 
> > Please find logs below for better understanding.
> 
> Any progress on this?

Yeah, sent a v2 - https://lore.kernel.org/all/20260602115644.8133-1-Gautam.Menghani@ibm.com/

Thanks,
Gautam

