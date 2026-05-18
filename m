Return-Path: <linuxppc-dev+bounces-21127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E1ACD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 15:46:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gK2GT1SbBz2xlt;
	Tue, 19 May 2026 01:46:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779119185;
	cv=none; b=N5SobrG6mOmCvhMxiNxX0+38BfcwzoOy+Uf6jxN2vC7d+s43rwMwp81UPvvEl98cXXBoNYYWZUBoOcFeXV+G++YEUPCG58jlg+rcelhk0CVWf/fF3ssF15Z7lV/7pr6Qkxb3P2LDRnLDgclOr+A7e/2k/k/XgYO1fttc8CtGKOpjLkvyAmkf4z6dmvHrZqgb1R6MgQhPeu4JaQLN50CZK5mgHZA9VUHNB2dmQF+8Xq2lfOhC8LvdGZoZE6WwHJW+T5ctrjtieWEBYVTzc/g6wZ9Kq0i1lW5PMCN0duWPpT7FnllCbN8yeeeJUg1QMtIBxM4wGx3hrJaKLUOQC3zRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779119185; c=relaxed/relaxed;
	bh=yMnLBzY0p0Cd+gtn+Agv9RdL/bu0d4IkitP7BLovXc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8PhJsdEzwOqO5LM5PnjxnwBOzuM+OcTjkMJMzCcE9nlh9+zwsueLai5S1C82QxTqnIN75Egr91h6DsFGrGQ1+9JWzgehMVJSWnAEgIXEGl2gZ9xAZvja0zrJ1wZdW4PDZ8XvYHO1r4CEG1pVwekV1ikERTRByFRWsXTUSNejDAVAuTgJm5KvUvg4V+qkiLAtCBeaulgRo0yMO2mrOPOD5xENzwKOCdZd1laDcG27C1vu04ec9HRfas56aKoxh+WTKgnwJO+Ug9QJE0QV+tkG0NUYjWZqdU7w02qKEbgQBpcboS+0TnmnmESvTbZWlpYx6ZbtPv+QdjHBr4OArZSxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DaZ69NTy; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbayer@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DaZ69NTy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbayer@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gK2GS0mzRz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 01:46:23 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I5TeTc3681418;
	Mon, 18 May 2026 15:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yMnLBz
	Y0p0Cd+gtn+Agv9RdL/bu0d4IkitP7BLovXc0=; b=DaZ69NTy6khgPB2oBKO7hR
	qPq1BlhIydDYngtnammgp3r0aiYWbExr0FbdV/xb+TqO/7WqXypPeXYGOX2Py7sr
	s6ee4AP4dfeo8FQKPiXw6YQ9w6op/QP2mfQ3yNsPaah26bKRJCdbv/0h20/3auf6
	NIvK6HIW7oxbP+1AK+jGsDirK6ZdtSEC8G29/iQq0TBb4JtPeBTwTvlXKXOeoq10
	WCFTMBSh2iWsbbjSH7yYr/ODAz4MyeydG+0SVeIeBazfBY6qmKQZTUPj8DwhflAW
	KppGsoV+1A0CTdXRPfMYUJQ8auXLDUBuMt98G8TmNZWej1KXsfl53WhMVapG1lMQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xrw5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:45:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IFdCpG023083;
	Mon, 18 May 2026 15:45:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxx9m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 15:45:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IFjonp30474780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 15:45:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B7CF2004D;
	Mon, 18 May 2026 15:45:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5194A2004B;
	Mon, 18 May 2026 15:45:50 +0000 (GMT)
Received: from [9.52.210.163] (unknown [9.52.210.163])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 15:45:50 +0000 (GMT)
Message-ID: <c12e2f60504c8988a172cd947fc5a07f5cf9148c.camel@linux.ibm.com>
Subject: Re: [PATCH 2/5] arm/pci: Use official API to iterate over PCI buses
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Yinghai Lu <yinghai@kernel.org>, linux-alpha@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        Richard Henderson
	 <richard.henderson@linaro.org>,
        Matt Turner <mattst88@gmail.com>, Magnus
 Lindholm <linmag7@gmail.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman	 <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin"
 <hpa@zytor.com>, Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 18 May 2026 17:45:50 +0200
