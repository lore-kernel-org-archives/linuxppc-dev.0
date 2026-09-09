Return-Path: <linuxppc-dev+bounces-26883-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5627C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:19:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrHc46Xxz30WR;
	Wed, 09 Sep 2026 16:19:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934764;
	cv=none; b=oNLYw07R9Hn4mUstDelljqY5pPNeNUESB4uz4zTgoODwI6BAYq3ZMpJyoHAZpje7qaaijY2XxnKP/0gPci8UsXRrjtR8pxRA5ZM8UfQg0v4L2T1gOXGZpAypG/ZtxRrSzTpg+Br98xVoDK1P5Brny3KhrU+UimWR8k8utgDAFMwnYoKCBgLXxT+EhwPRAwEjHH5PncI5suDUvxHJAr3RYVfK97L5t6nXxQGs3Wb7FBEl2CyEhZqt96WlDj3DsUVQKPtRfx2ysIhquJaDH4yKYP0vGMX8WA6hn3we7J9A9Di8LPxplD/PcOsyVFjekMcC5uZZ2rzWv7us6LeafiiHtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934764; c=relaxed/relaxed;
	bh=aetJS6kL2F2J92CPFETCFlhtUvGFQLN4pUA7GL9w0Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H71vfn+dm21egUkuHVqoctQ2WKnRH7CXa8NsYK5ydkMwEtCM+J/cw+Ltq0I1IvBswaxgQ+SuxMmvzvV0lob0GLUAbsoa9fP9eG+SgVk/oBf94eTYbu6dnYSqbID5WMoZ+DKU1jB4LHc7NHYfcJALWY/+7c2HT+It/wKP1pXT+IpcVPSwnTV3KZ9Fuv9FcPUJEebI/VE7ivid2Cj4xjPitUN1qLR5oGaAxsTT4dHg8TnkfWMAxqOhgtH/PTBQ/6eyNzqs9UqeWN4izreu+k/DUWukgbvqa4KbCjGuVPWpZF4/PYDhVWc20ryhICLZ+18k7mBZ8DHAGNrvxxX8Wc6apw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J/7u3liw; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=J/7u3liw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrHb5Rj7z30VS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:19:23 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1STJ2271946;
	Wed, 9 Sep 2026 06:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aetJS6
	kL2F2J92CPFETCFlhtUvGFQLN4pUA7GL9w0Ac=; b=J/7u3liwHgi8GwK5AqUbFU
	Dghw7hpE7jAOC8KRqvwtYT1jp+sQ28OWq51a6w4i7sSyDI49kWaQrLkS8VNRSu8u
	55Y1cm4pdlJNqdVPAbGXNeZKLSJm7LiMwjB89VG2PFWuHnWV0J3WmHyfCzKSxtWB
	CrrAWQslOgRnGj6Z3JA3JT35a7fz494wNn+UurFQX+rE8IyTLpvMTXZAuGyp9vw1
	XHLhboPKgzfN/QSnC8DyTY8HbyeEgYHd4YknBgMe/e/+UzPo2doZMSGTx/DhGPqt
	hp8jQZyEtCjaQMYLymDnmF+EaVwonZpS7rYI2rV5km3ma2gPYysIxrZa6XtvIjtQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbf442cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:19:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BFmu030577;
	Wed, 9 Sep 2026 06:19:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw8r14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:19:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896J0gI41484634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:19:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EE5920043;
	Wed,  9 Sep 2026 06:19:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD19B2004B;
	Wed,  9 Sep 2026 06:18:55 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:18:55 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec_file: Use inclusive range checks in add_usable_mem()
Date: Wed,  9 Sep 2026 11:48:54 +0530
Message-ID: <178893459270.174069.13645573174007360611.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809162403.18142-2-thorsten.blum@linux.dev>
References: <20260809162403.18142-2-thorsten.blum@linux.dev>
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
X-Proofpoint-ORIG-GUID: xJrfY1veIWE5WrJgp8r8Nl-zfwjmabNU
X-Proofpoint-GUID: lYpoe14h-MDC528E_DMn998unAibAPGP
X-Authority-Analysis: v=2.4 cv=DbEnbPtW c=1 sm=1 tr=0 ts=6aa0fa5b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=dmzOmzs3okPgUVi07eEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX9F9/3aKlOR3t
 cyFcdSNuMLiUeba6JJzwSz/6k3OJ2QMjLkoif5MzLm/5hUF8fOHVzAIT6PaBxSf055FVDlsRJBk
 cmqYBVi/pvUFf1J39CST3EaSndYJnKs3t81zYjgs1n2Al2XWfcbC7Aojr58GQAX9geH0XWpXWBZ
 3fOALHufyTql7sQinoQ1Pb37K7QWhKWKMv4tbWyF10NNd8Ldy0twA5Dk38FMGR/8R6Z9ZwREJ7G
 ErRbRAUiVKOuh+C8u0Qr3kxlm/xySk12kD1ANGtATzzob0TDSwrpEltltZsov6h3+F6U9SqSrIN
 NEH0IP6BLwdMZyKzUWTA+D4XHHK6OlwHWT8qw9lllqSZEGYV7hrqZSyHVMub2jD3WRboJKGEusP
 W2cyO+HHIoBNUam41msK+n4njTo9DB1E3CCzqNKvpz/bKpbn+IesX2OZsLJoV7wSDcfv7uuOMSE
 /pJp5LiRBIb1TJDpWow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX7e+7aQtdrZye
 sI76/smKLITOWdupRit6MshEiA+F5t3TKxYW4Qn4+1OuS+JZubsdcwZ+0TE1XF+A9u4ogHEinhp
 vl7okfSiENd6pslqXCLOiYOFU+MWglo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Sun, 09 Aug 2026 18:24:01 +0200, Thorsten Blum wrote:
> add_usable_mem() adds usable memory ranges for the kdump kernel.
> 
> The ranges are inclusive, but the partial overlap check uses exclusive
> comparisons. This skips ranges with base == loc_end or end == loc_base.
> Use inclusive comparisons instead.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/kexec_file: Use inclusive range checks in add_usable_mem()
      https://git.kernel.org/powerpc/c/c6755be4838d6ccd641effbcdc3d917b82631ff9

cheers

