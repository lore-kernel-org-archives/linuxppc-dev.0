Return-Path: <linuxppc-dev+bounces-21944-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF36CD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:09:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVchq6l0vz2yNn;
	Wed, 03 Jun 2026 16:08:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780466939;
	cv=none; b=YAKgUw86NX2Pdgur565XDdQMoJv/nADXdZf+N1Wr888gYB43Fs+0XnAFyZNbYmznHc+xMmhW631PT1YEtQ06qqyF/qTqd9KcJ2cI9X4JWuZC7X98mFqysokRWnGLZUKzYrYqeaxyDSvCuHt6ReSooRNvb1yyLr/eOyvYJ5KBXFfOkp4jVUuYmEPhBwV1wEgfN7FNShzFlKkhPA1oPYDc0Af9Vv01czLAdAGY/eS2CdPruC1PuRg5EZAfHzPkMsqMRDjoxi1ytihACOrSq+LFOu2DypD2kdB+6zRp6g99O4KXSMFBsPFDuD9b6n0fmUmNLbcWyu9LrbLS64lepzNJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780466939; c=relaxed/relaxed;
	bh=95WJe2ld0amV14OU1UZb8DE77vln26nKbfGACzakO+8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R+So/1pQtBxGuSC4XVhrYzofUkDHNwTGiYaY7rSedaNIcKUQZT+yevwpymYzgaFUTSfpUt4DJm2nCKXw9AHxF78OKCV6HIzcOGNmjUgeMAGjUtVNEnzFXCHmNp9BC/2oQ6StM7BOlg4ce5kdOLzdP1e9jcPlgxPau8VDsLvW5qzmo43gkAyJmC0C4wz2kLl1ukkQ+4R5RuR4SRslDbra3KSUbAV693o6tEquJR40UpLU63gbUN8i+MdRnClSeFqOrOXuQVoGJm3NKq49+YwszbL21MAG16D9K7mm2MZ5gbN8qA/865lHUQjjgMTe8PE7wYla0/4HGj2PNbgupnYo8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M308w3x6; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M308w3x6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVchp5jl5z2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:08:58 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652No0OE2403880;
	Wed, 3 Jun 2026 06:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=95WJe2
	ld0amV14OU1UZb8DE77vln26nKbfGACzakO+8=; b=M308w3x6pCxlU1vnqw36Sz
	Kn+n2X4eJvJx0muktbU8qJirdct2nJ/zM54Y5V44imj79DnIdpE62fX1bwt7V8hF
	xQfIEKI9yxpGevE4uG47wOCQAgPFLExIkNUn+MmBgNsFv9BaphFu1SawkLUGOSXQ
	ZFvz2I4GPEyDFHPK+1gjRZk5mnJ1OIR9jtEHV4gVW6m1WUXxRfYq+MXglz6dJatE
	2vZ8lxjvjYnVhZJKGRBzt/MziAEgphK+STmLQrcUIxYQm6wcWZvQl/tXLu9zhdaB
	r6vtujQKNpXGGIP2CFSI9xP6TqxixY3sy0oFug9zrMhpShRslUlT9Lz/cmhjdqIg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpae902a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:08:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6535s8gb019598;
	Wed, 3 Jun 2026 06:08:52 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7qf0p5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:08:52 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65368mrF46727546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 06:08:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D32292004B;
	Wed,  3 Jun 2026 06:08:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31DAE20040;
	Wed,  3 Jun 2026 06:08:46 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.39.24.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 06:08:45 +0000 (GMT)
Message-ID: <953a5a29dc71c5f3067f977b48c6da1ba36d58ac.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] powerpc/powernv: fix preempt count leak in
 pnv_kexec_wait_secondaries_down
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
Date: Wed, 03 Jun 2026 11:38:44 +0530
In-Reply-To: <99da8dfa-2624-44fb-96c5-ff7eddf717ac@linux.ibm.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
	 <20260518050855.1147242-3-aboorvad@linux.ibm.com>
	 <99da8dfa-2624-44fb-96c5-ff7eddf717ac@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a1fc4f5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=KmrhXWUz77OnfvDMe7QA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: 4RQ4VT8YlK4uol0qKNA4J5m6lchyvP_d
