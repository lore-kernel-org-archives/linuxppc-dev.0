Return-Path: <linuxppc-dev+bounces-26454-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A527C624D4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 19:45:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZtVc1yjvz2yjp;
	Thu, 03 Sep 2026 05:45:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788378312;
	cv=none; b=MDV9YQwe0/TrkCOveKHGfFp8HYD2LcP6InYYmFGgq+ElAha+UQ2lX1vbqZysixRCJjtAfd2NMb0KFpQ88h5uPe1BITr+1LJYu+KD5ql0NT370ZoqwIW9rhnM3U3TH6U2B8Ow7LVFFu/DR3X+cJXjq4iQgSZ0RdD3UEIDMaXwu+0Ebct13pi/lJJdbvS/QEjEoay1tdDIh4r5dW3coitnDOjo1Dd1I4rd2mRXo5Cn5RP+Rg82c/647bZepcjgrYpHkenOVFhLFSDBpWtbiVDs+TFOcXmPxlpl8eumTHGxSKVkdmP0XrvGnDZhW58FSBLYRel91+nwOCAxqIMucSpwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788378312; c=relaxed/relaxed;
	bh=bFIZvIZ6TByI4I0TMOgohhJsLheCJMeTeiL2xkc+g2k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nf30BqX4DMCapMFh5xGmPmw83cCoVxd9lzJPETY+tNt3UyoPYv+F6hUsmyC7sZq6+q+nMfig4bmpyWTvUq0ythVas+4vbtq1HF6DLCelkKMmdGNvQiruFGOerWT34lJttuXs6iQblQOXYYmYJJYdZmoSfMWTedn5IORLPW8+/RrYO1yhE0EL/Qvy3t0tzPLcbYQoGz9hp81sxG1+EjhrJhwO//N387n9cHai72ZcTdBgtVb+C6njYyaVvVHSARiAgvs26LPVM1iVbuGLDbi5hhKrF+SQfDGweGRegDENm+GHkMwSBpvmwaY0HFXUqSvCw6+cNdbcliC2biTMy/XwWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RyQWeGCu; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RyQWeGCu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZtVb0Y47z2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 05:45:10 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682I1ZiQ723223;
	Wed, 2 Sep 2026 19:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bFIZvI
	Z6TByI4I0TMOgohhJsLheCJMeTeiL2xkc+g2k=; b=RyQWeGCucxkxuW+WWeATKJ
	qkXvQgMKxiar78E7pT74IGU0yFXgPqfvyM0vsx7YyCUyFUwAPYZRr8PKi/ViCfvh
	hGarEm+BNrT+8qnrPvk6rHBvHcFGsrSsr4A7Gc2WAdT+t7X+aR3RWZCSV3wEd+jW
	kc17wOSKFifDY1FPLjQYwl4HsNp+h3qyFYBECwOoJ6pI4K1zZ6DHLaEIaQ8XRPb+
	y7ztgEcfzB6FWSymTYBX1xQXiLAicqJ7RVWxKFNq8VAyP/PyfdVBJgoU1UOMp4u6
	4nU/6GaNAKBBqe0pxU4FjUFZJ+mLYrgfJGIxPclZPS6iWznGzhkTMDMKpD2vkOSQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq551415-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 19:45:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682JfJKK004219;
	Wed, 2 Sep 2026 19:45:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkc0jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 19:45:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682Jj0Bk40370590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 19:45:00 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 193DC20040;
	Wed,  2 Sep 2026 19:45:00 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BD612004D;
	Wed,  2 Sep 2026 19:44:57 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.36.18.93])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 19:44:57 +0000 (GMT)
Message-ID: <742182de86c038f6b8a01a6c418469e7f8255595.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/entry: Fix double accounting of user time on
 interrupt entry
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Mukesh Kumar
 Chaurasiya <mchauras@linux.ibm.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, aboorvad@linux.ibm.com,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Date: Thu, 03 Sep 2026 01:14:56 +0530
In-Reply-To: <cd25ffa5-5efc-42f1-b145-0c1c6539b4c4@kernel.org>
References: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
	 <cd25ffa5-5efc-42f1-b145-0c1c6539b4c4@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE3MyBTYWx0ZWRfX5YmZHTuxqJAe
 l8LxbmTnvHdCoUhtYIY7EMWHIRkrLdQz8butTZL/nNavzd7ONUF0jpNMJt61lUSsgK2AoGvabfW
 H176Up5G9zwYryD4GY4w+EVRhxex2JuWT7jJHIZqDTfO68dKXBv5gLMblgegPResfDS/GbRwDwi
 PtKkrPKdrLkkBppytJt31Cr9yX0LtLGJgHJR69m9SpQjEPzRH5aBEZDCZcNqQxgkFvrTdqr9B62
 EScpMZpSkYKOv17sQydXjpuFv2+AOgmGwYNI8eI2tDK8MuysddrHYavLurFmuCnPpEfDiBMRhsa
 JtJlyY41iAw3Gr12dhPTZiNOtybgnjjzhFV3+5vJ92bVQ48txjDZgA2vVHukumZfpArJoe5rFqP
 D+7eWK6vPnaJT35IuliECJl2o7hI+/dXWamnHvEBjd/2ZMA1AROlBcDUsKstk2iAkW2oCRVIB/Q
 obG1iXdPIIhMiQU8e5w==
