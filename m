Return-Path: <linuxppc-dev+bounces-26455-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E65C624D4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 20:14:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZv876pBNz2ypW;
	Thu, 03 Sep 2026 06:14:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788380055;
	cv=none; b=CSnB6zh9y5fiCHwzJyZ7RDfH1APCKagNZ8eU6lqTU5wo3hbj9Q38E6P4kOcrVASoEPm1MMp3/3eyOzOCDsM+nUmCrApBVeR/x6k18fYPg4k/K1ZcKegzIiFZFispdgfEg0eOQRUS5OE1+ISNAdr8RRYYJSEH52xYap6wrYb5zcbnpMQMcBMHiImovT9dW9DWrLBAu+a51xehyhFSlYZ+W1QWTF/uH3yYHiTSh2m6Bwu6y8Hdi/CEU1yZ5Ll1lrvHq1Kv+ktjPmVbIUHgYhK5pkgnUSy7+N1JJ36xTtC8C3i1j3cvBfq8t01gcHWnCtZJb73qrWlB5LT+Odi67SeDvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788380055; c=relaxed/relaxed;
	bh=vOx4tcQvro1eM7A4lRZSKqXvPfVUtTIPbWFZwRZg64k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SmNQ1nt4eI+TuPQvqiq2t3mEH62szPykBBgjyJQ3JLav+6088HM22VaOOgqACH17byyNZSjQDXg5/+yvXSomhQFcxGtuHPBM+XtVLIUyUlyNTiExt+WAJQPqlwyoQgUlHetokpW019YBrYAVoChDjfyNnh2zVJF9Mrm7jVW8uZiXoZozjiefVepH5oKuATM1k6XA354lbHMACZTTWD0d5TJNN2UG3entaElzYKTXeWtuCUZKTW/QYCXEhf8BC9aMlj+BDDsyqLx6tG3goGNYQlF7fYyzDbf9sy3qL74i+kreeDttDu43gb25mw5gu13MuJJpKmb11/2t0CuV51ztyg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lpm2mECD; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=lpm2mECD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZv871C5Jz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 06:14:14 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682I1cpn726397;
	Wed, 2 Sep 2026 20:14:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vOx4tc
	Qvro1eM7A4lRZSKqXvPfVUtTIPbWFZwRZg64k=; b=lpm2mECDR5aBuTCve9GQPF
	llMN90hFFLGgjCg1WFRS+y16wuTmf1DVJnQzs5xrX8h+XGTcDMw8mqCed7PzVanu
	sqQml696+jdjN4fiwMT71gbZOs6Qc08ZW5BtuOo3En3TCpuwiiLVs8iG+lV1iQnU
	RwJEOA+FxPS/vznaOlwVb04p/oMVnmoz+RNLa9RmWK6QBYPUo5BQ4w+0yDKhym0i
	mxsMi7yEEtiLUE28ipO30/jzI1hJUE/fopsKKBi1tgoY6T8f19GAm+inUyxvkEHF
	UWm1sYrm1uqYH7r8T9d9xY4lm/k5WXDABZcWbfL+f+wcLFmFL/T7dpExQSBiexqA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5s7n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 20:14:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682KBGfp012636;
	Wed, 2 Sep 2026 20:14:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygkywx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 20:14:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682KE6st10879348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 20:14:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C09620040;
	Wed,  2 Sep 2026 20:14:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C73A20043;
	Wed,  2 Sep 2026 20:14:04 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.36.18.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 20:14:04 +0000 (GMT)
Message-ID: <032f834f0f6147649d9a29ec17ac62551dbf5142.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/entry: Fix double accounting of user time on
 interrupt entry
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Madhavan Srinivasan
 <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Mukesh Kumar
 Chaurasiya <mchauras@linux.ibm.com>
