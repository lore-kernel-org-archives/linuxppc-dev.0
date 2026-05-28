Return-Path: <linuxppc-dev+bounces-21636-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8103CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 15:59:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRB4P41dPz2xM7;
	Fri, 29 May 2026 01:59:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779983941;
	cv=none; b=kUc8rjXROZSwxUx57fVsbmNUnsXUMbHIB0hRXQBh/8pWem5jcntXbuGx7ShHDR+IDGZEUc34CC7qBS7xpNjRlPIcPWbCsEwbIFBiNbzMFT2ASHf3KrfWW4/0XqlQQ9Fa4OHJW0mllXsLz7fHqsIvd9DJ3kp+pcLkOEwKb6f86BWgLXUcXStt93fkbvHwAhk9pxquDbYNJwPdKwhH7PzGtFx0eh86/JOGQRAmolXzmQ87Wle9mRBqbSJu6BzIHfYrpybYCFd69oYCTZ5aaGUGPokCNshSpa8hSv4glxeukMKmmyBpHi898oDssxmO/Qn2lAugDWG2asPkas9V+/rSfA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779983941; c=relaxed/relaxed;
	bh=a4k+gKCjBXbCOO8QKaKb1xNtzykww9Oe6hiHbJSCBMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tqn0rKMgOz2BRD0Jh45ZPJJlX0rI9WzkCvnQwGSx74sOV1R6rxXUwsuveT/ghYuQYZEHa4QE23sk1QF/JE/cENYGwNw6EHrHlleZ/ZxaScQ07XCKJt89ljToVcSZIBa/bAofB0D9TET7yUcyHujnp6ndY1PMubSN40OnJKLtll7rO/XMBErxs0UkwnHdIiMpgGQvOpR01tjdjlCJFQVG0O2jl00Qs1Rf08TTDJcLh8+8GFOl+FUSq3KJQfwpBSxrNa0do+EIwB0KVW7TDzTY5V/xAArJFnPjqBI1B2wigDGzv1vnkAo8xyAdbFBy1VKNUwASdcKtRTQE7L+TODQyfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SHYIVqlr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SHYIVqlr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=srikar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRB4N5MPWz2xM6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 01:59:00 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SBHRD53784371;
	Thu, 28 May 2026 15:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=a4k+gKCjBXbCOO8QKaKb1
	xNtzykww9Oe6hiHbJSCBMw=; b=SHYIVqlr/TzhBdv2x+mTE+BW79/iMhMTBJ828
	9oQgrGZjY7SzApmQBkkfaaeuPryHWeMhNqe9nGistVB0Bvp+p6gnOwTizvCeKv4W
	ArSVqtaKORNnVosMT/QebHXyKL3rQOUDRqzl9z4yDssV0dMfHlWPB2gXqpwBbSgT
	A4gMqmiloj5FGU3o7NBCrikX267+wHaNC30PlV+Zr/xZ9Zfw38YIGpdBpOu4DoKV
	N2qMOfLvmm+3mXY2FlZmtZBjVhsFRXoWweKAsSY9N21kv3FwwY3ZPXd+S6QqXdFy
	Dds46yuY6+zISTv6Nry3SjscImQLkdwB7pgrUu4r0jPiO7Qbg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889bqat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 15:58:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SFs7kd024905;
	Thu, 28 May 2026 15:58:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb8ugb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 15:58:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SFwgAu15597852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 15:58:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 095B820043;
	Thu, 28 May 2026 15:58:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83B5E20040;
	Thu, 28 May 2026 15:58:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.126.150.29])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 28 May 2026 15:58:39 +0000 (GMT)
Date: Thu, 28 May 2026 21:28:38 +0530
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, kprateek.nayak@amd.com,
        venkat88@linux.ibm.com, maddy@linux.ibm.com, riteshh@linux.ibm.com,
        chleroy@kernel.org, tim.c.chen@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sched@vger.kernel.org
Subject: Re: [BUG] sched/cache: "Make LLC id continuous" causes NULL cpumask
Message-ID: <ahhmLlI62X3Mfkdt@linux.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.ibm.com>
References: <51154de7-3700-4cb4-82f2-1b3a8fa427f7@linux.ibm.com>
 <ahUogeqIq5km7JSr@linux.ibm.com>
 <058664ab-0982-4c13-9d4b-caa2f7616b0f@amd.com>
 <20260526140856.139657-1-yu.c.chen@intel.com>
 <d45877d5-86f1-4581-b3e0-59ceb722de3a@linux.ibm.com>
 <912676bc-230e-410f-a5fe-153b0f304aee@intel.com>
 <42a19577-fe56-44b4-b0ed-37cde6d03ff5@linux.ibm.com>
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
In-Reply-To: <42a19577-fe56-44b4-b0ed-37cde6d03ff5@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nHgcM0YvoVWmIxEQ4qBm28JwHOkXuMh_
X-Proofpoint-GUID: nHgcM0YvoVWmIxEQ4qBm28JwHOkXuMh_
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a186636 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=6UUPjkb784EC9J_kirwA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE1OCBTYWx0ZWRfX5e+bFHofKDaS
 0Zaj0b4AU91Ayk3Z2RPS1UU/t9ZDdWMcqyoXQs0DDUdnvwTnYAxhy8O0VLW+cJU+KpoM+W5osel
 eDIyNI6a0qj2zx9CP71qFOQghmwd+vZrtg4qDi9brv6iR37koPNqOIOVfJBFP5NnSzuiPl7xPUt
 XF7K+aRcTZbcQrzFwq8CayXGdZG4jcJnFzuZs8H3uPGdfp3n9Q1MPBfuMK3i7+Z/1FTEv8T/SSr
 +GTmytGlgiP4clWt7OhLdvdvGyYMTgBWu7EtRvi1KD5oMoX3M7BkCaTRHshG6JVM2XJ92WFaYBL
 iI7BbsXQ9J+58lmCg8eyQ+KA2fRe8SHphuWGHbqoXFe2AtrdhWLFpl0l/C/Ws1+sYJjP19z0L+I
 otu66Q39sdMYK9WXPhXSYB7sKxYoV9CYunp7vkdA9imQ/hVd8yFfk7lHWx0N+Mo/9du02p4Nl63
 830TRgN4PV02VWtsOWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280158

* Shrikanth Hegde <sshegde@linux.ibm.com> [2026-05-27 23:37:30]:

> Hi Chen, Prateek.
> 
>  EXPORT_SYMBOL_GPL(cpu_die_mask);
> 
> +const struct cpumask *arch_llc_mask(int cpu)
> +{
> +       if (has_coregroup_support())
> +               return cpu_coregroup_mask(cpu);
> +       return cpu_smallcore_mask(cpu);
> +}
> +

This is not correct. why should we again send coregroup for llc.


>  int cpu_die_id(int cpu)
>  {
>         if (has_coregroup_support())
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index df2ceb54c970..3b5155121276 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2063,7 +2063,11 @@ const struct cpumask *tl_mc_mask(struct
> sched_domain_topology_level *tl, int cpu
>         return cpu_coregroup_mask(cpu);
>  }
> 

-- 
Thanks and Regards
Srikar Dronamraju

