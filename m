Return-Path: <linuxppc-dev+bounces-24922-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF886C54EFC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 09:44:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8Vsy5hZMz2yRl;
	Tue, 28 Jul 2026 19:44:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785231862;
	cv=none; b=gxQHQEy9D4x5AulIoTn3Co/w0IQ7/MPetAArSPYOdq3UmBdviSPpVX94zBkWJxCfNxGa4beqcJjhaBaM/zcw9/XqmEf4oPniQ5ITkO49uwjkzCbxsSPMpajvBNl6A//JzZbJqbOHj2GzuvIddHWTnekdS7UqBSgB8LTKrG77kgQg1zF72N7hrEWzRihErn9/fS/k5bya7ybPobKGEFayezUoJGxysgF5nt9walx+ldMK856J3oXGB6VCXv+Hqz06O4h3mLG4xl1FoXbABZ/MvrKMFOsc879dNn+MsjJKzZwexjFEK0qIBu6mSGkmuVkHgz2hQGwSsYAH6o6cVlc8Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785231862; c=relaxed/relaxed;
	bh=RKGef2muif6ILNO0XS5ceeemFadj3Xs9s5IP3G284/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGpHAVYlOzczpDRV+Dsb0yK7IYPPZNAW4CPQ3/qXfyGL5loWXelJa6Gz2guoScPg66SZz1bNJ2uzworyt7+aFLQZPreDw+YHRu+u56oINTXV1AIzRB2R6OvoJ+QI24fZ7ItoiGtOs66OhzPShBxzlCwLJf9Y62gWdxdd7KmOpmSZPUHRa5AmTK5O+5LJIHNUj+YO+ZzDuHTmyMBiqZOga3Dfbu92jlPwucy6rqTWkwDamgf4llIvZOs9uRzqLSEOrqXgTf1nu4ltnIxifrjiexBy0Me7Wpfv/Q3qqfbFaDat3rGa1nxsILKnohM9hvM9X8L4JJogbWqzpj44ibhuUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z6UxIv8a; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Z6UxIv8a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8Vsx6jMVz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 19:44:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S8HZtZ2808589;
	Tue, 28 Jul 2026 09:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RKGef2
	muif6ILNO0XS5ceeemFadj3Xs9s5IP3G284/w=; b=Z6UxIv8as0QUC5VhG+w4jY
	zSa3vWhzyOCdnkMJlH2YdAdnHL2AjIO0AEB5siK9Sd2Uv6FJ90K0lvOt4sefEkru
	77K6Qu+rJb1E/6+kEVYiD1qcAzap39O6ABZtxwAH4iP8Xub45LmGDa6UzUrTGQ1L
	osEV7xbEyABD7xF+i96HKSZ1FHnrx6rrYJ8mcY0bexZwBlsC957R/GITLsCZcPhC
	X57nRHbSqzQCFHaB04Jrpvg1s2NptX6FhQ6U/WuyZ9sw3FJOyl8swjQzePVkdIs6
	95EwSyAcdKJIHepkQcKlqyfCkK6dIJTpGUWk6Lu0eDQpYmgWkrLnnHBcNiuXTWDA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyccfp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 09:44:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66S9fKJb015848;
	Tue, 28 Jul 2026 09:44:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uw1bam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 09:44:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66S9hwtS17236386
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 09:43:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FE0B20049;
	Tue, 28 Jul 2026 09:43:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE14F20040;
	Tue, 28 Jul 2026 09:43:56 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 28 Jul 2026 09:43:56 +0000 (GMT)
Date: Tue, 28 Jul 2026 15:14:19 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>,
        Geoff Levand <geoff@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Remove unused struct table in setup_areas()
