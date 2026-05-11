Return-Path: <linuxppc-dev+bounces-20670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D13CD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 May 2026 02:29:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gDNvg69qXz2y8t;
	Mon, 11 May 2026 12:29:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778466543;
	cv=none; b=hwJfQDlGbNSGdPvRDlSifPGipTEGuPUfAlP8DVP2IPTWMLs+8njuLykZx4M59LODxpV3x4iViararesCk+PM3l1PAMzpEG0URYkjfMeD0XtrmcuUxqZOpdpyw7X/ARq5Ev/vdEyfuJ2s3RVUGpFLhRsME05iG9xDleEk6epQKO9sdh7/7NrKE8V6J07ve94MzOJVfgaNg32gmmfu6SIt4jTthTP4xe+AnDvBC0xmtuM08yFJhTaWVVbpJTWQGeq4TMyYTFjTF3BNlfzOfn0xDtQhXNeIxdhcmdMupCiqazPBu3S18ij61YC0N4aheSD2/Db9U/o2n2a5iGkTLkwDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778466543; c=relaxed/relaxed;
	bh=3eUkOTjfCkucYjeTDThpMbrYX1VhyRRWZdnWNMT61qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EcE5l7IvkhbJBGUjK/8Oqi8xozGcu23uU5LEM1uV8XrPgPr4KgTm6BFvOxmoUQBPyTk1omk1Kuc6mhcdXhQimB0uSmRRF3YG9ZGKRbkw+wvoqGJEo+n++2LOdUYHD9GJIeZLwLzfOnVXbcjrmS6p3p2Y/U9DVmZ4oBbiF6J8lAyd5r118oeMhaPmQbdMCyDkxVINFar78sz4I3CmKq0q88hkdL1wYGvqaVu68eHHH+beMP1YvxLpZN596DP0AUVwUSBUkbh8gaLI3ivX9e0+jp2Ow+p+lcw73k4oYboNhHgnbFnZD/uFG7pV0CPGq+PDo1G3s2EhKIbT83bJ5khyvg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qCv0sZYY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qCv0sZYY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gDNvg0y9pz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 12:29:02 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64A7MLag2127614
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:29:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3eUkOT
	jfCkucYjeTDThpMbrYX1VhyRRWZdnWNMT61qw=; b=qCv0sZYYSF8Vyi6n1Umwpr
	1NpjDbZmlpHu7y8Vzp5uN0/LRk9swMHCKItRzaZ2j0AzhVSa/ELsvUIO6pu5JcHM
	PmSDKCNqNWq4SlF1uNYj/ZIB6cKlrOc9XjHWz467zZHmq3Wlmos9EnbXWLbsmN/B
	Gd87J/ta0XP+idhxnZyT0zfDDEAuCi0n7ZFSnjIsHrAgDXucpUMDcbXDIhWJibFV
	UG0s0xxZnoTUrEUmbNO6oziKTDNzTSqOMiXA0myy6/xUO1GggSddvV/jLMMFjwvl
	l26oSx0oRxA/X414mw5sR+sD2jtmtM05dgMAQog7U8fhMOHPZ3LXnDFiQ/j3Je3w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1vkqp7k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:29:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64B2IlrI025724
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:29:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e2hfg37ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2026 02:29:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64B2StXK48038204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 May 2026 02:28:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B3920043;
	Mon, 11 May 2026 02:28:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85D8E2004D;
	Mon, 11 May 2026 02:28:53 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.2.213])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 May 2026 02:28:53 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Shivani Nittor <shivani@linux.ibm.com>
Cc: atrajeev@linux.ibm.com, hbathini@linux.ibm.com, Tejas.Manhas1@ibm.com
Subject: Re: [PATCH] powerpc/perf: Update check for PERF_SAMPLE_DATA_SRC marked events
Date: Mon, 11 May 2026 07:58:52 +0530
Message-ID: <177846637463.1289230.12760317349967878144.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260421150628.96500-1-shivani@linux.ibm.com>
References: <20260421150628.96500-1-shivani@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDAyMiBTYWx0ZWRfXwJKBGzHMm91T
 CQApgkUPU6k3ZW/NSYZVMiRXcYlKb3qckNYbwyL9ccKekV7z5FAlc8F+ZM4qzaH8+FXTs5FS1WR
 J7otXC6tINd6nv8SQtg8bediBpN65Q8aVMUnNZqnhXj8ZPMBjrOxjqAh1U0CMwkkW1vPtuOhxhI
 avSogxANJoGlJj5Nfbuokc921cWf+Lfm/r2lyfWdIbSiqkS5jRt2RH1z3Hul+NECVLJncegyH6c
 oy0yYVST7veWon6Yy9P7oWpijoqCDl/Kb2JxwmzdU1dINgmdz5WDuyu6ZwzYyyhJUysREbosydF
 mIyjTW5wgj7ZP1M8B8XmB3khHLgdcVDFN+sxhysZzrOkDBl0LnaKVBJIijsoQb+A44haRLiJVe5
 Bhx3duAhZud2dM0e6Rhcx96tSYNs/rvI5npTL5b7BQ2N7tGa3hiWrncY0EJ2zdw5aFpgXHopnIt
 Cz1bcDZy73UgHv+Tl+w==
X-Authority-Analysis: v=2.4 cv=OaWoyBTY c=1 sm=1 tr=0 ts=6a013eed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=DOnHrMGtfHJrTJXtOF0A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: iZHRRwwas1R5dzYiikOdd1TFAXYry5bO
X-Proofpoint-GUID: iZHRRwwas1R5dzYiikOdd1TFAXYry5bO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110022

On Tue, 21 Apr 2026 20:36:28 +0530, Shivani Nittor wrote:
> The core-book3s PMU sampling code validates the SIER TYPE field
> when PERF_SAMPLE_DATA_SRC is requested. The SIER TYPE field
> indicates the instruction type and is only valid for
> random sampling (marked events). To handle cases observed where
> SIER TYPE could be zero even for marked events,validation was
> added to drop such samples and increment event->lost_samples.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/perf: Update check for PERF_SAMPLE_DATA_SRC marked events
      https://git.kernel.org/powerpc/c/131717e656b379addb95af2dcb2d90c723bae24b

cheers

