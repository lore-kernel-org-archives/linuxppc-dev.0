Return-Path: <linuxppc-dev+bounces-21947-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C9CCD6E55
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 06:17:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVct95wgsz3bpM;
	Wed, 03 Jun 2026 16:17:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780467425;
	cv=none; b=GLMZCieEomXH1hejdtaq2Xv/3pUEHwVxDFZm/9IPtGC/D6f6HHmrBaUGtkQYH0iPe60bRNg7THhgsrC84vlOF+EPizxo5OhWVC9N5ZvhyOek/G3hJmwomz8STLcNlcAxBR6QaJWPjfdPdRS+KerF0XHCZ53zN/UyvFKKLSBNcJ+EAUKpwK97dvz3wY1NonB6jghGPyPo4IQNtIVZCPrD0FrIpe5ZfV9SXagt0c2gIh5tUlKahEfwqPTpo5djV0HQEGfdR5XqDlLxXMdSQYcmvDc7MRjm3s2JwYjPcEqXf3DyvVl6kl/dYMxcGq5Mi9qFdExlv/d4wJzLwui3xD/bpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780467425; c=relaxed/relaxed;
	bh=sjD8vMoitFU1Sh31xveubUPLg+R9PP3P/awfzsy3Sho=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cy3k49TbKVtoYMM345piDy+9bFD2tCRy9Np2hnKeT5fNdmcwhXluUlwDXAEuVxLXedHLVPwAC5vdkAomaIi2RZkYvZRl0zeS/DU7aNcJgU/UnmLe/SaWkERJsFSDrC5cOIM3C3HRXlh27zkdkM+PnMFfEH4M0HL3LOmDBW2vvuJz7KitO8ppFonMAMyS1QpSpBbdPlsyfS0jWo9cR1DuKILzyLU6kkAD1KFi0BE1fpGezi5VunDG93UVyG5vGe3NbOu+dHj2AWM4ODKGfWTuMam/PSK3xXT86Mg+84yLgWZe4Zfy3VQ6ljC6I5gz2yMTDKAtaikQ9z6TLCWDafsABQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=molII2hO; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=molII2hO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVct91L0Nz2xc2
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 16:17:05 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652HMsKg633201;
	Wed, 3 Jun 2026 06:17:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sjD8vM
	oitFU1Sh31xveubUPLg+R9PP3P/awfzsy3Sho=; b=molII2hOtYsv3+asXAWHoI
	jXr6c7q/2/ZzN6Hy9xD8f9Z9TtVLFGM2pbKOLCjVP8xFvXx0zCYVfvTFFINXVKKi
	X+q56t66CGG4TSlBdv0j1Zti/dZ4+n90UzQeEGtcyvTE/9HXbNfmAolMO7AKCobK
	SOm0ZeDQtzdHKzGXsFSoPs6n11SA1UDQtVb1ddceAV0JcDwzhU/caZW9SbIhQjhh
	2QyfsXWzgQ7xK2/xMLzwzCFBZlAbmexv/jJBO8Zy+uNbGQ6hJlQwztRXVr4UZieu
	0QEiWiPvSYO8F5QHk9RxLjtfuftfxJpdG1+YU+n8keb1MF9cDEaaMI1UF3+HsyKQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq9e8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:17:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6535sJ6W022773;
	Wed, 3 Jun 2026 06:17:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvxy30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 06:17:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6536GvxL31457928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 06:16:57 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF9AF2004D;
	Wed,  3 Jun 2026 06:16:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4239220040;
	Wed,  3 Jun 2026 06:16:54 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.39.24.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 06:16:53 +0000 (GMT)
Message-ID: <7d7c24d7900a30f53820feae952e2c2bd92d0a42.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] powerpc: fix preempt_count imbalances in perf and
 kexec paths
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Madhavan Srinivasan
	 <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe Leroy
	 <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain
	 <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Date: Wed, 03 Jun 2026 11:46:52 +0530
In-Reply-To: <0c6d2855-61df-4fd2-bede-0c204f4fd2b1@linux.ibm.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
	 <0c6d2855-61df-4fd2-bede-0c204f4fd2b1@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: s13eGU7E7RevYS-DINJTz19-UrQ8R0ih
X-Proofpoint-GUID: T9YiJhovfMG7_oLb5jfUlzOXhombNN_c
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1fc6de cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=SyrEavi5T-EveYA-VyoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1NiBTYWx0ZWRfX7ytuOsw+Sav8
 X3q+LyHB3JRW9J9e1nbOKYhsQ1Tr9O54SXqhd0x4/7nE9c0baYkeLJFPbcY48IYB/3eIfnBr9Kq
 ei4z2p1fo9qL9Yi3ilCnlCbJnklEyfvApjRClGP0LQyO5riWek7VBBdixTaQc43h63UyuP/vl+E
 GfFo7Ndl0hx7feXGWd6CDxzyIUcc9wdeu73AT0wZRB9y447sLYxxZYdXA9uLqfu3wKA5pPO3JYY
 BEFqt55BNkdxftf7ufn+zO7UFwHLe78wEQzB6mWlCVyi4uZo8KR2eOsQtOIqcp3s+q/uYS2JwDN
 T2h2NqyHsV+DOicAlxsFbQ3q3Yj57IeooWFoCMm3zMupeSIZU8LF7qGSo+HvzwhMw9qbXwalzvn
 b62GZIewPrZMDoWCVQZxsSZaaGcd0JTkAAcO730rk/CcR67DvCloPkWi1d5sI/5H1RU19YSvRS7
 kNGjcIXrNEmtMo6Ua4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030056

On Mon, 2026-05-18 at 13:38 +0530, Shrikanth Hegde wrote:
> Hi Aboorva,
>=20
> On 5/18/26 10:38 AM, Aboorva Devarajan wrote:
> > Hi all,
> >=20
> > This patch series fixes some minor preempt_count bookkeeping issues in
> > arch/powerpc/ found during a preemption leak audit prompted by the
> > lazy/full preemption model changes. These are get_cpu/put_cpu and
> > get_cpu_var/put_cpu_var pairing errors that leave preempt_count
> > incorrectly elevated or underflowed.
> >=20
>=20
> Thanks for fixing some of these.
>=20
> while we do this, Can you fix these mismatch in preempt disable/enable in
> below files as well.
>=20
> 1. kernel/kprobes.c - kprobe_handler - Does disable, but doesn't enable i=
n some return paths.
> =C2=A0=C2=A0=C2=A0 A definite leak.
>=20
> 2. Maybe platforms/pseries/lpar.c and platforms/powernv/opal-tracepoints.=
c.
> =C2=A0=C2=A0=C2=A0 In __trace_hcall_entry/exit.=C2=A0 It maybe a very cor=
ner case,
> =C2=A0=C2=A0=C2=A0 I don't see a big concern there. But it may be remotel=
y possible.
> =C2=A0=C2=A0=C2=A0 Need to evaluate whether it should be fixed or not.


Thanks for the pointers. I'll go through these and get back.

Regards,
Aboorva

