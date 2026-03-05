Return-Path: <linuxppc-dev+bounces-17784-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2A6F3D33E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Mar 2026 17:26:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRc080P61z3c5y;
	Fri, 06 Mar 2026 04:26:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772731592;
	cv=none; b=k6QZBi1Qct1ib+tjFJk0s5dW6PuW34oirAOU2oU/09eNkqZybdFE7uShXNP/eM99vBrY1uzzJ/SWMxfQLqQtGI+DR7LK9yNYzvzzFDQKs9wPU8l47ip6kK6eEPfoKN5sxoCn3zwNaAtlGzHVW8HvtwdbUGiTlb8B8jZzgZoqV6h0OL3go76JenpZ8lHrmuUcVUTYevo3ttnT2Zu8BMXkdvUo5jewsOpeUcaSNpbfIoSCO1k1EyYINSWpZ7UQOLm66CchlJnphf3BKhbAwRi8lBf5ikWL2qfYV5z3RG7+jdC7Py/4EumABy26FvXjlZchDoc5JYMJjEl2Tg3p0CN6mg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772731592; c=relaxed/relaxed;
	bh=pKEoPgCndWCLrBzB+ANvkugEGsbEG9dKmNVe+ux6b/I=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=bflURWbrz/TyiftAJCFpgpzyK1kLVy6bd6C7wQfT55VUT8M/qvEHjfLw9uGwJrJ/hdpPHLpub23cwnM7Tz7NbmH6wX6buI2R9Cc7nwTAxrKNCgOEyGefTwRREfn3g+nSil9OJMXK3wiofTlFLVGkoQKe3/FPmoplqh6zv+/TwB/0j7+wVAq4njBzqP7RLRhfu2HHrogBs9fyLlptcEkyqD+XCroFLkKWkYgubVEnqBKmo7Bii9gJOKehxqcVjT5wlFtiiGUevLPZeUBEUPjqEZ9hET6q4eE7DEd4VWmdXHZEVEV4I/Uq/vcWROfZPywITGBPGQ/pY76Z6jNH95/wpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f5HhaZL2; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f5HhaZL2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRc0662x8z3bhG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 04:26:29 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6256XhaF2358989;
	Thu, 5 Mar 2026 17:25:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pKEoPg
	CndWCLrBzB+ANvkugEGsbEG9dKmNVe+ux6b/I=; b=f5HhaZL2YLiPpyCKTkbu9J
	IGDq/HdnHKBMZigcHjg/Cd8VlwblJsE5+TR6lvbkI5Itkm2FCCPoXMXxxGzkVVvN
	bkMVpn/KPZJI92/LSPO0lr5t3nk74fy+h6B7QHwtK66PgaHvIhzoBAIVFUVNx7es
	hquql/vPTH9LvLzyoPvW3uKrBwLMuJiaoyB4zSQFiKMgm+Z214WiMZhbLKDnsQB9
	U5nt7kT7cFoq0J8dv4iysXNG/Lx8rndllpDctzwLpxo/qsWhw/+udsiCIS98ggBq
	yb3XfU9eksHCf7WGOG0KxVZb3P+eJYk7eIXLSYGp91e+yU344EWER5UygGXcPBww
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksk44ce4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 17:25:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 625FQouo027658;
	Thu, 5 Mar 2026 17:25:45 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjm17q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 17:25:45 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 625HPips8979076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Mar 2026 17:25:44 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A49858056;
	Thu,  5 Mar 2026 17:25:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FC9F5805D;
	Thu,  5 Mar 2026 17:25:42 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.185.249])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Mar 2026 17:25:42 +0000 (GMT)
Message-ID: <b33086b5f20a635a86d935fef3f4c429c723f6ac.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/3] integrity: Make arch_ima_get_secureboot
 integrity-wide
From: Mimi Zohar <zohar@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Ard Biesheuvel
 <ardb@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Coiby Xu
 <coxu@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>,
        Madhavan
 Srinivasan	 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin	 <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle	
 <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar	
 <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen	
 <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry
 Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>,
        Jarkko Sakkinen
 <jarkko@kernel.org>,
        open list	 <linux-kernel@vger.kernel.org>,
        "open
 list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
        "open list:S390 ARCHITECTURE"
 <linux-s390@vger.kernel.org>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE
 (EFI)"	 <linux-efi@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        "open
 list:KEYS/KEYRINGS_INTEGRITY"	 <keyrings@vger.kernel.org>
