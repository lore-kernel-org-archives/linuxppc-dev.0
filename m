Return-Path: <linuxppc-dev+bounces-26450-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CBDC624D3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Sep 2026 17:46:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZqsM2cpgz2xlv;
	Thu, 03 Sep 2026 03:46:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788371175;
	cv=none; b=Kk7CVG/h3lEDkKehK31aPmVo8B//asGJ7Hm8ojykqNUKvAPEru9sB67IbE2QaeuoqTrxMxTtmqBRtnDMLcM+ycdX0t+Zpu8nxU+ZLvQbAaX1oewpmpFMxBYWMGZN48ITCcTyFhVUVrMvS78I6N459bf3uJaCejOo8KIqOCrw1jVIGStSF1RD4hbuyWqF//reFXNAZTXSMt5aGoAKVkCVuFiqI87hrJDc4IduQaWKfW92VH2Vfoz7Oo+uXD+6yT4mp4tCQR9YyvBw6uqqzifXRsbDM4u4lQJ49z8MGuaYPjZvIU5b4ToUl+4Fk2VuuA08EwH2ushN72zjPE2K2Dx7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788371175; c=relaxed/relaxed;
	bh=vu7j0yzmTOGaqxfg2o7HwfP5mkZLcVehRDr5ia1Lahc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KxbevWJ4m1KWJvUq1Fh2/sGeKC5DeC2rAEi3AoPD9QSAkm5XsGRjoc0BFqr9yoOioY+xWpQncPazArkzp6J2gdFtiH8YiWUosBQizPVSDFpVweRWxPpk8QPEWClrxe8bCF+7Hgywzs4X1gp7Ezgh6JFF5MGd09+TOXKbsWxwXzmMTiGyEj3FqULvLGrvDBeETwiNbmoj+H7YjlK8k3K9JdA/eUlykOdmE4YbmvYEIfcyyb+0L0KGvmlf8p9dhGzrZyT339Y87S9BwLWCJ+D1+V7cumNtOyW+W70/DTawVepjLUFkzhAvH5wkRZ94Ch7zeBZaH1E1vRVyksCMGFZh+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gQ5qdhLJ; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gQ5qdhLJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZqsL2C6Sz2xl6
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Sep 2026 03:46:13 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HVSnq657455;
	Wed, 2 Sep 2026 17:46:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vu7j0y
	zmTOGaqxfg2o7HwfP5mkZLcVehRDr5ia1Lahc=; b=gQ5qdhLJv7ptphHsAK/ph3
	2AsURYl8aLEchRnCuNTCaTAfm5OZTOw9DZcJbHTl083bd/zp31NULl+1dfICw6hh
	l70zmKnyIevBHnhhWBmyztLX0cW5/dHEOfJSJsQ1PtiY4iXi0AbqwPHzGvDLdsz+
	rMiEkz5FKZQ2Y6egWnskh9w7/sDgN2dbPOmslqNMRRJANarTrEjR/KSRxVLpOc13
	/Utopa3O6uLAxiHInTJllXp9yrev0oMiwonCQvgmZ81ykdVFOzcEXQYYXkQrmBY/
	XBCYp5usniEDSBZEzpQr+A7FyptTNNwPbErZ8SGhDIU9vT2zzueXteldDTDDOItw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq550dek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 17:46:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682HfH9l010093;
	Wed, 2 Sep 2026 17:46:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjakquc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 17:46:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682Hk4kb42991956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 17:46:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BC612004E;
	Wed,  2 Sep 2026 17:46:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9AA5A20043;
	Wed,  2 Sep 2026 17:46:01 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.84.236.55])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 17:46:01 +0000 (GMT)
Message-ID: <a0d95277e5771dc74afdc8058448b4e89c3a2cd7.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/entry: Fix double accounting of user time on
 interrupt entry
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Mukesh Kumar Chaurasiya	
 <mchauras@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Shrikanth
 Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Ritesh Harjani
	 <ritesh.list@gmail.com>
Date: Wed, 02 Sep 2026 23:15:59 +0530
In-Reply-To: <ape0GY5__P-_DdxF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260902050628.2553909-1-aboorvad@linux.ibm.com>
	 <ape0GY5__P-_DdxF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1NCBTYWx0ZWRfX0slba/WoLBhi
 1O/s7anqt+zkcyHlIbQAIBAnRNWaCVhlToxD3H0YvZqhiC832XEzRiRAoAwRV9HNNcR9onHIc9Q
 W/PxTWqi4V0dcZVdZYP4xP8A/K/TyGCTw+ZEOXeMinxpOUmuuepsCWPHk7Hp6CbAhaSmC5ptwto
 21UeEmH8qbd4AWi1v1clqXvL36bHASZsBL0+AhaGyeUXBNs9LNpvpbMMi9HsG8I4CRv6GSzIHdP
 oMO7ArCQZCeyvxoix9Is04a/jsE6IDhAi+mrKHAQ4kVPMVK4eHyn1fkvtTHO6VjZ5lVyGv5bk32
 cfjRn58OPXQkEPZiDpKS9YPHaS79vPlaLsAgELbP/iu1IZp9KXLQkAuJTcYr+fihQAu3Pc99PG4
 ZyrZTlFLJ5gbDILe8Zx8U522ceEobBjWo9HZuYdSRbA4BOjGd8RFhPqJTtcmvvcy9d2DLjBBYTr
 PmKc1cJTEw4Y+yRll+Q==
