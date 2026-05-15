Return-Path: <linuxppc-dev+bounces-20971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603C9CD4851
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 13:08:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gH6w35VgJz2xTl;
	Fri, 15 May 2026 23:08:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778850531;
	cv=none; b=k8yjVREd8oMbYpcZIo57n3UxjH7R+cxQY8B0CUlneeK4lAkJJhyz14GCx39PMaJKy91JOruCtWc9TjpFy1Q+3MYQ+rSvnt04QhvzHr1xlOVoYdBMfhInnpZlUmCYRhiSLWLG5nGrws9oCEOngCk8En0s5DpObC6AX7INzlhcVB4Mvd7PeQ0tmg8/+j0f2xlsXqr6sk1u63ZwjChk+2fbQcWsMxkRhipmqn3hOCpgl7/HLwfaLOYUSC4aFRMHUikNn5O25qZdq8+GTMz7ERnvFEgrH1bxVYHDbigfVRnMw+/alA97ca/nlW8BFwKRB8VTj8v9sRli1Ny1lVJWndZ6Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778850531; c=relaxed/relaxed;
	bh=jRi7dPn0xPwwF44nsUPUR/9QOu9r5yU5sKUGfcXfjQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF/ZP8cQPZ3YTnYBTCPv0UHxtgK3Ty6fDbS7hrJXlv/ANzoxH26cqFj/ZWRTgpp+skPZIJBfy6CItqthcM8IF18AJvO9x9UX9h7mwUrvMU8GEktbCLDQDYdUrghQVb4vqZRXiBJ3gFSgSPVmF3GReCgi9Z3kjL0UpWbFwso8dWwOsacjsus/TE307AYpen0BmbxX3diYzRNRkSROn27OkHgHOCEc2CLE7iQxZIHzBppDc7IGy3PAk305zr9M+4dRExX8hp9ZTEXMdxtfDgTbtHG7oRQ5YoSYlJbptt4Zd8EjmaXCkDFrbTrNG8/GdOGJp6R+Wt73jwxVKnSvfQhHUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RGYFH50e; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RGYFH50e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gH6w24MvXz2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 23:08:49 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FAlpKW4090487;
	Fri, 15 May 2026 13:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=jRi7dPn0xPwwF44nsUPUR/9QOu9r5y
	U5sKUGfcXfjQY=; b=RGYFH50el99/T35p6ITw4Yw/r62tIvRIx/gaDibIDPFSsp
	wlAxK5oz/2rvi/ZNWO3g6+HRab4XvP2QXzWlbhQr3sgFgunaILY9Egf8lua+Ylp7
	92B7PGuPxdYk4l3fYqddmrnyJXBRvvgQY+w/f18G9VF5EEOPycF3/8sP3Use0SHf
	PU6wfl6YkKVGslrCLPTedbDfs5TxzclpgyQ1LK2A2C7gZLBluBbDwNyj0WDn8qcW
	l2oyMYXfg6XNpp3vDIMWq0ag/LhD1GsCKqIbZfR3BbaYtkcqZItHqRsd1wvGdea6
	6Shj5IN7palrJLGhGUM0jneTxRU0GlzxwNtz4rSw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m93ua8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 13:08:33 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FCsBbj022227;
	Fri, 15 May 2026 13:08:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcbm8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 13:08:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FD8T0F55443788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 13:08:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 527A120043;
	Fri, 15 May 2026 13:08:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644EE20040;
	Fri, 15 May 2026 13:08:27 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.96.145])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 15 May 2026 13:08:27 +0000 (GMT)
Date: Fri, 15 May 2026 18:38:20 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: Gautam Menghani <Gautam.Menghani@ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/64s: Fix the vector number in comments for
 h_facility_unavailable
Message-ID: <agcaxAANsk5gNzWX@Gautams-MacBook-Pro.local>
References: <20260511080412.50722-1-Gautam.Menghani@ibm.com>
 <87fr3vvfvq.fsf@vajain21.in.ibm.com>
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
In-Reply-To: <87fr3vvfvq.fsf@vajain21.in.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: dzs8Ch2V-41uKQDwaGR07m7Djh1pKAUf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEzMyBTYWx0ZWRfX3znBzUxpRPMS
 RreTmCo36fqorD94ALrDRhvvXK8HgoOr93qAO9+EhQE6xYqC1Ksek6U27visXJvgr+GwjkPvZWo
 s/Her1O1/p7hy3wH1qr7nQD1uSkZT9byL6BJyCRAmh+o0KwWgDlKg/PruC5gtfdekDVV3O0fi0D
 VLuUjBTdShY3zqD+f9pLBrKzJH8vX4c60KQYKTPxwzVsux3N7E1liWIvtRYnLtqABfXUcX1QYEp
 US84TSZPj3z9jOzO8J2L+Yap+JzSw5KHKdj5R/o7PqT11tPGJlvDh5KULKbtKNGI1BclkAHo0yH
 OETHb2v8Srgbssa59a2oZk+AcZCQi5Arq+UO6gcARBlBygIqkAFjIsveLA3wkiijQv5JAyFyGbO
 qHGgjViFV7+i8qVCQx4fBXEMoaPXI+6wG6qh7KWNrVHh13DzcC3Zj/uw5U3uGnJb1ZhUEdK0d3y
 HnQrk2n/i7a7Cugv9LA==
X-Authority-Analysis: v=2.4 cv=ZZEt8MVA c=1 sm=1 tr=0 ts=6a071ad2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=sjeT_KK2IyOrXBOZXBIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ZjZGrCugJOQQB92ZOLJ9eYiqP6mZu8Ir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150133

On Wed, May 13, 2026 at 02:35:29PM +0530, Vaibhav Jain wrote:
> Hey Gautam,
> 
> Thanks for the patch. Since this patch doesnt have any functional or
> code change can you please put a 'trivial' suffix to it patch title like
> [1] or some other suffix indicating its a non-functional change. That
> way maintainers can easily pull the patch without worrying much about a
> regression.
> 
> [1]
> https://git.kernel.org/powerpc/c/d2827e5e2e0f0941a651f4b1ca5e9b778c4b5293

Yeah I've mentioned "comments" in the title, so I guess that's fine?

Thanks,
Gautam