In-Reply-To: <c00-01.ttbfdx5@ub.hpns>
References: <20260213012851.2532722-2-coxu@redhat.com>
	 <c00-01.ttbfdx5@ub.hpns>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Mar 2026 12:25:42 -0500
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
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: n5u3KvkqHsHSG1MPOf93GcHhdfPo5Ydn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE0MCBTYWx0ZWRfX2GwyKh4RC1hO
 8e835PXQ73sAhRTjc5hcUXNuRa16LUmjeYrKhRTH8uumRPD6u6AHpv+R1U4wbUNUKtaVD4BCTwU
 Gs+8eec+4MXi+5GADfbifXChrow3C7bOocLltn0fEKw6L/ghXKT3D9c7AQEND5Uxazf8QO/as6O
 J5n+fKJXv/TUTDvqUiyiZIgw51FJfJVs8F857zTKeHXbBMmRDNcvSlDk8Xig0Ffwjxv6t2OSjLR
 H1mzlFXc6/oBzQqofGITH/P1rzOap9r9zEpCq7G6PvzEKhDJtotff/HlT1iz6uiuttTQhZblak4
 7lPagrK2S28ATugKW7HODfQ1dDd7pFes418ioZ7o7ZU73J8mwDENhGclmBn91xk0SlzKfvnVbi7
 5YqF7xT68eY0VP3tD7JPON8zHDmEngH2dZZrq5VbC3H+w0alPrWtihSo4X35W0+8XOvAzN7Lv2h
 Ah50ca8+F56uPHOCZ7w==
X-Authority-Analysis: v=2.4 cv=csCWUl4i c=1 sm=1 tr=0 ts=69a9bc9a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=i0EeH86SAAAA:8 a=20KFwNOVAAAA:8 a=FlYQV3jgbqAUZRz1eTYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1tcHdgBiVXli_g0ESprzx_tD6GHaaEJp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050140

On Thu, 2026-03-05 at 13:55 +0100, Vasily Gorbik wrote:
> On Fri, Feb 13, 2026 at 09:28:46AM +0800, Coiby Xu wrote:
> > EVM and other LSMs need the ability to query the secure boot status of
> > the system, without directly calling the IMA arch_ima_get_secureboot
> > function. Refactor the secure boot status check into a general function
> > named arch_get_secureboot.
> >=20
> > Reported-and-suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > Suggested-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Signed-off-by: Coiby Xu <coxu@redhat.com>
> > ---
> >  MAINTAINERS                                   |  1 +
> >  arch/powerpc/kernel/ima_arch.c                |  5 --
> >  arch/powerpc/kernel/secure_boot.c             |  6 ++
> >  arch/s390/kernel/ima_arch.c                   |  6 --
> >  arch/s390/kernel/ipl.c                        |  5 ++
> >  arch/x86/include/asm/efi.h                    |  4 +-
> >  arch/x86/platform/efi/efi.c                   |  2 +-
> >  include/linux/ima.h                           |  7 +--
> >  include/linux/secure_boot.h                   | 19 +++++++
> >  security/integrity/Makefile                   |  3 +-
> >  security/integrity/efi_secureboot.c           | 56 +++++++++++++++++++
> >  security/integrity/ima/ima_appraise.c         |  2 +-
> >  security/integrity/ima/ima_efi.c              | 47 +---------------
> >  security/integrity/ima/ima_main.c             |  3 +-
> >  security/integrity/integrity.h                |  1 +
> >  security/integrity/platform_certs/load_uefi.c |  2 +-
> >  security/integrity/secure_boot.c              | 16 ++++++
> >  17 files changed, 115 insertions(+), 70 deletions(-)
> >  create mode 100644 include/linux/secure_boot.h
> >  create mode 100644 security/integrity/efi_secureboot.c
> >  create mode 100644 security/integrity/secure_boot.c
>=20
> This triggers a warning on s390:
>=20
> arch/s390/kernel/ipl.c:2507:6: warning: no previous prototype for =E2=80=
=98arch_get_secureboot=E2=80=99 [-Wmissing-prototypes]
>  2507 | bool arch_get_secureboot(void)
>       |      ^~~~~~~~~~~~~~~~~~~
>=20
> @Mimi: could you please squash this fixup into the offending commit,
> or pick it up separately?

Thanks, Vasily.  It's now squashed.

Mimi