In-Reply-To: <20260515-priv_root_buses-v1-2-f8e393c57390@linux.ibm.com>
References: <20260515-priv_root_buses-v1-0-f8e393c57390@linux.ibm.com>
	 <20260515-priv_root_buses-v1-2-f8e393c57390@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE1MyBTYWx0ZWRfX8r3cbmeKr0/7
 ZjyyZTE/MFfCBi9GbmXKpcNX+lwwkqC/9EqO4bFEKkV0WxHMu8YU0cBV1HoQiap3G8VrbbOhPqX
 cIVfyD5AhPx1YaItAYhYQCGqrHOagMWcAE3rumBa5VM1U0HRMmzgHAH8cxXQLRwUG9a7zv+SoSh
 c2bAAz/2ICYd/8D8AkBWM3CQq/JaA5wrKvpxgQtOs5xg1QKftyVzMr4wwI5LtajgClZtVrhMJcE
 TN1xSrsUsMzR8prwkGf/BQuS4GKBSgJKfIIz4XO23oksI0bbnyKrllJJq05fOGQeK9FvA9zifSt
 ILHC+u9s2O+MSeSQYqvF/D1QBzQMRoScTjrbjFUP295QGllnikQaHWgnadjneqDXfBgv2UOSqOF
 zBcOuQSW//l0VWrlAEwh+SLRmdEalckBAM9FewQOuKevizxfqy2W4DKwOdIVrPNhLkEftxXcmQk
 LX9aKHmREnD9ktNyOWQ==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a0b3433 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=FcXVdTTBcE9J8dFX6AQA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: xIpXrCK9Gg9N_OlSikDLILgWx7FxlsfY
X-Proofpoint-GUID: FH1kcY4D8qIED2hpPqBlCS4uqhpURrUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180153

On Fri, 2026-05-15 at 16:22 +0200, Gerd Bayer wrote:
> Replace iterating over pci_root_buses with the official
> pci_find_next_bus() call provided by PCI core. This allows to make
> pci_root_buses private to PCI core.
>=20
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  arch/arm/kernel/bios32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index ac0e890510da..35642c9ba054 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -59,9 +59,9 @@ static void pcibios_bus_report_status(struct pci_bus *b=
us, u_int status_mask, in
> =20
>  void pcibios_report_status(u_int status_mask, int warn)
>  {
> -	struct pci_bus *bus;
> +	struct pci_bus *bus =3D NULL;
> =20
> -	list_for_each_entry(bus, &pci_root_buses, node)
> +	while ((bus =3D pci_find_next_bus(bus)) !=3D NULL)
>  		pcibios_bus_report_status(bus, status_mask, warn);
>  }
> =20

Hi Russell,

Sashiko
https://sashiko.dev/#/message/20260515145940.E85AAC2BCB0%40smtp.kernel.org
reported:

> Since pci_find_next_bus() unconditionally acquires the pci_bus_sem read-w=
rite
> semaphore using down_read(), this introduces a blocking operation into th=
at
> atomic path:
>=20
> dc21285_abort_irq() [hardirq context]
>   pcibios_report_status()
>     pci_find_next_bus()
>       down_read(&pci_bus_sem) [sleeps]
>=20
> Does this path need an alternative approach to safely iterate over the bu=
ses
> without taking a sleeping lock?

IMHO, it looks like this entire pcibios_report_status() iterating over
all PCI buses and all their devices would be better off if moved
outside of the hardirq context?

Or could pcibios_report_status() be converted to use
for_each_pci_device()?

Any suggestions welcome...
Gerd

