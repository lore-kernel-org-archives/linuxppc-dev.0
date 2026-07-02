Return-Path: <linuxppc-dev+bounces-23387-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7E5C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 12:02:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grb9S21Nzz2yQG;
	Thu, 02 Jul 2026 22:02:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782993756;
	cv=none; b=KEmTgwy6xId/WX+MbiLOfKHpMdrqQ3rOZ1aNQ72kXrXUdFK/Eh+mbmofPZx84YQxfFhCexJMHKu8JlRi6AmLcW5miqjM+WNlkHfOAEoCmoOh9tnZZU6q01Pd3CXCc3yNhYem2ViS+KHqMif3bblx3/agfnZMGmvOjOlWyVvOgmHId7/WBkpi5ZeubO61U8O6FARzVJZzGYFvOZ0WMVb/GH7afhOnQO6cs/Bxdo911O1OKnzobEdPbLr55VPMytWdInLqAl99zDn0Mkjvqi+ovDrI8cC5TlI6pByTdt4Ibep4gTz+6DkQQOjlqwuZ+ZQDPQTiXX/FcCRB+DKxOonkrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782993756; c=relaxed/relaxed;
	bh=QXmH97+rWFoE2LAC88xt78ijllYCri9Xy6EsF1mVG6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KUaZgl9e/Q5ZHofUNGzo5pDjHE52gFKDIA7H60LEROVPaXKpPBIJYQeA5EHxNNTEEAmQUn+N+OVLwCl/8UkNl4XE4jKLB4pdK7IXk3LVP5zZonnQqR4U3VNqI9pVMeWINNRaEXsw3WYHVIHMupLw92IUOX2LanGpJj1LoiK/6lTbi8TzPrziWmodim2V2loi72INFSrEV11/Tkrp7/T0/tDC4k/oyXqtA8g3dgNcemI6zQutKtjvmJxULiMvG3llFx2Fea2jCSD0+ZaKHkobqjNL7Ssv98ALm3eEZyhwxDd5dp/oI+/43rlGgr5qjHENXkmuJdfodZzs1ZA/emOafw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ml+WJYct; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ml+WJYct;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=svens@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grb9R03YBz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 22:02:34 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621L37U2348150;
	Thu, 2 Jul 2026 12:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QXmH97
	+rWFoE2LAC88xt78ijllYCri9Xy6EsF1mVG6c=; b=ml+WJYctAzI5wdjjSDMgvP
	yYV2w0V14fb3FrleDRxXeZt2X9/C22lawvIy7y0+0JO66Vi6gKw1lfHi9eAyE3iB
	yoS3fYqtxvDpQ43tfL4lGRPA5bWXjXIUzVbxyYQxDdyfE1K1xqrHplG4o7Hdt20S
	AAsRGGTujytG5lXsdMbtKS8RLTE8pa6avsUyvnDduHvV2z5CY707mxKR2JNyI+r7
	IyOEJGe3WbV44naL8/o58lDH/tLH40lAil+soXDKPbWG+Z9RTVSTWMSdqkH2nDOb
	QLgPM5fv80o4n+0Z6dHnxoe02Eo3+yY6DnjNa6v6ZGL9BhLroq2Z252BbEu2DIUQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk1c1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 12:01:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662BnaEX019880;
	Thu, 2 Jul 2026 12:01:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhkrrx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 12:01:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662C13ZQ50987300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 12:01:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4769020049;
	Thu,  2 Jul 2026 12:01:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF39620040;
	Thu,  2 Jul 2026 12:01:02 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Jul 2026 12:01:02 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Jonathan Corbet
 <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Huacai Chen
 <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andy Lutomirski
 <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin"
 <hpa@zytor.com>,
        Andrew Donnellan <andrew+kernel@donnellan.id.au>,
        Mark
 Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jiaxun
 Yang <jiaxun.yang@flygoat.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mukesh Kumar Chaurasiya
 <mkchauras@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Zong
 Li <zong.li@sifive.com>,
        Nam Cao <namcao@linutronix.de>, Deepak Gupta
 <debug@rivosinc.com>,
        Lukas Gerlach <lukas.gerlach@cispa.de>,
        Rui Qi
 <qirui.001@bytedance.com>, Kees Cook <kees@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [RFC] entry: Untangle the return value of
 syscall_enter_from_user_mode from syscall NR
