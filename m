Return-Path: <linuxppc-dev+bounces-25119-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1681C55162
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 14:39:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9sKX1CKDz2xnp;
	Fri, 31 Jul 2026 00:39:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785422368;
	cv=none; b=GMskgWvwaKRdBjke+o5R515K93trRBJ30jZ1yr2OY+kMJtDsdYRRt9AkATJ9qHudRuTAWOeblOEXSsuCN+OfwWO0u5cP+lq9xPkcfHIETbSP4neU/EPJBOlQxsL4egXOzkUde1OfsFToi//EO2xr3fZ4+mtXErZjrK/J9wEEPWUI4Xg6hVdjPbmUFloUkfrytbWuAQd/1x8Nfp8GJfUc8EnZZ2dQ+uhgF3aUhjYDrCTOQl+TXGMFY/n8uhrq7mu0j4c8QIdV6KwkIOP9LK5a6zwSjDNJUSlSEAOrptPK9eScmW5N8RKKBoPR/ZT2fGyZfrV/lQd4iAHhnnngoVZVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785422368; c=relaxed/relaxed;
	bh=GGOTESLRg2rKhvPJ7aIZ7rRNo873qEi/Zr408zmQIag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiV201mC2YdsDRb34lKR7ixicctHYgiHPDDBK1VyeBvRvPlH7xXav/54j74v8Zw35vkfMf9CCmHannKtZ6KYFD/XBEjPm9H92MNwCwtMVGUuqlkh+tknvR3AFwKKCCrO7m1hOybp4QViobOlCWRE19MKf3d6mB9h2Vl9X0MJ0WpI/u11QZefbIFFyWkXT4MEnzg4ixK1ahrBZgVqgIxGLVv10SzzNMgljaxDFrqLGGbb9IPX7WD+EblweKHrtiqxDsUqdDtYnr0uW7gHkg8P3g2sKHWpobI3sHMJU0tt3XYHtWCKXzr9LoDTqLogOHOxnX3ZQtOnV20dVcLJ/LeGxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y8Uv88TH; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Y8Uv88TH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9sKV1htbz2xd2
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 00:39:25 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UDHer53019984;
	Thu, 30 Jul 2026 14:39:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=GGOTESLRg2rKhvPJ7aIZ7rRNo873qE
	i/Zr408zmQIag=; b=Y8Uv88TH1AJptteKvczMPuZ+q3ATjRcbimbI4rHJVLySNw
	T9B0wfsZG9QV65Bh3B7P2ghq9mBhntTQz8hHlZsK1sSQQSnB/nS0SN9M6NfTX8X0
	scQPZV+13MfXgKdXzL02PU4JlYy5/2RvdnrJKwUuKJLsc+TYoam84g86+zKJXFxD
	D/mfnu74+Y8C3rhhEw99wKtsdxKis0xkzTw7s+7OdbPHLLlmfEFmroG+cAB74pNj
	pHjEO6nut6gM05hgjqNHFMsG2/CTqg9wlV4cmGGbUbkzJSozc78N3ZiZhex6W8ro
	UgmAcltWnF8o9FMFcbCoeSRGmPq5CbZAQASsxcQA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyjfcsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:39:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66UEQKqG007842;
	Thu, 30 Jul 2026 14:39:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgkkft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 14:39:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66UEd9bV48693638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 14:39:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 793092004B;
	Thu, 30 Jul 2026 14:39:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 029C120043;
	Thu, 30 Jul 2026 14:39:08 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 30 Jul 2026 14:39:07 +0000 (GMT)
Date: Thu, 30 Jul 2026 20:09:36 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/serial: Use generic BASE_BAUD in asm/serial.h
Message-ID: <20260730200107.2d838459-3e-amachhiw@linux.ibm.com>
Mail-Followup-To: Thorsten Blum <thorsten.blum@linux.dev>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260729223807.570178-3-thorsten.blum@linux.dev>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729223807.570178-3-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfX1PdM9HjmjxWC
 t6C4MgKummpwD0mA7728roLCUBsLxfczvNrAWwDV40+hBznrSES0owdsCecaMOOD56HIb9ppP+7
 GwxqLhP90PI87Dnve/crThHcs1AzMcs=
X-Proofpoint-GUID: evN2iinnBxfw-HdQjByx-Q9phb1kSIxh
X-Proofpoint-ORIG-GUID: wZlWm6Cf4XwV3tkaI7ld28zuLVgIMJmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfXwaStSJ2QL9xO
 muH66b3TRIcTIzFG/ZmjVI/mpJaSAJuJ5Ykf/Voa/hxjhNmG0gDUqvmCGXlZGdnT79B4MiJUznI
 wZuljTr6ww0UqHVD+1mxY86focJopZ+h/ax4HwOF4iBE7MPAV7XrImi/RRBWPK354tJ466lu800
 2Y7MzPrdGcMlAXZqJdgNtgSueCKmpEDuFqEysnPgg09CUl2QTF6wD5w6PBrMVv465PVlXTl6VBH
 x4kgFftHIfVEoAO2qWh2F8sz3cZwGmB7D8Tk+D30UTHZ+pe9I8TK+GAmbq8TFLm1tlX3pzGnheq
 GagKmemGOEntqpyGOLvc1kq7+sZTAq5PEa4LHE0Hr+a0/MrK+Vr9rPFOAI7BDwRdxEJXALiH7GW
 1blWMa9sQOEW93SJ4NORn0nggPw3nXm7DK0ypvDjfWgd3DYEvwV0uhCue4ZJG4+K/3N98n9VlmI
 Xwy2KFI4ep5bcY0L3XQ==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6b6210 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZknpkhpxtOl38aixZ-wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300109

On 2026/07/30 12:38 AM, Thorsten Blum wrote:
> Include asm-generic/serial.h and use the generic BASE_BAUD definition
> instead of redefining it.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  arch/powerpc/include/asm/serial.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

> 
> diff --git a/arch/powerpc/include/asm/serial.h b/arch/powerpc/include/asm/serial.h
> index cd6c18d0e66e..eca0ef56f874 100644
> --- a/arch/powerpc/include/asm/serial.h
> +++ b/arch/powerpc/include/asm/serial.h
> @@ -9,8 +9,8 @@
>   * through the device tree.
>   */
>  
> -/* Default baud base if not found in device-tree */
> -#define BASE_BAUD ( 1843200 / 16 )
> +/* Provides BASE_BAUD, used as fallback if not found in device tree. */
> +#include <asm-generic/serial.h>
>  
>  #ifdef CONFIG_PPC_UDBG_16550
>  extern void find_legacy_serial_ports(void);

