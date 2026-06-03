Return-Path: <linuxppc-dev+bounces-21943-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A025DCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 05:59:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVcTl18Mgz2ySS;
	Wed, 03 Jun 2026 15:59:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780466363;
	cv=none; b=cwTX6xIpx9BiOMWvRwcq/ny1yVwxoBkZwOyQ5GuIMDhnaNLah8EjKWmUOD6UjJgMfi2idLzLfvctoVowbvQQ62Z3OSsp24YrnqY03vPNuUZWeSl9bvfm4sOvv2ZlCWWZJLbhBHy/SCwwpOdZYGoXumK1cMezP6+XpazR03L3fxfZpk9WqrAQgpM3/bCGLv7LuO9j52xkEfDExmyjo9mYde5lxkkURXUn1he5CnJq16vkdf5YXGgiDNrQKzbCUhtJ+x41J7Vjlq0gHWOg3nZkzTWvpFp9Lpt4/03MKlFCAqivKxlowgWkuNenNU/mwdVA9wvK4pv0Sj1dAfgPmYhJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780466363; c=relaxed/relaxed;
	bh=4yFYH/xPWe9Z6BdlDk1P+nnhURZtT94/ZDM3HdN+zjU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X1oNTHdwSxR0FTYlMM+8tHMI8j7pAITQoAcHWW53GeMOlNKCYynEADjC5P82VkuF0ed1G74ACRF/dGZREG9CtxqvBKELe6dVF+RUfkR+PPc/dhjDyhohJLAq0kfWl/EI7VchBvzfIyOGuilME7snallVsR+IVeISBl++T6oXXAU6d1t3WP94dWvYbd9vctwm/BnRLYBF/wQ+KObNGhi/ZLujR+qwo4EYdrh3XEZTfB9YrYoFNA6Zc2k7cP1+uveMUrkUUZLY9nLu+dTi9F9mBRgihlyOwv8U3XKylClC9+srhS2ejWKP69pj5Az7fk3R6A6stBndAr9ZrJJSv/ifRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MxIypX5w; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MxIypX5w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=aboorvad@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVcTk185jz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 15:59:21 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653512li260140;
	Wed, 3 Jun 2026 05:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4yFYH/
	xPWe9Z6BdlDk1P+nnhURZtT94/ZDM3HdN+zjU=; b=MxIypX5wL4uDpgB/z1JHGM
	bpi8ft3g3Gr9hfmBd0X4Th7I7YzHWd+C02HAp0eitG1UDpPmgi1IbiKSgq4p/nki
	hKQScHnYntGHSe9X/nM7F4WOddwzfW575z/vFO1EaFPJJxJt5vtRjKT/9ZtVGdHm
	VwWA3Xx0x6AgrA4IbeQSipXKl28rRDgF+XkDQwNdClMMYJMzkwUjU/QlfHua0YGS
	Oh4pCoIziFcuxbihByic3WDshBUfvZBDoUCf2yAjKnWOHd2opezD7u+pewk/8kI1
	W9kYtZS/mQiaFEfLfO7F1t37VM6Nm3+NDWnHSPi7Yp9YsY2zzfcmFnr/N7tRNFYQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjq9c0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 05:59:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6535sQEt021469;
	Wed, 3 Jun 2026 05:59:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhep2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 05:59:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6535xD6G41681256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 05:59:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1346E20040;
	Wed,  3 Jun 2026 05:59:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2529A20043;
	Wed,  3 Jun 2026 05:59:10 +0000 (GMT)
