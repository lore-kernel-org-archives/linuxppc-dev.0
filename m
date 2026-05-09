Return-Path: <linuxppc-dev+bounces-20631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A627CD3447
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2026 04:10:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gCCFH4TR9z2yZN;
	Sat, 09 May 2026 14:10:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778299811;
	cv=none; b=FchG5cTIVJuwk01uTXhI2P1zTQwQEXBqVuy4R/SuPx7Q8fzNJUlnqxYRelhQnhR2qxGd8a9ecSV4Ul/dXIQlfPIm9N82uGojMKbVeplkT8Pf/0MNn5oZ89rq7grHtQdFavqd2jiZgYmSgYJP+EF2qgp3klGsdQ2B3GWw7kEuaIwavWjxwH78zqmQT751Q2fvFzXDFU++kjbCVGEDelvRXwaXQaivR9Ya6wXcVAlKt6cHCHo33H/DGziHvJE7zyS6tEcCqNEzA/agIi44Zj72+9NW9Cw8YVooHaYIl6SMNdryhW9Hi/6/U7INsKhnsBEKTKeXuC3zVasaWbFvPkE2uw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778299811; c=relaxed/relaxed;
	bh=CEdJmRqUNQ+pBWtkga2n/W4D4a339rGyk64n/P/FoPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X25mki8v29iWFGyMGHMIBfoaJhXMvrxgpHVmE/eeex57l9nJUpoa9KOK2rBaG3Bp8xFQvVgcbFuG3tFw0nulCxntPP6uaGidCRHoRQ36OdxKRGOHZqOYGDyJr38A1yQbcef5Y7RVPVZvJk6ykS3InwtmH6Ex3idysHnl/KcImDI6pU5b7ucsc41FuR8He62axLnjzMAQl6uYYjJrcrqZcqsESByoJTcpqbaOsQqwzGr6gNb+oAyAQ/Z0DdfXwgHohEcnZfGeh2Z9Q3ecOfUzz7G5CxSM62nWLt4+2Gb+bXnssEA3cHeF55+h31mrPxBckpeUI0+nUwb3WQie2Riq3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M3XKqE4/; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M3XKqE4/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gCCFG4sWkz2xnK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2026 14:10:09 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6492kVwG2827936;
	Sat, 9 May 2026 04:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CEdJmR
	qUNQ+pBWtkga2n/W4D4a339rGyk64n/P/FoPg=; b=M3XKqE4/D+YFmTmeSOou2R
	EM1hF+uEFX9icwFJifS5HrcAPdMFgLCyCpkzHzSlM8vKFhlrhfHU/DKq7/ZZWap4
	TABDAbnscyrv40C1nRU7zo2l8UNEMk3oEKprEdC8SDEiWRsk3+YggY3UdQ8RuPc+
	dE/E1AT3gv76vjQMBRzJpdad9XCK7WbJy52p/6DIo/jwt+3x0R3/Be5O8TKk523q
	vKa/OQEGBye64rMmkwieMiSKsejwyQ7Wwa+idz1z5GabTY7fSGqYk1iB9sf7XGS9
	6LkbBRvVJmwQqJWIbgcAlotoMc4xGXq6J7QUZvf9RSw6iQp5Gv/BKJoI5IttJKSw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve6r5af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 04:09:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6493sSQ1016361;
	Sat, 9 May 2026 04:09:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e1007601q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 09 May 2026 04:09:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64949q3q43319582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 9 May 2026 04:09:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD04B20043;
	Sat,  9 May 2026 04:09:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18CCE20040;
	Sat,  9 May 2026 04:09:50 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.39.22.248])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  9 May 2026 04:09:49 +0000 (GMT)
Message-ID: <e86af01b989a7bda2ff5f68db1f05398e868b698.camel@linux.ibm.com>
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
Date: Sat, 09 May 2026 09:39:48 +0530
In-Reply-To: <9dad7c263f8197000d4e56b09532d87a7f7f57e4.camel@linux.ibm.com>
References: <cover.1777606826.git.ritesh.list@gmail.com>
	 <9dad7c263f8197000d4e56b09532d87a7f7f57e4.camel@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAzOCBTYWx0ZWRfXznt0TgL171Bp
 ROrhkVrfk/TwjR9jc3ZLVW+TWddE+oTnAyhLmZU2lKWp3p+vgBBY/UtIoSNSRuUiksrBeggKerg
 841/KazIh9W0fgNdrgQwfdjq+EKJjSzGjA7bWUeGBlMzeSc4FY1ieew8LaY21z1eZiLy4O9icd6
 2fgOrJ93Oc2AeA6Q7Tn15+9WHYfWrCSh/sp8w5GsHgfZhwiWeBhGPdqxkFdwo6+EHHyofU6Jqwm
 BaXmH7gA0M+umt/ThkM4z9YoG2+S3A0s/VPtJ94v65o8UVddTiW85htS+SYSri7qus0z97+1l4e
 1htwlcabgpr+zjE3kOehgACsIw1ckJH2vaigU4dZ93eeLSSBlABpIGMcOpQzoUivH9yaukYpSvv
 1KArMSQyDGU741lJvI2tCcK18iJJseAuliuVfNN0gIlz8h0s5YWhclCkBZk0EvfZzq+5ltmwsuf
 FytUi8DjBKba8SlQifA==
