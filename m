Return-Path: <linuxppc-dev+bounces-20609-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D502DCD3436
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 May 2026 07:47:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBh6723W9z2xdb;
	Fri, 08 May 2026 17:47:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778226431;
	cv=none; b=jdi4lL40C2uc1V9XWWY2kH/35tfXcEZi1lkdGcb7t0I+SSpsusD4fm8hpzyUvno1yZfQ5Xt1lb7P19tJ061eJtaK93NIcbIfUzCF4Tl6edurQ9ZJh1Osy6NsvtOFom+k+PWV0Y40T6lqLeXsxi5IMG05Mcs/gsqs1+Lp55sw5ipfV1inMRvDok3+vlgSI7Mmj6D0hJRP4LvjLqdmQ9w6Mu+29JIROEeoYsAho8rQ+YtIBjZrM/VUYMJyMEo3u7d/jqbcMFH5xH7qO2ZTDdHGlt1PNZsaPmBwPhs7/lfL7Cd2hsXsMIT8rxHaJppg2Gy6BRsJjcjAhQxzkMcvPeyadg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778226431; c=relaxed/relaxed;
	bh=0g3+N3AKrm/PzdCAx/bkpUA1zWbORVJCR0Rp88jRS5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kc2yob9J5AU7C2sWLGMHscjMlgYYVE7rdBztsU3is0+p+RFOzKwjJgor38Mz1rbO45JLJDKJF1h/72BYv4wSg1nAN4KjCM8N26VTr6iA2ySeVsZNTkoRC0qBg2QVhuft6QD5BVs6ncZPD21I3DyiCgBAZBEEjhfQ4HIjJu/8Ztoe896mCLVeBgESUsaYKE6dlxv3d7++pC8EV/NZqVgajqP0/K8hAkYBoiRonHircJVS4iv0fU1mAohyLKGDUc1Scq2P4mPy9I0Bc1oiYpJ1NqXyFJ1LPCMHR6bQr24dpY9dn/hHLz16hS9M1tg1PXovnXLq2scDceaYP0WxbrK2QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j/M3iwLn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=j/M3iwLn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBh663Dhqz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 17:47:10 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647H6AGs2476923;
	Fri, 8 May 2026 07:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0g3+N3
	AKrm/PzdCAx/bkpUA1zWbORVJCR0Rp88jRS5M=; b=j/M3iwLnlzXrJhZqk6Qk1U
	AUiPQ2uN6WjtORZ+SkKMq3CjQghP0Gr64LJm5vxIguSbNgU22sxvkmWlQCnd4IuV
	MypAwVvjKn3Til6jDydQh9SFQdI4s64/x/Lgc8xlKSicyepVU+6XGuzBM+4pZYjh
	kTsd570jmzEAHIWleyirW9tq7TiiWOiCLuRjtEvzbusVNsD5QCpZbXL6fN3Z8O2Z
	zbsEz/mh6bQcRqnvTpvQWGN6zHrvMJmE2s3J0ah8PW8ttykrEWwuYewMZjLCfunP
	VrYQk7jO8JLqD+3yBGwlQSznEHXhcHgAf+J7DaaTf3mgDcdb30NDFE8iWXQjkWIA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y51dc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:47:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6487ddYX010205;
	Fri, 8 May 2026 07:47:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwvkk78wp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:47:02 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6487kwLo9044312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 07:46:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36B8A2006C;
	Fri,  8 May 2026 07:46:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A94E2006A;
	Fri,  8 May 2026 07:46:56 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.123.14.187])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 07:46:56 +0000 (GMT)
Message-ID: <9dad7c263f8197000d4e56b09532d87a7f7f57e4.camel@linux.ibm.com>
Subject: Re: [PATCH v3 0/9] pseries/papr-hvpipe: Fix deadlock, races and
 misc cleanups
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Haren Myneni	
 <haren@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Venkat Rao
 Bagalkote <venkat88@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org