In-Reply-To: <akYreY_BHuRbxSsO@kunlun.suse.cz>
References: <akVRcPsD_R_CE1qW@kunlun.suse.cz> <yt9dechlbyj0.fsf@linux.ibm.com>
	<akYreY_BHuRbxSsO@kunlun.suse.cz>
Date: Thu, 02 Jul 2026 14:01:02 +0200
Message-ID: <yt9d5x2xbny9.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX/Q+2VIkEZeXm
 zSpy3sSNQGU/T2UgslNS6VsPuREql8uSSdJVoQTob97qLRSMv8GJjVr6kKiJKJCJeXAZoKLkJvq
 5f+8ytV2grsx0grvISHbwQ84vmEGrrdzVPGn9ShEzfJJHyfO1sPZ67aE51b4LMU/UA4XKMH4nm3
 i3aZUnP9MOw4vJ1Gv1srPH7aTjCuWOOkR4qKRHoTc08VZ+RLjIvr8Wq1ycDRZScggqf8vwMr62U
 JjJTrtJxIQEPkt6pbRVU3+sX0S+j9wkj8f1eX7QLV6sX7z6Zs+pNzCEJDl3mKhspgytP+uB/ism
 Cbiu9d27//atMwvdZ67Jmyysa6pe9elrVf0h5Ag/2OdiGgMqcKBh7JR9tfXjSJ286bhQpmHm/WG
 VZ+c5pOODZgvCHxA60BGuyRiMofbgW+8J+7uiJsQ4y6cR6g7q0HtmmyhZwGSkt8korNuifin5NM
 AFNwBLKljHK92fKlxUQ==
X-Proofpoint-GUID: 4HRNE-F5FeM-i_rZBbEwAtB_lah-fAD7
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a465304 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=96I0iGyHsLkaCD_aHbUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX3fqq5rJK1Pw6
 XAlVAtz6S5ae1lDAR5UGIg8LAyH/oHFacO80fJr93TGA5Wz3SkDELaofBJAuvm8s6hTRnqUcZGM
 jGAhDbq6yYnrtndAHrmEOWgPfMLlxrw=
X-Proofpoint-ORIG-GUID: COL-UTUh6U9SgZkk02MSCnjQmBsVFo93
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020123

Michal Such=C3=A1nek <msuchanek@suse.de> writes:

> On Thu, Jul 02, 2026 at 10:12:35AM +0200, Sven Schnelle wrote:
>> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>>=20
>> > The return value of syscall_enter_from_user_mode is used both for the
>> > adjusted syscall number and the indicator that a syscall should be
>> > skipped.
>> >
>> > As seccomp can be invoked on any syscall, including invalid ones this
>> > somewhat undermines seccomp.
>> >
>> > While the seccomp variants that terminate the process do not need to
>> > care about this for the filter that sets the syscall return value this
>> > disctinction is required.
>> >
>> > Pass the syscall number as a pointer to the inline entry functions, and
>> > use the return value exclusively for the indication that the syscall is
>> > already handled.
>> >
>> > This should avoid the need for the s390 PIF_SYSCALL_RET_SET which is t=
he
>> > workaround for exactly this deficiency.
>>=20
>> I'm not sure whether PIF_SYSCALL_RET_SET can be removed - the syscall
>> return might still get set by PTRACE_SET_SYSCALL_INFO when the tracee is
>> stopped. This might be a positive number which can't be distinguished
>> from a syscall number. But maybe i'm missing something? It's been quite
>> a while since I touched all that ptrace stuff.
>
> When the syscall return value is set (in the registers) the return value
> which is also the modified syscall number is set to -1 indicating the
> syscall was handled. At least that's how the API is described.
>
> So yes, if the syscall number range is restricted or the syscall number
> is returned through a path different from the function return value the
> flag should not be needed in the entry path because the case can be
> detected through the return value alone.

I'm still failing to see how this would work without an additional
flag. Assume a program (the tracee) is stopped because of a syscall
entry. The tracer then decides to skip the syscall and changes
regs->gpr2 (which contains either the syscall number or return value)
to contain 42. When the tracer than restarts the syscall, how does
do_syscall() know that gpr2 is now a return value and not a syscall number?