X-Proofpoint-GUID: 9ExPAciZIISQEFZSq0fIX8XQtpf8wsH0
X-Proofpoint-ORIG-GUID: -8VmWo8HPQ4FARsvp-jRyDYmU0dtf9Oc
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=69feb395 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=sP59YwRNpf-BF--PUKgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605090038

On Fri, 2026-05-08 at 13:16 +0530, Aboorva Devarajan wrote:
> On Fri, 2026-05-01 at 09:41 +0530, Ritesh Harjani (IBM) wrote:
> > While going over papr-hvpipe code, there were a few fixes which were id=
entified.
> > This patch series is an attempt to fix those along with some misc clean=
ups.
> > Me and Haren are trying to get these patches verified on a real HW. The=
 tests
> > are not straight forward and we are waiting for the results.
> > Will update on the test results once we hear back from the internal tes=
t team.
> >=20
> > v2->v3:
> > =3D=3D=3D=3D=3D=3D
> > 1. Rearranged the patches in such a way that it is easier to backport t=
he fixes
> > =C2=A0=C2=A0 if required.
> > 2. Clubbed patch-8 and patch-10 (of v2) since they both were changing t=
he same function.
> > 3. Handled ret>=3D0 case in copy_to_user patch, when the user itself ma=
y request
> > =C2=A0=C2=A0 for 0 effective bytes (after the HDR_LEN).
>=20
>=20
> Since this is CCed to stable, it is currently being evaluated by RSCT.
> We can merge it once we receive an Acked-by from RSCT.
>=20
>=20

An update from RSCT: with the patch, the earlier issues observed are
now resolved, and the inband RMC connection is successfully established
with the patched kernel.

Thanks,
Aboorva

>=20
> >=20
> > [v2]: https://lore.kernel.org/linuxppc-dev/cover.1775648406.git.ritesh.=
list@gmail.com/
> >=20
> > v1->v2:
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Fix a possible deadlock due to use of spin_lock instead of spin_lock=
_irqsave.
> > 2. Prevent kernel stack uninit memory leak to userspace
> > 3. Fix the race condition in null-ptr-deref case where there may be an
> > =C2=A0=C2=A0 msg pending to be consumed from the hvpipe.
> > 4. Fixed error handling in init routine in patch-10
> >=20
> > [v1]: https://lore.kernel.org/linuxppc-dev/cover.1775569027.git.ritesh.=
list@gmail.com/#t
> >=20
> > Ritesh Harjani (IBM) (9):
> > =C2=A0 pseries/papr-hvpipe: Fix race with interrupt handler
> > =C2=A0 pseries/papr-hvpipe: Prevent kernel stack memory leak to userspa=
ce
> > =C2=A0 pseries/papr-hvpipe: Fix null ptr deref in papr_hvpipe_dev_creat=
e_handle()
> > =C2=A0 pseries/papr-hvpipe: Fix & simplify error handling in papr_hvpip=
e_init()
> > =C2=A0 pseries/papr-hvpipe: Fix the usage of copy_to_user()
> > =C2=A0 pseries/papr-hvpipe: Simplify spin unlock usage in papr_hvpipe_h=
andle_release()
> > =C2=A0 pseries/papr-hvpipe: Kill task_struct pointer from struct hvpipe=
_source_info
> > =C2=A0 pseries/papr-hvpipe: Refactor and simplify hvpipe_rtas_recv_msg(=
)
> > =C2=A0 pseries/papr-hvpipe: Fix style and checkpatch issues in enable_h=
vpipe_IRQ()
> >=20
> > =C2=A0arch/powerpc/platforms/pseries/papr-hvpipe.c | 181 ++++++++++----=
-----
> > =C2=A0arch/powerpc/platforms/pseries/papr-hvpipe.h |=C2=A0=C2=A0 1 -
> > =C2=A02 files changed, 97 insertions(+), 85 deletions(-)
> >=20
> > --
> > 2.39.5

