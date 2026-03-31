Return-Path: <linuxppc-dev+bounces-19049-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1EBFF60CE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 06:44:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flJWP6C5Jz2ybQ;
	Tue, 31 Mar 2026 17:44:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774939473;
	cv=none; b=YqEi9QO+b1pqaW2EaJMEQ7F0Bg0Jc8cLoO95C4YztP37LuKAa6yN3FfHVmhf7wW9fKa1HJSk9FgXvg+78mvlCt1dhuaW0c0jFf/kEtOJAyuslx5iPO+89Mkz0lc+EaIV+aNsNiX81Pz8Kk7SXhec3psJa13OLPNMaKEKuxY3hmEiAfVGtt9/LcTutlnT+6UmoHH6lM1a2e77ZDxuAMa0i3jCx4RHZfbVVt8zTJ3IM4QDK9Hv6L10XOBs+eRFx0mM5FKHXbpvL76e3mWzvfvMAuLsmoVP7l6XDqRQjfDNp0NDuKw5O9TpsU9Y9AVGJtn9On+qX5KAf15Snjm+JrdGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774939473; c=relaxed/relaxed;
	bh=Y9GCtCDBGo/k/bo5qV4PyHSzEj49q9Yb8t4+rZ80jmc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RX2eXTWVtghwaDL7Yeq6/zRAHfULPRDjzLzVXWd0sHQgwtnKfvPPB8GEfsbyad+Bl++2N5uzNGuTBbTFLbJ9k/fjhh2a+pSJXfAuxR9qt1DKq3f1BGMdwPQlE5TN7SJQp/ekO54V+sWOPRSKvgUemfnG/sijQgV8JnQ9O9ajDGMfaDXWYZ/TdLKU1tTVibc7ElbGCRG+nOfIY2v1LLFb870e/PZxVR/wP5xKQkmtimb5SbV3RgAgcXeQistlAjpDIxrT/udmzmZX6gP5VSOgIkYgtWXBoe1pSxxw3WpNcttmaHFe4tEfdRgyrE0oChMkrh8yS4a6ZvnnAdJcphKjXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rKkkZrqd; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rKkkZrqd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flJWN4nDKz2xSb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 17:44:32 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UEAUuD039609;
	Tue, 31 Mar 2026 06:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y9GCtC
	DBGo/k/bo5qV4PyHSzEj49q9Yb8t4+rZ80jmc=; b=rKkkZrqdjA+65Ry7blQUfJ
	YTm9tAT2X6FWHMFx7xsPn2N1si+Hc9BGdPpwptj1IKT3TgLdYuXAvpXWpo3Xckuu
	29Jy52FoDcoLYeCK9WbN+QBQTJkqmXBpnqfKRtgeIJWMgPcL/IWAsQAXRtc9Rvig
	VB2RE6hj3P+uutqUaftJoZo08FB1GQm7HAVimUrv0xJ/VwLSuv/YhShsEM1LlFgu
	jazjBK22CJL913yelPJtEbKNyy5wfYl5U6OeQjDLGU4cqUIJB4EUUMX+CRa7M7N/
	aRx+N/hx3f/5nSmWF/6cK+TulOjYjbXCFNkuHXDYdKTE/nQDNlaUNlqNRWa7fmmA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d64dghqxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 06:44:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62V1RHum013987;
	Tue, 31 Mar 2026 06:44:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkftdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 06:44:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62V6iEPt53019016
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 06:44:14 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9167F2004B;
	Tue, 31 Mar 2026 06:44:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DE2520049;
	Tue, 31 Mar 2026 06:44:12 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 06:44:11 +0000 (GMT)
Message-ID: <53d80173ef5015601a4e9faa14c24ab60815ecf0.camel@linux.ibm.com>
Subject: Re: [PATCH v2] pseries/kexec: skip resetting CPUs added by firmware
 but not started by the kernel
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Srikar Dronamraju <srikar@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Madhavan
 Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin	 <npiggin@gmail.com>,
        Christophe Leroy
 <christophe.leroy@csgroup.eu>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Vishal Chourasia	
 <vishalc@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Sourabh
 Jain	 <sourabhjain@linux.ibm.com>,
        Anushree Mathur	
 <anushree.mathur@linux.vnet.ibm.com>
