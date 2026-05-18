Return-Path: <linuxppc-dev+bounces-21060-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E10CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:44:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmvN4TCfz3dKL;
	Mon, 18 May 2026 15:44:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083040;
	cv=none; b=SIW1rOkSWz+IYRAeTfe0FMiKWKvQwdMC8LjRWruZi6MTdLsJYe+ExysdHSBqViuAbReih5NUJqfNaY+hihZlvxqcGy9DA9tIzDsJ/468FjmxyI9ALFUoJ9++UXaiLms0stl8/g6f0BKMuJTji7vXZv8l3jdA85l1aprFwn5aOzHHDlpRpbKvGOW/yCdsuyPAh9l5SG9XuYIQx0cO0vf9n2dp2US0X1ZGi/gCKLUp+r4taY/+QIlzJZcVoSJsi+u7bHY9ZxftPRbJoQyaiajVpfC7kKemP80wmRunS6olnbWihXVXwTgrx0jnEqqNkEj5oYnf+ENVTVp1WUnVCLsFJA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083040; c=relaxed/relaxed;
	bh=/d+b9koYYJ383tPUUP0AcYDRjFx6C12hgmW5OIErYV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTK7ImZqX0hZ+tqkAALJskrvJ5iZea+Q23yo8uiF65J0fHXJbJTgFc8xdd0n/0jaPhrWaxcaHnaA8sEayVD5Jmope91hwBT7M1VKK+wS6K23zryj10QzJAq/pl27cGWq9CHsS3dtLhwN6buEs8Boa1QzqH7VXoQL9PiS2aStdQL42mNPQQHzSutkZcG+qifJinNhYVMLACTeUM+NkxSC46qJJPqH8Z6xt6QKD11QLOb2/fn6CacgnIj//vbqrm+QuRbQqI+Bi/maRir9Y9HuYILxxCarabGJD2FznUiWvSdLTVNeomKNojnJ9P0ZPKjnjO1p6l1cIJYvBPTJ7dcaoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pr4rn+Rv; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pr4rn+Rv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmvM6rDxz3cll
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:43:59 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HMHmqn982643;
	Mon, 18 May 2026 05:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/d+b9k
	oYYJ383tPUUP0AcYDRjFx6C12hgmW5OIErYV4=; b=pr4rn+RvoWjNY+nsJ1dyY2
	Lk4xDETRtgC7TeurnKY4Cf58GljRoPDqNALkXl4PHgtgimN90TipQh9Uf8tPg7he
	G4hFMGAlIiIm/LralVHSHWH7ykzoEljm9zoJJBnmxOVdeHHon8VyvAZhOKORwGFF
	kUAuAJ8Us/JQ1V7kFVoBF/W/aj3F0Eede7KwQ8Aa7004VPdx89gmlyN8CaRLl/U6
	F5HBDsTP3W3gi8P49xZ+kj667w8m0w3WYQwXGRrPpeMPYBgUEEwnSCtobrLKE5kI
	YEihd/BW55f81ksXfUYZRziYqkQIve4nYjuvM3QlMy/VMfglS5jmYC3f8626OV/A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mebqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5d3J9024830;
	Mon, 18 May 2026 05:43:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxv3kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I5hhZa31588776
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:43:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A62E520040;
	Mon, 18 May 2026 05:43:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B2A720049;
	Mon, 18 May 2026 05:43:40 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.43.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:43:39 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, benh@kernel.crashing.org,
        smaclennan@pikatech.com, Christophe Leroy <chleroy@kernel.org>,
        Ma Ke <make24@iscas.ac.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/warp: Fix error handling in pika_dtm_thread
Date: Mon, 18 May 2026 11:13:38 +0530
Message-ID: <177908291160.287704.16294849296370164231.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20251116024411.21968-1-make24@iscas.ac.cn>
References: <20251116024411.21968-1-make24@iscas.ac.cn>
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
X-Proofpoint-GUID: osToTChQ8jajGyfxbqhQBOL5SDs6aD6B
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0aa712 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=-GyfqmGyNljL1kGGE3gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UuZO23Y2vWK2vyeQJg-z0FiQ39VNilDL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1MSBTYWx0ZWRfXyHaHLqYTU1Vz
 N4BcCIQVyVx5BrJXcBs/Cc51xPVb6A1PfLQBUUmCErwa8w+mNrTguHZfFVZgcWb9e2ef/XVxXLJ
 3x2pRQYIchCso8FuABFNmOFx5kc7EYXmTk1fFd19LQe6qrCpoHhhYavUtdE76vj68/Qg3Jrsl5s
 DSi5QTW3zQCqTyiZ4ZvjsC6OsVnMeELvxU5jj99hF4RDJWy540eluF3nKQo963hzRBrcpVm6ONU
 oizlYb4pHN3CgsYu5rdUai05Otg0bhBiuHr1FYR2rUly8Jh/UPUMFI7Ro9ZcS5bivXHh054N3P4
 thCm7rOpkh2N7mpzAJUC3D5T0/anfg6WYpFfWV1pt8LR2vjaHmzo/NQYOiVGQDCA9h0yn+Ch1oK
 tS1wkgj0vg5IX0fH0Utg2gEGXgqgqF2Wg+DtsFZsdPLcoADMfH20H4yKdoXacbJnQMRue+9KD+G
 3lDl840Yt692R7XdfsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180051

On Sun, 16 Nov 2025 10:44:11 +0800, Ma Ke wrote:
> pika_dtm_thread() acquires client through of_find_i2c_device_by_node()
> but fails to release it in error handling path. This could result in a
> reference count leak, preventing proper cleanup and potentially
> leading to resource exhaustion. Add put_device() to release the
> reference in the error handling path.
> 
> Found by code review.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/warp: Fix error handling in pika_dtm_thread
      https://git.kernel.org/powerpc/c/108d7f951271cbd36ca36efc5e5d106966f5180c

cheers

