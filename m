Return-Path: <linuxppc-dev+bounces-19427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C2EDB7ED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Apr 2026 10:20:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqhz72JYyz2yZ3;
	Tue, 07 Apr 2026 20:20:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775557219;
	cv=none; b=QUsN5/FFJZy6HZ8gmzoPpwcEslUa7qo7Amo7IDvdWSCeLQYq7LQhpp+iql+FjP8UTqcovUtISzIJFmxv0DXdWOnhagYh3nAwHawkE4H6fod8oLh90fz2iDJ6cZoJqye2WQe9x0xQTHD7d1H6mqC675QNqJkLQ1Z24EXd5e2F1StN54NBaeu0OhvzCDN/Jt79MJc4MJCHiYpwq7F2wMyhvTvdboOHBI8iU5QS9Sp9Wig2wLzkJmogBDFA8HHN1fCaQ2mCvz6dfr6QDqa1WmDRB6t2khTrxIm8L2CPd6UM0YGbaJ+mZlYDaXJN3iYG8EJMR5dRpmb2r7dyyX5OhKi/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775557219; c=relaxed/relaxed;
	bh=poosSsq6I2IlrZQ/bGYJTqxbs5SAnETy3EMS7ert0L8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGH1facdr9eptuDqg2cM3bf6xG5cT3qdW5D/zUvP8/Z2St8JZvfAjZTQ08s2JC3xKv8401uHjk0JAlPmMGkLL9xP3dTTiTM+08IFahcZc96vEDGIpbb2NcSJ0Ykh6cCtrrXbWLWfClBtL0hh2xro8JgVjQM7Rv9QJzfQWm8D4IVSt7EHJZtu2fo8vil+JZYjpgMERxhoPcvRFPsIp/9r//+NjVO9+qT1BRZr24k7QtvMxbpyDZGQXfIGbGWECr5ttYxJhtXGtEnrdaIdsa6vN8A0HncZ7VDY2NAMzibC8M2HGGgC8TVFJ5eLi4u5bFw4PWDBh82jEcy87vk5V8GnUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=myhXCU7c; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=myhXCU7c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqhz540v5z2ySk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 20:20:16 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LmHTf2592704;
	Tue, 7 Apr 2026 10:20:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=poosSs
	q6I2IlrZQ/bGYJTqxbs5SAnETy3EMS7ert0L8=; b=myhXCU7ch7dIgHO/pvdsvc
	0YxzV1KNgdKvqqiI3/6+qNyboxl6R/gGwJWEWEBiYrkw8m3DetUL33hHKh6XLRlC
	wqviyC93Sz7/80GkDKSka6bxB0Oar1mMnJehGON9c8tWZCYUlLIP8IGgDXr7fOIq
	tvLHD8X2aLYN5BbA5zAqj2JVO+cbvDEVIPSilq2dtaBQfTVj7zia7fuSyYO47Z9M
	VPQr6NIwrSRaGPqNkDIoFIoxkuYRxXBMf5lbwqp6Yvk6B24zr3nJN6UtNpOYY6hB
	CD0nBfaCLYZYj4lfYdyJjt0gv0TxZr4qWfbHGLnfK4waRzGf6qqzPP+YYPYDHHTA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2e2d7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:20:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6378xvSj030058;
	Tue, 7 Apr 2026 10:20:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7a4rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:20:03 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637AJxR315729124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 10:19:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9A6F2007C;
	Tue,  7 Apr 2026 10:19:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 521AC2007B;
	Tue,  7 Apr 2026 10:19:57 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 10:19:57 +0000 (GMT)
Message-ID: <3075019f74969b25e3ab7f6b3f51ee54ed455aaf.camel@linux.ibm.com>
Subject: Re: [PATCH v2] pseries/kexec: skip resetting CPUs added by firmware
 but not started by the kernel
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman	
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
	 <christophe.leroy@csgroup.eu>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Nysal Jan K.A."
 <nysal@linux.ibm.com>,
        Ritesh Harjani	 <ritesh.list@gmail.com>,
        Sourabh
 Jain <sourabhjain@linux.ibm.com>,
        Anushree Mathur
 <anushree.mathur@linux.vnet.ibm.com>
