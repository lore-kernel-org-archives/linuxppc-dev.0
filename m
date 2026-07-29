Return-Path: <linuxppc-dev+bounces-24969-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A7CC53219
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 06:06:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h920P5gFPz2xrL;
	Wed, 29 Jul 2026 16:06:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785305205;
	cv=none; b=FauyzPyaSJgzV8JLADuFlcRbLHoU9jl/Y9KbrUMbAv6dOcUUfO7xsGZPj9UVygRXaRSLw4hVYI0HMkB5o98nsze400CPJYbcwJ4RKBaQUud9QhqlyLyceli+ir/BYvAwz0WpsAnU9lXezMhb+heBPOnmKxqcMvNQyNqzpTF/z2NtjOFlkp4r8gcdgIQ7fb+arMDbjPLpwikQHewDeZ971wJV+LC6NbI3jAU7Kb9cJF6X/8P0c7Bm53EuOxWN1XvrfbWOAgF4p0S2PB6+s7gTxrnS+ewCTwkpT23BpLkEwimuxeJxcbkHIxQY/rwKuG0F/cTK722yFE0xs8rMEP7GXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785305205; c=relaxed/relaxed;
	bh=wT62qaFO7xm5CRVaZlrD3ZBJXgNTtmoMQiPTB8GGIWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FbjDRQS4irF857HqeqVXR/Vyy+T4EXRnoB1ArgccPFIaIt58dD2G2zxgqNf0npKrX3CBkFUMRFIFGe969bbfDWM03oDR5TYZQra49VhdKXptwuZXJ05/SsoqR2qHp+HUczQnZ0zqd0XNrFdllPTw8hLwh8ISn3f1oOHIPBcjThyIMLy4eMG6BUobOUPxU7ndcwoF0Zkuo2+nUt3vNlyn4v5jAl5sVAz6ldjAFfvGs8RbfiWAvGY8cGp8v9a5vFnsKCd05lqxXF9er1KrkRsFLvymPCM0H2PHbZgc61gfe5DY65i0Mmfw4SxACBp5fzH6OUuxnsrC9j63lS27S4hDvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=obHOBZxw; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=obHOBZxw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h920M6mQnz2xFc
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 16:06:43 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T4mFPM3131696;
	Wed, 29 Jul 2026 06:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wT62qa
	FO7xm5CRVaZlrD3ZBJXgNTtmoMQiPTB8GGIWg=; b=obHOBZxwcXe+SK6jt8t2wF
	eCDumzd+4jEFYPvrwjzMQyH/NnjSDumK1joPDY79BnwWiqja2pfpeJZPUS18Rj5y
	Cg33FiWyxi4kFeFv0geyZU08fX0/Rn9xELhmbhzvERobo7Sr+7BdsGIPS9COWqJZ
	Bqxc0L2ELhzdz3ELbzbnzEStgqS2jJFKA/U9Wnz02oW2DGAfJeQsTx9Oy+5Wf6B2
	KglE8AxJDTqsMRnRDPTwFv3wc7327emDhYXY+NLkhVh6NpS9KirXU5L5bo312cxZ
	AN+NHEfP3wqh9Agq28nM1t8YIDod6Mg4zn+/Z6hzY22bXZIoXC/pn5sTQDDMS9fw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nrbrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 06:06:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66T5uUcY011378;
	Wed, 29 Jul 2026 06:06:24 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgd72h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 06:06:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66T66KFu49807804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 06:06:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B93DD20043;
	Wed, 29 Jul 2026 06:06:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6904820040;
	Wed, 29 Jul 2026 06:06:18 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 06:06:18 +0000 (GMT)
Message-ID: <7618bf3e48f6770a803f8350d0b3b084c23042fa.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/fadump: collect dump if the collected size is
 lesser than reserved
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adri.vero.dev@gmail.com, adityag@linux.ibm.com,
        anushree.mathur@linux.vnet.ibm.com