Date: Tue, 31 Mar 2026 12:14:00 +0530
In-Reply-To: <actOtLSoqSMgmEQh@linux.ibm.com>
References: <20260330062206.170437-1-shivangu@linux.ibm.com>
	 <actOtLSoqSMgmEQh@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA1OCBTYWx0ZWRfX37gBA0hJU7KL
 FQKaX2D6I5cf8SuAcszKZPcQNEGIm6k8bQiqWwrJAHUeubv1iH0AGT+i3zlt9b0fBfm4L3vtH0x
 RZkU462Z5ZB4hPUhQnO40xJt5tM9uYbHN5bmttRKNlcMjA2qE4gLgnY3GlvooDRYQ0pADlxL6kU
 XWUGnnAjmqN5YRBphtFhVrJPjCMbBaZ8dTi7BYwfRSTerS8EbWz1vAtwpiPas4BaEoGR+WAGTZ4
 L4DvT7DT5G2Nue8jNOUxYKVGmNPyBalNpy1XWZSlFtz7zRoIIZT5dQLtZ0s9aL5+FdMqLZ/5iUc
 XU5Rx+QqPNrENWkMpLsyvb8TrgIZfRj1O1usax4xyKHl+xl+o+NpGiQ6eZ376fXoCe3zV+v1jb+
 nsdFu7Pg9mY4XkYoaqayF+yCOD02wiFiXwIqGRbIihbkfxKQNpPMNBn8CrHA66x+vrItjVLnqe2
 S0Xy8N8N2nm+HMafyxg==
X-Authority-Analysis: v=2.4 cv=QKZlhwLL c=1 sm=1 tr=0 ts=69cb6d44 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=1UX6Do5GAAAA:8 a=OQYtAnS5VtIFOpmrliEA:9
 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-GUID: AerLmqN0Ju-3jo14nG1jf08aB8zV4bJL
X-Proofpoint-ORIG-GUID: NbtGEpMH0ET33Q8PEpd-Ctr03L8KNEKq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_01,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310058

Hi Srikar,

Thanks for reviewing.

On Tue, 2026-03-31 at 10:03 +0530, Srikar Dronamraju wrote:
> * Shivang Upadhyay <shivangu@linux.ibm.com> [2026-03-30 11:52:06]:
>=20
> > During DLPAR operations, the newly added CPUs start in halted mode.
> > The kernel then takes some time to initialize those CPUs internally
> > and
> > start them using the "start-cpu" RTAS call. However, if a kexec
> > crash
> > occurs in this window (before the new CPU has been initialized),
> > the kexec NMI will try to reset all other CPUs from the crashing
> > CPU.
> > This leads to firmware starting the uninitialized CPUs as well.
>=20
> What would happen if an non kexec crash nmi was delivered when we did
> a
> DLPAR operation and before the CPUs are initialized?

As per my understanding, similar hang like situation should happen
there also. But I think this case would be highly unlikely. Crash's
case is little special, because this is called for offline cpus also.

>=20
> >=20
> > This can cause the kdump kernel to hang during bring-up.
> >=20
> > Sample Log:
> > =C2=A0 [175993.028231][ T1502] NIP [00007fffb953f394] 0x7fffb953f394
> > =C2=A0 [175993.028314][ T1502] LR [00007fffb953f394] 0x7fffb953f394
> > =C2=A0 [175993.028390][ T1502] --- interrupt: 3000
> > =C2=A0 [=C2=A0=C2=A0=C2=A0 5.519483][=C2=A0=C2=A0=C2=A0 T1] Processor 0=
 is stuck.