Date: Tue, 07 Apr 2026 15:49:56 +0530
In-Reply-To: <da6f75a7-8a68-46a9-9897-1aef11d33829@linux.ibm.com>
References: <20260330062206.170437-1-shivangu@linux.ibm.com>
	 <da6f75a7-8a68-46a9-9897-1aef11d33829@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3L3oxF9-xhHu2TfNCWynPmp9pSoV3ebj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5NSBTYWx0ZWRfX/ALdGn/b3vRo
 qe4n5lXIjBtTEhTRVGbNNgG2s72yI8ocDvhWU2pWZ8eBfBLxbF+knbILOc4P1L/LRj4EMjjS4cM
 3JV/SQYpAt3YqGU6wol4ABkm+wuE+a3pZ/bVngCfmH/eb9q8UYWq7ubVztUagFOD3b58EYAS7q2
 o7NxLZEM0rzP4bOqGlY0qJcZaBy8wyWNlEkHeIrylC8pr1wJk4R8FGBpzzhdCYHkJnBD29dlqOn
 b7HVubctiEv2V7r8j/DWJrT3UArs/s5BX9Kdhdjunz5m+NiFQVolMmSaYwPA+brHFCuxeD6j7ON
 ktCvo9+WRn3nIPbSqSMr8+ZMAcq9zDG/qfM/MqsXHZsZ6mPrBvYBiAJZxXZDBXct+95pj0flAQo
 gozUBwY0Mq29gbbWna/+tllkGuAM6atJ0d+vnWxek52rrIhAIp0g/hIjAS97YzUnvTpG9+hOeF3
 tVhMUpEiY+YNKqiEWZg==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d4da55 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=sa8xbvTfupTnthYiAgYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: k8JBEXS7pzLsS6ACr50AuM90goflhvsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070095

Hi,=20
Thanks for your review.

On Mon, 2026-04-06 at 14:22 +0530, Vishal Chourasia wrote:
> Hi Shivang,
>=20
> Thanks for working on this issue.
> A few questions and concerns about the approach:
>=20
> 1. Was this issue only observed with QEMU-based virtualization, or
> does=20
> it also reproduce on PowerVM/phyp? The commit message and sample logs
> don't clarify this. If this is QEMU-specific, I think we should fix
> this=20
> in QEMU rather than working around it in the kernel.

Currently this is only happening in Qemu (both tcg and kvm mode). But I
think this should be reproducible on phyp also. Ill confirm wheather it
is really the case or not.=20

> 2. The approach taken here moves away from the PAPR interface. The=20
> kernel currently uses H_SIGNAL_SYS_RESET_ALL_OTHERS, which is the=20
> architecturally defined hcall for this purpose. Replacing it with a=20
> per-CPU loop that checks internal kernel state (paca cpu_start)
> breaks=20
> the clean abstraction between guest and=20
> QEMU's sPAPR implementation should behave the same way. The
> hypervisor=20

Yeah it is a valid concern about ownership for this resets. Ill try to
see if this fix is possible in qemu itself.

> (QEMU) should maintain a list of CPUs that have been=20
> activated/online/started and given to the guest. When=20
> H_SIGNAL_SYS_RESET_ALL_OTHERS is called, QEMU should only reset those
> CPUs that the guest has actually started. Unless the guest makes the=20
> RTAS start-cpu call for a CPU, QEMU should not include that CPU in
> the=20
> set of CPUs to be reset.
>=20
> I think discussing this would help determine the right fix location.
>=20
> Can you refer to the following commit in QEMU to see if help in this
> case.
>=20
> commit fb802acdc8b162084e9e60d42aeba79097d14d2b
> Author: Nicholas Piggin <npiggin@gmail.com>
> Date:=C2=A0 =C2=A0Tue Mar 18 15:03:48 2025 +1000
>=20
> =C2=A0=C2=A0 =C2=A0 ppc/spapr: Fix RTAS stopped state
>=20

Thanks for this reference. cpu->quiesced state was introduced in this
patch, for modelling "RTAS stopped" state.=20

as per the commit message:=20
A KVM spapr guest boots with all secondary CPUs defined to be in the
RTAS stopped" state. In this state, the CPU is only responsive to the
start-cpu RTAS call.

So, we should be able to use this to check wheather cpu is started or
not. Only other concern here would be about phyp's implementation for
this.

Thanks.
~Shivang.




