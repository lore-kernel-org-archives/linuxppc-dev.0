Return-Path: <linuxppc-dev+bounces-26868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1555C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 05:29:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfq9S54wxz2ybK;
	Wed, 09 Sep 2026 15:29:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788931740;
	cv=none; b=f40jjA61l+/kZ5uyCh1gTay7CDclsN1fr92OwL+00y52NotqzEZ3LMkP/eJemWE1tTwVGlaHDKK0Z5XlcOoRn9qCjgZVmBmPbSHXN016SuGIqxAeqcct8gVYs4wntawQFttQFV8eP0CqKDSNYMkmIdImSjWAVxT8rQ8XEsxrzRe3PK8uwpxjlUfdATyHgvEnOOjjjBFJzu1eZJ1iXgV8AZkIrrJB0z8vdGhDxSxA8k6xBra4xYm9TVvAGbTJlbUYuwIuVPOkJz3pfvRArDwShTi/EsFXrUVC9cYzOrovuu+j3Xwsx7HUfX+tN56/EltD1vMpw5xryuarfD5o6AXkBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788931740; c=relaxed/relaxed;
	bh=SaSmSwb5+ofYkEvpsbuLF2tga5O7aTXcipz58r1X/SE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LO34mIea6NKqvovp8exg+0k0rXF+bIA5Ux+A/FrKvqQjfKp5VKwfqrYuzcRdAluhoDJYpX4HSAEvZ8w3WwCWOc6ijJ4gAxl6pLoPgdnfU/eGuaHBdtJVRfI48ys3KNTqqKA7Zrw4SLeFhtcMxMwXfhXYdQgJmgN6eg66vQYHtzDHnmXcQEsS+Lut30PSbPHOKsmjUHRT5tqVie0dIVBAXa9Tg+KEChngyHCZ6WYrT+DxXQN1HXjPf9cSvLn0PvN+aiOgDS6ezL+zVkwU/QQtB4MZT7bN1Pse8Xz2B1UaMbcWhCZBC2uUUHkluC4+VHjWrfSaJViLBuY7c40ZafPK6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rY1oONZV; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rY1oONZV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=venkat88@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfq9R5B72z2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 15:28:59 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1XEM2272051;
	Wed, 9 Sep 2026 05:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SaSmSw
	b5+ofYkEvpsbuLF2tga5O7aTXcipz58r1X/SE=; b=rY1oONZVJRu1iRh/a1Jnhc
	C6vmEtWAJmKtmr1TxZjgENXlyjZkx7A+FQlViuU407O4bxkhYAJ+3FOn9VDa4Ki+
	TcbIlg/irgdM/VH6L4AyoW4meEKGVEVV47zOWEvQum0tSThYyZR4hJSB3tt5ETgU
	f6D1D66TqKB4f28gwRpVx3oIoust24pZW2sy/gRJaroKWLu7UfPwigrMGpd14CTR
	KyeFjqJQd/bBwHWJBFnHBgbm048DLoVTlx7bVAYd4kIGheiQMzTNqGn7SNnM8+4D
	ZF+8fo1Z0VZovZPKURy7RVk1H4NiJwO1OGLdaAz33LssD4pm6LOTQTqoimdFidag
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf43uqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 05:28:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6895QGmS004351;
	Wed, 9 Sep 2026 05:28:40 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw8h7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 05:28:40 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6895Sdra25887274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 05:28:39 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 626165805A;
	Wed,  9 Sep 2026 05:28:39 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FBA658052;
	Wed,  9 Sep 2026 05:28:36 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.123.0.173])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  9 Sep 2026 05:28:36 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] selftests/powerpc/tm: Fix tcheck() reading uninitialised
 CR value
