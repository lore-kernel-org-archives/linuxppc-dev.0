Return-Path: <linuxppc-dev+bounces-25464-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D00C55ABA
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2026 04:17:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFvB920S3z3090;
	Thu, 06 Aug 2026 14:17:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785989825;
	cv=none; b=D9JdftEojBiDTDi5yZn5/Vvm0B5ZSuNKtUh/rk6Wa6UWM+KZjz3jUJ+0PqwR9B4TVP7Yav0di52biEy8/wP4yCzQb/Zf70Max7RwzxOz76f3tgZU7/wFehUR86FHzvYuY4AzlO82FcD3/WrLAo8EiHAUmanoUDquLX9N5sLyKQCAQr2Oplq4SCYwGF0N0tpofU5jc+cZim/fQbqFwqJwp4+EaM+IMPJCnl20iue5/fMWv0C/lMpTAgNnl9q5CwPYCj34kEzemlHQP4ybr5UXhQI09Wmr9HTaWdA7VivsNnyFEj/r0bCzbWK37wVm48fPDog3IDxyjlltchy74R1wmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785989825; c=relaxed/relaxed;
	bh=x0VVkLMR/hGrHcgCpSJQ0PqiF+s4nKSVP0fVvBdJUqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LanSW5UhPiGYk0yRHoGMQhvS8L1tSrRe7srHbI/O5JLTbJnE+DzJkMTwZoLEAwcc5FN+mkpY8LoFyitJB7p4/n5Ba4ZOqnIo7bLj7S+23tqKDzsHpFcaLjSNDQfVkJlyXea1ljURGzoXQO/2IL5hEMdl79Ry0ff8/tqYQjlETxaPcCf3M2+uxaK9dPzhjixuwLDmey3r4W6zY/WDJOkgvXMxd7yEpuLV8XsRbJBvQRjqqKNBWGvtmO8EiA0r0nRYC9qeCt22+yA0zM6lHZ98cB/fWmnj3IHwVUNtFTHvD0tIuxjpyZTxCEtIa3ggyo1PSdEt2UsISFhcj74VwOVYEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nKB+4Pjm; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nKB+4Pjm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFvB83C1Pz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 14:17:04 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NllpB993261;
	Thu, 6 Aug 2026 04:16:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x0VVkL
	MR/hGrHcgCpSJQ0PqiF+s4nKSVP0fVvBdJUqg=; b=nKB+4Pjmu5zGhuJnYZHd4o
	oNkg/xADXWOR0nXJKFxTtUjKdV0tvGVtUNr+Yb+KoUzUa74S3rCPnViOOYvXikZW
	YtRaqIYqXS/sXmzuzAWKxUV8hK/hXw4qFPWwS+A4ZYHU4XnMuVOrJ3MtdlfpMSHv
	hPeSqHKgqKl4WZvmnh1OczZ4sMNPrgpX8pUGw83vP0wyE61x+0zDXM/TxqNO5tA0
	S+ocClVfKEUVv5wVDhWiF42bhcUT2nivSutzC/z9EaRgfTUXnQOocBuQwdGQtk5s
	T+gWyQhRi38CCeydREXWvfW9irdjp6+N32FwfimpT1ys/Tn5t0I0/ossChlxgK9w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gdv19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6763uIjH026698;
	Thu, 6 Aug 2026 04:16:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4k9kep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 04:16:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6764GZIp45613420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 04:16:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F233320040;
	Thu,  6 Aug 2026 04:16:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 050F120043;
	Thu,  6 Aug 2026 04:16:32 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 04:16:31 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
        memxor@gmail.com, hbathini@linux.ibm.com, chleroy@kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com
Subject: Re: [PATCH v2 1/2] powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()
Date: Thu,  6 Aug 2026 09:46:30 +0530
Message-ID: <178598971877.942627.13081813570192663692.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
References: <cover.1785387718.git.skb99@linux.ibm.com> <e8e582fb425db165a72f00e3337cdf4c6ae383ad.1785387718.git.skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfXwnNV+zBGLAsu
 pH5Vs7FdP0fwcKGmOaj0nddk6OQDZv9UFvP6lHwtJSnJbZgcS665Byr62Mqqth55tfENOuxLcYF
 LvvzzjtpuJ2m9J4yS3ARrnVVzaPUnzffuVSaFExAUnmnB9af6YfKzkvD0xckYBw5eRkiuuDrxIF
 LP/Ls3JgdMukxIR5mBqQDbuA3h1mTwEkHSSsqrcDxIwdaD86WDYXf65/Ik1l2ETpAjmxjXfcN5a
 4DEj7eNo7c4Q7mk19Fm/qEYnNJvxIxyPOVGB83wOvKOZZyxFdv2lo62bKhtrXiK4e4QmnAW6FT5
 dLW0lABQFD23TEbR6Rj64BEQ0Po6gz+BJESAOojrhAwvBDbXZkgTV0SZuQw1M271BIzuNVhUQec
 LDngrbe7dNpziroHW5mn6PeeE3yFfaKyPsQk2ptCLJF0ZqNrB4bsFDJpDfph+b3bPsfkW+ikVzw
 PnXDWWD3rHjU0e5mMUA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a740aa8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=PYhWMvAcGiom0epyy1YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mK-F5A29MI63cB6GShHH3wAVyVJ1jBWa
X-Proofpoint-ORIG-GUID: _Vla3WCVPhYqydr0C6CEKJaHrdYNXqp-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAyNSBTYWx0ZWRfXyn5QL39qkWcg
 4Yj7rymqdWQCuQyJYKQwlsssbaG3jR+EjqngahzToIxf0DKuuPqCmnk/7pY+9gs8kYi0Jh14T2Z
 V8eIe59VU6PcOcDdhvZELK0DlVXEQ20=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060025

On Thu, 30 Jul 2026 11:16:02 +0530, Saket Kumar Bhaskar wrote:
> With CONFIG_PPC_KERNEL_PCREL enabled, build breaks with below error:
> 
>   CC      mm/dmapool.o
>   CC      fs/readdir.o
> arch/powerpc/net/bpf_jit_comp64.c: In function 'bpf_jit_emit_func_call_rel':
> arch/powerpc/net/bpf_jit_comp64.c:475:13: error: unused variable 'ret' [-Werror=unused-variable]
>   475 |         int ret;
>       |             ^~~
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc64/bpf: Fix build break in bpf_jit_emit_func_call_rel()
      https://git.kernel.org/powerpc/c/e8ee988c0087248324dbd3da486d22045e4a4079
[2/2] powerpc64/bpf: Fix build break for arch_bpf_timed_may_goto
      https://git.kernel.org/powerpc/c/e1e5e682511eda648aa91372542cc8f665ad0bff

cheers

