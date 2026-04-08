Return-Path: <linuxppc-dev+bounces-19466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38FEFD5F6D
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:29:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr9722WHYz3013;
	Wed, 08 Apr 2026 14:28:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622526;
	cv=none; b=HfEo5FyWiIH7u36QWvueao4H0Tg7aykFnsMDiXH3HEe3kYM0248LpLvZe5KSohNMrSEVF/1VQruV4mxrS2HzqEb8RBGAh5S+xPdPU13i/0WdVmFjpK8THMgP/BkvHiDdsSxiwuPayIbkjSWmRJzBdboRfRlfR95noHXeGJpdJVu2/Z0PpVW+Pw9aQ655WCAJ/y6ORMIiS+JRFUtpYcD8d8irHonbg+lr2mMii49zwaqGiqpwtgmFTKQ+VBUcnMaF8NIc02SdfTY2nBQ+bMh0kGAUzahutuNBKom5qnEGW+kdVmuUjzFQW5gBnk3/ysMD0JFgnat3WcmvhWz4W7j1qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622526; c=relaxed/relaxed;
	bh=cn/b3L+iZw0HE1l5V55iWwKR1HYFZgA3n2+Ugm/qTvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YN5qUQrLy3hHQvcbpxBk7KVLkwsYnZ8ew9ZGhCA3DpVVwmkPTc9xU0Dv+FXSsOSfvP2igxEb/FHJAmW0Lh+B8Kr9bgZ2drVqv8GctAyDm8jNRCECIZN0YhPmgOYIEFV1oLYWp/Ambq5zNjdG06j+UwQwMwugt7iYPv9YjZv2cYqt/2soVAky5KAwjvOnSv2GdRyTITVf+N/IQmO7E2mwTdlsMXebW4P48qsaZ855nhKozgPY9s7BnumEWpx3janyiRLbKvkLoI99+0PhgkJ0hwCYpLd8Vd2oZRpUE8QAA8/P9UzwCWlUjFT1nwV7mVB89xbSaKA0SzzyIVFo8DbTEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YE8LoFfx; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YE8LoFfx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr9714LlGz2ygp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:45 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EjBwZ2302360;
	Wed, 8 Apr 2026 04:28:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cn/b3L
	+iZw0HE1l5V55iWwKR1HYFZgA3n2+Ugm/qTvA=; b=YE8LoFfx/kO5+M2YaC6ihc
	lpxPa2V5Y6dMs5U0pmrkggQnHKMzeF8lyF/pXMs8d1XJK4UDlM3fOPHehq+xwA02
	o0wiYwbyAfPQ4jKTjyEWlqDfEqgAvyRT1KVspXvYOA9GjxWsboOXZQAVJBHNmJhg
	3kUmvyJf8IHLJNEQxNExqLMtol7xrbjd0OlX4rX+F4WRXyhhBeu2hlayMLL6wsul
	00m7ATfqkr7S7mzQre+e0o0P5t9X+jvanwMuUBk92YQudN8PAHszZ6MRdK9YqFpi
	3Qa1JW6u8E0FwPQfkq7gX/GDYozd5IudbuoF8tdxkxeYh45eeixzcSwZv+pvytmg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fe77n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380DChv030025;
	Wed, 8 Apr 2026 04:28:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7dyr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SXUg48497140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0E4120049;
	Wed,  8 Apr 2026 04:28:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F6F620040;
	Wed,  8 Apr 2026 04:28:32 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:32 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/sstep: Convert to scoped user access
Date: Wed,  8 Apr 2026 09:58:31 +0530
Message-ID: <177562236432.1381144.17106566048665416172.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8f2d85bddacff18046096dc255fd94f6a0f8b230.1773137010.git.chleroy@kernel.org>
References: <8f2d85bddacff18046096dc255fd94f6a0f8b230.1773137010.git.chleroy@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX/ffqgCc48cUi
 02Ljfyxll7KP4sRfeZ+VoBS88gmhhBG87kbcsU97oz4okOBGQnHkYuqGw01RWnWJJTIUjQKg6ad
 GCEzCkZcxe/Qgcgfirtc+e5e5P3tkNzCVJAc15yp4K4aa4dmNPq6JhTBvg4FNUXhDdvZUhxgKSh
 nANGdy6NgW9xUSCBQk0pfo5UkNCwqM4Qr1VvaFg3svq/bNH2m93TNH3Atp8rnN/5d8wgyWDhb51
 T7TS9liT8Yc2hUeKgy5MfT0hDGzoHqs+5lG2Osq3AWQI2P1CzP0mDPMnrUWpp2WSqsTU7DPKyL2
 x6dbwSPZ9BaYnArS2zgRvTLFRiF/V+t32NItBZ+bf2zs1GbTxqMc/+YZhe0cULnbDyZUy0KoavJ
 esypCCdM0v7uiog/F8fjuTcYOubf4NWQ/zikHyp0AEsFIvS9Z6QdGNxdotKZZEpIa008W/GUOY5
 nycYI4dwqtuDX0qiFgQ==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d5d975 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=Xnn0j8UZnTOuyrh_SIYA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: tDNlvx5Hp2-WS20b43oXmlAmbWwXAaKt
X-Proofpoint-GUID: -m2KeOBZh5aXXVqBgkjZzLYZUGLFpWCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Tue, 10 Mar 2026 11:03:41 +0100, Christophe Leroy (CS GROUP) wrote:
> Commit 861574d51bbd ("powerpc/uaccess: Implement masked user access")
> provides optimised user access by avoiding the cost of access_ok().
> 
> Convert single step emulation functions to scoped user access to
> benefit from masked user access.
> 
> Scoped user access also make the code simpler.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/sstep: Convert to scoped user access
      https://git.kernel.org/powerpc/c/cd54714e938d4951abc671e562d10c2308613901

cheers

