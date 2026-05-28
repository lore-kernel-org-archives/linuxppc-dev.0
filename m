Return-Path: <linuxppc-dev+bounces-21640-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6E7CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 16:45:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRC5l3zTYz2yVZ;
	Fri, 29 May 2026 02:45:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779986715;
	cv=none; b=AW2i228g7TPuR0+2bTv2HWHankJyp0zmWQhpeMW1kjsX7Lvs+qwmE+8Jq+n3tFAJSmXMqzxoEzArCUPpHzCrq1ZAjRd3qdQC1ccak9w+lXJD9xcJuonqFXPgA57Ojjkt+MRUvAJGoZFEePcnFmx6jRYILKEfMnhGu2tW6+eVZ6nf1zIDlc10xdJIpffkjAKckpbFcYOj0Ippk+nP9psKv0QDzqtJCGBD8VMoPjeutK5hJYmNRhfqVUL0f/cMxSxyjvVwHvu7zqWhDzZZ0qzOzZOAvOwQ5pgwwrpi0LTpIO62zRgk86SboKEl448MSodLWU7hmjtWv4wlXsZYmgcBaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779986715; c=relaxed/relaxed;
	bh=iXcQxszEjjPgyCAjzQVDY7j/G4tQuHDyvuC4FNXwp2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/JGeVYnO8U614yCdTunIJmYsdISRoKbyw5Gv+gkTQrK9WhixWiviP63/3gUOVw8zP1+RF74SaaLp4Pw8TsGc+nJDcCNEA/HPggItDiwc61u99/60xGlAfDzMyXXakeH/0mXoXjUzfADUiSu7LawoC3yaAVPdP1ohKNsL6GeUQJ4vmd+bAWA8AZRyorNMgluP83Qrr7voaUX3BIeHhzAEAOrmtU4+OaeGgY2AhlM0hZIcl8++VVZwbESCByMn5IC4bpBrJceHXrUJjWEpPK5P/rqfwio8T2JxV8SChoQcOTSxH+wKW+tyP5ZzezCuJcK8+TQT8yZYWVdaobPzHxc8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=STKNlKV8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=STKNlKV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRC5j6JWbz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 02:45:12 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SD4NKH3784140;
	Thu, 28 May 2026 16:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=iXcQxszEjjPgyCAjzQVDY
	7j/G4tQuHDyvuC4FNXwp2Q=; b=STKNlKV86wq+x/Bx23nAI7pdf0ZQWQ6WNKFsV
	m8MSjiI3WJ4mrmk9MZXe+LskvA4nQByabYdj45N4lF99F2k/21uTJteLJdyhV+0b
	CaGcHkNUq5n3OPlTbbOGaKVhwhVIrWg0rENcDog+kb59gdm/K9wT20l0uNX+4VkQ
	gDMsiItAy4RYrQRRyPZ1SSqmQ5onrl1WgI4h/ugWB16/IqHLAYwKRTXjoYqyEihv
	oB1HWr2mKDzhrXtR6pyW+u19NQJy08rkYWIpSx0i5f+Eb26chmzluV+wgO4Ll0VK
	LJb85H0fQWmTYNzQwe1PCiyJQU8y38msCwgxMtMsAMNIPHuYw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889bwjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:45:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SGdN3j007177;
	Thu, 28 May 2026 16:45:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrb913s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 16:45:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SGiuH924838504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 16:44:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E6D02004B;
	Thu, 28 May 2026 16:44:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1205D20049;
	Thu, 28 May 2026 16:44:54 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 28 May 2026 16:44:53 +0000 (GMT)
Date: Thu, 28 May 2026 22:14:53 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Chen, Yu C" <yu.c.chen@intel.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>, tim.c.chen@linux.intel.com
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
 dereference in build_sched_domains on POWER9
Message-ID: <ahhxBaPUhltShhcP@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <74a61427-b5d8-41ad-bc5b-508ee246d510@linux.ibm.com>
 <ahhlrQ1XO47FusNi@linux.ibm.com>
 <3498bef8-8835-4971-a753-029d73acffc7@linux.ibm.com>
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
In-Reply-To: <3498bef8-8835-4971-a753-029d73acffc7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6ZWVZ3rgDYbEFh5xFZE3knNj12WlmH8p
X-Proofpoint-GUID: 6ZWVZ3rgDYbEFh5xFZE3knNj12WlmH8p
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a18710d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=eWJfLxs8EZ6PmFCxo0MA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE2OCBTYWx0ZWRfX1AFrfqxkkfas
 YIdCBvVxb1MOV7THUy8JlX9/5pI8ltFuReYu2o+isbK+k2sy0m3QGMEXqwQ0xZVomrTha/wsC5x
 3RhPsza+AC4baLIfXY8DiTqd93Yi2VYOGVAUHTKxYXivguw5vwJ6WjEXDtKLZAdbbB8j80CsI5k
 KXaMKNSb/D1VgzQzf/uJUZBvldQ4D/yFlnT6Ye4KBHxMAn5ee8P3xo9wE0EpkSk6Pcw99mNWulQ
 PDxytvStRsfTIyhiKoQe/o4uglnt7CGpCrxcki4uOpyk1lx6o1/Sq8PqvibRfSnQMokAOaRaq+A
 X9bjNjjcOyblnU3WtpoezzCCMUcirDnTY52zP4oCrp1z8lpVHb+Uwap3mAXNXl6wkQVOLfsKDTR
 pXBDTZ7tZPYxB6RhZSCfEaY2BhdsmdCDZ10RwtCN3Q+kEfg9l6mZgxcdpd7WMyT5WwqEaDsxZtv
 iQTEikSZMLXABby13sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280168

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-05-28 22:01:53]:

> > > index 3467f86fd78f..cc8e87d6cae9 100644
> > > --- a/arch/powerpc/kernel/smp.c
> > > +++ b/arch/powerpc/kernel/smp.c
> > > @@ -1101,6 +1101,16 @@ const struct cpumask *cpu_die_mask(int cpu)
> > >   }
> > >   EXPORT_SYMBOL_GPL(cpu_die_mask);
> > > +const struct cpumask *arch_llc_mask(int cpu)
> > > +{
> > > +	/* Power9, CACHE domain is the LLC*/
> > > +	if (shared_caches)
> > > +		return cpu_l2_cache_mask(cpu);
> > > +
> > > +	/* For others, SMT domain is the LLC*/
> > > +	return cpu_smt_mask(cpu);
> > > +}
> > 
> > Why dont we do
> > #define arch_llc_mask cpu_l2_cache_mask
> > 
> 
> I would prefer to keep the abstraction. This leaves
> room for implementation details.
> 

We could always do that whenever we need it.
But doing it now will confuse the reader. Why keep if and else when both are
returning the same.

-- 
Thanks and Regards
Srikar Dronamraju