Date: Wed, 29 Jul 2026 11:36:17 +0530
In-Reply-To: <72589eca-2e97-4a2f-8665-b2a817a04722@linux.ibm.com>
References: <20260714173010.615682-1-shivangu@linux.ibm.com>
	 <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
	 <afd516619eea338039a6defb123ffaf38cf82949.camel@linux.ibm.com>
	 <72589eca-2e97-4a2f-8665-b2a817a04722@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA0NCBTYWx0ZWRfX4YQdvflEDlUL
 f5dteK9U9Vo6w0uoxvCIOO2zFNhMF2/XV5MMC7X4lrqmhyNiQt+oy3UoZcEX1YPVPSU3MukNvp6
 Afd3W31A+XKn01CmyaYMm3ePMm7RBfA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA0NCBTYWx0ZWRfXzLrZtPebuoC9
 K2/Aj03acLTqKfE/0kOaAVjYrSo0GmMwTusJH9jOCZOb8C+DcfQilvN8GHJlvyFTTQx7YapE9qB
 GP5RvNJzohPHQ/oqohCxp6Ibt/5OsklbMIarRexjDwzPzbAUkJS08egUDk++uU7p7Cqf2k+H05F
 nAq/6rdTLc1YvBKtxAMhbFeSY1HnWn5bOKKpGEGyanCfe+ALbbO+7auuNuTFayi+s+gImpT/M9T
 BtsWAH4J4KpeF8ds4pGOH03724mWD8ItHkVqt0NzwYYGP356MXdu3J8RBmeKOCVJk90R2d8vx7V
 yZhDhnBJaAXr8VOKtIZQhpqKB4S+UJVxPDHZAg0bUGzWddhgAooIaLxISBlqbJ2Yg+nXVx44rUw
 lFeZqiz3nAziUNt591ahQeNU1IkeB++R9c8vXTROMBpGCaYeFXtNT3wneIrh0VemID1u/D5DL6Z
 wuHqHTT7EnU1BDBApOw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a699862 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=P-IC7800AAAA:8
 a=VnNF1IyMAAAA:8 a=JxK2_L4-sVxCcE4O1m8A:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: _SCKaPn3PEbQHy-2x2sjQnEb3yfz2To_
X-Proofpoint-ORIG-GUID: 4gO1MA1sxW_hfaN1YxAYJYC5KynbYiZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_02,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290044

