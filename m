Return-Path: <linuxppc-dev+bounces-24635-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A43DC4453A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 09:11:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4pRC4NPwz2y1F;
	Wed, 22 Jul 2026 19:11:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784711511;
	cv=none; b=mBFgKT+1WQo4cY3Hb+x0Q3/5ZFsvkQGCmJz8GQPEiCfoGL/gNnE8iFDd4ewdfIzmnHQz+eiIKPveeb+90f9yTM4VTqBWaucS8qac+Q/FJqRu/afvq6YPU3xsHONfrcOw16EzgSL6fUo1/lo+HRBYReZWAfhnUxnasD1AIOPTUiPu2LE9JvIipJ267k9Gk1kvSWI+QARDrtEPoiH17zhwonY3gT41MtoJ6vzBn1CxI4L7/SkU6GaN+NBydCl8uqE/uEn5Mp9gvs+Y+Lgk0YOT6NGMln52htu2jlH1SdKWCevdBfYxzeQ0llrUq9JEom/5hD+NyaFMlEhYRxSwgtPmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784711511; c=relaxed/relaxed;
	bh=FA+/rxUijKPrvOIWo26LQdgmHtPKosAfeWskdjkpZqo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o1SI3EsXSOkUyYNqRmY/jsMw9Bs4PDkMbIYp1px1+2LooIpmeTzEm1BhdFIXA1LWgqv9qGTxnRZkdVGKgu1n+ijctoTeF10fDpLpu/FK48kDEkr0W8Wql7ETKgqg0ExDUKFqsG3s15/eoSjE0TTHxLJ/S58H8QpJmrF/wxhDpuA/TxPkmzzR9K00+iWAp4zJKbNdjrRVyVYdVcc1fTAxZDpfpiHYm4xpnVQzPpqPkDfrbs8Fq0aH17b/qbd6O8p7u8QJNdPAeLLRDPqar14KGk4aYM5RFDJneCLYGdRUNcM/gJPy5QnTG+oig5ydtBR3Z8TNsPJad0hrI69UEVFMEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MdTkrZFe; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MdTkrZFe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4pRB5g1wz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 19:11:50 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66M5CFq93153884;
	Wed, 22 Jul 2026 09:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FA+/rx
	UijKPrvOIWo26LQdgmHtPKosAfeWskdjkpZqo=; b=MdTkrZFeODCCsCIDNLQ857
	xkMDcdOnmN3X6Mn9QacMOT+9U0gmJ9FIDftdIGWIXkOltxAqbi/xpB3H6DaVk/vs
	yzANWrGtFtoe6H13brPb8hO9KOvB/HCj/wPeXwcxs4mGjkoo0TGdG+bVsmfCSJtw
	vHMDhFXY9IkEjVBZ6NH/bkLrvcdtjNSX/Ro0UpFPbxqc/UIVfiXU6YNekDTS8DIZ
	q8UQslLrowmzzmLYIf39Zl0C13EfxZU9nQ8B9kd3DFZAGoGhN6MGg7rXBjYva2RO
	BMgKtHSA5+XjfqwDojydI/r3B9a++41pQr45gRYX57mHqqgEBIzI/ywXiK6GwqDQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah8u9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 09:11:31 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66M952N7006043;
	Wed, 22 Jul 2026 09:11:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgye9yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jul 2026 09:11:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66M9BQkE50856356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jul 2026 09:11:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AE7F2011B;
	Wed, 22 Jul 2026 09:11:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96D5120116;
	Wed, 22 Jul 2026 09:11:23 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Jul 2026 09:11:23 +0000 (GMT)
Message-ID: <afd516619eea338039a6defb123ffaf38cf82949.camel@linux.ibm.com>
Subject: Re: [PATCH] ppc/fadump: collect dump if the collected size is
 lesser than reserved
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, adri.vero.dev@gmail.com, adityag@linux.ibm.com,
        anushree.mathur@linux.vnet.ibm.com