X-Proofpoint-ORIG-GUID: w-b4aFE-RxnaFyZMJG8cXNvHvPeezooP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NiBTYWx0ZWRfX59v9j55MSimh
 IkWA1fQUmzglCvpyvjvA3lZ8qdM2wc3FPWB9/xKp+pDL7WEWGcStbtryMe7rRsxMVG7fV5RYzEq
 gnHb5tOxPzR3c+92I1MoF1ONEo4Sjz3zjtXy4FQnasrnI5/mppN3lLtnFdoVQhqtKQvf8zUKkLL
 cg+uxYSdiESKITeM9MBtNVqXtEXmDQsf3CzOjl+3MlHq4I7q4qbOSMoKntfu3L3uljtJBrBTkWl
 XuEZDmzWhQ6mOiYU5esnuBDJNlI6pxIMfIrzTv2eeeB5DkUnHQi8tv+8Z0a3g0wHHC8KzSybV9j
 5xL7aJFQCC9oYmbMvkP9GXRe4X8RcJy0Bk+XeghAGONjguDMZDaiI+yqXRllGpUFAzzN7g31P8Z
 XmcekolAvkyNJJy37n1hMj8gA1wlcBl4wVHOLjVRNRA0KbJEtkfiVw0q+uj+7dOyFW0vVhZEgTj
 Asv9/5SgHX15cdtTPiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030056

On Mon, 2026-05-18 at 13:26 +0530, Shrikanth Hegde wrote:
>=20
> Hi Aboorva.
>=20
> On 5/18/26 10:38 AM, Aboorva Devarajan wrote:
> > pnv_kexec_wait_secondaries_down() calls get_cpu() to obtain the current
> > CPU id but never calls the matching put_cpu(), leaking one
> > preempt_disable() nesting level on every invocation.
> >=20
> > In practice the imbalance does not trigger a visible splat because the
> > kexec teardown path is a one-way trip: IRQs are already disabled, no
> > schedule() occurs after the leak, and default_machine_kexec() overwrite=
s
> > preempt_count with HARDIRQ_OFFSET before jumping into kexec_sequence()
> > which never returns. However the bookkeeping is still wrong.
> >=20
> > In the kexec teardown path IRQs are already disabled and the CPU is
> > pinned, so get_cpu()'s preempt_disable() side-effect is unnecessary.
> > Replace get_cpu() with raw_smp_processor_id() which returns the CPU id
> > without touching preempt_count.
> >=20
> > Fixes: 298b34d7d578 ("powerpc/powernv: Fix kexec races going back to OP=
AL")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> > =C2=A0 arch/powerpc/platforms/powernv/setup.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/plat=
forms/powernv/setup.c
> > index 4dbb47ddbdcc4..177da0defcb36 100644
> > --- a/arch/powerpc/platforms/powernv/setup.c
> > +++ b/arch/powerpc/platforms/powernv/setup.c
> > @@ -396,7 +396,7 @@ static void pnv_kexec_wait_secondaries_down(void)
> > =C2=A0 {
> > =C2=A0=C2=A0	int my_cpu, i, notified =3D -1;
> > =C2=A0=20
> > -	my_cpu =3D get_cpu();
> > +	my_cpu =3D raw_smp_processor_id();
> > =C2=A0=20
>=20
> Is it always with irq-disabled?
> How about !CONFIG_SMP and in kexec_prepare_cpus. I see it disables interr=
upt later.
> (though it is a less common config)
>=20

IIUC, PPC_POWERNV does 'select FORCE_SMP' (-> selects SMP), so there is no
!CONFIG_SMP powernv build. The !SMP kexec_prepare_cpus() variant in
arch/powerpc/kexec/core_64.c, the one you spotted that calls
ppc_md.kexec_cpu_down() before local_irq_disable() is therefore
never compiled with powernv, so pnv_kexec_cpu_down() ->
pnv_kexec_wait_secondaries_down() can't be reached through it.
so, IRQs are disabled in every case that reaches this function.


> So use smp_processor_id()?? One could compile with CONFIG_DEBUG_PREEMPT=
=3Dy and
> see any reports.
>=20
> > =C2=A0=C2=A0	for_each_online_cpu(i) {
> > =C2=A0=C2=A0		uint8_t status;

sure, I'll switch to smp_processor_id() in v2 rather than raw_smp_processor=
_id().
It returns the cpu id without touching preempt_count (so the leak is
gone), and unlike the raw variant it keeps the CONFIG_DEBUG_PREEMPT
check which is a no-op here since IRQs are off, but will flag any
future caller that reaches this path while preemptible instead of
silently hiding it.


Thanks,
Aboorva

