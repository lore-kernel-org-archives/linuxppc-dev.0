Return-Path: <linuxppc-dev+bounces-19665-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F29EBFD03
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 07:00:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvJFQ67WPz2yjV;
	Mon, 13 Apr 2026 17:00:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776063610;
	cv=none; b=HtgQ/gSq66NqbiG26zy8/U6dgTc5t/b2R54W3hMuXu+/C/G000YWstIgATbndLl7RiAMldpCULVyFOlkSEjo6mPKvp9+/9pXjsC7ODqOmeU7UAYClyImGpBIbDdPw3eQPttwHyVuCJwO8SOnNkcQTnKe5YtkmrBNdq3dmLcK7AJuMd+3RnTYOL4Iq52tfwGX6K4PsO+pSWRJwk72ToBQAhO2N9wmMcIPJCM4eX5JREzLJX8gkIGakz8/WIQO5eHlM/Y4V/6PAFPmrvAdI+SdoZy9DuRsOiwSfbGQWrRGjrD+Ten3YlAPtZ6QqLVUHnXEleCAHuGm2+naEQEMZksdlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776063610; c=relaxed/relaxed;
	bh=ANjFRe4M8fBQTznoa9KGN8nYwgDjVhLGlZTpRrytd4c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EpyRrScdgkceU4r+EYbSlD09V74K8A7RsSJmSHbosynohpNu4UfZUplzGzUkbQWeHkZYs9BwR4ri3F6eCdDCT1PrfAcewWDgUw9cI000zgL6ALUsIRoa5oiMfBVGUr/b+omyuTS/3t4Sd4YRipr90jhcykLqIc98M3h+fGNd14A5ZyIeoGPYoyDq1Xgx3zmZ86wBVqe++QinR1MnVo3B/yyK5ttbFY5Yypv7Ny4+Rt7zlZaCMT41ZrLdRMUg+TrG2eZEks9F5Svjojqdn0Hay0DbjEqtTEmd573tCfmkfNjtscWNuIPR64iM/WJRvCNr3D22h2XH9hQcR24rj0Xxkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C4cABJJI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=C4cABJJI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvJFN5GpBz2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 17:00:08 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CBvBFX2352800;
	Mon, 13 Apr 2026 06:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ANjFRe
	4M8fBQTznoa9KGN8nYwgDjVhLGlZTpRrytd4c=; b=C4cABJJIakPoZHJnUs2SJh
	RoD7GOW6x8VmoMQ7tIzkPCHTWNutlL+bS6gAByt2i80/Dd/ZkTxmQmcyXOBmgeeu
	0G6WP4U8I3Scj34zOWz+Ljvt6aPVYi2Q7xQReudWLB1fFxQ7dFrgGnYkB46Ula1g
	iHzDNg2TvcEU8Xazf/mYRNxOefISr1bGLnLnhzlhuYIEfqA9JtiGQfg0H89AA6cf
	l6hpNEW0PqtPESAuoMk5F6+gQn+TFJv2YpMBZBCm+1Elb/923659ePw/YmjzMSrx
	V5VWn9mk8pUr37q3vBhdna1xAR/YvwKKnhVzCDKoI5ZqpMkmFntshbj4GYvGWcGg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdt3pebm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 06:59:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D3uZSh004162;
	Mon, 13 Apr 2026 06:59:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mn41xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 06:59:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63D6xoIt29032958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 06:59:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E877520043;
	Mon, 13 Apr 2026 06:59:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6E4220040;
	Mon, 13 Apr 2026 06:59:46 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 06:59:46 +0000 (GMT)
Message-ID: <9dea69ff2e99a7314d669249581912b678ab15d4.camel@linux.ibm.com>
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
Date: Mon, 13 Apr 2026 12:29:43 +0530
In-Reply-To: <0732de44-964c-4e0f-b4fd-dcc631ba70fa@linux.ibm.com>
References: <20260330062206.170437-1-shivangu@linux.ibm.com>
		 <da6f75a7-8a68-46a9-9897-1aef11d33829@linux.ibm.com>
		 <3075019f74969b25e3ab7f6b3f51ee54ed455aaf.camel@linux.ibm.com>
		 <0732de44-964c-4e0f-b4fd-dcc631ba70fa@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: _My4aGvO-RtgmVYUkK0C1q0Kf1iKfOGO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA2NCBTYWx0ZWRfX4f0hWARM8wQX
 qYkgdw5YW6k8WLKthuXQsuT+0oVeqxjh/gT0YBTe3R7az3d+BJYqAiaore7CnksRzs/9LtDVhJd
 F0300EjSb8nzQZJQAwjzmU/PCT3fD80G7oT+oes2k7mypKtTf83632c5nBTKqj6Ch+UnHbzM5U2
 BjugM9Lg1Ek99COCQl/sYScXS/CsPd8F/01WK53Cr4zqG83GFCU8kY6OSdCyDSzHCdxgvAYZXLT
 Z5FEW2V/DhhEhvEWLGhcjnafUQek0FuEMfBBIZAcqRw7p5v4Vkyi/+rUHOPl2Wtj4YJgRVhxOz1
 GbM7ucztt7IEsUdik8Kd/LpSXwKaAA3Xvma/M09+hdTKLxMqmKoO6eaRLLdT4kdEVJ12OfjkKOD
 rZKGfI6VwmpyeQA3Ms8Dx+G1DY2hKj12AIDtP81pAj/VLybgUp6EKri4BHPXGKW7rWXkSaStqVL
 zhvPncGDDNOROgISNyQ==