Received: from aboo.ibm.com (unknown [9.39.24.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 05:59:09 +0000 (GMT)
Message-ID: <d54ba34b23e83a525ca2f3bb22af5294c4c12616.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] powerpc/perf: fix preempt count underflow in
 fsl_emb_pmu_del
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Madhavan Srinivasan
	 <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Christophe Leroy
	 <chleroy@kernel.org>, linux-kernel@vger.kernel.org,
        Sourabh Jain
	 <sourabhjain@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Date: Wed, 03 Jun 2026 11:29:08 +0530
In-Reply-To: <1e31821a-2c9d-4394-83b4-e850f96ad662@linux.ibm.com>
References: <20260518050855.1147242-1-aboorvad@linux.ibm.com>
	 <20260518050855.1147242-2-aboorvad@linux.ibm.com>
	 <1e31821a-2c9d-4394-83b4-e850f96ad662@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
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
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: R208_Ny77-QjBEhE8w6Ajp24roRSVgtT
X-Proofpoint-GUID: gHtWpWbmuaBXrF6BjwLvEEI7EjLtkt_q
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a1fc2b6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=-EqLoAvprTokvDOC_UsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA1MSBTYWx0ZWRfXyC8vhuVKOljS
 NkOdeMYFOT8BgNRjMeT/lchyTHIxuBa6xUJdmJmUVoJAS/xIaDsHG94seR0A5NDVJXYwnt9Iv18
 dy1JWvI154sTQvk9lEbbo62Y4gzWEHUj48uyniArA6CrJ6+eUcn+aFTRGtK1ZilvPN3YJzeZOKj
 Iy0VGJDTWhG5md3xkJ2PagcX8c63X/TOTmpQtz/2iAoEPecyRNLCJ84HiUyntiy+n0tjwKfsIpa
 2tJ4KGMEzRz21Sq7pdpPcmxlRIXuUdSYQjJvFWTSFxsgwWnG/Scmwmo3W0DDauKX5PlMQn5S5yQ
 6LRM26/0I4v0g5n2r0zXH02fcJ7+jQuC6KdISLN7Bw2DgD9OtMMd6KXiUXUREa3OY+OZ/oQeSdQ
 vjs5/VMKSvoBl3AGOxwXzQOetiF7FDiSvXFmYkoPKAloD1YsVYneyIW1FDaBqlozpgTrX0MwZ0h
 I1dmIhm7oFC9r4hiKSw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030051

On Mon, 2026-05-18 at 11:43 +0530, Shrikanth Hegde wrote:
>=20
>=20
> On 5/18/26 10:38 AM, Aboorva Devarajan wrote:
> > fsl_emb_pmu_del() unconditionally calls put_cpu_var(cpu_hw_events)
> > at
> > the 'out:' label, but only calls the matching get_cpu_var() after
> > the
> > 'i < 0' early-return check. When event->hw.idx is negative the
> > function jumps to 'out:' without having taken get_cpu_var(), and
> > the
> > trailing put_cpu_var() then issues an unmatched preempt_enable(),
> > underflowing preempt_count.
> >=20
> > On a CONFIG_PREEMPT=3Dy kernel preempt_count would underflow and
> > eventually present as a 'scheduling while atomic' BUG.
> >=20
> > Move put_cpu_var() to pair with get_cpu_var() so the percpu access
> > is
> > correctly bracketed and the 'out:' label only handles
> > perf_pmu_enable.
> >=20
> > Fixes: a11106544f33c ("powerpc/perf: e500 support")
> > Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > ---
> > =C2=A0 arch/powerpc/perf/core-fsl-emb.c | 3 ++-
> > =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/perf/core-fsl-emb.c
> > b/arch/powerpc/perf/core-fsl-emb.c
> > index 7120ab20cbfec..02b5dd74c187a 100644
> > --- a/arch/powerpc/perf/core-fsl-emb.c
> > +++ b/arch/powerpc/perf/core-fsl-emb.c
> > @@ -366,9 +366,10 @@ static void fsl_emb_pmu_del(struct perf_event
> > *event, int flags)
> > =C2=A0=20
> > =C2=A0=C2=A0	cpuhw->n_events--;
> > =C2=A0=20
> > +	put_cpu_var(cpu_hw_events);
> > +
> > =C2=A0=C2=A0 out:
> > =C2=A0=C2=A0	perf_pmu_enable(event->pmu);
> > -	put_cpu_var(cpu_hw_events);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 static void fsl_emb_pmu_start(struct perf_event *event, int
> > ef_flags)
>=20
> Thanks for fixing this. Looks good to me.
>=20
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>


Hi Shrikanth,

Thanks for the review.

Regards,
Aboorva

