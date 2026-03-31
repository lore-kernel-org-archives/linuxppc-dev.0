Return-Path: <linuxppc-dev+bounces-19040-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164011061B2B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 02:59:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flCX25QCmz2ybR;
	Tue, 31 Mar 2026 13:59:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774925986;
	cv=none; b=KbYPEiCov3ZuxFgPltX5ir3sXRSM+nbSAdlFmh3cHGImOD2A4scJj4SL9YFq8PsnQelvs/IDULuZ15EyvkJWNYIMSPVsoWYwe1uUAPgNACx0m34uGqg23bysDBEzn7lWjDYqTU/ICO0EROnOt9W7tDWTe97KUeNbbQa6VJ2UEPRVJO8CayE1pwDfNqvcoWStQA9wDdZU55lF2UPRWKfVbqcJk/FgFWeHDpVeNOLtDd5JQoxJWtxr4gbMeCS/VDbj5j2XCxIwY8vPnuKmVVNNwtDFeryWvIn8C3US0J7PCMwbdAYUw+JbCB6DXbeo47Bf9D8VRXYGLA9U7L7ZpltTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774925986; c=relaxed/relaxed;
	bh=PjMYyLrVnM+bqTYfOEHaLe4av6NXY+bW+zWqW/mvKrk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TBs3To6TiuIpNI0xyOK12yXb3fArsVJk25dKavlSVke2L13Opyfu4hyzB9eOCgjcQisF+/lSTGcCJ/S6vp+K3ksWnE4oauCLwWQr/ZVYXiBh7NgnRkS5Teyf3MhgRHYWdjRdApuvAr8jg87R/fNJqja0P/h9yvF4n9blUXiMXpZrKuwWSEUaHK0CKNtbycTu3nuD2tVqo+phimXNEAxlXHhCXdevt3VxTKzher8mmccBzjiUR1Jr4LLag1jJq5ytO7BK0UIPxH1Qr8OxI3DlF0rBJO3aGLgCyxgfcyo9RQK8e1se39EdlLWKjR5NY3iszNfQelYcyb8SfDtPy55JEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gG+kgVn4; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gG+kgVn4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flCX15pNQz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 13:59:44 +1100 (AEDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UF3lBe143604;
	Tue, 31 Mar 2026 02:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PjMYyL
	rVnM+bqTYfOEHaLe4av6NXY+bW+zWqW/mvKrk=; b=gG+kgVn4batnB2Jm49eE89
	FcWixS35au7ySZen4YqFGRkZInY1atTR51WSO7B3QoWcnWuAjT/mnswBsWn/8uwF
	GCVyU/lV520IC3HRKLTek/34kcvjbMivZ2NCsSFsNcoyW108LxbJon0765w+GUY0
	Ksj8Wyf7vnZHvuGOtL5v9yAHqhFCQVO8H0HxgyTpM3LqO+s6oAfEn/lbUBbGoVXa
	8Bsw4bIuxHte6NOU1aiXS1YWyiU68ujeDait8w9gvzP4kRl/ErEVzzH+3VwvQY3V
	MdbRshdrCcHqOG06EOtBJ9Tnay0/308axcVkZ/ClEbe5z/K+HIb1HOELZoK+0Xnw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d65dc92h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 02:59:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V03YPB021651;
	Tue, 31 Mar 2026 02:59:32 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sasfgh6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 02:59:32 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V2xSO251904878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 02:59:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 792C820071;
	Tue, 31 Mar 2026 02:59:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8EB12006E;
	Tue, 31 Mar 2026 02:59:25 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 02:59:25 +0000 (GMT)
Message-ID: <ffe1cb38c6b1a634814f559343778e473131c66e.camel@linux.ibm.com>
Subject: Re: [PATCH v2] pseries/kexec: skip resetting CPUs added by firmware
 but not started by the kernel
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman	
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy
	 <christophe.leroy@csgroup.eu>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Vishal Chourasia
 <vishalc@linux.ibm.com>,
        Ritesh Harjani	 <ritesh.list@gmail.com>,
        Sourabh
 Jain <sourabhjain@linux.ibm.com>,
        Anushree Mathur
 <anushree.mathur@linux.vnet.ibm.com>
Date: Tue, 31 Mar 2026 08:29:23 +0530
In-Reply-To: <84aa93be-189e-47d9-a159-87bed9f10ee5@linux.ibm.com>
References: <20260330062206.170437-1-shivangu@linux.ibm.com>
	 <84aa93be-189e-47d9-a159-87bed9f10ee5@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsjI7SmK c=1 sm=1 tr=0 ts=69cb3895 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=1UX6Do5GAAAA:8 a=19gfRiDpz2mMbCJza2MA:9
 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: RCzQFlL1bppOg2TE5dSNMJhNSWx9Ho-S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDAyNSBTYWx0ZWRfX8mh6jREJIzUC
 PScJWeRtasPUD6ypQess6rjGawCQIHv8Pk3dgGkqS9wPNvv+y2McXnilEZlt+OKyyDjkLT+hyxj
 CRj4K0edqUyqY5p11B/rrh2kJ6gA2GQLH57gC/bgTI9r9/3EhzdsPx42JoDlFzpgtPcDq31s2W6
 nYINKpc2T50cycRNphHMOtvsQ/A3QfVamnd90e034wDs/QR6o1lS5xN56DvhTNNjAHSVOygNpoe
 45IR20J00+VxnoxyuZZwZ/xIfJ2dTEhWejcCxZgAZJSjJG1ZiIiB/3Mb0WT2zkw5Z9JN17h5O94
 xYv7ijrLHYsAeLzTFQLYa0+lXftoSZLSPAEskuFuhO0ooZovpFCRqZxRHcqzpK/YerkHpcFY4RJ
 3sU7sYf+FI/h8fTXYFXNT1TpULtOHgyZRfAylcmSnF0TpOoWas8rjvHtWR8+OL3+G4ixPyTMVTb
 34tD8K3uXs233Q7qUiw==
X-Proofpoint-ORIG-GUID: kgwYRlwVgIx9JeTOxlsAmuxwcu7-_ZDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-30_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310025

Hi Shrikanth, Thanks for your review.

On Mon, 2026-03-30 at 14:19 +0530, Shrikanth Hegde wrote:
> Hi Shivang.
>=20
> Few nitpicks.
>=20
> On 3/30/26 11:52 AM, Shivang Upadhyay wrote:
> > During DLPAR operations, the newly added CPUs start in halted mode.
> > The kernel then takes some time to initialize those CPUs internally
> > and
> > start them using the "start-cpu" RTAS call. However, if a kexec
> > crash
> > occurs in this window (before the new CPU has been initialized),
> > the kexec NMI will try to reset all other CPUs from the crashing
> > CPU.
> > This leads to firmware starting the uninitialized CPUs as well.
> >=20
> > This can cause the kdump kernel to hang during bring-up.
> >=20
> > Sample Log:
> > =C2=A0=C2=A0 [175993.028231][ T1502] NIP [00007fffb953f394] 0x7fffb953f=
394
> > =C2=A0=C2=A0 [175993.028314][ T1502] LR [00007fffb953f394] 0x7fffb953f3=
94
> > =C2=A0=C2=A0 [175993.028390][ T1502] --- interrupt: 3000
> > =C2=A0=C2=A0 [=C2=A0=C2=A0=C2=A0 5.519483][=C2=A0=C2=A0=C2=A0 T1] Proce=
ssor 0 is stuck.
> > =C2=A0=C2=A0 [=C2=A0=C2=A0 11.089481][=C2=A0=C2=A0=C2=A0 T1] Processor =
1 is stuck.
> >=20
> > To fix this, only issue the system-reset hcall to CPUs that have
> > actually been started by the kernel.
> >=20
> > Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Nicholas Piggin <npiggin@gmail.com>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Cc: Srikar Dronamraju <srikar@linux.ibm.com>
> > Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
> > Cc: Nysal Jan K.A. <nysal@linux.ibm.com>
> > Cc: Vishal Chourasia <vishalc@linux.ibm.com>
> > Cc: Ritesh Harjani <ritesh.list@gmail.com>
> > Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
> > Reported-by: Anushree Mathur <anushree.mathur@linux.vnet.ibm.com>
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > ---
> > Changelog:
> >=20
> > V2:
> > =C2=A0=C2=A0 * added set_crash_nmi_ipi to saperate crash's case from ot=
her
> > nmi_ipi
> > =C2=A0=C2=A0=C2=A0=C2=A0 users
> >=20
> > V1:
> > =C2=A0=C2=A0 *
> > https://lore.kernel.org/all/20251205142825.44698-1-shivangu@linux.ibm.c=
om/
> > ---
> > =C2=A0 arch/powerpc/include/asm/smp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
> > =C2=A0 arch/powerpc/kernel/smp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0 arch/powerpc/platforms/pseries/smp.c | 29
> > +++++++++++++++++++++++++++-
> > =C2=A0 3 files changed, 30 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/smp.h
> > b/arch/powerpc/include/asm/smp.h
> > index e41b9ea42122..cb74201f5674 100644
> > --- a/arch/powerpc/include/asm/smp.h
> > +++ b/arch/powerpc/include/asm/smp.h
> > @@ -47,6 +47,7 @@ struct smp_ops_t {
> > =C2=A0=C2=A0	void=C2=A0 (*cause_ipi)(int cpu);
> > =C2=A0 #endif
> > =C2=A0=C2=A0	int=C2=A0=C2=A0 (*cause_nmi_ipi)(int cpu);
> > +	void=C2=A0 (*set_crash_nmi_ipi)(void);
> > =C2=A0=C2=A0	void=C2=A0 (*probe)(void);
> > =C2=A0=C2=A0	int=C2=A0=C2=A0 (*kick_cpu)(int nr);
> > =C2=A0=C2=A0	int=C2=A0=C2=A0 (*prepare_cpu)(int nr);
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 3467f86fd78f..3390ee8adf79 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -594,6 +594,7 @@ void crash_send_ipi(void
> > (*crash_ipi_callback)(struct pt_regs *))
> > =C2=A0 {
> > =C2=A0=C2=A0	int cpu;
> > =C2=A0=20
> > +	smp_ops->set_crash_nmi_ipi();
> > =C2=A0=C2=A0	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback,
> > 1000000);
> > =C2=A0=C2=A0	if (kdump_in_progress() && crash_wake_offline) {
> > =C2=A0=C2=A0		for_each_present_cpu(cpu) {
> > diff --git a/arch/powerpc/platforms/pseries/smp.c
> > b/arch/powerpc/platforms/pseries/smp.c
> > index db99725e752b..c6c2baacca9a 100644
> > --- a/arch/powerpc/platforms/pseries/smp.c
> > +++ b/arch/powerpc/platforms/pseries/smp.c
> > @@ -51,6 +51,9 @@
> > =C2=A0=C2=A0 */
> > =C2=A0 static cpumask_var_t of_spin_mask;
> > =C2=A0=20
> > +
> > +static int crash_nmi_ipi;
> > +
> > =C2=A0 /* Query where a cpu is now.=C2=A0 Return codes #defined in
> > plpar_wrappers.h */
> > =C2=A0 int smp_query_cpu_stopped(unsigned int pcpu)
> > =C2=A0 {
> > @@ -171,12 +174,35 @@ static void dbell_or_ic_cause_ipi(int cpu)
> > =C2=A0=C2=A0	ic_cause_ipi(cpu);
> > =C2=A0 }
> > =C2=A0=20
> > +static void pseries_set_crash_nmi_ipi(void)
> > +{
> > +	crash_nmi_ipi =3D 1;
> > +}
> > +
> > =C2=A0 static int pseries_cause_nmi_ipi(int cpu)
> > =C2=A0 {
> > =C2=A0=C2=A0	int hwcpu;
> > +	int k, curcpu;
>=20
> Please follow inverted christmas tree for variables.
Ack.
>=20
>=20
> Can the below block be re-written with less indentations?
> One level indentation removal could be.
>=20
> if (cpu =3D=3D NMI_IPI_ALL_OTHERS && crash_nmi_ipi)
> 	hwcpu =3D <>
> else if (cpu =3D=3D NMI_IPI_ALL_OTHERS)
> 	hwcpu =3D H_SIGNAL_SYS_RESET_ALL_OTHERS;
> else
> 	<existing remaining logic>
>=20
> > =C2=A0=20
> > +	curcpu =3D smp_processor_id();
> > =C2=A0=C2=A0	if (cpu =3D=3D NMI_IPI_ALL_OTHERS) {
> > -		hwcpu =3D H_SIGNAL_SYS_RESET_ALL_OTHERS;
> > +		if (crash_nmi_ipi) {
> > +			for_each_present_cpu(k) {
> > +				if (k !=3D curcpu) {
>=20
> Maybe below to reduce one more indentation level.
>=20
> if ( k =3D=3D curcpu)
> 	continue;
>=20
Sure, i can rewrite it that way.
>=20
> > +					hwcpu =3D
> > get_hard_smp_processor_id(k);
> > +
> > +					/* it is possible that cpu
> > is present,
> > +					 * but not started yet.
> > +					 */
> > +
> > +					if (paca_ptrs[hwcpu]-
> > >cpu_start =3D=3D 1) {
>=20
> It either 1 or 0. So if(paca_ptrs[hwcpu]->cpu_start) is enough.
Ack.

~Shivang.


