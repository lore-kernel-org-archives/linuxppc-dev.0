Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D9E606A335
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NNXYf4Is
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVWG51S18z2y2R;
	Thu, 19 Nov 2026 19:04:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795075469;
	cv=none; b=PPcVSD6IKT8poaOnZ+wKDjdlKJOpqzOKPfZhPKOZ+X2hcTInD6N4RNhFrqZQpQuQ1r+PK6UNSK6iGxeLLo2dcJw7EZ9dugmSHLPgbvIh0nThYcpnvfHKxeZ04Q3CYC6MNB4FxFqqgG4pB9jgAigDbcV3A9bcU3vpn9kpQa/R/7LeN7qIBJrPud9z0Go+C+6qgD+zxYT6JWnxHePOE85xSDouJmJtHRfQnFkNOmXGXZ9oHNJY6qc4YnPXwBfPPkvSBCkf9/c2P0+KYS02qb/ZolbTmIdlYCLo1u2I+YE/VAR85a543KYg0/YRKdygBI3i2Gj+15/Kov/JxzVKnYlbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795075469; c=relaxed/relaxed;
	bh=KJVj/kj9TUfC5U25moNOJpfG8IeN1Z/DKDptskt/i9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4oXPZvCOML24IZSagCCSmCY02UWNB73vOJ3j3XCLrFitDt3q94E/wpno4XUcBqSW02GhzGftHHoCTJVJfBDV23qvcYNMd1wvZRJan67OR8U85CVdKypg5T0uON24q03//2BYzBejcbIRDK/IqgYSBx8cOXarNheHUkpNuddMOKH4wytXsyTSL6sLU4DwE3/WB5+16pMO2khzHRJ0L/U1udqXv8ijsJKXWu1x8Ue368kyMYZmPiIYBrPoSYCPz/F3nwxyj6KAA1C95YtLJCfJZdRC8vRvPltvGM2rH6CcJ1J8rw0sc39HC4nyZFyoQ2NPqa7USIIPEB6CgubVWI6QA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NNXYf4Is; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hca@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=NNXYf4Is;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=hca@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVWG40yhWz2y0B
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 19:04:27 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ6uX0n3598174;
	Thu, 19 Nov 2026 08:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=KJVj/kj9TUfC5U25moNOJpfG8IeN1Z
	/DKDptskt/i9I=; b=NNXYf4Iskp9aW7wh9wp5+yD++njdn0lJ9UHUxyVtLnGcOh
	+imeaNzLylMStHs7rWLVAS/6zxMvGlf790mWbLINInkhlMr5NPZfjBMEo93R6TDo
	v1DieXnPNHqmI2iGeOfK2qN8k+7IyE/kJf5EkWt7mNkDf6dP4/w4u3TpBCrupPQ6
	pDqkt+RQPiyksep4NBjfa54jrMrXYOPKvNmCqIAXAWDBQBpMyufCtsh83WEqcMFN
	ht4aQkWJNRHECdzT4s6B/WQLa81T2r3p9hEXy2PAyIhG1A3SoyH2PU2IMB/IZTHN
	Q9Sl/8Ox0awQGrT5FVxR6BIilCP6EhsnMa8O+44A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105nfft6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 08:03:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ74was179507;
	Thu, 19 Nov 2026 08:03:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3htdru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 08:03:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AJ83T0246989662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Nov 2026 08:03:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53ABD20040;
	Thu, 19 Nov 2026 08:03:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBB2B2004E;
	Thu, 19 Nov 2026 08:03:28 +0000 (GMT)
Received: from osiris (unknown [9.68.31.201])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Nov 2026 08:03:28 +0000 (GMT)
Date: Thu, 19 Nov 2026 09:03:27 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <baoquan.he@linux.dev>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Paul Walmsley <pjw@kernel.org>, Pratyush Yadav <pratyush@kernel.org>,
        Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org,
        Alexandre Ghiti <alex@ghiti.fr>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Cong Wang <cwang@multikernel.io>, Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        loongarch@lists.linux.dev