On Wed, 2026-07-29 at 09:14 +0530, Sourabh Jain wrote:
>=20
>=20
> On 22/07/26 14:41, Shivang Upadhyay wrote:
> > On Sun, 2026-07-19 at 12:39 +0530, Sourabh Jain wrote:
> > > Could you please reword the commit title to make it a bit
> > > clearer?
> > >=20
> > >=20
> > > On 14/07/26 23:00, Shivang Upadhyay wrote:
> > > > When a machine is subjected to CPUs add/remove, using dlpar
> > > > operations, the number of collected CPU_NOTES can change.
> > > > As per PAPR, collected dump size should not be more than
> > > > allocated size. Reflecting the same in source.
> > > Can you add more details about the problem you are trying to
> > > solve
> > > with this patch and how.
> > >=20
> > > Adding the error message and scenario would be really helpful in
> > > understanding the problem.
> > >=20
> > Hi Sourabh,
> >=20
> > =C2=A0 When a qemu ppc machine is booted with fadump=3Don and `-
> > smp=3Dx,maxcpus=3Dy`, on the panic kernel, /proc/vmcore is not
> > generated
> > because dump_bytes and source_len does'nt match for CPU_STATE_DATA
> > region in fadump, then we just give up on parsing rest of the data.
> >=20
> >=20
> > > Can you add Closes tag if it is reported upstream and if possible
> > > fixes
> > > tag too.
> > >=20
> > > > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > > > ---
> > > > =C2=A0=C2=A0 arch/powerpc/platforms/pseries/rtas-fadump.c | 3 ++-
> > > > =C2=A0=C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c
> > > > b/arch/powerpc/platforms/pseries/rtas-fadump.c
> > > > index 3bb4ac2ab6cc..19a5adaf326b 100644
> > > > --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
> > > > +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
> > > > @@ -469,7 +469,8 @@ static int __init
> > > > rtas_fadump_process(struct
> > > > fw_dump *fadump_conf)
> > > > =C2=A0=C2=A0=C2=A0				pr_err("Dump taken by platform
> > > > is
> > > > not valid (%d)\n", i);
> > > > =C2=A0=C2=A0=C2=A0				rc =3D -EINVAL;
> > > > =C2=A0=C2=A0=C2=A0			}
> > > > -			if (fdm_active->rgn[i].bytes_dumped !=3D
> > > > fdm_active->rgn[i].source_len) {
> > > > +			if (be64_to_cpu(fdm_active-
> > > > > rgn[i].bytes_dumped)
> > > > +			=C2=A0=C2=A0=C2=A0 > be64_to_cpu(fdm_active-
> > > > > rgn[i].source_len)) {
> > > Can you please share your observations about `bytes_dump` for
> > > both
> > > QEMU
> > > and a
> > > real system (LPAR) where the number of online CPUs is not equal
> > > to
> > > the
> > > maximum
> > I have the following observation.
> >=20
> > I booted LPAR with 8 cpus. After crashing it I saw that fadump
> > CPU_STATE_DATA has notes for total 16 cpus, and only top 8 notes
> > have
> > valid entries.when trying with 16, I see all NOTES have entried
> > filled.
>=20
> Yes even I noticed the same on a LPAR with (Min=3D1 Desired=3D1 Max=3D2
> with=20
> SMT=3D8 CPUs) maxcpus as 16 and online CPUs as 8.
>=20
> [=C2=A0 =C2=A0 0.036128] rtas fadump: --------CPU State Data------------
> [=C2=A0 =C2=A0 0.036129] rtas fadump: Magic Number: 5245475341564500
> [=C2=A0 =C2=A0 0.036131] rtas fadump: NumCpuOffset: 1c
> [=C2=A0 =C2=A0 0.036132] rtas fadump: NumCpus=C2=A0 =C2=A0 =C2=A0: 16
> [=C2=A0 =C2=A0 0.036135] fadump: Allocated buffer for cpu notes of size 6=
5536
> at=20
> 0xc000000006a30000
> [=C2=A0 =C2=A0 0.036138] rtas fadump: Reading register data for cpu 0...
> [=C2=A0 =C2=A0 0.036173] rtas fadump: Reading register data for cpu 1...
> [=C2=A0 =C2=A0 0.036178] rtas fadump: Reading register data for cpu 2...
> [=C2=A0 =C2=A0 0.036209] rtas fadump: Reading register data for cpu 3...
> [=C2=A0 =C2=A0 0.036240] rtas fadump: Reading register data for cpu 4...
> [=C2=A0 =C2=A0 0.036272] rtas fadump: Reading register data for cpu 5...
> [=C2=A0 =C2=A0 0.036304] rtas fadump: Reading register data for cpu 6...
> [=C2=A0 =C2=A0 0.036335] rtas fadump: Reading register data for cpu 7...
> [=C2=A0 =C2=A0 0.036390] rtas fadump: Updating elfcore header
> (c000000006a20000)=20
> with cpu notes
>=20
> The NumCpus is populated to be 16 CPUs by the firmware (RTAS/PHYP)
> even=20
> though only 8 CPUs were online.
>=20
> Kernel avoid processing reg entries of CPUs which were offline using=20
> below condition.
> code snippet from rtas_fadump_build_cpu_notes()/rtas-faudmp.c
>=20
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fdh && !cpumask_test_cpu(cpu, &fdh-=
>cpu_mask)) {
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RTAS_FADUMP_SKIP_TO_NEXT_=
CPU(reg_entry);
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=20
> But when I removed the avoid condition kernel failed to process the
> reg=20
> entries and
> below logs were printed.
>=20
> [=C2=A0 =C2=A0 0.037877] rtas fadump: --------CPU State Data------------
> [=C2=A0 =C2=A0 0.037879] rtas fadump: Magic Number: 5245475341564500
> [=C2=A0 =C2=A0 0.037881] rtas fadump: NumCpuOffset: 1c
> [=C2=A0 =C2=A0 0.037883] rtas fadump: NumCpus=C2=A0 =C2=A0 =C2=A0: 16
> [=C2=A0 =C2=A0 0.037889] fadump: Allocated buffer for cpu notes of size 6=
5536
> at=20
> 0xc000000007a50000
> [=C2=A0 =C2=A0 0.037891] rtas fadump: Reading register data for cpu 0...
> [=C2=A0 =C2=A0 0.037937] rtas fadump: Reading register data for cpu 1...
> [=C2=A0 =C2=A0 0.037974] rtas fadump: Reading register data for cpu 2...
> [=C2=A0 =C2=A0 0.038009] rtas fadump: Reading register data for cpu 3...
> [=C2=A0 =C2=A0 0.038044] rtas fadump: Reading register data for cpu 4...
> [=C2=A0 =C2=A0 0.038079] rtas fadump: Reading register data for cpu 5...
> [=C2=A0 =C2=A0 0.038082] rtas fadump: Reading register data for cpu 6...
> [=C2=A0 =C2=A0 0.038117] rtas fadump: Reading register data for cpu 7...
> [=C2=A0 =C2=A0 0.038155] rtas fadump: CPU 8 was offline
> [=C2=A0 =C2=A0 0.038157] rtas fadump: Reading register data for cpu 8...
> [=C2=A0 =C2=A0 0.038195] rtas fadump: CPU 10 was offline
> [=C2=A0 =C2=A0 0.038197] rtas fadump: Reading register data for cpu 10...
> [=C2=A0 =C2=A0 0.038235] rtas fadump: CPU 12 was offline
> [=C2=A0 =C2=A0 0.038236] rtas fadump: Reading register data for cpu 12...
> [=C2=A0 =C2=A0 0.038273] rtas fadump: CPU 14 was offline
> [=C2=A0 =C2=A0 0.038275] rtas fadump: Reading register data for cpu 14...
> [=C2=A0 =C2=A0 0.038311] rtas fadump: Unable to read CPU state data
> [=C2=A0 =C2=A0 0.038319] fadump: Invalidating firmware-assisted dump
> registration
> [=C2=A0 =C2=A0 0.038370] rtas fadump: Firmware busy during fadump invalid=
ate,=20
> waiting 1ms (total 0ms)
> [=C2=A0 =C2=A0 0.039403] fadump: reserved_memory_range[0]=20
> [0x00000040000000-0x000000800305c7], 0x400305c8 bytes
> [=C2=A0 =C2=A0 0.039408] fadump: freeing reserved memory (0x80030000 -
> 0xa00000000)
>=20
> For some reason, only CPUs with even-numbered IDs were present from=20
> offline CPUs list. This suggests that although
> NumCpus was 16, only 8 CPUs had valid reg entries. I think we should=20
> discuss this case with the firmware team before
> finalizing the solution.

Thats weird, I remember seeing entries for all of the maxcpus. Maybe I
put my prints differently, Can you share your debug patch source?

>=20
> On the other hand when I increased the CPUs count on the same system=20
> (Min=3D2 Desired=3D4 and max=3D8 with SMT 8) the
> system was booted with 32 possible CPUs instead of 64 CPUs. And
> NumCpus=20
> was 32 in fadump kernel.
>=20
> >=20
> > I previously proposed this fake entries fix in qemu [1]. But that
> > is
> > not compliant with PAPR, which states that cpu notes should be
> > collected for current_cpus only.
> Yes, that solution does not appear to be PAPR-compliant. However,
> based=20
> on our experiments, it is unclear why the firmware reports NumCpus as
> 16=20
> when only 8 CPUs are actually online.

I think fw's reason for doing for maxcpus would be same as our case
also, CPU hotplug. It would be hard to handle variable cpus in dump, so
why not just keep entries for all?

> > As per current states of things, reservation is always done for
> > maxcpus, (LPAR and QEMU both), NOTES collections is done for
> > current
> > cpus on QEMU, and maxcpus on LPARs.
> >=20
> > My proposal here is that we make the check for bytes_dumped and
> > source_len, less restrictive to let QEMU also generate
> > /proc/vmcore,
> > when current_cpus !=3D maxcpus.
>=20
> By the way, the changes proposed in this patch also apply to other
> regions,
> such as HPTE and REAL_MODE. That is not the intended behavior, right?
>=20
Yes, I made it this way by reading the dump_bytes and source_len
relation. PAPR only says that dumped_bytes should not exceed the
source_len. My change reflects the same restriction in sw. Also along
with this lengths check, we have firmware reported error flag also,
which should take care of overflow (Qemu handles it like this [1]).

[1]
https://elixir.bootlin.com/qemu/v11.1.0-rc1/source/hw/ppc/spapr_fadump.c#L2=
63


~Shivang.

