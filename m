Return-Path: <linuxppc-dev+bounces-25226-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E430CC5516F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 04:47:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD40b2T4Cz3090;
	Mon, 03 Aug 2026 14:47:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785732447;
	cv=none; b=ALvxyQLZQA0gyRDOLwH3ANQf4GVVvHkJcfe6SsWuYS2+4Q1in+a2vWHyRzaAkeRJyuh+yCjawV5j1ikKPPouaKxCLRioOU13IyFUGJUa+kgRbBoUg7OCtd7Qqemy54qjb2Nxet/Qh6UYQgskRs2/GHNziY3TBqAAm99NFsN+KKIX414GAExHPa9zA4Zwq5RtS5wNHQdqfXPtNC/zhblPgdLj1uz8yqKAcKyZquprq+jeh7aGuEtkgpVLGohfvFTkfQWasLlLuGdVsNORMmJaQePhicn4XvR0tpzaGA2N5tWDcHkk+o6CtsZGzqd9yEK+ulj9jItX2agvMW35o2/YFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785732447; c=relaxed/relaxed;
	bh=WpjgLouLKAoRoR8IJIEOUWpBtpuVGVbbWy3OJPLHk0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGbpB7s/xNIuNpIPA31P9hnRcOV9Afzj5RGNtUIq0P4nG5KfNMnuPdhHIpMlHRoD8saDM3bD4vihQwcGQTR45DFo7RISSRHyUm9UIqzzfhln0d0CgUfSDVwnebs93r435hI7+jq1GX9/pTQPcI9s7WNttAplk65J9hcBvlANXoQlXDgQ6j8Va2re9JY8PikMmjcO/Er+Vfug64wfMpnhLra0Vn+8TtKnjfedi3tq7WzrCFq/aL26axQinh7K/Dk9ugdD55ZsuIVfk0U2d4dK39gXKQTkzZWJAtRqXqOGga0/IbVvOwJVffc5X73zpWbMR+A5kvuuBRzsT1HjQsyh8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r/UuCTtY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=r/UuCTtY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD40Z4Nwfz308Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 14:47:26 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lm5DI224106
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 04:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=WpjgLouLKAoRoR8IJIEOU
	WpBtpuVGVbbWy3OJPLHk0Y=; b=r/UuCTtYxVHB+TJh4KIjazVaaOvoCW1ruEes2
	jWxUZwgm9wG/AlbKLu4WqqzvXKUabceclb9FjDzUwcix8XxmsI/q4K2ekQIVeRoR
	hkw/2CdhWSAk52UW5H52Tsn43OsqjC4Cp8U4v/I4ES7D103FFFI02EM02FkmmieI
	Ar2y96hy5hE77DdTEtGGudab2misUU8k5vV3WIrIuWlYcsp5PxCqaGXA8Iuil3V0
	V1pC9W0gFC92jDhdlyNBmY2WT2PcEhZls4dIvGSwlC2I58XJSaFuaO23ybimdcw7
	W7RzOT39hvMaUs6ThKOFvHK/czWAq4UYWV2rSa0w2bsqVJGKg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3pv8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 04:47:24 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6734fIJY025575
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Aug 2026 04:47:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtybgk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 04:47:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6734lJr746596582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 04:47:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 473BB2004B;
	Mon,  3 Aug 2026 04:47:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69C5620049;
	Mon,  3 Aug 2026 04:47:18 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.39.27.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  3 Aug 2026 04:47:18 +0000 (GMT)
Date: Mon, 3 Aug 2026 10:17:15 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4/4] powerpc/perf: Add power12 Base Performance
 Monitoring support
Message-ID: <anAdOKei-tOvF5cT@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260729145405.3230272-1-mahesh@linux.ibm.com>
 <20260729145405.3230272-5-mahesh@linux.ibm.com>
 <0c7a7137-97ec-458d-bbd1-949b823cdc00@linux.ibm.com>
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
In-Reply-To: <0c7a7137-97ec-458d-bbd1-949b823cdc00@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a701d5c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=7wQ5LN9j1xiy9RActOsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: YBbrL_hkSYehSmoim0b15-2EV0HxYrj1
X-Proofpoint-GUID: YBbrL_hkSYehSmoim0b15-2EV0HxYrj1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDAzNCBTYWx0ZWRfXxUpNItfHwkfA
 E/YcXYUjYjaB8ARzC2BbKb4u95fd5QnTUDyw69GafT9z1IR6d6J8UmmmiOMHg3q2xGVYt5p9kuP
 Ac5kYJpDOgY0Lmva36MPID6eYI4KprU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDAzNCBTYWx0ZWRfXzuDB8hXAvQq5
 bZbxYkvGmXlue0WF/j0aB8vVN5td3LvR1upojmaFi/5gNU/Q0y16vKI1mP/L9UDP+sThnaIv6kK
 WSF2UOXSYIJsQSp2PfQo9rt/3hLIl12esVvemVbo8KmKc+vDzhNiSfzfTy0uNa37qJy/nc2bTHf
 Eqvn+JtjWuS9jKS9VwevU0n/Kux6eBRviVH0lYWEFtww0zp4u49rbFhVsXUZbjHWUzdPNRTRsbd
 BlAvOSxQ0KNFyj4w4uZbGOA8LtneFUzfdHbp2V10o9pVCRP9uo2cpaA1IbdzsFrYRtwq9AcUTs6
 DN3aCy8MJI57Sn3XFOEhrJVndSh3xpPXjK4VfN/Gex2xkeC8kjd83sqEW4OQsmWlJZAOxLz1pXE
 DKmbTSv7byKD7Rt86C9PRHN/C0pup2MoO2BC/fy+YjHDUArhpKv87i1B596LLwNOZk0Mowsar7x
 aBghxcEnzUJAg3Nojfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030034

On 2026-08-03 08:40:23 Mon, Nikhil Kumar Singh wrote:
> 
> 
> On 29/07/26 20:24, Mahesh Salgaonkar wrote:
> 
> > +/* Instruction Demand sectors wriittent into IL1 */
> > +EVENT(PM_INST_FROM_L1MISS,			0x03F00000001C040);
> Hi Athira and Mahesh,
> 
> There is a typo here: "wriittent" should be "written".

Will fix it. Thanks for catching it.

> 
> Thanks
> ~ Nikhil
> 

-- 
Mahesh J Salgaonkar

