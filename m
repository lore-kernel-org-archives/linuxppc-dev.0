Return-Path: <linuxppc-dev+bounces-24107-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75613C44506
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 09:27:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzHCm1CWXz2xlv;
	Mon, 13 Jul 2026 19:27:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783934868;
	cv=none; b=bgimBI7mMeTJtiO9FfKeJuDU15gz8+63kWqOGagog9BOgT9HxtYhBXnJMLq1JnCekP/PSF4ezAASDFSavKo4okwCuGPz+UDXMUFeRDPCDfXBW13yciGmydjm1LyVyEQxxc0bmW86ipk5/VrkQ/DDjO0yeQ5YKR5HsHvYg4C2Oq+QhjGQwkNwkMNOhL2PsJb9fVmn5xWhmwmMDqibz8iMLGBZ/AsOfjIxRrzC59xHdVNlOL+6ACYAtfjw4eI6Va6o8hjVMbUC/sn6A/JfOh2u2sEL4xrOKIquM3DQOrwxUQ1sDJOqGUnDvGzN5Kj52j2mPa7hFXEJ8s9sjY9Oi1HBZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783934868; c=relaxed/relaxed;
	bh=PR092mdGsoe3SbzvnZtVW8Ro9KyMD2O/0hXxEWFUOEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEXpgnstQW+f4/PZqF8+Uj6K3CZfPY8OBMTjf+L4TN5q6cq+VrnlDJTe9WphTDgj+vTZOXep+oCl9JOmiTwlsaIFV169YW53J1Qipf0ObZPxHsxsJRJDcuQmf+q4YonTF5TN82uiAICcksMkAFCMyoaQP+0iTYIQLxlmi11eMBMVZ9hCRJmKC0DAt9U4poDYIo/ybq0Au0SrdDD2MpahdaU9TJhtL4AaKyqW9AFY73bccSZczSTZuUg6ww1cqk341JBzdhDyFn9PhMQ/xfMwmnc36pr/EnVpRxo0Lo5rgv3JGEAxRsQQKKGU612nLf2WmwSk8YpFJlK7/WRqqaFiKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JyY+ZVEz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JyY+ZVEz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzHCl2l65z2xQ3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 19:27:46 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7vFOE006565;
	Mon, 13 Jul 2026 09:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=PR092mdGsoe3SbzvnZtVW8Ro9KyMD2
	O/0hXxEWFUOEQ=; b=JyY+ZVEz0z2RSWxwbcegX+n1eldVyugm2Ezzhii0Q18rr3
	mtfnd7t6NQeSYnv8ZQcTXHwhYkofQeCEEHsxnw4ex4zCYJUySGKBu6MmsBInGS9P
	YL95YT+ABj0cWzpqHrtu6LmSfpHglDYg+pWzFuLHa0xGx/QtuBl47wWyBz7jwHZr
	V8MGYeKfPWLLZZbhJ6wqzY2s642Qxsd69JHmTtilkpgm/D8U/Vq7KZt7ZkFJIq2v
	ALa8eaK03A5vjSgFi1nW7VtsZhwotIZAFZ8srErym332fSfWHkSHMgmn/daZ8Fbs
	lPJCGTBUk5047Fu3rYMUGTFnncXSHFw8QlTPV/bA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv330cvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 09:27:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D9JasX013748;
	Mon, 13 Jul 2026 09:27:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pw64e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 09:27:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D9RJXa21365180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 09:27:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 043CF20043;
	Mon, 13 Jul 2026 09:27:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3D3F20040;
	Mon, 13 Jul 2026 09:27:16 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 13 Jul 2026 09:27:16 +0000 (GMT)
Date: Mon, 13 Jul 2026 14:57:30 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Geoff Levand <geoff@infradead.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/ps3: Remove unused struct table in
 setup_areas()
Message-ID: <20260713145642.aaa21051-11-amachhiw@linux.ibm.com>
Mail-Followup-To: Thorsten Blum <thorsten.blum@linux.dev>, 
	Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260713091731.97212-3-thorsten.blum@linux.dev>
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
In-Reply-To: <20260713091731.97212-3-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5NSBTYWx0ZWRfX3TU+9z1OQHhz
 VrjTR3CQGTMgS3MbzuZ37s/9lNUL+tvQt1/dKVcK19/eUU0nkucqP7X1ZAgANIe8iY6IChEUSZO
 QUpzxiHbaeeuGf5UX5oOj0kxHoTwrko=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a54af7c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=tBb2bbeoAAAA:8 a=VnNF1IyMAAAA:8 a=tDlUD9aaDW1ZiZdEypIA:9 a=CjuIK1q_8ugA:10
 a=Oj-tNtZlA1e06AYgeCfH:22
X-Proofpoint-GUID: GfUV5dN0PB4O7Mg8SrUEZkq6_76Erl_n
X-Proofpoint-ORIG-GUID: vmvRo6sn1PvmpKZrUTGOWrrFT4b-Hb2X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5NSBTYWx0ZWRfXxaBNiY/PQ3GQ
 RnWD2W6vEPe7Kj9oB6oEVSgjGuIUFpBnsHdPdpQcaUfEdd4jkf6fbV8luucLNiFGiNA+WpKZ8gT
 l9TuXF/9rFpwvDj98un7nIbSar5LXZ+FAN57g4Lo/VFSL2hWPVcarfdHOFzGEOE4DHYRuUstPPL
 3To49iNbTOvR/sCHfGrhN3hUXCAYlMmeyq+fS12XMPqP4nBB0OFIqg2h2p5jvexlA6zYLHw006D
 FOniZMF1KV5i4aXocwJVWnkk1jkW2Dq5I0zEp/cK3huJ+W3PCsDFjnDTi9SDdGxdzCtdjJ0YylZ
 mOluxHM4kPJGoHZ9+BmFTFt7XgWOglRMe4Eul2qB//I4Vs/tLsE5/Py620AdOJx0ttYNkuA8Dx6
 h9WbcWpeYeaE8BpovFFPaSb19+Jysj7/jd4L95GyP/QntPXuFh+10T8bNCDiLg9z6GvpkZo/a9v
 KmNJiu8xWPHFf1pMg2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130095

On 2026/07/13 11:17 AM, Thorsten Blum wrote:
> The local table structure is not used - remove it.
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Drop the %0 change because it is valid kernel-doc markup (Amit)

Thanks for addressing the comment and sending a v2!

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

~Amit

> - v1: https://lore.kernel.org/r/20260712151300.3664-3-thorsten.blum@linux.dev/
> ---
>  arch/powerpc/platforms/ps3/spu.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/spu.c b/arch/powerpc/platforms/ps3/spu.c
> index e817def7f424..2c785bc72565 100644
> --- a/arch/powerpc/platforms/ps3/spu.c
> +++ b/arch/powerpc/platforms/ps3/spu.c
> @@ -190,8 +190,6 @@ static void spu_unmap(struct spu *spu)
>  
>  static int __init setup_areas(struct spu *spu)
>  {
> -	struct table {char* name; unsigned long addr; unsigned long size;};
> -
>  	spu_pdata(spu)->shadow = ioremap_prot(spu_pdata(spu)->shadow_addr,
>  					      sizeof(struct spe_shadow),
>  					      pgprot_noncached_wc(PAGE_KERNEL_RO));

