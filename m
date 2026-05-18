Return-Path: <linuxppc-dev+bounces-21058-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B708CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:44:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmvG4gPSz3cl0;
	Mon, 18 May 2026 15:43:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083034;
	cv=none; b=Aury/tWlZSdHr1OTr2QkzFiLqQv9yeaXA/7MO1NhJVT+31nZ95VFRQa9s/KGr+jAEm0KhN1osgCVbVzb5/CexHu66azlXaUimIJmZAYdyTfyg6LXpx+KbdtPFk+NaVrPc4+YV+jPKmpG8CRkbRKAYokZTV3hMV1So/LYyNDJte5wG9AQYmdM9QfQz76Q/SOPHTE+OgkPVCSeEiGDqJDIzijvvkbCbGNdYI/Gv7L5DTLtyA5z4PCPHcl9xPjUPiCAqx0CFSZKC9YcFV1TbnPlejmjvwZGrYVugFHDzESunPgwuXcXEZFQ4ZzXMOU0sTr1GYn5pylQvLnkXhjL2rFbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083034; c=relaxed/relaxed;
	bh=p4OCwZiWc1eJcOn1h+qF4MeEl60tWThaYsdZgH0EDDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDdSLXyaAFFjznm/RyE+Q5FCwmSoLBmbdjayKfVquTQRkNzLp7SxCd2NNOgmcQ9edlpIU8rm7B15VYER/ZM/g+eGQsnG58X+ZvtMcLtZurge5TdDZcbdQFO59smVEzgFeGYRo4PA/+xC1uovaEbjiarb0Ean4vpQyD8Sr6jCAI5RfD7uaUOoUL2h4sDNjbYZ3pq8LoKVj/yJXK3p0vU/GHoyuhs97os89T/Xtt3IBt98Ltatv6Wz92oHod4X0JXpR44U2Ne7b2U/4GsJV3oezrxsVITRkr6BWPYeWx9ArJzFF/h81S6EmPTT8xnQMzwUZndzxCzU2MAQw3uWWEWySQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dqvy7pUT; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dqvy7pUT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmvF6pfZz3ckc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:43:53 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HMFxiB980011;
	Mon, 18 May 2026 05:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p4OCwZ
	iWc1eJcOn1h+qF4MeEl60tWThaYsdZgH0EDDQ=; b=dqvy7pUTAdFbkMYFk9tNJ+
	VmEg8pxfwJZyXmo/Ul+DWLDdh2P0la0/xJYdTD0brboT0ohjDOJFy/ktCNKNk2zR
	z1+EPyHt0BRr4LLAxCAJoFGeaoEk5IH+4UGfT2w/YOw4z5VgzI6coQz1/0ev/7PL
	2bZDwiFnjD41bYD6XPmOA0eUtpI9TAUM9gmuHWFt6SFgGLEkyqfdC5BPpNa7Siqx
	OSPuDuCpLO5QamfXeqfYWLILu6Pe9en5S3LMdEcPtdNdn9zOeOsB6YjuVGNaAtLT
	TTbmP3eMWbyrFWg1/eH48981F3zocE1/xsLg8RVeoA5VoL4pxiWPJrsFEmUzYzpw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mebq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5d8bK020303;
	Mon, 18 May 2026 05:43:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739vmfns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I5hUWf26804682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:43:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3859120043;
	Mon, 18 May 2026 05:43:30 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0EBB20040;
	Mon, 18 May 2026 05:43:27 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.43.25])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:43:27 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Bart Van Assche <bvanassche@acm.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
Date: Mon, 18 May 2026 11:13:26 +0530
Message-ID: <177908291161.287704.8881627212615459121.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260316174747.3871924-1-bvanassche@acm.org>
References: <20260316174747.3871924-1-bvanassche@acm.org>
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
X-Proofpoint-GUID: T0W5ScfCkl2ohrPrbPxXOaMWdAaLiihp
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0aa705 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=bcr2Kui_xr01opdjBMYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZpB5KOMAWdDW3dZUZhxJCi2i_sX037Oz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1MSBTYWx0ZWRfX4rPs8162S/eh
 Us7Kt+feuqQnz6gqkeG0gXZ6uv0AmJYMTq1ZW53OOdMgh3LgsbZIn+qkJZfaZC+U8O0DEJL4fxA
 j4pZs0l9nyppzra9oYPkEfWqGX99VOqDtdDha2xKhQ2g1DTKfkc1y4PRtuOygfq/AfRx6HjSklk
 QZkqv1yzio+ynNecLDCBUIITloFmd1tRKdFrxQcl8qReiIMgODM8OAzUHtdgHe+0uw89X0Jehhf
 ZWhMCZFXOf/CC8OPNNPnAvu8E+4IdAnn9VuPDqzlI4tjuuE2AnyXNGsYxrbuUslvVS7vVnDvG1/
 Y/KqmTE9IgntgybIIxGNBoabOPK/ahkT5hKjb1pl6H4Leyg+EOb0i+bIDLM3nbh8IKkdxOBuikN
 zy+kFEWjNdi7IuEmvl/8DvkcjGfkBXgK0K1CNlGA+QrqQG55GagHXMjnYm/8U3ix31V7Ysvl/IJ
 GIMSYPbOAAJUbtrXQKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180051

On Mon, 16 Mar 2026 10:47:42 -0700, Bart Van Assche wrote:
> Commit a28d3af2a26c ("[PATCH] 2/5 powerpc: Rework PowerMac i2c part 2")
> removed the last calls to the pmac_low_i2c_{lock,unlock}() functions.
> Hence, remove these two functions.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/powermac: Remove pmac_low_i2c_{lock,unlock}()
      https://git.kernel.org/powerpc/c/f98020c22ad9be07d6feefd0496e70f9f36a2f63

cheers

