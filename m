Return-Path: <linuxppc-dev+bounces-22831-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF95CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:00:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs2c2rltz3bvX;
	Sat, 20 Jun 2026 07:59:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906392;
	cv=none; b=KYkhLUl5vI4Z/uVhwzJjzvwineib7C6ekxF2E4AAIxH9dUZgdKTWaOIWjQal9wzfTh48KM2ySq06EwWwWMza2HptdSFL1m9teFWB8MV+Bs0Ojca288W/TVWoA6sol5vjr+V2HBZV94zHxOAseUvw8bx3wcHZtFmIiUpeRNlWLFHohXoKlD48+5U8dHdNAn0mbVsq9JFzUZ/xGMr6cIP+QE8ENCmOmHNoe4cdCHWOEm05U1aiSRjiD93td3WxmEC6xKkgEr5IMZe5YgDF2u3hzPKcJ4L62CXcCZ7l2oe33r/NVeKWFhT7vSOdNvaks2oKwmXkomohMZOzibU92fqXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906392; c=relaxed/relaxed;
	bh=E24qgoqE8+39Ugu4A76b0yoZeVUOIY7VGb/BsT55POc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nC7wc8J7amwxaCx2BE9DCH4FxbxbhUWmhbuNnE2st7m+gCjUGSiZRB30RFG6PLfE+mxrEG2z7YJEXxyxKRozHsObmhby02eBrRls9lu6ZTdBeidiqxP8od5Yuw6SLQPod/lvzvAyDKr9PV+FgZCYynp56HLgmMMdqamI8AUMnX/5k25IArXmERHsNNd/T/NYMumSZ4Qyo/n3K2OCEmtzkwXUsGqSeWS+0JifUTws7/48ob9fqNN3pCGr03L0VG/bRDw8I5HY3A2hof5lxXVGcvlTs9v3cTXd1WlUEiiWtC2NfWuSjoDqeAOKM9/QAfGQwMA5Eo1OqLfZaFvluy5gVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V7wNIjpH; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=V7wNIjpH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs2b4qJ1z3bqV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 07:59:51 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmGTs3445137;
	Fri, 19 Jun 2026 21:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=E24qgo
	qE8+39Ugu4A76b0yoZeVUOIY7VGb/BsT55POc=; b=V7wNIjpHaljInis/py3rRE
	l7pMSqVNrK0XPOsD7nV2eAG+o3tRWqpWriq2pbpxQlZN0djwsHc0tedTY+NIjwr7
	ipdZLzG9w/lGju+6W3nluQEVASYD6O+7kp8T35mb7rh6VcNxLmHDVejpbE36rgWq
	n8UoZi4BLkSemyfywwVPCugkevdwIf0EBi8ezwxFLUtialtIHx2dtaBsuouHUrQ/
	DKu0voNjF9etdbMSRLFth09pFx4LUJQHeQlV66PZyxwiRzWzSGt2EFkdZ8cWb69L
	LXm9U2sPLjWnTWxtisU3kx8jK+lfnNh5De1XipW37SDGtjPMJwtpg6YL0Zzr1QxQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw7rtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnaQT014045;
	Fri, 19 Jun 2026 21:59:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172jrp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JLxdlp59703650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 21:59:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0672820043;
	Fri, 19 Jun 2026 21:59:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC65920040;
	Fri, 19 Jun 2026 21:59:36 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 21:59:36 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Linus Walleij <linusw@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: brgl@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] powerpc/8xx: implement get_direction() in cpm1
Date: Sat, 20 Jun 2026 03:29:18 +0530
Message-ID: <178190618804.653308.5075689673595650569.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603-powerpc-8xx-cpm1-get-dir-v1-1-2ae1c9a5b992@oss.qualcomm.com>
References: <20260603-powerpc-8xx-cpm1-get-dir-v1-1-2ae1c9a5b992@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX/Qq30D8PZTgA
 lkRMqhc2BK/0H8fA47MEMG7zJR+d0B2s46DE8st+dw9lf3vVqwnxlnPB1NiAMUHNvxrA8EXaf/N
 nFBWosebmzJ0yghn43m2uYkCzKgdNHQ=
X-Proofpoint-GUID: ZmHExxleiaQivrB2_6KnuR6qxDTDANMI
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a35bbce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=exhXoVybxqd9mzuGZbsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UPLJBwuQDNyS31-pubP0tcbs1gf50hZy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX1EVRo0oKyIqD
 1Cw/dG5HD3w/9197l37QvnkYinFKzUY+4E6E/itcpCEr0tTQgKINWyHFOF21DCbQDdYyiD9hYQB
 msWWN0eiknMZITE/3qZsA2uSc7qnV3Hu52YbLbdLttf8N0rT6Fm2JP75Mw7Pu1v0YZ/hX6k/ka2
 k3y4IhYeT1+5khQ40mqz7R9+1I3b9bSIKjODOK8kSxTebXwitr2FZBv/5BoXacA57Igu3qbWn8z
 kS5AOv9YSUMy65U28SZY2V/ffNJV1AAvwmc/Td20MWTQ+pSN7DeHMGy++AD7Mi02n5eWyxEY81h
 +S8DSDs/ukDPMo5aEgGOemHOHphpUvivmogSS3kZJ7D0jxng5+VvknGYauMjvjVL2WqpTEG27nD
 hrLsBkD+V7rS/x6go+YBcJF2rovd+PgPmtccVLNr7+AY/GpnPl70oLeXZCSUyTuMP1q9vZstTaM
 UJpVnZZw6LKt3GFWORQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Wed, 03 Jun 2026 10:26:26 +0200, Bartosz Golaszewski wrote:
> The lack of get_direction() callbacks in this driver causes GPIOLIB to
> emit a warning. Implement them for 16- and 32-bit variants.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/8xx: implement get_direction() in cpm1
      https://git.kernel.org/powerpc/c/052f67a1ae6ffa6e43c82193bf2e6c0dfd2e6d8f

cheers