X-Proofpoint-ORIG-GUID: TyMcjxi0QfSYfPCKUUw7FQ8Lr5HiNTMp
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a987cc2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=HjTMWmxqODYMH3nO9VIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: GM494aMV_57jIkM_938BwgLxRjfrP1mV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE3MyBTYWx0ZWRfX+XSVcpjXO3bg
 2csljucqRrGHbknljI0N+V8v0ii+fOsFeRaF6ghWKMp4vZZoMdLpgtUO3VYqzD9F8qew8ZhsGyy
 EyCitYKGD/VlANLX0Sp+2VNWjaHDTdU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020173

On Wed, 2026-09-02 at 07:36 +0200, Christophe Leroy (CS GROUP) wrote:
>=20
>=20

Hi Christophe,

Thanks for reviewing the patch.

> Le 02/09/2026 =C3=A0 07:06, Aboorva Devarajan a =C3=A9crit=C2=A0:
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
>=20
> One of them was added by commit 09a9d3a8499d ("powerpc: introduce=20
> arch_enter_from_user_mode"), the other one by commit 893082ac769b=20
> ("powerpc: Prepare for IRQ entry exit").=C2=A0
>=20
> Would be good to mention it and explain how it went wrong.
>=20

Sure, I'll explain this in the commit message.

>=20
> >=20
> > With CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=3Dy this roughly doubles the
> > reported user time of any workload that takes interrupts. On a
> > pseries LPAR, ps/top show ~200% CPU for a single-threaded CPU-bound
> > loop, and time(1) reports user time about twice the elapsed time.
> >=20
> > Remove the accounting from arch_interrupt_enter_prepare() and rely on
> > arch_enter_from_user_mode(), which runs for both syscalls and
> > interrupts. The duplicate account_stolen_time() call is removed the
> > same way.
> >=20
> > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
>=20
> Not sure it is the correct commit. Should probably be one of the ones
> that introduced the wrong call.

The history is as follows:

Commit 09a9d3a8499d ("powerpc: introduce arch_enter_from_user_mode")
introduced the arch_enter_from_user_mode() function with the accounting,
but the function was not called at that point. Commit 893082ac769b
("powerpc: Prepare for IRQ entry exit") introduced arch_interrupt_enter_pre=
pare()
and copied the accounting from interrupt_enter_prepare() into it, but the
new helper was not used either. Both changes were preparatory and did not
change the accounting behavior.

Commit bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") made both pat=
hs
active. The syscall path removed its open-coded account_cpu_user_entry() an=
d
started accounting through arch_enter_from_user_mode(). But the interrupt p=
ath
started using arch_interrupt_enter_prepare() followed by irqentry_enter(),
which also invokes arch_enter_from_user_mode(), while the accounting in
arch_interrupt_enter_prepare() remained. This resulted in the same user-tim=
e
interval being accounted twice for interrupts taken from user mode.

I used bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature") as the Fixes
tag because 893082ac769b only introduced the accounting call while
arch_interrupt_enter_prepare() was unused. bee25f97ad24 is where the duplic=
ate
accounting actually became functional.

Would it be ok to keep bee25f97ad24 as the Fixes tag? Please let me know if
you think 893082ac769b would be more appropriate.

>=20
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> > Verified on a pseries LPAR (CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=3Dy),
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
>=20
> Don't polute the code with such a comment. This is to be explained in
> the commit message. First a comment shall tell what code does, not what=
=20
> it doesn't do. And the comment has no added value, when you see=20
> account_cpu_user_entry() is called you already know that.
>=20
> Here you feel the need to add such comment, but if you had implemented=
=20
> this function yourself and done it right at the first time, would you
> have felt the need for this comment ?
>=20
> Have a look at https://docs.kernel.org/process/coding-style.html#commenti=
ng

Agreed, thanks for pointing this out. I'll drop the comment in v2.


> > =C2=A0=C2=A0	account_cpu_user_entry();
> > =C2=A0=C2=A0	account_stolen_time();
> > =C2=A0=20
> >=20
> > base-commit: fb442a6673ff1046bf67754957d95880fdb394b5

Regards,
Aboorva

