Return-Path: <linuxppc-dev+bounces-21637-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D08CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 16:01:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRB7X3dZPz2xM7;
	Fri, 29 May 2026 02:01:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779984104;
	cv=none; b=UR6UaWhVjSkhRaEp0PVl0/bxc/DA2oPEil9MOjx7d2XSwiBSRmyT1jgyqFU5cg7AdOa+BdmQrWwh8isRvY23V5BlR0D3RCv/RZo8VKlr9ofcKQuorx+UE/Vn13yEatUC7fenaEbZ4s0YDjKLhrYyQjV8tSm5+Hm+5ROSAif8IquLVA59be3TuzLOY58z0WKvBlpcN3ek6g8rxSbe6MjXLVsL1EAZ8ZN3fLKpSvPHPu4bNBA8X9/kQCOLA9RdoCM8vpsi3xjRzcJ84nlcz1IFXq0ZlC85RxAyNMN3S50Bgey6auIUUwURasw/9HHPiU23lKpUWX2i+SQbJoPtc2vnTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779984104; c=relaxed/relaxed;
	bh=XQkdJmpo3JmApCgm6FlizNCVylDuF6POy+eYRX98q4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhqjxnAgCy17KCUE33PVJSgW0XH1PWwqIBoyxOzNsLlU1933QaFSD1bnYh+9ysMw/fECt96sFw0WLZ1zoxmM7+udQYLIyU9UmltmzMkpvOaDF2wC1piq4cvGqUu5YZ+D9mH6MhZDe692+32ZKj1EWF3TXmEghBAZvcoXIWV7pwGyYt8RuLqIAbWlCFM93RzkmUFxHRy9IeyIHa6B78aCtmZH/bcZLEOKTJrPwTZsvrupWXFkwerPb7MByM1Ro5O1NKJQNngAq+oH6Sa5RvWHhzfvpWyRUzN+CQ9TyidrEWPgVn9/zsoOtlP1K7MNq6jODnRROOvhkmwJS6BRqY9l7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=awgZ63pQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=awgZ63pQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRB7W4msqz2xM6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 02:01:43 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SC9tS8035843;
	Thu, 28 May 2026 16:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=XQkdJmpo3JmApCgm6Fliz
	NCVylDuF6POy+eYRX98q4A=; b=awgZ63pQQhdHQH10YN6jmlb6UVs2Rphpn49Eb
	RdoEY7X40FJDnIFiNPjjcPXQFwka7F4ucKKa2Qbvx9CmuvSdT01SpnXUsdJKjD1C
	LUcjPQuwoA1b5DFtN3s6y3DklVUy6HB0t8G3GAvayQ+uVyx/0AOkzLhkOJLspi7C
	t68Whwz2cuWLbgD0JiUCvg+ZnfOHgcnuWoOB3jy+myxnkJLbtbl2i5l3S3G80MqV
	VFd1dElW1nMARxUmucIz3i9E6li+N5QWqs2sGmOH5IRIDWbm86TDddkVCTKLPT+Y
	CigmpBdSxLTX23yBzLadLDxzgb4OQcuTAk0MYT67sV+1iIolw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bbqcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:01:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SFs92Z031977;
	Thu, 28 May 2026 16:01:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8utv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:01:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SG1PQU41812308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 16:01:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F22682004B;
	Thu, 28 May 2026 16:01:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BF9120040;
	Thu, 28 May 2026 16:01:22 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 28 May 2026 16:01:22 +0000 (GMT)
Date: Thu, 28 May 2026 21:31:21 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sched@vger.kernel.org, tim.c.chen@linux.intel.com,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Chen, Yu C" <yu.c.chen@intel.com>
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
Message-ID: <ahhm0dwSKiFt4bDj@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <bca40921-d351-4439-ae6a-9e5294f23e2e@intel.com>
 <ahUQE-AgvOAQV_mI@linux.ibm.com>
 <a0e3f4f4-03b6-4bb1-881f-06bf5abca1a3@intel.com>
 <8675afde-5c7f-4717-be7a-a473bd1af381@linux.ibm.com>
 <eaefc945-f2e5-458c-9d63-ead737c982bf@linux.ibm.com>
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
In-Reply-To: <eaefc945-f2e5-458c-9d63-ead737c982bf@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1OCBTYWx0ZWRfX4korwaZaue1t
 2eiT8yF1fyxNgq4nO2AupK3SCWPUQC1FpnNWoI99sVPpmHcw3bKQnGxzmOfY41mis7TWX2jUI0n
 DoY2ezOLYFhuqa9lzjBsopmLoayKqoM+OLrwNTAhcAqnunnsP+pH/svqmNYFB3ZpVBlaXWq0AxB
 7oVPiPX9DTQ6BKSkhOIsnSz4zOLElvsys4kVsq4h097is9eftrVlrqljBQUUhsh2MijW4vyCBhl
 LTzm41pXS1QC9Mf1xqRBR+Lik5poIn4OuGlPBbvtlAgoiAzRCvvI9tqSm771C/QEH2vkpEvgm9V
 JloEFZR2QPhAcKMd9/Wbc5m9XMuYruSHhSkDY6bY3PljNf1dh1U59uSn3PPgY3Pk7gHq/oZJMOH
 ++urzHESVwXiIHfZ5wCCG8bhSWgGQ03PSnx5Bc7kHIU1M+tjgbQiVovFO1meA+HpJsnf6ODddCE
 /Enw/asUhxuuGYDEIkw==
X-Proofpoint-ORIG-GUID: bAmFYiY2BSOdJpW932MLCGeXnyHgt9LI
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a1866d9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=QyXUC8HyAAAA:8 a=F3R1hv1vQv_lyvgeWPUA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: bAmFYiY2BSOdJpW932MLCGeXnyHgt9LI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280158

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-05-27 12:35:20]:

> On 5/26/26 10:54 AM, Venkat Rao Bagalkote wrote:
> > 
> > On 26/05/26 9:38 am, Chen, Yu C wrote:
> > > Hi Venkat,
> > > 
> > > On 5/26/2026 11:14 AM, Srikar Dronamraju wrote:
> > > > * Chen, Yu C <yu.c.chen@intel.com> [2026-05-25 23:35:45]:
> > > > 
> > > > > Hi Venkat,
> > > > > 
> > > > > On 5/25/2026 10:07 PM, Venkat Rao Bagalkote wrote:
> > > > > > Greetings!!!
> > > > > > 
> > > > > > I am seeing an early boot kernel panic due to NULL pointer dereference
> > > > > > on a POWER9 (pSeries) system when testing linux-next (next-20260522).
> > 
> > 
> > This issue is seen on P11 as well.
> > 
> > 
> > Regards,
> > 
> > Venkat.
> > 
> 
> Venkat,
> 
> Was it on P11 on Shared LPAR?

I also thought the same.
But I checked with Venkat, he said it was on a dedicated LPAR.
My multiple tries on dedicated, didnt reproduce the problem.

-- 
Thanks and Regards
Srikar Dronamraju