From: Venkat <venkat88@linux.ibm.com>
In-Reply-To: <20260907215420.1258678-1-thibault.ferrante@canonical.com>
Date: Wed, 9 Sep 2026 10:58:23 +0530
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, shuah@kernel.org, chleroy@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4206CE63-979B-4464-BECE-F89D0B1BDC91@linux.ibm.com>
References: <20260907215420.1258678-1-thibault.ferrante@canonical.com>
To: Thibault Ferrante <thibault.ferrante@canonical.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Born88Xy5W__aUKQPHZNVaBvKO3rLeS2
X-Proofpoint-GUID: 2NosABKQM7vMTTgQ1lQgtCbA07niRYZL
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa0ee89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=danhDmx_AAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=DfNHnWVPAAAA:8 a=J6Up9oq4io0qgRxRdXUA:9
 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA1NSBTYWx0ZWRfX9LO+VVbSPt+V
 5pUiFzBXG2rgLT0JDllYFyGJ61649W4bFpwVV/dyV6pCTYRV0vQWc64QHkzCriaeiLiqCX4Jlg+
 NufVYbcxXzo7LJbJQJwLnjdAJJEcuSgGpce8onVhV938MCATnxdiErkRhVa25Da3vnla+kEACF6
 V3u3oJHpQPECO3fg+rEUG4Fx3KwXGkRPr+TINcni/BIy5nfW/z0Mq98t3AtWaM+GWjtCy6Tv6hH
 xsCE+x9qgPmlC72zcaOImNqavCJUxd1TSdkQZJm7mNh/XwBOst7/pDml6DaiIC8ZR6tpG5ee0Fx
 7DE2cae+ngU/4x1mIal6Ecc55dnKkl+kw1XOIsrG95E8ripNb1iYaE0XHTUs/zDOPmi1lHmclOE
 5th+1h5i6GYCMpDdlBLSS8/71+Gu5yh92UylpvDoEMW4HiVSQd5+QeHg5ErScxDPf6F0sqbUnot
 BKzL4r37ZL4ZOF0cdFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA1NSBTYWx0ZWRfX6ZQJ+mMiNzmX
 TuLwEE/EP+HE6WcFyFy2s1BOLncleaa+yqGdqn4vWYtJOXyEQSeVOnsxsBStRszYl0Gje2quiRR
 UeHlm4pFuZTILPAWLfm0wk6ZQp1+dyo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090055



> On 8 Sep 2026, at 3:24=E2=80=AFAM, Thibault Ferrante =
<thibault.ferrante@canonical.com> wrote:
>=20
> tcheck() is used to check the current transaction state (active,
> suspended, doomed) via the "tcheck" instruction, which writes its
> result into CR field 0. The inline asm declared a GPR output operand
> for this result but never actually moved the CR into it.
>=20
> Every caller (tcheck_doomed(), tcheck_active(), tcheck_suspended(),
> tcheck_transactional()) has effectively been testing bits of an =
unrelated,
> arbitrary register value since this helper was introduced.
> The "& 4" mask discards the TDOOMED and TS_lsb (suspended) bits before
> they ever reach the callers, so tcheck_doomed() and tcheck_suspended()
> can never return true, and tcheck_transactional() degrades to being
> equivalent to tcheck_active().
>=20
> Fix tcheck() to actually move CR into the output register with mfcr,
> and widen the mask from "& 4" to "& 0xf" so the full CR0 nibble
> (TDOOMED | TS_msb | TS_lsb | reserved) is preserved for the callers.
>=20
> This bug has been present since tcheck() was introduced.
>=20
> Link: https://bugs.launchpad.net/bugs/2107442
> Fixes: 8e03bd4e70b6 ("selftests/powerpc: Add TM tcheck helpers in C")
> Signed-off-by: Thibault Ferrante <thibault.ferrante@canonical.com>
> ---

Applied this patch on top of latest mainline and all the signal =
selftests are passing.


Please add below tags.

Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Closes: =
https://lore.kernel.org/all/364996ce-aba2-4213-8d20-7dd481b43fe6@linux.ibm=
.com/

With this Patch:


# make run_tests=20
# timeout set to 0
# selftests: powerpc/signal: signal
ok 1 selftests: powerpc/signal: signal
# timeout set to 0
# selftests: powerpc/signal: signal_tm
ok 2 selftests: powerpc/signal: signal_tm
# timeout set to 0
# selftests: powerpc/signal: sigfuz
ok 3 selftests: powerpc/signal: sigfuz
# timeout set to 0
# selftests: powerpc/signal: sigreturn_vdso
ok 4 selftests: powerpc/signal: sigreturn_vdso
# timeout set to 0
# selftests: powerpc/signal: sig_sc_double_restart
ok 5 selftests: powerpc/signal: sig_sc_double_restart
# timeout set to 0
# selftests: powerpc/signal: sigreturn_kernel
ok 6 selftests: powerpc/signal: sigreturn_kernel
# timeout set to 0
# selftests: powerpc/signal: sigreturn_unaligned
ok 7 selftests: powerpc/signal: sigreturn_unaligned

Regards,
Venkat.



> tools/testing/selftests/powerpc/tm/tm.h | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/powerpc/tm/tm.h =
b/tools/testing/selftests/powerpc/tm/tm.h
> index c03c6e778876..6024ce4ba6ff 100644
> --- a/tools/testing/selftests/powerpc/tm/tm.h
> +++ b/tools/testing/selftests/powerpc/tm/tm.h
> @@ -105,8 +105,12 @@ static inline bool failure_is_nesting(void)
> static inline int tcheck(void)
> {
> long cr;
> - asm volatile ("tcheck 0" : "=3Dr"(cr) : : "cr0");
> - return (cr >> 28) & 4;
> + asm volatile("tcheck 0;"
> +     "mfcr %0;"
> +     : "=3Dr"(cr)
> +     :
> +     : "cr0");
> + return (cr >> 28) & 0xf;
> }
>=20
> static inline bool tcheck_doomed(void)
> --=20
> 2.55.0
>=20


