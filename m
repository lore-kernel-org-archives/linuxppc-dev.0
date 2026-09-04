Return-Path: <linuxppc-dev+bounces-26514-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5ABC624DB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2026 02:22:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hbgGL3BJRz2y24;
	Fri, 04 Sep 2026 12:22:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788488538;
	cv=none; b=DEkt/I5lVjKTftS7I/IvOGDJCEtyADxbvuiBTRTS4NeYIaAs/SP4vNTN743Uo1HnOpxGDs0UHsGY1JQbUaSMVCUXip6xA+g7ad3jGFt8mn34u/ggzGm9QGwfN03PrKM0sJI8+rHeAe9zPfeDqwkePx5cIpUucdFzrAFZvgPkfhh86JGNDyvbHuFfFHfUdrpQPVJf7i31sIbylqYdgCkaoI3M/XG2Gi8FdwxSFg0vVBAB0v0ahONEllOl+j0lZB6g59Zji3QMLcxTJNOkLVfaTw6BbPDkJ3lFY8H/ytbD056YulUjTdIgOjyH/hb96Ue29bUUOEBm3MP42f0NH3eQrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788488538; c=relaxed/relaxed;
	bh=GBnW5YEcKk8IcPDVnQrNPEXuwSQjt4P1NIdDUE0CN/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMpApiESzBhuuJ+BwSXTUYJyRxDkyD7uo+t+woWwZn5ZKSqPR7cTy2x1pLbNG0dKXiDP+mKgJnxwUW7RKpQ5JEbfLm2E/5kTu04n7K0Ak/+PJEMfpxBlr+b4bQtSR5wnipqMQjeE5AcabM0JXn3o7PuBgLn8WJhAq8eSAgK5P4CTbE18NKR+uknWczNHPGtxTv6tk2+uf1OzEE7Dq4PkTrVl5V3DW9Y15at46JiK8ICjqqlg1xD2nHDDTNPhn4RmmpC/n0CXXIhog4KAl/i9oLf8cVtW4DELlr0tbLtLOYFr0k/LUDW7PXM6SGnbI003ksnBIoIN3B8kFDNbqynlVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CyORFOoL; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CyORFOoL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hbgGK3W8pz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Sep 2026 12:22:17 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68401eZG084681;
	Fri, 4 Sep 2026 02:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GBnW5Y
	EcKk8IcPDVnQrNPEXuwSQjt4P1NIdDUE0CN/s=; b=CyORFOoLD/iv8iW3Bf69wn
	audY7vSe5/nscxaJ8MsQLUQJOcfMKfhuyiP+P13IZmSKJMyyjhRlwcRSNhy6/GhV
	MBhghYZtNfE/5xAOE02tIXXMmATtCPNOchdtvTJypO7SDVb5k4d806MJKhZFUZti
	pZXMD/jI1celWo/nl4SQWUiaNYs1VXr2Alr4IrRL/l99zKMMMr4TqoGMeL9ZqAiZ
	9CEEj9gkQu4vLfhJqO05aDxrs1OV6GG5+92tZ+fAQ1iiiWpfw1qtWfH4PShpMxDm
	0lmYV3fjz6j5xetIqrvxevdiF9/pvSf5PeyXaAaJcrUTANkwNbuRBYqD9jrirnBw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj7u0a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 02:22:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6842BIE3013918;
	Fri, 4 Sep 2026 02:22:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcarkjmrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 02:22:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6842M6cc30081572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 02:22:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 446C920043;
	Fri,  4 Sep 2026 02:22:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4E4A20040;
	Fri,  4 Sep 2026 02:22:03 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.84.232.156])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 02:22:03 +0000 (GMT)
Message-ID: <60e6f5132a751f0c2efa015e13c15f47fd4d80df.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev
	 <linuxppc-dev@lists.ozlabs.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Christophe Leroy
	 <christophe.leroy@csgroup.eu>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya
	 <mkchauras@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>, aboorvad@linux.ibm.com
