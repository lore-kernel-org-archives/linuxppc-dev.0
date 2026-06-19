Return-Path: <linuxppc-dev+bounces-22838-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859E7CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:01:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs3M6lF4z3bsX;
	Sat, 20 Jun 2026 08:00:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906431;
	cv=none; b=ltRrVQW5JXn7jSKi4E8pHA98Y5gBsCk49fiKjdaojrYxMeQ8VE0tpff4ojQiAWBHKwOs0HC1hdp9w3EZvgY/MaEWxkYYC7mPUQ3Fe5FyRhUWhW/asvKKEkfZF9MaH6hi+wp9FpOZUGaydcJrBDT+xD59Vs6TDDlR8RwXpGYW2f1CYda/QaUTerTyqw9LOjzxZJxAoQ2wyoKOoxbWXKNc5q4PQcn9xfA7SoaAiLQjO7WGOCrJ7EgMTz1TWOQD4nbK895zqHXolMRxPd0l1yuzHuLaBE/cJ85D1aMkdhPYrCU2IKMPF560NXft8LITF5BpJOGzvP56LcgBi5B1b/fUag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906431; c=relaxed/relaxed;
	bh=0uRnNtI0r1gzL66gT3HryIZGjWFcSrBJNaKfVWcINqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCp5fUxt/N+fUX1oJ8QrvPLb9EWHJlBEIelFkhn2kS4xKKe5sGYf0pYtWAwTkRR2/WcNqYkwvpzrqgBZS4KsIkrQmoMjFdy5OHXCrRK9+sXET3q6uxsDrScygNWTgRB0jIHPteM0xn7Be/tK4eHFyJ+jR9NDl4OWBaqs4dBFCH9Zp5p52s/rjohiArTGTGIPrwsbYtddM/d1sC4n5FAkVyihClUUZSUhLT59f7euJ5dWJdC2wIs3c+oSw7piv+tVTuC9HJjYoJw2P2V4zp/2/dBJXTJ5I/98DfMfxvVBRZuBIgh1rf74zqHaRm2bzzXrOJew8JXFrqReXV62uMDYwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FfUMLHDp; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=FfUMLHDp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs3M0K8Kz3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:30 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLnxeU3360405;
	Fri, 19 Jun 2026 22:00:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0uRnNt
	I0r1gzL66gT3HryIZGjWFcSrBJNaKfVWcINqQ=; b=FfUMLHDpp5+vTUBj2J2e7O
	MROE5JRxUg2SS4Vg4TDLaT30GYPSzse70CzoGnXVPe/SNilHS2Urk8e3STkCjSHW
	G3aloZo65yDfrONQaiIP8PtzkyvGUbX6nrsSfThO9V5KiGP3If7EToqxMMeXlhLF
	2U5M1rHcmmVPKz7mne25KMDw1n1Z/xj9/ETRyIH/4yjWtDVonLG89Rtj3wDul7jk
	lijKWjKPI88dpxVLli2c2X81KYuFLvFYYA5j3X7QL+4R0SJCDX/tvtGrxNOsTdEH
	rMuTBnGq1ZqsNgeP6EZy9J9mtG8NL4BNcvyyDS0HPDOJbxPH+rWFWljowU4ClcWQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxfg56-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLniPt032203;
	Fri, 19 Jun 2026 22:00:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172as50-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM09H19372150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9BCA20043;
	Fri, 19 Jun 2026 22:00:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D58CD20040;
	Fri, 19 Jun 2026 22:00:06 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:06 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, kees@kernel.org,
        tony.luck@intel.com, gpiccoli@igalia.com, ritesh.list@gmail.com,
        rppt@kernel.org, Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Shirisha G <shirisha@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/fadump: invoke kmsg_dump in fadump panic path
Date: Sat, 20 Jun 2026 03:29:48 +0530
Message-ID: <178190618792.653308.14718990774482559384.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260412113057.46090-1-shivangu@linux.ibm.com>
References: <20260412113057.46090-1-shivangu@linux.ibm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LEOAJc0oWEsgmnbBdRgzx-5_cE1wVz1V
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a35bbee cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=o0yxbJjfz1-Qail0h0YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX+656LQCXmfBu
 L7+Os6RdSbRvYaj4u7kiLp1dDSCUpbMyGz2ONvPvYcjhDYQjNi+Iyf/BaXdt++pw9O6tx46fs0r
 V2KF9EcFqH8TSpB7ZiXG5SpgR3LANBI=
X-Proofpoint-ORIG-GUID: lf2qDui7G6yblG5usyXgIx1bhUh1m78_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfXwHyM/viRuoNQ
 2HxSOFtBxiAUgzNeMNobE9JqhBa3b6mf0b7Z6nz2CYF2dC7ZF1w6yS8ITX+0ASmgdI1eH8nk/Q5
 8jknlwAQjKBERDx7mK9yBJ0B//2aHDwjdQ1PuoethvNBEqHH05N0p+JNXiYxKHzUeuMfQ89UEwO
 rjX+S7N4wHgwOT84ekdveNPb4VXJNHYrRmmU/Rd3z6UlnVs339wHSA6IAvBhFy51yGmqd1h8Awd
 T3HCmLl3Csy5w3EUD3GT9D7PHX4GINtzcvXEB112zWMy0UeBYIXCU/6ihFUOd8xFEv/C9LWhDzL
 tQvb4HAQ23Jq8Qzp9fQPILHNKSfig+HX05xfGlhBTh2S3TBpdvwT9YkX+gvqdTVjIkvYBinMQJs
 bbBzsa7CjyMlGAas/ThFrGOUZCKrHYNGsJ5CFltB6pwLLgIhs8UWID60eNRzPffWf+0KLspDGPD
 9gtud95v1GvLboHDKpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Sun, 12 Apr 2026 17:00:57 +0530, Shivang Upadhyay wrote:
> fadump is registered in panic_notifier_list and gets triggered before
> kmsg_dump_desc() in the panic path. As a result, kmsg_dumpers such as
> pstore are not executed during fadump crashes.
> 
> This is problematic because pstore provides a critical fallback mechanism
> for crash analysis. When fadump fails to successfully reboot the system
> or capture a dump, pstore logs may be the only available information from
> the crashed kernel. Without invoking kmsg_dump_desc() in the fadump path,
> we lose this valuable diagnostic data.
> 
> [...]

Applied to powerpc/next.

[1/1] ppc/fadump: invoke kmsg_dump in fadump panic path
      https://git.kernel.org/powerpc/c/6ed8332639853b77329594a241eb99fc36d591a2

cheers