Subject: Re: [PATCH 2/2] arch, kexec: declare kexec and crash capabilities in
 Kconfig.kexec
Message-ID: <20261119080327.12916Ac7-hca@linux.ibm.com>
References: <20261119-arch-kconfig-v1-0-37c276fe4d26@kernel.org>
 <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-arch-kconfig-v1-2-37c276fe4d26@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMSBTYWx0ZWRfXy8bDEZD/HzO1
 Ej6fSCUmufwaGVs8qDbsLLSFspAjGF8EV57/b1UAhhkJVI7XRX4gvSjQSKfcSsiK74DRTfmozkt
 /ROcpv4UPzkhercU92Bv3pOW124/C4PyRRuMx/ikvSMd1AE3EG9BKsoxjRjGUkLK9hw7IJKrg4/
 YRAYeEUUMXCqn82c56PVhZptydQWuHKP4jJKXE05r4eSXDJU3z8jTciGXLv0tpOPm13aCmj/f0c
 VlJi7ZYKgBQELDj74CX57DaiLHPhuPSCjFRc6oLUx8NvurAyLoOAcOcizOtr/oEPqrKfVSGXr8Z
 I+pWvX+KMJTvAl1hPVIiPa366OqIAmWq2w0D6SVFoDpZkCddgcNowB9MS0YkiNpmHwVIKkH3Aig
 TSWl3fJ/fu21seeQCA7tRQxlIoKvqNtJGr/wq/mpgR9CL98J1JRMfDEC9Y0n62mBzCDYUXdtbhh
 6zgnLpz9nmHYhElrFug==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afead5a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=rNe8aJYx3auY1A-cjiAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 6EMbp8-aufz9djOo_kjz6yvOKs-gD7lm
X-Proofpoint-ORIG-GUID: 3vzaEwyOTJJHOeKIPx0B_GRjewJ73XWm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMSBTYWx0ZWRfX+jzSPCVdQB28
 e9b6AO4bXKV5KrHOR5wnZ38l6ryoyS9P0QgO17Eyyj1+OKhehU8TYsQNMNVX7bkCr++NTblrk4q
 XKZmhJevMP70D8zhZsJSq4dAvRO2bY0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190031
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 19, 2026 at 08:16:58AM +0200, Mike Rapoport (Microsoft) wrote:
> The options that let an architecture opt in to kexec and crash dump
> features, like ARCH_SUPPORTS_KEXEC or ARCH_SUPPORTS_CRASH_DUMP, are
> defined in each architecture's Kconfig as def_bool, and most of them are
> copied over several architectures.
> 
> Declare these options once in kernel/Kconfig.kexec next to the options
> that depend on them, similarly to how mm/Kconfig does it, and make the
> architectures select them instead.
> 
> Selection conditions are preserved, so there is no functional change.
> 
> Acked-by: Baoquan He <baoquan.he@linux.dev>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/arm/Kconfig       | 12 +++---------
>  arch/arm64/Kconfig     | 36 +++++++++---------------------------
>  arch/loongarch/Kconfig | 20 +++++---------------
>  arch/m68k/Kconfig      |  4 +---
>  arch/mips/Kconfig      | 12 +++---------
>  arch/parisc/Kconfig    |  8 ++------
>  arch/powerpc/Kconfig   | 30 +++++++-----------------------
>  arch/riscv/Kconfig     | 28 +++++++---------------------
>  arch/s390/Kconfig      | 28 ++++++----------------------
>  arch/sh/Kconfig        | 16 ++++------------
>  arch/x86/Kconfig       | 48 ++++++++++++------------------------------------
>  kernel/Kconfig.kexec   | 42 ++++++++++++++++++++++++++++++++++++++++++
>  12 files changed, 101 insertions(+), 183 deletions(-)

Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390