Date: Fri, 04 Sep 2026 07:52:02 +0530
In-Reply-To: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
References: 
	<10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
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
X-Proofpoint-GUID: j3LcTginuY_0tca6PoSm--DA-T28Y9-a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDAxNiBTYWx0ZWRfX3R5B+C9+Ai+l
 Qvc7cgyFKYNGj0t7dGkaxZQLMOqp70NP3Tivjo39WBURIdiw21MCe6HnuonNMUngxMLNvtFSNhN
 NaMlqoz7KeevwD82YdOR4ulZy2Sm0ymLTSSHduz7aSNDsMRblZ5VmwOIZWoLj34O1DalIF+caWj
 0sApgO84QwviclRhEmU6MD2GXabAUTuy7AEGrN5RV0SFwqewMoBdqWWP86K+IzCGk0cQuYr0QVf
 AY4Oyb1bsLXSuXdEvKk3en4OW4mcKaXxyB4X4nPNM2ii6y5LQ6pkIyOBloKQWIZgvoEbtoNxmRg
 l0QeVZenJ9pPrG0IULV1RRsrrWje4ECAcrg/S6qYP62z6lO6BuJIITZnHOQGfL+7XvMmJUQ64TR
 w32BXGN6Eu56k5vQCd+ddmEbUo4rvUK2xaXEHUIB6ml+rj33A4S0ZCp81vDjWTMZ0Xhn1oIur++
 hUwGUBsIaKXv9CfA0Tw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9a2b53 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=67n_AhbQrQQhk4f1qesA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDAxNiBTYWx0ZWRfX4nbO9rGL/qKD
 8NhPuyIL3gKM2eDgfjYMBEOKwgo8qp9fZEdZ5kBA3+NT+j7SkTk+iMywvi74lKgDEGIwR5G9vLG
 SBxex3M5yQiyV/GfjGnr3PSsYJaQ/x8=
X-Proofpoint-ORIG-GUID: tftb_cUFm1Xod8J7ycBgDlmk4VvgmEZm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_07,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040016

On Sat, 2026-08-29 at 09:49 +0530, Ritesh Harjani (IBM) wrote:
> So the syscall return sequence is as follows:
> A syscall return to userspace is prepared and then a short asm sequence
> that actually does the RFI. Note that this asm range is restartable i.e.
> EE is still on, so an interrupt (e.g. decrementer or external interrupt)
> can hit while SRR/GPRs are being loaded. This is defined via:
>=20
> RESTART_TABLE(.Lsyscall_rst_start, .Lsyscall_rst_end, syscall_restart)
>=20
> This restart table then sends us to syscall_restart rather than resuming
> in the middle of the RFI. The same stub is also used if irq_happened
> already has a pending bit (soft-masked irq that has not been replayed
> yet (PowerPC special case of local_irq_disable())).
>=20
> Here is a bit of a flow of sequence of code to visualize:
> =C2=A0 syscall_exit_prepare
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decide full-GPR restore (_TIF_RESTOREALL) =
for signal,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rt_sigreturn or syscall trace
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 save that in regs->exit_result and return =
it in r3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
> =C2=A0 .Lsyscall_rst_start .. _end=C2=A0=C2=A0=C2=A0=C2=A0 EE still on
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 irq_happened set or interrupt in this rang=
e?
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | no=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | yes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 v
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cmpdi r3,0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sy=
scall_exit_restart
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 restore all / zero=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replay irq, try exit again
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 volatiles; RFI=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 must return=
 flags in r3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 again for t=