Message-ID: <20260728151342.229f146b-70-amachhiw@linux.ibm.com>
Mail-Followup-To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>, 
	Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260712151300.3664-3-thorsten.blum@linux.dev>
 <a7f327e0-072b-41c9-ba95-361c948ddfa9@kernel.org>
 <b671b001-8120-4f50-90c8-3d0abf01300e@linux.ibm.com>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b671b001-8120-4f50-90c8-3d0abf01300e@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: geJosZ8Q5xtwmpK95yc9dUoZsrIm6BuM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4MCBTYWx0ZWRfX3iWePMufe/oS
 nHoboRssUthrAleAp0X/7qyKx6o3c4gsWgUri3nB5+YA5tQgRDQdkFhN4My8v4pMOaFpTk/yUH+
 8XXSaJ1pvuEhjBPExumTalzculVs181E7DrX9sb/Hq0mM9FrFr1PIofp8c2QdeUcFviJbpjBuDR
 rOI/VT2+1j/ZF+712qvyvFHH8yFqTwBIG+jJENYgcyWLbdSdFZpqUbOjA83pME0viLe/EWIzE1L
 YI4B87rcLcY54pS4T2dVyivlKRxmw6lNrhLNjiyCJL3pJri0t7poY3arEClj71F1Qavm2R69Ozs
 qwjWqKbCucjpPCUtXmPGjjnsBJL4g971vNZvWyEWndTiJ+1ijJ5+K32D5RCSYYfsqLk3alrOVoA
 Rz9NcnK7fckx7bXzyFi58uRZfLbcnWlFB41F26ueFVDSwsGY6nxQuCWqKIGGfP3xC8fEouuNEkV
 Mq1NyNjObDJcyXAPuEg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4MCBTYWx0ZWRfXyLoOpDsly26Z
 DuI0mO+uHTP55TlBM+IohsPE4AHASL/Q54muRBLjw8Csg5uKq7Y6BxkS0xSL33EUyNImkIRdM6m
 9ZRZkmJrauVS8eakZa7dKYmPPgJSSJA=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6879e2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=or1Wt5K52hvALrdL_UMA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: qcvLNJ_uvZyTOzQ-rJk5C0Btt_lqS0TZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280080

On 2026/07/28 11:32 AM, Madhavan Srinivasan wrote:
> 
> On 7/27/26 6:47 PM, Christophe Leroy (CS GROUP) wrote:
> > 
> > 
> > Le 12/07/2026 à 17:13, Thorsten Blum a écrit :
> > > The local table structure is not used - remove it.
> > > 
> > > Remove % in the comment while at it.
> > > 
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > 
> > Looks like it's never been used since commit de91a5342995 ("[POWERPC]
> > ps3: add spu support") that introduced it.
> > 
> > 
> > Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> > 
> > I have no opinion about the %0 versus 0, is it worth the change ?
> FYI.. I have added this patch as-is to my fixes-test
> not waiting for v2

The v2 was already sent Maddy.

  https://lore.kernel.org/all/20260713091731.97212-3-thorsten.blum@linux.dev/

Thanks,
Amit

> Maddy
> > 
> > 
> > > ---
> > >   arch/powerpc/platforms/ps3/spu.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/platforms/ps3/spu.c
> > > b/arch/powerpc/platforms/ps3/spu.c
> > > index e817def7f424..c904f9fa1caa 100644
> > > --- a/arch/powerpc/platforms/ps3/spu.c
> > > +++ b/arch/powerpc/platforms/ps3/spu.c
> > > @@ -185,13 +185,11 @@ static void spu_unmap(struct spu *spu)
> > >    * The current HV requires the spu shadow regs to be mapped with the
> > >    * PTE page protection bits set as read-only.
> > >    *
> > > - * Returns: %0 on success or -errno on error.
> > > + * Returns: 0 on success or -errno on error.
> > >    */
> > >     static int __init setup_areas(struct spu *spu)
> > >   {
> > > -    struct table {char* name; unsigned long addr; unsigned long size;};
> > > -
> > >       spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
> > >                             sizeof(struct spe_shadow),
> > > pgprot_noncached_wc(PAGE_KERNEL_RO));
> > 
> 