X-Proofpoint-GUID: 2WyQkSRZz5LqHAxX8WjUIYcmCwK8M7Qx
X-Authority-Analysis: v=2.4 cv=WpEb99fv c=1 sm=1 tr=0 ts=69dc946b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=pGLkceISAAAA:8
 a=QxhYo2x1SfaFJ5ueYPkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130064

On Tue, 2026-04-07 at 15:55 +0530, Vishal Chourasia wrote:
> On 07/04/26 15:49, Shivang Upadhyay wrote:
> > Hi,
> > Thanks for your review.
> >=20
> > On Mon, 2026-04-06 at 14:22 +0530, Vishal Chourasia wrote:
> > > Hi Shivang,
> > >=20
> > > Thanks for working on this issue.
> > > A few questions and concerns about the approach:
> > >=20
> > > 1. Was this issue only observed with QEMU-based virtualization,
> > > or
> > > does
> > > it also reproduce on PowerVM/phyp? The commit message and sample
> > > logs
> > > don't clarify this. If this is QEMU-specific, I think we should
> > > fix
> > > this
> > > in QEMU rather than working around it in the kernel.
> > Currently this is only happening in Qemu (both tcg and kvm mode).
> > But I
> > think this should be reproducible on phyp also. Ill confirm
> > wheather it
> > is really the case or not.
> >=20
> > > 2. The approach taken here moves away from the PAPR interface.
> > > The
> > > kernel currently uses H_SIGNAL_SYS_RESET_ALL_OTHERS, which is the
> > > architecturally defined hcall for this purpose. Replacing it with
> > > a
> > > per-CPU loop that checks internal kernel state (paca cpu_start)
> > > breaks
> > > the clean abstraction between guest and
> > > QEMU's sPAPR implementation should behave the same way. The
> > > hypervisor
> > Yeah it is a valid concern about ownership for this resets. Ill try
> > to
> > see if this fix is possible in qemu itself.
> >=20
> > > (QEMU) should maintain a list of CPUs that have been
> > > activated/online/started and given to the guest. When
> > > H_SIGNAL_SYS_RESET_ALL_OTHERS is called, QEMU should only reset
> > > those
> > > CPUs that the guest has actually started. Unless the guest makes
> > > the
> > > RTAS start-cpu call for a CPU, QEMU should not include that CPU
> > > in
> > > the
> > > set of CPUs to be reset.
> > >=20
> > > I think discussing this would help determine the right fix
> > > location.
> > >=20
> > > Can you refer to the following commit in QEMU to see if help in
> > > this
> > > case.
> > >=20
> > > commit fb802acdc8b162084e9e60d42aeba79097d14d2b
> > > Author: Nicholas Piggin <npiggin@gmail.com>
> > > Date:=C2=A0 =C2=A0Tue Mar 18 15:03:48 2025 +1000
> > >=20
> > > =C2=A0=C2=A0=C2=A0 =C2=A0 ppc/spapr: Fix RTAS stopped state
> > >=20
> > Thanks for this reference. cpu->quiesced state was introduced in
> > this
> > patch, for modelling "RTAS stopped" state.
> >=20
> > as per the commit message:
> > A KVM spapr guest boots with all secondary CPUs defined to be in
> > the
> > RTAS stopped" state. In this state, the CPU is only responsive to
> > the
> > start-cpu RTAS call.
> >=20
> > So, we should be able to use this to check wheather cpu is started
> > or
> > not. Only other concern here would be about phyp's implementation
> > for
> > this.
>=20
> Yes, something like this.
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
>=20
> index 032805a8d0..8c51372cf8 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1105,6 +1105,9 @@ static target_ulong
> h_signal_sys_reset(PowerPCCPU=20
> *cpu,
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> +
> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (c->env.quiesced) continue;
> +
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0run_on_cpu(cs, spap=
r_do_system_reset_on_cpu,
> RUN_ON_CPU_NULL);
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return H_SUCCESS;
>=20
Hi Vishal,

 The changes mentioned above are also able to solve this bug in my
local testing. Which means "env.quiesced" state is enough to track the
kernel's cpu bringup state.

So if phyp is able to independently handle this case then we will not
require this as kernel modification. I am Yet to do that test.

Thanks.
~Shivang
>=20