X-Proofpoint-ORIG-GUID: PgKkCeLkdDR6JociuO39dQ1V_Lu8THJL
X-Authority-Analysis: v=2.4 cv=CNgamxrD c=1 sm=1 tr=0 ts=6a9860e1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=1y1RV8LzgxBv0SgG8zUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: BdSw1y9abjrdkpAw_OCicYoARwWrzMHT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1NCBTYWx0ZWRfXx8BLKiz+JSHl
 Mt8/WUSiTitrD/gCTiG3TrvhR3IDMT1+DCnpoMh+i7EB/4EXj3aOCNSXqyDNzrf/RMOXlV6GyP1
 VDS2geuapp4uV2I/CnEbCtY6WDuSAFg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020154

On Wed, 2026-09-02 at 11:01 +0530, Mukesh Kumar Chaurasiya wrote:

Hi Mukesh,

> On Wed, Sep 02, 2026 at 10:36:28AM +0530, Aboorva Devarajan wrote:
> > Since the switch to generic entry, an interrupt taken from user mode
> > accounts user time twice: once in arch_interrupt_enter_prepare() and
> > again in arch_enter_from_user_mode(), which irqentry_enter() invokes
> > for the same interrupt:
> >=20
> > =C2=A0 arch_interrupt_enter_prepare()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 account_cpu_user_entry()
> > =C2=A0 irqentry_enter()
> > =C2=A0=C2=A0=C2=A0 arch_enter_from_user_mode()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 account_cpu_user_entry()
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
> > Remove the accounting from arch_interrupt_enter_prepare() and rely on
> > arch_enter_from_user_mode(), which runs for both syscalls and
> > interrupts. The duplicate account_stolen_time() call is removed the
> > same way.
> >=20
> > Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> > Verified on a pseries LPAR (CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=3Dy),
> > 7.3.0-rc1, single-threaded CPU-bound loop:
> >=20
> > Before:
> >=20
> > =C2=A0 $ python3 -c 'while True: pass' &
> > =C2=A0 $ sleep 3; ps -p $! -o pid,etime,time,pcpu
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PID=C2=A0=C2=A0=C2=A0=C2=A0 ELAPSED=C2=
=A0=C2=A0=C2=A0=C2=A0 TIME %CPU
> > =C2=A0=C2=A0=C2=A0=C2=A0 4980=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:03=
 00:00:06=C2=A0 210
> >=20
> > After:
> >=20
> > =C2=A0 $ python3 -c 'while True: pass' &
> > =C2=A0 $ sleep 3; ps -p $! -o pid,etime,time,pcpu
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PID=C2=A0=C2=A0=C2=A0=C2=A0 ELAPSED=C2=
=A0=C2=A0=C2=A0=C2=A0 TIME %CPU
> > =C2=A0=C2=A0=C2=A0=C2=A0 4951=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 00:03=
 00:00:03=C2=A0 105
> >=20
> > =C2=A0arch/powerpc/include/asm/entry-common.h | 6 ++++--
> > =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/entry-common.h b/arch/powerpc/inc=
lude/asm/entry-common.h
> > index c5adb5006361..984294e62568 100644
> > --- a/arch/powerpc/include/asm/entry-common.h
> > +++ b/arch/powerpc/include/asm/entry-common.h
> > @@ -222,8 +222,6 @@ static inline void arch_interrupt_enter_prepare(str=
uct pt_regs *regs)
> > =C2=A0
> > =C2=A0	if (user_mode(regs)) {
> > =C2=A0		kuap_lock();
> > -		account_cpu_user_entry();
> > -		account_stolen_time();
> Yeah, that's dual accounting the time.
>=20
> Thanks for the fix.
> > =C2=A0	} else {
> > =C2=A0		kuap_save_and_lock(regs);
> > =C2=A0		/*
> > @@ -426,6 +424,10 @@ static __always_inline void arch_enter_from_user_m=
ode(struct pt_regs *regs)
> > =C2=A0#endif
> > =C2=A0	kuap_assert_locked();
> > =C2=A0	booke_restore_dbcr0();
> > +	/*
> > +	 * User and stolen time is accounted here for every entry from
> > +	 * user mode. The interrupt prepare hooks must not account again.
> > +	 */
> I think this comment is very specific to the current problem. We already
> have a commit history to explain this, I guess we can remove this
> comment.

Agreed, I will drop it in v2.

>=20
> With that,
>=20
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

Thanks.

>=20
> Thanks,
> Mukesh
> > =C2=A0	account_cpu_user_entry();
> > =C2=A0	account_stolen_time();
> > =C2=A0
> >=20
> > base-commit: fb442a6673ff1046bf67754957d95880fdb394b5
> > --=20
> > 2.54.0
> >=20