Date: Wed, 22 Jul 2026 14:41:22 +0530
In-Reply-To: <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
References: <20260714173010.615682-1-shivangu@linux.ibm.com>
	 <446c84c2-8639-4ecb-8a46-1e203a166e46@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: QvUS0EuO8yGxrysIgsZQhtdex877iRZR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA4MSBTYWx0ZWRfX+dUMXNs19/zR
 SmmDWnHqqooEGht4aoLP1IpKHbzTblWsIemaayAR6xcR0fRl2ZwspBv8jfkt465q3MeGD4DwAG+
 T/DW79lvxHFW5x2PaLDYn/Cg+rJb+m+Wp26ickyMTevw6oeaAANK+x0LposTwUxpE/EhrFtwRMn
 zsmCM0gCZrsvJ2o7ne4TjYSj6OXuCqqHeiQ4UaijxJf+tI6FksQ5OVmAFiY9LqD6jlC2mWR+yzD
 xMdbLTU4KUQXIyktqpmoEt7jkSCzf7iBZUecB+Yg/YKQoYobMhA1hL5PVvF0REEt1THasrLWA5J
 +uqdhYI/8zZI3Qy7zVddAxYhz2mpcQ1bvh6d3THI/qUBVAO7LLLpJoC2RAYnQGLLdqekb7HHPIb
 Un0Q/0PJv8x46chlJjZec95/4kNXQWx8EixNMu8ByGrfHz4IEwGv/IQz7SFYxybFb0XpvFRXkH3
 KcseoHXz0lfXqKZLhvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA4MSBTYWx0ZWRfX9emwXLSrzACk
 qjGHUZHW8rRrZM/SfqZa5McW1A0cb7gq/dEa3ZXGNPvBau7W9lM4ZM9lEpvbhw4uDu+2TbT4py8
 +EVtHz930uveI7L75YswAN1WOX9zXZw=
X-Proofpoint-GUID: wH7Ju42W9jRrKcxCDuuz2Ys3qGyXm7RN
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a608943 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8Fid4Lw7F1ng2p3Qk_oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220081

On Sun, 2026-07-19 at 12:39 +0530, Sourabh Jain wrote:
> Could you please reword the commit title to make it a bit clearer?
>=20
>=20
> On 14/07/26 23:00, Shivang Upadhyay wrote:
> > When a machine is subjected to CPUs add/remove, using dlpar
> > operations, the number of collected CPU_NOTES can change.
> > As per PAPR, collected dump size should not be more than
> > allocated size. Reflecting the same in source.
>=20
> Can you add more details about the problem you are trying to solve
> with this patch and how.
>=20
> Adding the error message and scenario would be really helpful in
> understanding the problem.
>=20

Hi Sourabh,

 When a qemu ppc machine is booted with fadump=3Don and `-
smp=3Dx,maxcpus=3Dy`, on the panic kernel, /proc/vmcore is not generated
because dump_bytes and source_len does'nt match for CPU_STATE_DATA
region in fadump, then we just give up on parsing rest of the data.


> Can you add Closes tag if it is reported upstream and if possible
> fixes=20
> tag too.
>=20
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > ---
> > =C2=A0 arch/powerpc/platforms/pseries/rtas-fadump.c | 3 ++-
> > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/platforms/pseries/rtas-fadump.c
> > b/arch/powerpc/platforms/pseries/rtas-fadump.c
> > index 3bb4ac2ab6cc..19a5adaf326b 100644
> > --- a/arch/powerpc/platforms/pseries/rtas-fadump.c
> > +++ b/arch/powerpc/platforms/pseries/rtas-fadump.c
> > @@ -469,7 +469,8 @@ static int __init rtas_fadump_process(struct
> > fw_dump *fadump_conf)
> > =C2=A0=C2=A0				pr_err("Dump taken by platform is
> > not valid (%d)\n", i);
> > =C2=A0=C2=A0				rc =3D -EINVAL;
> > =C2=A0=C2=A0			}
> > -			if (fdm_active->rgn[i].bytes_dumped !=3D
> > fdm_active->rgn[i].source_len) {
> > +			if (be64_to_cpu(fdm_active-
> > >rgn[i].bytes_dumped)
> > +			=C2=A0=C2=A0=C2=A0 > be64_to_cpu(fdm_active-
> > >rgn[i].source_len)) {
>=20
> Can you please share your observations about `bytes_dump` for both
> QEMU=20
> and a
> real system (LPAR) where the number of online CPUs is not equal to
> the=20
> maximum

I have the following observation.

I booted LPAR with 8 cpus. After crashing it I saw that fadump
CPU_STATE_DATA has notes for total 16 cpus, and only top 8 notes have
valid entries. when trying with 16, I see all NOTES have entried
filled.

I previously proposed this fake entries fix in qemu [1]. But that is
not compliant with PAPR, which states that cpu notes should be
collected for current_cpus only.=20

As per current states of things, reservation is always done for
maxcpus, (LPAR and QEMU both), NOTES collections is done for current
cpus on QEMU, and maxcpus on LPARs.

My proposal here is that we make the check for bytes_dumped and
source_len, less restrictive to let QEMU also generate /proc/vmcore,
when current_cpus !=3D maxcpus.


Regards=20
~Shivang.

[1]
https://lore.kernel.org/qemu-devel/20260520092857.1079193-1-shivangu@linux.=
ibm.com/


