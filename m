Return-Path: <linuxppc-dev+bounces-24583-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A511C44529
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 08:26:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h49Sl2lPbz2xm3;
	Tue, 21 Jul 2026 18:25:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784622359;
	cv=none; b=gqlKOn/tZMvjY1pdDb4aq+GqTSEFKmYOTNRw5Y788TdlMu/ZjyaSg1sEatQ8GSGAFUVzYI3eJkAljKBMBlTLwTD1GfB4u3nnNx/Yp41ZQHX1ErMXlug67ITtgv25JRHwGEc4mdJt0nGwsxGKXkRK85ChqQyWnHsMWCUMH3fKqR/A/HRgQ9CcchvNv0jS4pLT8HKZd227JrkftQGzKk2C+F3zurI+tLnHzYioic6+mxF4Zoag1FQOw7d2c0noTiQwXdhUik3c2Z0pIZaycJmRFx/D2Lo3S7Ch6ZUCxI+C3t3yZJTYqKUtdFe2a9VLW5RDftd2AOMmiqTpz2y/ZQZpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784622359; c=relaxed/relaxed;
	bh=7j7nVslGBbg59EfE4pwRTw4Dz/0j8aLe4h/NWrEIjEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVh4xzsvztYZRpw9O+8q+9lyZyjRQ4rOHfaDdW5YWPhznJP+7vSge/oBXoXGdws2SrWP9MfNWtTVZRkrs1Scu3z6lscilBzKE7DuIKPTNI13MwZ58kfOv3S8gjM41kPrnPEHvfnFqQ98hJL1EkpiBk1agEMVYTABt4/QsX5duZXxg1bRdeCo2v4fQW1a35FK4dO37zlc5oylDanrn9XubKgpLOcq+3LlkC790KikhrurvuMKdTO3AsvsTN4AUjM25cXYlh63cFJEw2M0ssW5R6iyd3dnZaAa2gf4TIkEsImR4w5CS/SwqRPQ3e80SGvs6A7XZEnhWj1JMCeVCBZLzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ps9kxCYe; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Ps9kxCYe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h49Sk3HLsz2xjd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 18:25:57 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCmGM1675584;
	Tue, 21 Jul 2026 08:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7j7nVs
	lGBbg59EfE4pwRTw4Dz/0j8aLe4h/NWrEIjEM=; b=Ps9kxCYeEGopllJm2JM9Om
	uyM1HCt3eR9LW1Q+KPMJ/fTV3s1Ob5X1OwPv2DxuVavMSbnLOtwTcsHAd45MrKEk
	9p7ggEsYeN+50PRRrM8VLTiw2/lttx+nu0LVS7KQ0xns9yNyaHvg1sy/1vxqXEpL
	edgzvI8bh0ExW/Z20imqc7EPMEKRx87y/tWp1CbEMJQlrd1CaQ9aN3FOwIRlZmu5
	Oa7aVmf1lrNu7JnOuL6dOOGC1i/316SQBen0S9SZgOS4M0xm1fftNHu5B6pXOFtu
	NSUyRNb63Nllga7/67M0oLurOGWh03b4FyiMdJOL33ajOwU6AgWiL4g6dSPP+R5w
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77abjdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84lJM029535;
	Tue, 21 Jul 2026 08:15:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g96jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8FDnb45023504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B21A320043;
	Tue, 21 Jul 2026 08:15:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10A3920040;
	Tue, 21 Jul 2026 08:15:11 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:15:10 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Junrui Luo <moonafterrain@outlook.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/spufs: fix out-of-bounds access in spufs_mem_mmap_access()
Date: Tue, 21 Jul 2026 13:45:10 +0530
Message-ID: <178462153933.1974055.13501387546099263670.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <SYBPR01MB7881EE775E8B51C09F5A29E7AF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881EE775E8B51C09F5A29E7AF152@SYBPR01MB7881.ausprd01.prod.outlook.com>
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
X-Proofpoint-ORIG-GUID: R9RrSg4K12j4rLoovRmoGl1yOsihmmiN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX4ZYn65B2pG3f
 FzS2gchqqlBy9zRKnvNKT09Y1Bs51cbh8bbGpOMTIhqUXppoktjSTTliCHOh70jAVe/TxAKf1r0
 GMM/KxkwWdbjak3A8d5PbLaFjmO4eUo=
X-Proofpoint-GUID: 8mrab-e5_py-OG28MP08hdwlUPgQe4hz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX9akqyrGD+l9W
 GheGfIK2/eM+CNtofm/6hZ2twvoP3jBvkVBI/xm5N347wAlZS6Lo2UN7RZ9J16ma36wp1M5lgZu
 O26fkDRISht/44h3SEqSezE8uKCkz1CLFwHHI15BVtZxsrWmpgLtxZNtBJC63WeVZetwnFXonpD
 XgSogrzmRaEcsZ32JABFxAGmU4uD+8IMbqjAJGDynGrQI8G1WDXJaIK47q47+dIlVth5bgEWin8
 W7mJws2DzekjSUB36aXEZrFE2WYEbbwJM6Uvxc+33uff4bMb8Wr4KiJFh5+SBAogDwpkB4gqxOD
 oemyf+hZFGmZ61Gp4aD2cnES+J1f0EhOHaFy0EbRrD5JFq8Bf18pgUrEhIH++QA38YOlWSVMRHr
 zxEYSFCUCr+K7ftOVreWxYwiaOM7tNdSFcZwTmVorxQnKHVwEmWSfaiLni+WbBvdVHL2umeQ0xb
 tRZZhYvOyYBBhhrlglw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5f2a94 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=BQYIXjdxv5RcgdlrVYsA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210085

On Mon, 01 Jun 2026 15:50:00 +0800, Junrui Luo wrote:
> spufs_mem_mmap_access() computes the local store offset as
> address - vma->vm_start, but bounds-checks it against vma->vm_end
> instead of the local store size. On 64-bit, offset is always well
> below vma->vm_end, so the clamp never fires and len stays unbounded
> against the LS_SIZE buffer returned by ctx->ops->get_ls().
> 
> Reject offsets at or beyond LS_SIZE and clamp len to the remaining
> space, mirroring the guard already used by spufs_mem_mmap_fault() and
> spufs_ps_fault().
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/spufs: fix out-of-bounds access in spufs_mem_mmap_access()
      https://git.kernel.org/powerpc/c/47b87f469a35b5ffc81c16eee6b13a9b6c8d55c6

cheers

