Return-Path: <linuxppc-dev+bounces-18176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23262105F7B5
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Mar 2026 15:40:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXTGc0Qmkz3blq;
	Sat, 14 Mar 2026 02:40:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773416456;
	cv=none; b=JJRgA3TLl9QlipfFR1O66EG33zc+kT+2cN4hNNcRX2kuGlrvfiIlPRvprcP68i9gL4MJDaf1IV5AcPggC6XljRt9J1MTTdDBr3D+f/2lsUmwM1EPX1hHcIAW6ESb158gEgRNWB/nbkpciUYaXIEMba8rYZROMuEspJai2tz1kNVeFy58Hf0dcCLa4AwF3W9DWQ91DiLvfGKyctvw2EZMScLB0cAC3mLMV5X5ZVbEQFF4xd4aGaxtW/rYxr8Mmh0mt38OhImdljq+r1aDLcDlgAeUA8wWtI8SRkRpbbkFcqfp1aZEy3PfigOulB8PeVgnhf6HqCSRY4Yrjp4QDFbDZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773416456; c=relaxed/relaxed;
	bh=4blGWLTNwciZlJ1JGFf57y21cB/j+hd6OhQxrPFKUBM=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=HsFHyYq/yA+t30NzC2pRdQnMvCrJS3eqy7Zni1PDOLF9CdQwQWaDjn+KPaKaFKbw1km5aG8BDyKgObiBzvy2y8Qbg5Kg2pt8+MYOwFsYjVvdi7I/+8u5g/m61Xc/N3oP3nN9FtpyFUoY3bazdnIKvfFKT4Ld5OD9AVtRhstzYxZ8dpGTVSU/jxAPZYciOoMQeFf2kG+3r+rXGydwgJ2jxZ2/WqsJkMKon5+W/F6uxCv6705BW4bg3YeGca0T0Utf9ll9z111M30HQBtr1uX/5RouMSBk1Sil6Y6QYsY9Tc55oWIvOAOxpMYEJmX6MfAStnKailgrwPN4+zeyWHiV9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qnbCYwOC; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qnbCYwOC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=zohar@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXTGZ543pz30Sv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Mar 2026 02:40:53 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5B2Bg2259422;
	Fri, 13 Mar 2026 15:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4blGWL
	TNwciZlJ1JGFf57y21cB/j+hd6OhQxrPFKUBM=; b=qnbCYwOCwfMxxAbYOdsIol
	3FM9CO78egN45nCqMcJmAirimvvKyfQyvzNxFTT+G9mqjEblQLQHSxCCZfwfiX8V
	3t7KbVlQH5kF1CIolbNS/ORb2NhsqcNIAH8TSza+Jc2neJZKialtMUD+hbB2ldOS
	P799UzbEXhC1Y6R1eaisrqqlz/Af93wLYvPzjn1uELA0IuPhijF+lY+HO8I+SfOS
	jmYxj3CzJ1zrSpWdz5LCDuxucMQ4Xn9SoPRGdGPH3lOEtG5ulO2AEIX8dYtC7QXC
	FmifkMWW3ZqA22uNAmtTepbbqcJmNN+s4eaAW59tqeYa8hr7LN040JOVEeUyHq0g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cuh92gg48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 15:35:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62DFSJH6006130;
	Fri, 13 Mar 2026 15:35:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cuha9q6m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 15:35:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62DFZE5V34734722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Mar 2026 15:35:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CD4058058;
	Fri, 13 Mar 2026 15:35:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E58E058057;
	Fri, 13 Mar 2026 15:35:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.190.35])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Mar 2026 15:35:12 +0000 (GMT)
Message-ID: <0dec7e06d61eb8775d70e4d8bf1be98fff7a2af3.camel@linux.ibm.com>
Subject: Re: [PATCH] integrity: Eliminate weak definition of
 arch_get_secureboot()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Alexander Egorenkov	
 <egorenar@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy	 <chleroy@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik	 <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger
 <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Paul
 Moore	 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn"	 <serge@hallyn.com>, Coiby Xu <coxu@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260312205533.GC2747807@ax162>
References: 
	<20260309-integrity-drop-weak-arch-get-secureboot-v1-1-6460d5c4bb89@kernel.org>
	 <d2089740-16d8-4ca4-a61c-8c381f8e30a0@app.fastmail.com>
	 <a985c90d9df8ba0fc63f65117cc8e884f70e6035.camel@linux.ibm.com>
	 <20260312205533.GC2747807@ax162>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Mar 2026 11:35:12 -0400
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
X-Proofpoint-ORIG-GUID: 59AJO5q2NmJeb8Rolla9nJmSuuxhw6YQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDEyNCBTYWx0ZWRfX9aSEbAynOTD2
 UeJLB+Dd5ETgybJ8X78OLdjbas70sNl4JkiLY2bQgWpqeaA9Bq9rz7HejSSEaj4T0A5FsF28woD
 r0l51GZUhKSYl7jlb/t7A4klpYtKU/gkZNh0HLwC0eZr7N8tvSI2xFbdL3dM5Ft4hBrdmeRl12D
 yN1mi8hd1UFyQ4NJcE5ulUzUuNhrdkchk2nkNzUIKkNFmznEW/dBToaqXOJRXTUbZGEZDWuJTJX
 lIVXqQUI8ikcOEJDFppzCs7DpCJM9/tRjWO43FDUDzFeIg/AWHsViTtEQM9uJvr6LWzuKDUXTp4
 dpeimsnm7vZfjmHKdJBnKYohGLm9SRyAa8bHnNuuQJNcuDP/FFc1ws3/3w9XAy2KFIrQoAT9TXt
 y2AdsOvmkT13f1Htb4+PxPM2BmwyVMOw0jnflDfTJTJNxhiZxg7kK7vmn6f/XEcj7/CdH1zUo5z
 6f68HNPiTwzy7KqoXcA==
X-Proofpoint-GUID: Kc_uVUzOyW2576MqDxMLZmh21g7_PRH-
X-Authority-Analysis: v=2.4 cv=XNk9iAhE c=1 sm=1 tr=0 ts=69b42eb6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Jgx6WarZ80nwb2z7rPIA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130124

On Thu, 2026-03-12 at 13:55 -0700, Nathan Chancellor wrote:
> On Thu, Mar 12, 2026 at 12:07:41PM -0400, Mimi Zohar wrote:
> > I pushed out the patch to next-integrity, but am a bit concerned about=
=C2=A0the
> > definition:
> >=20
> > +config HAVE_ARCH_GET_SECUREBOOT
> > +       def_bool EFI
> > +
>=20
> What is concerning about the definition with regards to s390?
>=20
> > Has anyone actually tested this patch on s390, not just compiled it?  I=
f so, I'd
> > appreciate a tested-by tag.
>=20
> It would be good to test (if it is possible to test in QEMU, I am happy
> to attempt to do so). As far as I can tell, 31a6a07eefeb placed
> arch_get_secureboot() in such a way that the __weak definition would be
> used when CONFIG_KEXEC_FILE was disabled, even though ipl_secure_flag
> should always be available, which this patch avoids.

Thanks, Nathan.  Fortunately I got access to an s390 and was able to test. =
 It
seems to be working.

Mimi

