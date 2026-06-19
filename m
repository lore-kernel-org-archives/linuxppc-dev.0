Return-Path: <linuxppc-dev+bounces-22835-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF682CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:00:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs330BYSz2xlw;
	Sat, 20 Jun 2026 08:00:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906414;
	cv=none; b=eKrXtFS/rsCdSwVu6fmHLeGfN4b05onaRp2UA/VwvmvfN2xOXR6DFpPu/fu0+SCA92QxG7El2Lcr5OZHv+fd5mWXntQTR7uvawSWa5kG5KluaGm44Qvt8mRfu2V6R8D1az5hr2o8YHGkfHyJjQXV0eeoKpe8AGTHRWZsMGxqpJ+R5xv7Wn66IXXJXdEQm+pJZ7vhaApyJDcjD0pQG0ZICnC7yzAUdMGXB5nht/M1vllfl10j2e75UQAfgBAiOF8m07WSpLU6ZINDc8dD7uERyQDLGQMkGaEW18Obelrdu5bNxlqpavVP6hAL8nbv+30sWL/KJ1n6xwQVpXN5VSXesg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906414; c=relaxed/relaxed;
	bh=to/Y0Dq2/7tew6giCJZRjh7lVt1bwqIyT881ylzkaz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MduLk4o/ZtrMwXdNgJYl4RVKGIB3Y8uVTDWxV1oWPnDtqn12lGoyxt9KNg+xsIOIQnD/dfW6GrtyIGjAIWyyJZdFGwqSGsHyaNOjzQOOtFZ9mvW7fOs70z15ZHBEHR2N91M7QGbdGcO/i+U0uTqXD7fgH7uCh3ma0upRHicy2uVd17r7MS2T2dQXAkixA4yH1zjOIqikCnU8sdFcY96ILVcCIsjMVIbLfVnxpNDKlfy6bJbdw6b9KkmNJNhctRdSlyW7fxjV6f557vk2m9L+LeMkVovu4o2iCaVvLuGd00HnjhaU/z0vIBL2OMVdBCjRPtW0M2gd8sJeIlWNvC0l8w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KWJy2gkO; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KWJy2gkO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs316qQ4z3bqh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:13 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmxCb3358943;
	Fri, 19 Jun 2026 22:00:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=to/Y0D
	q2/7tew6giCJZRjh7lVt1bwqIyT881ylzkaz4=; b=KWJy2gkOjpNfKL4ZNsP99d
	zA/xc++4W7znU90xEiHu48N3sHKMRhVsfkWiuGHhAFQ9aLMjzgzkSnedRvaIlF+q
	CPr1koifel4Ru/YO+aBs44x/j67N1BgWkJoQJcYpBWvWZtsxh9vtj1x7ZOU9SYDd
	dkAXzDwWK5NTI+0oISGNfsddiXCzk1sWpwryvX97HryWsbLt8g5Nn2TfkcwxoN/Z
	8vTs2e5JVgOgKPyfAChTS7mUvhJK3JY6t4vx5uR1D7WN04QYtM79gx1E9viNuQ5n
	9II5/aFcfKB+iKQxNypcocJ4B+zpc4zr8PIlmJ32zvkvQuLObIscMEUDeVm2eAzA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxfg4s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLngv8016865;
	Fri, 19 Jun 2026 22:00:09 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172js0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM05w242205534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:05 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 816E02004B;
	Fri, 19 Jun 2026 22:00:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EDC920040;
	Fri, 19 Jun 2026 22:00:03 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:02 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Christophe Leroy <chleroy@kernel.org>,
        Michael Ellerman <mpe@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
        Sayali Patil <sayalip@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v3] powerpc/fadump: define MIN_RMA in bytes rather than MB
Date: Sat, 20 Jun 2026 03:29:44 +0530
Message-ID: <178190618811.653308.13497717984315304514.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <310b040acef712fdc79e3e37d0f4c2213938b556.1781589284.git.sayalip@linux.ibm.com>
References: <310b040acef712fdc79e3e37d0f4c2213938b556.1781589284.git.sayalip@linux.ibm.com>
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
X-Proofpoint-GUID: mufkNSYbOzsE_Z-sHKnXAPPfTbyP8Rnc
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a35bbea cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=uW7mcOdcQNOelwDoLbgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX1WhsMyZ0CC2R
 hsbkRCclkBoeSYewQN5yi0XWUN7Pi2+wh05NxsPTyJptmlsCFjA+K3VVAtviXSyf6H3LZPyvk2R
 lfc4xx8Vxp59Rwbxebj0PoNWiU8AeDE=
X-Proofpoint-ORIG-GUID: DAMWTHpSbNmmBAU-5LP2LwdFa4qShJH_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX2cCO7vPKUxR7
 KPJHKtRCgZBOiTE2DBqEgIcTnv570WredlDQLEp4xMYotL5sQAeMLXCxhbLtnlOCKO+WbRkgpCQ
 TKmck4lySZS6HZvEZu91Aha+R1LyJ8FTX3kAWdjwlb3VY60jc5zR/jxT1ADnK+WY6KjbxinA3yk
 Vc8+X6nz9C9JWLpn3SquqMXm8X4DahOCCWMBM4EInTLWjH+xiqjz+tKSD8YZyVqEjPYmY5bN4Xs
 KPccIxxwNtzDvlx0u6LRrnMwR8/yZG0Nxuza5ZPwEdG3uq7Cz4hmI2PD+t4zbk+sQtprpi+Ych6
 m1IgY2OSCjGv0o2qJLEDK/83+V1Rtsd+HNWLwasBqaB/AuHZvTKzY0uyvEPqGAqy4liOkthaNUb
 xyo+8RUMICLn0O+IZCs1GSCYdl8NFmsUzUtZLe23f9BQ4uuYbMiaLVHsFvBiIeBz2JwT3KnnrX0
 cZ1igCyZD/TUEGV0Gwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Tue, 16 Jun 2026 11:44:35 +0530, Sayali Patil wrote:
> The MIN_RMA size checks in fadump_setup_param_area() use
> (MIN_RMA * 1024 * 1024), which is evaluated in int and can
> overflow when MIN_RMA is increased to values such as SZ_2G,
> triggering compiler warnings such as:
> 
> warning: integer overflow in expression of type 'int'
> results in '0' [-Woverflow]
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/fadump: define MIN_RMA in bytes rather than MB
      https://git.kernel.org/powerpc/c/42f252f5a646866a95f025863c8b201042494ba1

cheers

