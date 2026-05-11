Return-Path: <linuxppc-dev+bounces-20667-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B19CD37B2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 02:29:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDNvV6z72z2xQB;
	Mon, 11 May 2026 12:28:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778466534;
	cv=none; b=GnICilhGRV1oAsLz3haIxjBwMQMlF+/b4ZiTwjF14oRl6qgUx/0RzRc/VDiBQWiQASy5LPkNrTyh7Jc3rdIMBDzZCC4gypBxEDeCBkdu0z4DxcbAwiRyA8B38u0cZKHnrXjg280B1Cv1BrG8sdXPtpDbaHjQcuPdH9xKjjDFZvNah3sGzhXnXshObRCg+yP4UzXD0K8uq14UsJ0TtKk00gd2Io2Om138cx710FF4wCBhCo09GwvLvFAEgS3TpS9NdgPL6bFHGMkrg11jufJDLgVx9XuQWv4NYSCuB/sVFE0Y1HrHLIt4Qg9EBwYQW4qq/A27VT7UT5v/qhfg8gMbSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778466534; c=relaxed/relaxed;
	bh=NHm+nA/wyEEZG8iTumDlAArrYk1HVtjoeaaWzX3988M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gn4ikBFpJi2yna1fO+aaRKrkTBaZ3Y6a47JiY5FaukEjyHjH1PI+iWaFLnKPPPaDSWm8+E1TIkTwCeWgW22AUYZuetO9Rzz7AvCwbiBjcbZFn9jFcDfmU696ghpY4MvL5gfEZrB1QnITIfArs+RuM3abcJJ2PB5sr1SchA6rHtRnrrXb9A0bL9o8jAkdWBGch8lPQqlfz/ZdpbHh6WL3rM7tz7DO7WPGBdeF12phIp0JYSFso6/nER++Vr6pYFPiySPDyK4q5HZowFm6OKA/VE4RrbOef+vHs4JYxBqm11HOUUi40d465kfjzMOwd8QXB6ZKjrPGoHUWvf0rH7gdWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S6Gqo9Qo; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=S6Gqo9Qo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDNvV0yZHz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 12:28:53 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64A2hQ3j1991346
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NHm+nA
	/wyEEZG8iTumDlAArrYk1HVtjoeaaWzX3988M=; b=S6Gqo9QoYSodRP/mK2At+b
	cX3PIgEFKLW97p7s2glnMAKN6Blt9RKLZjgXNlS42/uMAmuXIENFjz+qAKPKH6lk
	j/Zu63j777ouCqfQlPvFKMNFl+UWeT6BMJ6R+WzXJO8ojTVUzMwq+0eqntruUISM
	yoaf6sK/Vfjf9ZLnoXP6U3/183MkbqrYMfOjmeRzGWG8XwidPQR5AYFbpffIAcUV
	IEl0NT59Rxo5ma03wlQT7VOG0giu8A4dFiw/yQ83920Usl3mNowYpsMNHQ3SaaXF
	Op486yz+g7FC3mUJzTsRVf6tbr+J3S2ttUTshe3TuVmuXPn/RN1X0kwZx/FK9Yaw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1tbhp22b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2Ijp3025690
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg37br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2Snem16908782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:28:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E662520043;
	Mon, 11 May 2026 02:28:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F33A020040;
	Mon, 11 May 2026 02:28:46 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:28:46 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev,
        patches@lists.linux.dev
Subject: Re: [PATCH] powerpc/vdso: Drop -DCC_USING_PATCHABLE_FUNCTION_ENTRY from 32-bit flags with clang
Date: Mon, 11 May 2026 07:58:46 +0530
Message-ID: <177846637465.1289230.8017211033998445491.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260311-ppc-vdso-drop-cc-using-pfe-define-clang-v1-1-66c790e22650@kernel.org>
References: <20260311-ppc-vdso-drop-cc-using-pfe-define-clang-v1-1-66c790e22650@kernel.org>
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
X-Authority-Analysis: v=2.4 cv=ZdQt8MVA c=1 sm=1 tr=0 ts=6a013ee3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=vtwD8gBtCyEPof04ByAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ii-nbiUyXhGELicUvcBL-oZI9LtPRJjW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfX+RFQDKRu+TV7
 XSDfN7m6cSRWchUJjbFl4QDoImmwWFqpuDs0I/UKFs6PRY1oNNnZrZWeTofKbm0jkG49hBx1rfB
 c1Q3XvpzxGQEReRwPzNsdw0M0/5bFejRkA2OIgNmscrIiIfw/InnFSm6zr+6+JlIkvA8FPXYYud
 D7zSXOXA0FNlLLo+e5m9xfRd8s+V00BKICk6EUlttZSpxbBxngkhuxA8AQWT0eBqTTuqY/GC6V4
 TxA2pgZkVD+szBblQiia4uEf9H8hn1+qpHum6WDvOo3E9FesS2pa94DYaZKDO/o7Io59Ig96GLl
 JNxqa9bqnIwMA9ZV5xTwU9Ep2ZAua7ge7wqj6/pgFNHv4P8EIkMOQp3+aG7X2Kbta1B6Qow5InI
 V6u5tXGG4m+79tOhLheRHpDGG9u+DTqZwVXhkQaABXsJE6nZ9Fr1459LyPtICfFORntJsNLBPYT
 vIXvLwp/tSUHcVQFwDA==
X-Proofpoint-GUID: ii-nbiUyXhGELicUvcBL-oZI9LtPRJjW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110022

On Wed, 11 Mar 2026 17:39:56 -0700, Nathan Chancellor wrote:
> After commit 73cdf24e81e4 ("powerpc64: make clang cross-build
> friendly"), building 64-bit little endian + CONFIG_COMPAT=y with clang
> results in many warnings along the lines of:
> 
>   $ cat arch/powerpc/configs/compat.config
>   CONFIG_COMPAT=y
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/vdso: Drop -DCC_USING_PATCHABLE_FUNCTION_ENTRY from 32-bit flags with clang
      https://git.kernel.org/powerpc/c/60c71369ee356d11ad845ddeb28ceb70ec6cd70e

cheers

