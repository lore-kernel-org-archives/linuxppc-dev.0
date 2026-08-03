Return-Path: <linuxppc-dev+bounces-25243-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 209BDC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:58:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vL0HxFz3c4r;
	Mon, 03 Aug 2026 16:58:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740286;
	cv=none; b=Wsq0c6hqyf7Tt2vRA7lAM/cp+j5BuZGQ/ejgyaJpTGjXFaW8Wp24xq+3RW1j8k0Si+l/DgGzqdKpLRlbwDcz3qVUJpgq7N+ZZv+DnRjlgAv7aUUbby3wAr7TrZK5/7ab6peRRii579aUr8+Rhfy8Fkgur5KlB1PMA4uqBIaJo/1fXFgTrcZCylSso/9r0b/Lk41S9diZvGQtDFZXlbkCiSynFchajmykE6eEgRfVdTT8ZEJQ9EW+qECq1pGV8xJg0op5LgnqlOqBq52/Lju08jFsur+zldlNc5/kq6WcJxjsKFsX8bgk5yyg5dgQyk/KXlB1FOrHqREjdhpFJxrEHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740286; c=relaxed/relaxed;
	bh=kxj2KyP7Bj6hFSsXiHFOgWJtGj2GhMCitgsSItjUp74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zx60/V2JZ63lSgdjAT2X6ADVCz+GHpuUO+7fvdHmvGdPwlsNY3msk3yF812MsRVOuxlL4NbuqtxC27ME2kqX2yijJ6t5p7Mcm+3XTmer87Dd2q7JbdTe6ayHl+DmpHvMCi4pDPnXiLVwvW977vX0exKjD9lSOb6ttE8gLhRJ2mM2cNOxtIbWNfuN71KzYEJoQyWNR9ihbXa/WSLVp6kb3CBFJjuYOteiT3Z7AxG7mwhMHQ0jSFoiif+9TCBa5bo7j7wMGW07HwhU5tGtp1lbybs9+cFbummgcsJx/NXLDmxZB+IOKwMBua9m8ikm+b1HmnAqP9JK2LiTsYAcUSA5/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fbSq9nuZ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fbSq9nuZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6vK1VYFz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:58:04 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LllRj159860;
	Mon, 3 Aug 2026 06:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kxj2Ky
	P7Bj6hFSsXiHFOgWJtGj2GhMCitgsSItjUp74=; b=fbSq9nuZ6o+BfWXBAR8kKr
	06WG74ml9S9LTbz1hdXXcg2EuZg+63vT5NAqp0uB9A59bpVwcBKaXoe2sGfg6130
	aiquWFV8KHuvbVJ6nfdsHS8gMHSJonI5clUVQnyKx8nGP/r8kzrWZS0F7RM8GJw0
	ZLkT73fpf75YYoA0WNokTfy56b3TNlgyLq1TEP+o0pE2q3qIUTvyJhS17p3BzwXm
	CLgroJXNJ8lruTwAlO0jSDBA3mh/SptydKWzIzEB0oDgQt/S0DPMii+7Xwco9/DL
	DJVG4sZIU65SKlAl2SbaJ8a5nCg5hPQiGwPLa1nVd5IyGsWMYlO4HSkGRSRDA8IA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hf9uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736ubhH001129;
	Mon, 3 Aug 2026 06:57:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh431t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vnFH50069992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B272F20043;
	Mon,  3 Aug 2026 06:57:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2883920040;
	Mon,  3 Aug 2026 06:57:48 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:47 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Kees Cook <kees@kernel.org>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: Simplify attribute description check in papr_init()
Date: Mon,  3 Aug 2026 12:27:47 +0530
Message-ID: <178574013461.29744.6120927787330610066.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260626110718.4367-2-thorsten.blum@linux.dev>
References: <20260626110718.4367-2-thorsten.blum@linux.dev>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX+jJs2qoVcPlz
 TQWeVh/k7xWYiz88WRgmP6YAlXZCwXsJnuQHTmYbEKcPF5UYYhXuYr6UpvTjoSwIh2mVIuDgTeK
 u7suA9AhUaCmctvpasRkF2I3Ir9vfWw=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a703bf0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=5sT70pVx6Kt7Vdj9NNAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX3wid6bw9p+0T
 5V7be+uoYYC63lCU0D/jX89wvNmguvzDH2PyzanBkGRcJoXzv74vDVg8d5sQkUFkKzqKusMELbS
 tVJm0VzHT0uopN8gNV4htat1QSM/Yc+ynEpl7hcu+MykkEZhENI3X8a8WG8zaFeNmvv8Z/5CyXM
 CzOunJOW+XRDUXdX0DQvlb1iQi7eeWTl/PgfM3NsmjPETQtvak46TS4OeWJzBfWzcZANbOARTPv
 F5NoX614NV9T0Tvnzc2vOavW6ydK4CK4dT7lYIZY63g5PVkluy0qUDzDFzP0s7hKHnTlEwX/bWL
 02W0k/Wb0cBO1ALfOrot2fn2+yvdQRh7ObWpFd/XXAlhZwP0gpYaiYt7rPiRRml8U+/niO/dLrM
 t/KbGwGbho9bLbmRYii1eFaia9rpHaOpjxEEpWXfllv+OQ2Yr0twRP8k2vf570rdKKlx5r7P+Se
 J2dbbT0KgFxq7iFCAcA==
X-Proofpoint-ORIG-GUID: r-psJBpCdZ4s9ndvgb8GqkwnYsQX6W-w
X-Proofpoint-GUID: GsuamiJR2t8tVxoS30MTYDTDYaVOtl6s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Fri, 26 Jun 2026 13:07:18 +0200, Thorsten Blum wrote:
> Check only the first byte instead of scanning the entire string with
> strnlen().
> 
> 

Applied to powerpc/next.

[1/1] powerpc/pseries: Simplify attribute description check in papr_init()
      https://git.kernel.org/powerpc/c/7cc3d3fdc97fa32f1e1d7b15810e723fe524b0f8

cheers