Date: Thu, 03 Sep 2026 01:44:03 +0530
In-Reply-To: <95913fca-5631-40ff-abed-4afad99722e6@linux.ibm.com>
References: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
	 <95913fca-5631-40ff-abed-4afad99722e6@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
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
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a988393 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=opBZN2_kVkm32md8eYUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kdUp5yMMC6YSYQDO8nSVRAi8OQm0_HHK
X-Proofpoint-ORIG-GUID: YfOAApO53ATYyMFSuGLlbDc3fzKihqZp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3NyBTYWx0ZWRfX6tCxOhQZZkpq
 3lbtPSG59kuNVMmxxWO1+sxjtX1ChkvdIHLjmPkSLlM+J9AcfRnOZDK0ABUrkuntc5i+Nz4vL73
 jW9x7T6TYBT9fUjmSncdEnNSbnwAx6U=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3NyBTYWx0ZWRfX9uK5SAzl3BoU
 R5OMEpilG6gbt4dSJlRJacbProDdxSSjTyAmEo9K9btTlLW7MMuTm9QA6WoApT1upYCBVGquVZi
 eZEJi6B0HuS+NQ8UBp6Tc6A2iq3qMkjpR6uoMG9asrANXb4dcLJQGn2Trgpun3+6l8Bf8uCxzmJ
 NCsq+PtVB21iuzviAfGpnzY6pk5qy5kF/d+SXjs6uh2KcGdr0hlh5HKp2a9z1PEJStBYVPEK7Jm
 p8eblFlQre97rIzEovm4mkZbmy/RlucvNPRLWY9owo1ZIK9380vjqSHUcUUSjIZXYOuvCOoZ8R+
 fk74dsGY0i5ywQR4kV0/Oq/otZYJMvSe+LfuSHoZxXvzCbV+8wo7Jbl39WEB74/+NbRuMM11sFS
 9UyFEHBD4CH6BGcTxaMHvE+Pp6EOuehwCdxGfo4/AILWtpPBbt8vLyI5lJT73rrLmX0PzmYpdW8
 jo1oN4YfEAi9lG4znfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020177

On Wed, 2026-09-02 at 12:37 +0530, Shrikanth Hegde wrote:

Hi Shrikanth,

> Hi Aboorva.
>=20
> On 9/2/26 10:36 AM, Aboorva Devarajan wrote:
> > Since the switch to generic entry, an interrupt taken from user mode
> > accounts user time twice: once in arch_interrupt_enter_prepare() and
> > again in arch_enter_from_user_mode(), which irqentry_enter() invokes
> > for the same interrupt:
> >=20
> > =C2=A0=C2=A0 arch_interrupt_enter_prepare()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 account_cpu_user_entry()
> > =C2=A0=C2=A0 irqentry_enter()
> > =C2=A0=C2=A0=C2=A0=C2=A0 arch_enter_from_user_mode()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 account_cpu_user_entry()
> >=20
> > account_cpu_user_entry() accumulates the time spent in user mode
> > since the last return to user space, so the second call charges the
> > same interval again.
> >=20
> > With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=3Dy this roughly doubles the
> > reported user time of any workload that takes interrupts. On a
> > pseries LPAR, ps/top show ~200% CPU for a single-threaded CPU-bound
> > loop, and time(1) reports user time about twice the elapsed time.
> >=20
>=20
> Could you please run mpstat with 50% or less loading workload like stress=
-ng
> and document the difference in changelog.

Sure, will add it in v2.

1. On the same pseries LPAR, taskset -c 6 stress-ng --cpu 1 --cpu-load 50:

Without the patch, the reported %usr is inflated, while with the patch
it is close to the expected 50%.

Without Patch:
06:43:09 AM  CPU    %usr**   %nice    %sys %iowait    %irq   %soft  %steal =
 %guest  %gnice   %idle
06:43:10 AM    6   69.74     0.00    0.00    0.00    0.00    0.00    0.00  =
  0.00    0.00   30.26

With Patch:
06:29:33 AM  CPU    %usr**   %nice    %sys %iowait    %irq   %soft  %steal =
 %guest  %gnice   %idle
06:29:34 AM    6   48.51     0.00    0.00    0.00    0.99    0.00    0.00  =
  0.00    0.00   50.50