Date: Fri, 08 May 2026 13:16:55 +0530
In-Reply-To: <cover.1777606826.git.ritesh.list@gmail.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA3NSBTYWx0ZWRfXw2wwDiwMFIRk
 vBq/GoFmaLwOA5Cv0VDjS9rQHZ/8yGHGnNbq8tJpAVjX4HLy137qsmNKtu9hbxhDWqMBNuqvD5o
 jLLdnd5upXeuqmRzwxitw5vpWf5p5hkGWN834wK+7v2iIMCXhQb8qNCRqy7d4f4zwL+A1g2jtUx
 ti06PEN5Z5vawtQbYysT8/x9cmCobk4G95RIt4D8vnD9WEUEYN7e1Kf60Aa/o2R7Qmx8GOHXdfU
 2SHuY8cpcpJMY60CQlJV4NjHkBU5SRz1FeyQuK8ZcZiAde8FjmzPcO+EGJruzAwaAngrcM8KtPo
 YcMHoEY2uuv4A1eTlmrCXBbvlxiLWu9AT2+ycQjeEpdoDtw3rIggUdj0gNFwiiV1j9oZqJf2jIx
 POQzzWKkSXHbyA+Z+O7JZ+z/KdNDjzUe+DkcNgiQVYu/zrb8wU1kBcb8okEBpN4ZOK6sFKhfn4+
 FbVIrN83FXoJxnc9v4w==
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=69fd94f7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=9j7TknyyNkHXIu9f1doA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: HUH6lf7a8MXBBbAp3KXY4G5BEBUGweB8
X-Proofpoint-ORIG-GUID: pdrDXqtkGeCnGu9uwgzPcAVnboZBElJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080075

On Fri, 2026-05-01 at 09:41 +0530, Ritesh Harjani (IBM) wrote:
> While going over papr-hvpipe code, there were a few fixes which were iden=
tified.
> This patch series is an attempt to fix those along with some misc cleanup=
s.
> Me and Haren are trying to get these patches verified on a real HW. The t=
ests
> are not straight forward and we are waiting for the results.
> Will update on the test results once we hear back from the internal test =
team.
>=20
> v2->v3:
> =3D=3D=3D=3D=3D=3D
> 1. Rearranged the patches in such a way that it is easier to backport the=
 fixes
> =C2=A0=C2=A0 if required.
> 2. Clubbed patch-8 and patch-10 (of v2) since they both were changing the=
 same function.
> 3. Handled ret>=3D0 case in copy_to_user patch, when the user itself may =
request
> =C2=A0=C2=A0 for 0 effective bytes (after the HDR_LEN).


Since this is CCed to stable, it is currently being evaluated by RSCT.
We can merge it once we receive an Acked-by from RSCT.

Thanks,
Aboorva

>=20
> [v2]: https://lore.kernel.org/linuxppc-dev/cover.1775648406.git.ritesh.li=
st@gmail.com/
>=20
> v1->v2:
> =3D=3D=3D=3D=3D=3D=3D=3D
> 1. Fix a possible deadlock due to use of spin_lock instead of spin_lock_i=
rqsave.
> 2. Prevent kernel stack uninit memory leak to userspace
> 3. Fix the race condition in null-ptr-deref case where there may be an
> =C2=A0=C2=A0 msg pending to be consumed from the hvpipe.
> 4. Fixed error handling in init routine in patch-10
>=20
> [v1]: https://lore.kernel.org/linuxppc-dev/cover.1775569027.git.ritesh.li=
st@gmail.com/#t
>=20
> Ritesh Harjani (IBM) (9):
> =C2=A0 pseries/papr-hvpipe: Fix race with interrupt handler
> =C2=A0 pseries/papr-hvpipe: Prevent kernel stack memory leak to userspace
> =C2=A0 pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_create_=
handle()
> =C2=A0 pseries/papr-hvpipe: Fix & simplify error handling in papr_hvpipe_=
init()
> =C2=A0 pseries/papr-hvpipe: Fix the usage of copy_to_user()
> =C2=A0 pseries/papr-hvpipe: Simplify spin unlock usage in papr_hvpipe_han=
dle_release()
> =C2=A0 pseries/papr-hvpipe: Kill task_struct pointer from struct hvpipe_s=
ource_info
> =C2=A0 pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg()
> =C2=A0 pseries/papr-hvpipe: Fix style and checkpatch issues in enable_hvp=
ipe_IRQ()
>=20
> =C2=A0arch/powerpc/platforms/pseries/papr-hvpipe.c | 181 ++++++++++------=
---
> =C2=A0arch/powerpc/platforms/pseries/papr-hvpipe.h |=C2=A0=C2=A0 1 -
> =C2=A02 files changed, 97 insertions(+), 85 deletions(-)
>=20
> --
> 2.39.5

