Return-Path: <linuxppc-dev+bounces-25651-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 963F5C5AC80
	for <linuxppc-dev@archiver.kernel.org>; Sun,  9 Aug 2026 13:14:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hHyyP4m4wz2xyl;
	Sun, 09 Aug 2026 23:14:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786281245;
	cv=none; b=cA7oz5X7fVWKkWCSPXRbkSuVWYZ6EnPQHJkbHTV0xQOsQ72PUiesWQENWzty086mrhXmauvkbcprfV25/TTblSzXWLzR4SRo8w4KObKd0WyWSfOFpejQXuHuy+NVIY8ZunSj9cJ02iD5BeSeJ9/YCWg72aMxXkjo7S6XwRL7ElhkyrpSA7V7tYeLhsw9DjieMi6BcHDdK3sJ6nSHW92LTNT3Y5i/TZVDLznMwylCe8Ic2jKWLB0yyXYJYsLsF5uzxaCEwI5qaFyzLnqT8xA42HFXl1N/HgJiBe9t9oozG/WxsOVa5POAbDLHSTdpPS6xNDvcnq4HK1wpjesyHDyEwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786281245; c=relaxed/relaxed;
	bh=N8uX7pKjP4SORWQCud83XjwEJ4OuEJ/76jlgNrsPHmQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTOkWdpQDzAz9cJHn47jZYBKjUz+TlnAv0EZ/l4c73rUY8zerjIdcIUszlFia/9AthGhlbBvALY8EGwEMBoLYIm9x1zZGvMB/BqeBf5aSI+H5GYWFILpV5dHwVf0JOCkddkznBqLN4c3h5t77MlkxEZtmtkRNCc6shOhkLl1fLuuuzAkVyBgfIt8su3DdwkRV1gqdINHnr/zidw8fSFXSyP8DD3uk+T4rVz8ZyaZAKftqnjyW400oMRKP67Yo4hZ9QrK3MU1/zMtHC6v6Y7InDqoa4UXOD7OCbdAw2ur2P+9HeC7+43QLnW0YN/qxqzrfipYA5y6fGo0C26DpeXZkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ws0QqTYC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ws0QqTYC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hHyyN5DYJz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 23:14:03 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679C33uO2822712
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Aug 2026 13:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=N8uX7p
	KjP4SORWQCud83XjwEJ4OuEJ/76jlgNrsPHmQ=; b=Ws0QqTYC2FFvQD+RB34c8z
	Y7Xl04NYiJR2Wu2aw1gh3dVgiQAnhV8Uo7c/cyJYYED/JXwyJrONtKXeYBW6KafS
	S7X0TR7/sEWaWqe8CnR5xFrSi2JiDtgBdXBfBl9hoO04jSAvTtKk4CxaQ+Su/6Zu
	QIS9EOcfK5uL2uE9DO5oTCCeXXTPKp5wTSNTiaoU322THlsxrg5ExB5c5qBiJePN
	FlaXcDVwvrxDUmy0yoOShM9D/doybpI3i1mnBfPIoEohB5/CrNbOU5HIc9l+VwQ6
	+2wJX7hKkYndZFA+AaWaP/T5IskQqwNZNaumQGC+JRLPo6Gy/ttfkRuS9rJUfJnQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2kyxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 13:14:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 679DBJWx017363
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 9 Aug 2026 13:14:00 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9gsa7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2026 13:14:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679DDunC30146916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 13:13:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8869720049;
	Sun,  9 Aug 2026 13:13:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 698A520040;
	Sun,  9 Aug 2026 13:13:55 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.32.240])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 13:13:55 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>
Subject: Re: [PATCH v4 0/4] Base support for Power12
Date: Sun,  9 Aug 2026 18:43:54 +0530
Message-ID: <178627549724.530848.7684124018845428258.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806051120.3703698-1-mahesh@linux.ibm.com>
References: <20260806051120.3703698-1-mahesh@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a787d19 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=2Zfqsbblk5NFlngENzQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QodOH1UqUXNSn1fQ6ezVfye6gciO4buL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDExNSBTYWx0ZWRfX5hAVlpil3TAs
 wM9LDCd3VFSlc1Zd4anDbU5YPCtXa/O+7IIILsNIUI/4P0EAZF3LvLATyzOEPaSawxBiJ0FeH+v
 TysSK+lEDNENB9xCzudrjVFxqvbBD0NsB7OB3fnZy0FxL1R5mUoFryzjwhG33LxPcoCAyv9NsHn
 wFGFPd/4JFP9gaFaR3vXv77YCd8OyCf3t85HjV3W1TCzZZncqSSJOSGJYn0qqhjSpCayA70omlA
 KOHKo4lro4nOiXsbUAnOs+65ZZaey+HcVe3GCrMyYzeC7lCAfkOYQUdn+PqNrHdOlPuFBwK1Afz
 TNgP1yc97p25VM/f/aCMND0LqLzz2o64OA2Xs45pD09HQM89aWVq8X1qK4OdPOOblLJ3IRynZhs
 h4XHgbRUtEPW3KDif3kPaRQXLI6P+JtBJK3q3FYZlhdVkQMGVtDu0+9eFuULK01OXD24mnkcnQq
 FhID+VLnEOICfj2UdkQ==
X-Proofpoint-ORIG-GUID: QodOH1UqUXNSn1fQ6ezVfye6gciO4buL
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDExNSBTYWx0ZWRfXzgMBtal3QzIW
 4sQVV2sfukMOUAOwPM7AmUW+HJT2kmj3kQ8MnswujHoVsthPTZqvor1PqdII4BGgX2EPkrMSzqu
 ZF1fvIxWnbrRwuiGKGaYtD7JzBr2Vv4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090115

On Thu, 06 Aug 2026 10:41:16 +0530, Mahesh Salgaonkar wrote:
> This series enables Power12 raw and architected mode with Performance
> Monitoring support.
> 
> Changes in v4:
> - Rebase the patch series on powerpc/next
> - See v3 at https://lore.kernel.org/linuxppc-dev/20260805110924.3853410-1-mahesh@linux.ibm.com/
> 
> [...]

Applied to powerpc/next.

[1/4] powerpc/pseries: Limit PVR list to 16 entries for CAS negotiation
      https://git.kernel.org/powerpc/c/972a7b78722cd2faee75148278322d844f4274bb
[2/4] powerpc: Add Power12 raw mode
      https://git.kernel.org/powerpc/c/e671e147ea51e95d7535940ccb2b76ce681ff765
[3/4] powerpc: Add Power12 architected mode
      https://git.kernel.org/powerpc/c/287df870bf47d191875ca12f951dde7a6f913251
[4/4] powerpc/perf: Add power12 Base Performance Monitoring support
      https://git.kernel.org/powerpc/c/aca7cf5b1ffe07f1a1aab5db71a6cd14e07165f4

cheers