2. Single-threaded CPU-bound workload:

taskset -c 100 python3 -c 'while True: pass' (executed for ~3 seconds)

Without patch:
TIME         ELAPSED %CPU
00:00:06       00:02  209

With patch:
TIME         ELAPSED %CPU
00:00:03       00:03  104

>=20
> > Remove the accounting from arch_interrupt_enter_prepare() and rely on
> > arch_enter_from_user_mode(), which runs for both syscalls and
> > interrupts. The duplicate account_stolen_time() call is removed the
> > same way.
> >=20
> > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> > Verified on a pseries LPAR (CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=3Dy),
>=20
> Usual default is VIRT_CPU_ACCOUNTING_GEN, selected by NO_HZ_FULL.
> Most distros usually enable NO_HZ_FULL=3Dy.
>=20
> At hindsight, I don't see the issue dependency on it. But better to be su=
re.

It is only observed with CONFIG_VIRT_CPU_ACCOUNTING_NATIVE.

account_cpu_user_entry() updates utime only with NATIVE accounting.
With CONFIG_VIRT_CPU_ACCOUNTING_GEN or tick-based accounting, it is
an empty stub and therefore a no-op.

So kernels using CONFIG_VIRT_CPU_ACCOUNTING_GEN or tick-based accounting
are not affected.

> > 7.3.0-rc1, single-threaded CPU-bound loop:
> >=20
> > Before:
> >=20
> > =C2=A0=C2=A0 $ python3 -c 'while True: pass' &
> > =C2=A0=C2=A0 $ sleep 3; ps -p $! -o pid,etime,time,pcpu
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PID=C2=A0=C2=A0=C2=A0=C2=A0 ELAPSE=
D=C2=A0=C2=A0=C2=A0=C2=A0 TIME %CPU
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4980=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 00:03 00:00:06=C2=A0 210
> >=20
> > After:
> >=20
> > =C2=A0=C2=A0 $ python3 -c 'while True: pass' &
> > =C2=A0=C2=A0 $ sleep 3; ps -p $! -o pid,etime,time,pcpu
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PID=C2=A0=C2=A0=C2=A0=C2=A0 ELAPSE=
D=C2=A0=C2=A0=C2=A0=C2=A0 TIME %CPU
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4951=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 00:03 00:00:03=C2=A0 105
> >=20
> > =C2=A0 arch/powerpc/include/asm/entry-common.h | 6 ++++--
> > =C2=A0 1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/inc=
lude/asm/entry-common.h
> > index c5adb5006361..984294e62568 100644
> > --- a/arch/powerpc/include/asm/entry-common.h
> > +++ b/arch/powerpc/include/asm/entry-common.h
> > @@ -222,8 +222,6 @@ static inline void arch_interrupt_enter_prepare(str=
uct pt_regs *regs)
> > =C2=A0=20
> > =C2=A0=C2=A0	if (user_mode(regs)) {
> > =C2=A0=C2=A0		kuap_lock();
> > -		account_cpu_user_entry();
> > -		account_stolen_time();
> > =C2=A0=C2=A0	} else {
> > =C2=A0=C2=A0		kuap_save_and_lock(regs);
> > =C2=A0=C2=A0		/*
> > @@ -426,6 +424,10 @@ static __always_inline void arch_enter_from_user_m=
ode(struct pt_regs *regs)
> > =C2=A0 #endif
> > =C2=A0=C2=A0	kuap_assert_locked();
> > =C2=A0=C2=A0	booke_restore_dbcr0();
> > +	/*
> > +	 * User and stolen time is accounted here for every entry from
> > +	 * user mode. The interrupt prepare hooks must not account again.
> > +	 */
> > =C2=A0=C2=A0	account_cpu_user_entry();
> > =C2=A0=C2=A0	account_stolen_time();
> > =C2=A0=20
> >=20
> > base-commit: fb442a6673ff1046bf67754957d95880fdb394b5

Thanks,
Aboorva