> > =C2=A0 [=C2=A0=C2=A0 11.089481][=C2=A0=C2=A0=C2=A0 T1] Processor 1 is s=
tuck.
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
> > =C2=A0 * added set_crash_nmi_ipi to saperate crash's case from other
> > nmi_ipi
> > =C2=A0=C2=A0=C2=A0 users
> >=20
> > V1:
> > =C2=A0 *
> > https://lore.kernel.org/all/20251205142825.44698-1-shivangu@linux.ibm.c=
om/
> > ---
> > =C2=A0arch/powerpc/include/asm/smp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
> > =C2=A0arch/powerpc/kernel/smp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0arch/powerpc/platforms/pseries/smp.c | 29
> > +++++++++++++++++++++++++++-
> > =C2=A03 files changed, 30 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/smp.h
> > b/arch/powerpc/include/asm/smp.h
> > index e41b9ea42122..cb74201f5674 100644
> > --- a/arch/powerpc/include/asm/smp.h
> > +++ b/arch/powerpc/include/asm/smp.h
> > @@ -47,6 +47,7 @@ struct smp_ops_t {
> > =C2=A0	void=C2=A0 (*cause_ipi)(int cpu);
> > =C2=A0#endif
> > =C2=A0	int=C2=A0=C2=A0 (*cause_nmi_ipi)(int cpu);
> > +	void=C2=A0 (*set_crash_nmi_ipi)(void);
> > =C2=A0	void=C2=A0 (*probe)(void);
> > =C2=A0	int=C2=A0=C2=A0 (*kick_cpu)(int nr);
> > =C2=A0	int=C2=A0=C2=A0 (*prepare_cpu)(int nr);
> > diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> > index 3467f86fd78f..3390ee8adf79 100644
> > --- a/arch/powerpc/kernel/smp.c
> > +++ b/arch/powerpc/kernel/smp.c
> > @@ -594,6 +594,7 @@ void crash_send_ipi(void
> > (*crash_ipi_callback)(struct pt_regs *))
> > =C2=A0{
> > =C2=A0	int cpu;
> > =C2=A0
> > +	smp_ops->set_crash_nmi_ipi();
>=20
> Shouldn't we be checking got smp_ops->set_crash_nmi_ipi being non-
> NULL
> before calling. Dont we expect set_crash_nmi_ipi() to be NULL in
> PowerNV
> after this patch? Or what would happen if set_crash_nmi_ipi() was
> called in
> PowerNV code?
>=20

Yeah, that should be a Bug, Ill fix this in new patch. Thanks for
catching this.


> > =C2=A0	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback,
> > 1000000);
> > =C2=A0	if (kdump_in_progress() && crash_wake_offline) {
> > =C2=A0		for_each_present_cpu(cpu) {
> > diff --git a/arch/powerpc/platforms/pseries/smp.c
> > b/arch/powerpc/platforms/pseries/smp.c
> > index db99725e752b..c6c2baacca9a 100644
> > --- a/arch/powerpc/platforms/pseries/smp.c
> > +++ b/arch/powerpc/platforms/pseries/smp.c
> > @@ -51,6 +51,9 @@
> > =C2=A0 */
> > =C2=A0static cpumask_var_t of_spin_mask;
> > =C2=A0
> > +
>=20
> Nit: Are we adding an unnecessary newline?

Ack.

>=20
> > +static int crash_nmi_ipi;
> > +
> > =C2=A0/* Query where a cpu is now.=C2=A0 Return codes #defined in
> > plpar_wrappers.h */
> > =C2=A0int smp_query_cpu_stopped(unsigned int pcpu)
> > =C2=A0{
> > @@ -171,12 +174,35 @@ static void dbell_or_ic_cause_ipi(int cpu)
> > =C2=A0	ic_cause_ipi(cpu);
> > =C2=A0}
> > =C2=A0
> > +static void pseries_set_crash_nmi_ipi(void)
> > +{
> > +	crash_nmi_ipi =3D 1;
> > +}
> > +
> > =C2=A0static int pseries_cause_nmi_ipi(int cpu)
> > =C2=A0{
> > =C2=A0	int hwcpu;
> > +	int k, curcpu;
> > =C2=A0
> > +	curcpu =3D smp_processor_id();
> > =C2=A0	if (cpu =3D=3D NMI_IPI_ALL_OTHERS) {
> > -		hwcpu =3D H_SIGNAL_SYS_RESET_ALL_OTHERS;
> > +		if (crash_nmi_ipi) {
> > +			for_each_present_cpu(k) {
> > +				if (k !=3D curcpu) {
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
> > +						plpar_signal_sys_r
> > eset(hwcpu);
> > +					}
> > +				}
> > +			}
> > +			return 1;
> > +		} else
> > +			hwcpu =3D H_SIGNAL_SYS_RESET_ALL_OTHERS;
> > =C2=A0	} else {
> > =C2=A0		if (cpu < 0) {
> > =C2=A0			WARN_ONCE(true, "incorrect cpu parameter
> > %d", cpu);
> > @@ -243,6 +269,7 @@ static struct smp_ops_t pseries_smp_ops =3D {
> > =C2=A0	.message_pass	=3D NULL,	/* Use
> > smp_muxed_ipi_message_pass */
> > =C2=A0	.cause_ipi	=3D NULL,	/* Filled at runtime by
> > pSeries_smp_probe() */
> > =C2=A0	.cause_nmi_ipi	=3D pseries_cause_nmi_ipi,
> > +	.set_crash_nmi_ipi =3D pseries_set_crash_nmi_ipi,
> > =C2=A0	.probe		=3D pSeries_smp_probe,
> > =C2=A0	.prepare_cpu	=3D pseries_smp_prepare_cpu,
> > =C2=A0	.kick_cpu	=3D smp_pSeries_kick_cpu,
> > --=20
> > 2.53.0
> >=20


Thanks

~Shivang.

