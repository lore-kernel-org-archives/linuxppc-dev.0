Return-Path: <linuxppc-dev+bounces-22829-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C29FCD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 21:59:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs2T3Y5lz3brB;
	Sat, 20 Jun 2026 07:59:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906385;
	cv=none; b=lbQCEzNgbgtGAJMgpbSE3O1FlI6Of15Wo5Y3ELJB3cAPRkhg7Lo7pMGxpI0DOg7bfPbCkKVUXw7HZXvVlP9rLP+/usng6QYgIrAcBOuNn1xS51Qdj7AQE8O4HSgwbOxmYCLpbjNXa4gME2B882eolcPXktKAUQsUEk4yumr6oHV8Ouc3fbhTfK9bpSg1cboKJRYSz7hMcBUJG3LiMw67bZU3TCFM2dxWpCD88L4PSGLe9HWTWSqr6OT2W6Gfisr23i+Ts1zGL2O8MdX2qnz18E8pnzfMyQaQEZZ+uwKCTp7fXtWuUnH/aWvXgab082a6HHlCzyxwuwfUaGnNO1L32A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906385; c=relaxed/relaxed;
	bh=YSSd86g0JeDf6OIcdwDCvZKiMzoVmgXKISMxtkIXdv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSLCmZ3nb/fj1pRMof879Lb4R4hjiUzznc4SzJbXbtE1bZ5xaJAJ6IqAjBI4OeGEbTy+67X7bU9LMYcfMtUovZYv2WbyApW2sgXMkaxP8mO1DKDOmN1BNVjUq5rbY0tGTBCWgRVmlSTP73Ej2J7ltCFOKAxm9Qdyl2D/w8Zpxd//n6qtOARuIV7oA5yDJf6ZUA/rdPSmXPLcl2PwWvqAy6lfyag7ZVA3q0lOYa4sF5pw4ulnCWwe1Cfajxf8n4wUZlaD2an4lw2LqdE5+4exLEqaWTfaIuAxjLTrE7A8rwlvFhBGR/tTRHqTg2OLL7tNgW4hum+LfXnnIBrosXh+RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MvQ+rn/0; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MvQ+rn/0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs2S4dbfz3bqV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 07:59:44 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmCUc3609682;
	Fri, 19 Jun 2026 21:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YSSd86
	g0JeDf6OIcdwDCvZKiMzoVmgXKISMxtkIXdv0=; b=MvQ+rn/0uNfsn++v5zMI5O
	732XT4+sHJG0fiIEB/pVV1pmNqTSqF8kv0cXK1/0bDbrdyQuesNQvLl0FL+mGBds
	dvccABtKn+JSzr48wiWNco+dyYynM/3FbSGY00N7v13+zSXRReRYc1KL2Wx4WRlL
	H59FkvM8lM9M7KY/q9IXE3waGWtMNOTFfri+cly3VbHe5KpkLeLErwC2kiE4eJ8p
	CjRyv9JYdEUmVvlzXgd1Un/xRCDRgSzL0vffcFtPQwrMVw66KQH18cJt8uVMLUsw
	ZvukYdU2+ICMmMKaHpZqqrH3x1BWe9xr1xyXPksGP00WEgTdxOlPAu4FWRY6zxdA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequfrd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLngnC007540;
	Fri, 19 Jun 2026 21:59:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JLxVhX24969472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 21:59:31 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B863920043;
	Fri, 19 Jun 2026 21:59:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E00B120040;
	Fri, 19 Jun 2026 21:59:29 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 21:59:29 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, sourabhjain@linux.ibm.com,
        Adriano Vero <adri.vero.dev@gmail.com>
Cc: npiggin@gmail.com, chleroy@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/fadump: Add timeout to RTAS busy-wait loops
Date: Sat, 20 Jun 2026 03:29:11 +0530
Message-ID: <178190618788.653308.3156372491592916149.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506222024.30352-1-adri.vero.dev@gmail.com>
References: <20260419065039.23495-1-adri.vero.dev@gmail.com> <20260506222024.30352-1-adri.vero.dev@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX6KkOETrSthlQ
 jc6mBWw5Ts9A+xFF2erzTWD1NAP4jpuDMjFviaUbpRoc6+6Fr1VoMZC4bV8OrI4lRyr3dxuQoFy
 p4sfj2Ze/dkgIjvxlZkJEo+fdB2i0EI=
X-Proofpoint-ORIG-GUID: v79xoo0pw6M8hr9lwBBNAAW61sDjIbPc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfXyBJoCMKh8Ady
 GP5nVT0FSggD+DKdY1kYMk+5/IO6IJH5e429OciTR1vAaZhc2tflzXTFvEbxj4LjB7o+9pEmQcK
 7G1fJ3fOqUnALS5zkQvnvhXCxI0OYy8BoQCPAdVZh7ATEwzUhQyMsd8Lp0GTyaiTIYyn+Ud56/z
 DEFLvj/ErXbwtNLfFfRchFEAXG+sTutKPUqN5j6YMobPYyEGtnbkjRUJV3BGhMs+Njz2vJUWU2y
 wUfTm8z9pzVQxW5ZDxfoLgC4lU6EBROqw0X1bYXUag0+I+G0nWW1Utg6h4kDm6UyX3VYqWssRcF
 fC0ryG2QjS3ER4VE56gBJ32clBQc4z7y3o7fy9gAPdvwQXeVeAZsqWhH9IFLawx+x70Ph6hN5O4
 BL1Q7Y+IP5RuyahJZaypBCRklerIfimtGv2b7nwkXEGkoKF7Kx/EXORPWh/SXjN95sh+vYKwfXd
 ZNGNdbbEERe9mUrk37Q==
X-Proofpoint-GUID: N7bFnW8kuiknQINSqJgYA7MX7J3d9SQa
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a35bbc7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=Sxv089hMkP26gHWbFUoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Thu, 07 May 2026 00:20:23 +0200, Adriano Vero wrote:
> The ibm,configure-kernel-dump RTAS call sites in
> rtas_fadump_register(), rtas_fadump_unregister(), and
> rtas_fadump_invalidate() polled indefinitely while firmware returned
> a busy status. A misbehaving or hung firmware could stall these paths
> forever, blocking fadump registration at boot or preventing clean
> teardown.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/fadump: Add timeout to RTAS busy-wait loops
      https://git.kernel.org/powerpc/c/b3580dd1c68cec23d44a39c439e18b4686c13480

cheers

