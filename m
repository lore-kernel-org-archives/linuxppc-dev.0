Return-Path: <linuxppc-dev+bounces-19481-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CE3FD5F6E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:31:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr9820P8Wz3bn4;
	Wed, 08 Apr 2026 14:29:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622578;
	cv=none; b=k+YTXGir3pViaQiK4fQF3tAtPOMVQBw0rX33dh9YMTEo8VQch2Y0s9LyXbgzCDxdjvgUd2gboIJWoXWNZmgrEy6kwVgJ86xkxuwGl4qsL9lzTCWLe2pYvEf4i8fjA4HaxtsvWYAd4XKziJ/eZhSqJ9R80s5yUiEVZYcQI6AlzWdnpbDESVtnz6bMaL6chY0MH4Qi2gAzf6IYs/5D+hI4BCIDBq/XumYIKDCkYQI7tY/YEWivpi988dbSkTMJK9wuL8qWnsyEYqrWwzBjJqfbdd4L9BBckJEv/YWNKfzNNO0PQCSUqyyvfBB3NlgGMwPB38PffWkSx+ZxBWyZrSqhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622578; c=relaxed/relaxed;
	bh=v5/YrR33uGKSO68chXkKymlpzjyg1KdFoS5R95+jex4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWWx3N8mmd395p2pnN/3DHzXAMAnIxcjg+6Kn2u7XcpJul9mW5Quc6ihbt22h1MKpTQScYOQRcMAruqDOymj/DQuI7Z3xJySlCEgLlg7vwJldrxpnkiz6g/lv0vZL+9V4NBw0Y2B0PMYxUM0NPFnV6rfi2IKnyvQWo4BmXCDpgnEhutTNKDEa1NnfRtnCaXaIEMXSp7fYpagy/P34yVlrL/wu38X/sppYa9S2Cd2CEWwmApCt2r0JtIiuqyWckjym5IV4F2+ODjUNsSRlv4PWVZSBwUkjGXIQ/ZhcFrj2c2i1O+LpZBZmNP8qRS7W6ZTWFAhIvZXIV1XQMAgEieFPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s1PwmsRR; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=s1PwmsRR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr9811WPSz2ypY
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:37 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637EY95H2325939;
	Wed, 8 Apr 2026 04:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v5/YrR
	33uGKSO68chXkKymlpzjyg1KdFoS5R95+jex4=; b=s1PwmsRRbs5flG6pTMt0NR
	6RWTQa7i2PFw+G84iiimGmJcQnOFYLh9xFr2s2F8fAqsWulqWPrtdCFUuWDnUWie
	yQgUZ/iz2hql7iBB+IxqQop7Jdst7c++1TRGZeD/w4GFGfe1y8QJY6verOfWXsDA
	27eWBzojbXhPmxVFLDUeTROccUluvpC4oTQgRDToxjJIWwqPDTecJ5o2a6HIBYRo
	OVRBvy/wwWZFmG7eNc1JTsotPnifQjyI210suGoGGsri/oGuGhoRI9ZHx9jvl7dj
	gxv19kd7s6rWtaJGSpZjTVXiKY6ahDZlmppaElz8hYWll+0x+7LPf7bF0bikKKNQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kdrfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380PlnC026655;
	Wed, 8 Apr 2026 04:29:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7wy3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:29:26 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384TMh845613424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:29:23 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3FFA20040;
	Wed,  8 Apr 2026 04:29:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB7D20049;
	Wed,  8 Apr 2026 04:29:20 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:29:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Christophe Leroy <chleroy@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3 0/2] powerpc: pci-ioda: Rework pnv_ioda_pick_m64_pe()
Date: Wed,  8 Apr 2026 09:59:19 +0530
Message-ID: <177562236433.1381144.6264870139061995462.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20250814190936.381346-1-yury.norov@gmail.com>
References: <20250814190936.381346-1-yury.norov@gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX8YKx5rAPXVYN
 n0H4FrhqSqdrIHuEpBiCcU+4mSor0ITvdB+YEpyT0pBkFpzJzjkCGye8S06KyvYkMemiMvxggAe
 tBt2whxyy9e2Zmhz18cKSGfSzipDYYjesrxfMvIpxcfLrssIJRI1RkV9QpwlmKrIzvTjZ0CRYet
 gZKkfUQAtvQ1XEOIxWBH03KDjp+U1Bjmtb48DolDskPj+kepGa58ujlzoNa8++86Thx/Rg+jDhv
 kSSGQrI5ulZTRBqx9IO8fAwSEWkGmsA2PkKAZ8ArShUSPeDdr2D3v7fwcObGUst+BmMcsxQqD6h
 yjVjB4a9xF2RczafEa00FMkMKqIRLcad/csMHzdBpetaccxI71AsnUDZrAayiKhfARF/UF7wlly
 SBQNBhSmCBHukzoxtWH8+pfJBWK1lbMXYeZy+3eXR0H44HGXOG1xm3/K3SEA3D1ow1poU8h2d+J
 4iK9GBxkP3thGhNxWCw==
X-Proofpoint-ORIG-GUID: wyX3YFzpqvjxu2l-IPHC20qoLqEVc9PK
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d5d9a7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=yZIcU75f82u-5EbNS-YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WruQHZkjaZwRU879gPuODPxvKrDcaNKu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Thu, 14 Aug 2025 15:09:34 -0400, Yury Norov wrote:
> Use cleanup functionality and better bitmap API in the function
> 
> v1: https://lore.kernel.org/all/20250720010552.427903-1-yury.norov@gmail.com/
> v2: https://lore.kernel.org/all/20250811165130.37552-1-yury.norov@gmail.com/
> v3:
>  - use bitmap_zalloc in #1 (Andrew);
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc: pci-ioda: use bitmap_alloc() in pnv_ioda_pick_m64_pe()
      https://git.kernel.org/powerpc/c/f73338d089deedb4f4f1e49751c30b8b7f595ecd
[2/2] powerpc: pci-ioda: Optimize pnv_ioda_pick_m64_pe()
      https://git.kernel.org/powerpc/c/bd77a34e9a619ee92c03cbb227ca86d814aa6601

cheers

