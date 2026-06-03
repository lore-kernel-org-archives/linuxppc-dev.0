Return-Path: <linuxppc-dev+bounces-21945-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44505CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:14:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVcpv2ZKwz2yNn;
	Wed, 03 Jun 2026 16:14:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780467255;
	cv=none; b=X1Yw3jGRwHZ9WbCmDEUZudrGNdNqA4hmaA2zyP/PrZcfXezhUk6eYkjW1VQhpVmzc96spvrIFSxtC+cuJVZ6l3LWzxeT7DW0a3v9iIp5ezgmesmk3ZtCeXOYboY6Wp0GVBE4YWmP7ilMsVde7XjzHOtTG5NjAf8p6P0EoDs8s/pdkSrXUuXo0aZ12Tvg2rf+DYe8KnAAUeH6DDIpEemFF/pIkMtUKzhZERCxGo4xbfl9CW2q/SF1E3bdYkVTDVy+ELpGoKj9p6soUbXV09dAiFyPJ7qu7GBY/9JdRLn+G2RFKiF6NfdaIdwELS8Awuj0SCTjRdurq/Vpy7JP3WwuSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780467255; c=relaxed/relaxed;
	bh=IZG8fDz6wS+yhJGRhFdFkI7GYS/avFdbtWetDfnI3Aw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eKJFdpF7OtTILbZ6m584yAZK941953smCbe7E6doW0rgFaJ/IIBk9XQFCW5kXtADUggpZ5+2r6GMDy+v0mBFK99W+IBRdrhG4B0RrrIZiGwGm39NJdaIhXjnQOia5Q6++LKlPov0WQxECM957ah3ubB2O3sL9x9XY+9Y+27IEJMAkR7hf7eOZzM7PKr4K3KHu3ZFBOjCDt8QZuR0T+NG7XjdTv4StDpN7W/d0nHANuHsfqRArYz0nfsakEh0ZOB9LF57LoJUtahnqJFzRLLulxjpU79sqxjLHPF7X6pF89BTC4FXUN3WSw/GdC4BUET6Jvffrs8t0VheLvm0KYYHLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YeKQEw/l; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YeKQEw/l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVcpt23xBz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:14:13 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652H1gbV745528;
	Wed, 3 Jun 2026 06:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IZG8fD
	z6wS+yhJGRhFdFkI7GYS/avFdbtWetDfnI3Aw=; b=YeKQEw/ld8y4Z6oZqmrOoz
	KYDvmRNoz5Hi8X7nAscWY8d/EedMLwHM+PxwzLfDCxthWxQcItsy1pUdLr5YWmiq
	DgomIhVY584tEJ76Rk6EeKbbAs8NB0G7r1iLZ0AkAsJEHxW+sNWP2sZwRDmnEpYO
	83IFpiqtjQ1qrYnqZvx5a5h7HzrO2kR+7BNbLfNvbhs/yFn2dmmHTaQ/nNV/7gqE
	I2MD0wRF3s9zclw3LMvcajNWGKuDG9WCUv8EhdUAAK84SZln2NXmu+G+V2h269f5
	ZajWN9VdMVXAmVkYvwyy+eO8ynBiHDj5C4nwlGqVZORZCV/Lj19X6EqhKoKcRpQA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm51e4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:14:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6536951u025452;
	Wed, 3 Jun 2026 06:14:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyeh4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:14:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6536E52w56623392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 06:14:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C667920040;
	Wed,  3 Jun 2026 06:14:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE27420043;
	Wed,  3 Jun 2026 06:14:02 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.39.24.39])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 06:14:02 +0000 (GMT)
Message-ID: <786b3540efcd83eed95f5e4fb2e7bd9fbd917474.camel@linux.ibm.com>
Subject: Re: [PATCH 3/3] powerpc/kexec: fix double get_cpu() imbalance in
 kexec_prepare_cpus
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Madhavan Srinivasan
	 <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe Leroy
	 <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain
	 <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Date: Wed, 03 Jun 2026 11:44:01 +0530
In-Reply-To: <45af9f95-da07-45b6-babe-dbae0f7eb318@linux.ibm.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
	 <20260518050855.1147242-4-aboorvad@linux.ibm.com>
	 <45af9f95-da07-45b6-babe-dbae0f7eb318@linux.ibm.com>
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
X-Proofpoint-GUID: 309CtfaZaSwwaWUOtgjq4aGvAT_0OfLk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NiBTYWx0ZWRfX+E5ORlzbp1n0
 o49k2ad0n6VaCKuHLc8UpcsMpJul8DqwqjBoPzL1T0/g14cpNktg3+k1AfAqR5oeuIcPgTDlvY6
 XvqVGB/Kui5pnwl3GauD04IyPBQVsFwrv79ohDFBGEYHs/GkMXwcGUN1vQ+EyoTYvGEsbODdcfD
 xQUTy7XwD2hYRaUk+L67iWxwjdZDHy27klqYOmaELyvMR4LimKhOY7N4AGRp5i3nVK4bwTUHFVN
 89+VXxNvkJiR4Tk3tqM9zMOsKhrpqua9lkL5pll7dSIF+f+7NVrTop4WZ0X49Fwj4kgAAky6vkH
 c9kEb1Fd3eDhl95/nAJcHy0fJQLMyXebqyuC8MvdJbe3361wErvTC0dUFz37zsd7tWHWuRL6xZQ
 ZgVcl1h6YBzQNYO25zQG7YgfxLZqGzWgq6rD4JSJDibqtS3ei1XMlnICrUoIPCijkqc7+EREfg3
 CZ8ev5qJfNLoAShDtZQ==
