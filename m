Return-Path: <linuxppc-dev+bounces-19460-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94D62FD5F6E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:28:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr96t2Vlkz2yqT;
	Wed, 08 Apr 2026 14:28:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622518;
	cv=none; b=KqLU2OrtDS1B/JDlVJo0bAtPFA/B1rUShnjtYolhbuDbZwafPp/zpNBlxxGYGwpptHLqka2qONrSZmAJ3eTz8Iut9Yu1fvjegD5fXTYzA/U5xdaoKLjmj4vZ9dC7S8GBmbgT/dfWmqzi/e2SarfVzOIXMhfW9f2vMboeE/ps5F7e40dQbRJURWL4V2CZBcPwrBWOceMitD5WUlUxNL/HGjACLRWgrtbR1UbTjatynJYKQ4yE3FYcKA9vvBU/4UTZkOMukMNA05JOL3UBGb+OgSsPOxlZvAC3D297pyb1RjFXi7+XsbtNdgRYX/ubbeT7/Ep9QDbHRwW2XFB3aW4A0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622518; c=relaxed/relaxed;
	bh=o8rHuic0PhX8hjUGEtYE9ZcgUfT+BN1KSsR4UDkv5rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPdw/h++2giL6h5+2EztMpTEEOaljoNxWAWgOdnI7fAcCVZmcFgx+sVWyJHXqgJAgjuHh09ji07XvQrhPOP219uzPxCaT+H82ykyQkjLxmgnB7x7FfDpNpaXbHlYEKS9jApKEjRHGkp3beuXeniZL+cPOd06V2Ubr4i5bZhNr7X2r0BXHxSKne2ysAisE8UkdFE9qYCcNSEsNPM3xeyI4bLA0Yiobh78bJlVdN14JPDraT6TRiT7MomlcwB2GqxGfOnLPuFWoB0znaht5hyKpVUJtPpF0VB4hLQHvsG3+eYSfBRCwHYL0fbg3U39sfe4I9kLGiimw3xanZNQOa8/bQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IK9JjESG; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IK9JjESG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr96s3KLPz2yjp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:28:37 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6384419A2297727;
	Wed, 8 Apr 2026 04:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o8rHui
	c0PhX8hjUGEtYE9ZcgUfT+BN1KSsR4UDkv5rk=; b=IK9JjESGiuUV6NWZrN79l0
	dGubO1zgudhr+8yZS56GiVEi56EmQpcDSOgn78KZfEcOQLjweNWA1WXprC+xYFWk
	lzNCkEAX6olItHh/4oZ831tdYFPnBfdEj4n4e5nNan6Tri6YHJcG5BcVlnH/mUHD
	VuW338MQfY/pEgcfMfdRC/TE4Yn0kuOLgAKlp65dUanfjtxEmSQegZszYxGStI+p
	bGCG3/ok2+QanGKpO9JWkUjdeYD4wS1+OxUv8jAWQHFlKaIK1EpADiHwFIhrgqSQ
	SXLACHMro4SGvJu7TbLONAi7qD52zZ22h/W8NLmOY6wABQciRgIz53WwhGiNatXw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fwrre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380MXsb026661;
	Wed, 8 Apr 2026 04:28:21 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcmg7wy0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SHZ745089264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A66320043;
	Wed,  8 Apr 2026 04:28:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0E5B20040;
	Wed,  8 Apr 2026 04:28:14 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:14 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, adubey@linux.ibm.com
Cc: hbathini@linux.ibm.com, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH v7 1/2] powerpc64/bpf: Implement JIT support for private stack
Date: Wed,  8 Apr 2026 09:58:13 +0530
Message-ID: <177562236435.1381144.14761242301174081744.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401103215.104438-1-adubey@linux.ibm.com>
References: <20260401103215.104438-1-adubey@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d5d965 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=c4pk_TAjE7_yaBmCtEEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FVHN14Ku_mOeP_4FgGT6mPb5d7fNqbnx
X-Proofpoint-GUID: FVHN14Ku_mOeP_4FgGT6mPb5d7fNqbnx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX78ucmViPT1i4
 zl7C/iYJnuR7fKbz2HmDnyObajcLWfbrVe8hoadygD6xGougKOMv0BcRs3mfsW1QXw8QlcE1ETm
 fGw417V/fzMsqRs6bfX8s0dQAtX+pDE6e7qH6THjwjHmJIzqWg9eX90qxN4muAVzNr3swPx1gR+
 LjVYzLE9Ywm3lHsFfO1Q9yOBWKzRluxBGIl0iX2kYfO86QASf0koEeO0NZH6SkcfKKScdbI3HbD
 pk6GYpXcbvH5Nz4mqE9dyIY6fx4h+Jez6Okb9YJKPyiosGQkBlBYb7J8mXBNYHJ4VbAdNT7HcDP
 xjJMyvcCFd4rrVtZj3PGVLBHP+4SGj+ltpb6pLBsuiuVxEeKf7UEJZ2tRtopS+WEZQT8FWdyuS1
 iSaV+oNx7xHdrQ07ql0dHA1LMj2cFcqSffRr9EnolwSCwYRg4EhrYwO1W+BxP5K5iPTJc2ongqT
 2WyRrvLiAhWXlajcN0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Wed, 01 Apr 2026 06:32:14 -0400, adubey@linux.ibm.com wrote:
> Provision the private stack as a per-CPU allocation during
> bpf_int_jit_compile(). Align the stack to 16 bytes and place guard
> regions at both ends to detect runtime stack overflow and underflow.
> 
> Round the private stack size up to the nearest 16-byte boundary.
> Make each guard region 16 bytes to preserve the required overall
> 16-byte alignment. When private stack is set, skip bpf stack size
> accounting in kernel stack.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc64/bpf: Implement JIT support for private stack
      https://git.kernel.org/powerpc/c/156d985123b6d6e5189cfd0286b93c12167ae798
[2/2] selftests/bpf: Enable private stack tests for powerpc64
      https://git.kernel.org/powerpc/c/e640bcd1bf83dbdaa967b20cd98a782d52ec89cf

cheers