he same cmpdi
>=20
> Now r3 after prepare is the flags word, not the actual syscall return. A =
nested
> interrupt clobbers it, so the restart stub reloads RESULT into r3 and the
> C handler (syscall_exit_restart()) should put the flags back (because lat=
er asm
> checks whether r3 returned from C has _TIF_RESTOREALL set or not):
> 	cmpdi r3, 0
> 	bne	.Lsyscall_restore_regs
>=20
> Note that syscall_exit_restart() already ORs any new _TIF_RESTOREALL into
> exit_result, but then it only returns the new sample and not the full
> regs->exit_result.
>=20
> That sample could be often 0 even when restore-all is still required:
>=20
> =C2=A0 - rt_sigreturn / syscall trace set the bit in prepare's local
> =C2=A0=C2=A0=C2=A0 ret and in exit_result. They never set exit_flags, whi=
ch is
> =C2=A0=C2=A0=C2=A0 what restart samples.
>=20
> =C2=A0 - a signal does set exit_flags but restart clears it. A
> =C2=A0=C2=A0=C2=A0 second pass through the stub then returns 0 while
> =C2=A0=C2=A0=C2=A0 exit_result still has the bit.
>=20
> The asm as mentioned earlier then treats r3=3D=3D0 as the fast path and
> zeros r0/r4-r12. That means the userspace that needed the full register
> set could SIGSEGVs, (which could happen often in ld64.so.2 like while
> doing a parallel kernel build as reported by Venkat).
>=20
> So we should instead return the accumulated exit_result, like how we do
> in interrupt_exit_user_restart(). Note that prior to this commit
> 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs for ptr=
ace")
> we were returning regs->exit_result from syscall_exit_restart(), but
> this commit changed that behaviour.
>=20
> Fixes: 263e5159e00a ("powerpc: Fix exit_flags field placement in pt_regs =
for ptrace")
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/all/75419f88-eab9-444b-bf97-28a9765819ad@=
linux.ibm.com/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
> Sorry about the long commit msg. It took sometime for me to fully underst=
and
> that complex path, so I thought I may as well document that properly.
>=20
> =C2=A0arch/powerpc/kernel/interrupt.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interr=
upt.c
> index 5b88bf72786c..55f9c0c9922a 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -175,7 +175,7 @@ notrace unsigned long syscall_exit_restart(unsigned l=
ong r3, struct pt_regs *reg
> =C2=A0	current_thread_info()->exit_flags &=3D ~_TIF_RESTOREALL;
> =C2=A0	regs->exit_result |=3D ret;
>=20
> -	return ret;
> +	return regs->exit_result;
> =C2=A0}
> =C2=A0#endif
>=20
> --
> 2.39.5
>=20

Hi Ritesh,

Thanks for the fix,

I observed several processes consistently segfaulting in ld64.so.2 especial=
ly during
parallel kernel builds. I have hit this issue multiple times while running =
7.3-rc1:

[13619.338946] [=C2=A0 T75988] grep[75988]: segfault (11) at 2a720 nip 7fff=
a1276694 lr 7fffa12757f8 code 1 in ld64.so.2[36694,7fffa1240000+50000]
[13619.339095] [=C2=A0 T75988] grep[75988]: code: 7ce903a6 60000000 6042000=
0 f9490008 f9490010 39290020 f949fff8 f9490000
[13619.339120] [=C2=A0 T75988] grep[75988]: code: 4200ffec 89210376 3d42fff=
f 394a7ea0 <e9028000> 7d081050 f9410030 f9010020
[13620.062652] [=C2=A0 T76441] sh[76441]: segfault (11) at 2a720 nip 7fff9c=
026694 lr 7fff9c0257f8 code 1 in ld64.so.2[36694,7fff9bff0000+50000]
[13620.062807] [=C2=A0 T76441] sh[76441]: code: 7ce903a6 60000000 60420000 =
f9490008 f9490010 39290020 f949fff8 f9490000
[13620.062923] [=C2=A0 T76441] sh[76441]: code: 4200ffec 89210376 3d42ffff =
394a7ea0 <e9028000> 7d081050 f9410030 f9010020
[13622.951229] [=C2=A0 T78978] as[78978]: segfault (11) at 2a720 nip 7fff99=
806694 lr 7fff998057f8 code 1 in ld64.so.2[36694,7fff997d0000+50000]
[13622.951378] [=C2=A0 T78978] as[78978]: code: 7ce903a6 60000000 60420000 =
f9490008 f9490010 39290020 f949fff8 f9490000
[13622.951403] [=C2=A0 T78978] as[78978]: code: 4200ffec 89210376 3d42ffff =
394a7ea0 <e9028000> 7d081050 f9410030 f9010020
[13624.287972] [=C2=A0 T80382] sh[80382]: segfault (11) at 2a720 nip 7fff7e=
d76694 lr 7fff7ed757f8 code 1 in ld64.so.2[36694,7fff7ed40000+50000]
[13624.288112] [=C2=A0 T80382] sh[80382]: code: 7ce903a6 60000000 60420000 =
f9490008 f9490010 39290020 f949fff8 f9490000
[13624.288137] [=C2=A0 T80382] sh[80382]: code: 4200ffec 89210376 3d42ffff =
394a7ea0 <e9028000> 7d081050 f9410030 f9010020
[13631.123076] [=C2=A0 T87355] rm[87355]: segfault (11) at 2a720 nip 7fffa9=
476694 lr 7fffa94757f8 code 1 in ld64.so.2[36694,7fffa9440000+50000]
[13631.123222] [=C2=A0 T87355] rm[87355]: code: 7ce903a6 60000000 60420000 =
f9490008 f9490010 39290020 f949fff8 f9490000
[13631.123249] [=C2=A0 T87355] rm[87355]: code: 4200ffec 89210376 3d42ffff =
394a7ea0 <e9028000> 7d081050 f9410030 f9010020

With this patch, I have not observed any segfaults in ld64.so.2. This patch=
 fixes
the issue for me.

Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>