X-Proofpoint-ORIG-GUID: OFsnAGauXPNfwindnoUmJqIp-cyjECPy
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1fc632 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Oz65gRQD8pac7a9URQIA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030056

Hi Shrikanth,

On Mon, 2026-05-18 at 11:32 +0530, Shrikanth Hegde wrote:
> Hi Aboorva.
>=20
> On 5/18/26 10:38 AM, Aboorva Devarajan wrote:
> > kexec_prepare_cpus_wait() calls get_cpu() internally to obtain the
> > current CPU id. kexec_prepare_cpus() calls kexec_prepare_cpus_wait()
> > twice -- once for KEXEC_STATE_IRQS_OFF and once for
> > KEXEC_STATE_REAL_MODE -- but only issues a single put_cpu() at the end,
> > leaving preempt_count elevated by one extra nesting level.
> >=20
> > In practice the imbalance does not trigger a 'scheduling while atomic'
> > splat because the kexec path is a one-way trip: IRQs are already
> > disabled, no schedule() occurs after the leak, and
> > default_machine_kexec() overwrites preempt_count with HARDIRQ_OFFSET
> > before jumping into kexec_sequence() which never returns. However the
> > bookkeeping is still wrong.
> >=20
> > Lift the get_cpu()/put_cpu() pair into kexec_prepare_cpus() so it is
> > called exactly once, and pass the CPU id to kexec_prepare_cpus_wait()
> > as a parameter. This keeps preempt_count correctly balanced.
> >=20
> > Fixes: 1fc711f7ffb01 ("powerpc/kexec: Fix race in kexec shutdown")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> > =C2=A0 arch/powerpc/kexec/core_64.c | 15 ++++++++-------
> > =C2=A0 1 file changed, 8 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kexec/core_64.c b/arch/powerpc/kexec/core_64.=
c
> > index 825ab8a88f18e..9d7e5a1e6e5b8 100644
> > --- a/arch/powerpc/kexec/core_64.c
> > +++ b/arch/powerpc/kexec/core_64.c
> > @@ -164,12 +164,11 @@ static void kexec_smp_down(void *arg)
> > =C2=A0=C2=A0	/* NOTREACHED */
> > =C2=A0 }
> > =C2=A0=20
> > -static void kexec_prepare_cpus_wait(int wait_state)
> > +static void kexec_prepare_cpus_wait(int wait_state, int my_cpu)
> > =C2=A0 {
> > -	int my_cpu, i, notified=3D-1;
> > +	int i, notified =3D -1;
> > =C2=A0=20
> > =C2=A0=C2=A0	hw_breakpoint_disable();
> > -	my_cpu =3D get_cpu();
> > =C2=A0=C2=A0	/* Make sure each CPU has at least made it to the state we=
 need.
> > =C2=A0=C2=A0	 *
> > =C2=A0=C2=A0	 * FIXME: There is a (slim) chance of a problem if not all=
 of the CPUs
> > @@ -246,6 +245,8 @@ static void wake_offline_cpus(void)
> > =C2=A0=20
> > =C2=A0 static void kexec_prepare_cpus(void)
> > =C2=A0 {
> > +	int my_cpu;
> > +
> > =C2=A0=C2=A0	wake_offline_cpus();
> > =C2=A0=C2=A0	smp_call_function(kexec_smp_down, NULL, /* wait */0);
> > =C2=A0=C2=A0	local_irq_disable();
> > @@ -254,7 +255,8 @@ static void kexec_prepare_cpus(void)
> > =C2=A0=C2=A0	mb(); /* make sure IRQs are disabled before we say they ar=
e */
> > =C2=A0=C2=A0	get_paca()->kexec_state =3D KEXEC_STATE_IRQS_OFF;
> > =C2=A0=20
> > -	kexec_prepare_cpus_wait(KEXEC_STATE_IRQS_OFF);
> > +	my_cpu =3D get_cpu();

> raw_smp_processor_id() is better here. All it needs is get current cpu?
> caller does irq_disable above and that renders call for get_cpu un-necess=
ary.

Agreed, get_cpu() is not needed here. kexec_prepare_cpus() already does
local_irq_disable()/hard_irq_disable() before calling
kexec_prepare_cpus_wait(), so we only need the current cpu id.

I will go ahead with smp_processor_id() rather than
raw_smp_processor_id() to stay consistent with Patch 2 and to keep the
CONFIG_DEBUG_PREEMPT check.

> > =C2=A0=20
> > @@ -262,13 +264,12 @@ static void kexec_prepare_cpus(void)
> > =C2=A0=C2=A0	 * Before removing MMU mappings make sure all CPUs have en=
tered real
> > =C2=A0=C2=A0	 * mode:
> > =C2=A0=C2=A0	 */
> > -	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE);
> > +	kexec_prepare_cpus_wait(KEXEC_STATE_REAL_MODE, my_cpu);
> > +	put_cpu();
> > =C2=A0=20
> > =C2=A0=C2=A0	/* after we tell the others to go down */
> > =C2=A0=C2=A0	if (ppc_md.kexec_cpu_down)
> > =C2=A0=C2=A0		ppc_md.kexec_cpu_down(0, 0);
> > -
> > -	put_cpu();
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 #else /* ! SMP */

Regards,
Aboorva

