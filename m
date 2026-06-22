Return-Path: <linuxppc-dev+bounces-22866-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 150F7CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jun 2026 05:40:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkH946hHQz2yVP;
	Mon, 22 Jun 2026 15:40:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782106824;
	cv=none; b=SZgNPZwgRjAREdZxtdxf+MUgIRqdGJdzcDEJdbOyHpoJJ9FKv7nSd72B4pMa9vVRfLkvP5oaLDK5PQx93SsCKCt6O3TsXc6Id3kYYs7I32AiDH67Ui88Ra+DDMa5OGYSIhn1rVmUjBnDjdbBB5a4QBagigxZFbgTb0O5xMdW+1KdHzE6AjeWf0Rj71hV2TPlc5a2dsNiP3uN9R5mPvVZikVk8t1HpVAmDbSwZniDNo42sysfh+wED5bUXt0Lhe93GluOzI2h3YldetgSeQGSGohq429MOdMZXd58YOEbOI+haX0a85E2TdybwyTnzGhpgGSwDUGEEFSLik7kt8lo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782106824; c=relaxed/relaxed;
	bh=jm2AmFyd/QI77zwCG7lII1o6QQJL339NSiscJsVLusI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWuQ4nDJRIFbBNpVzoyUFiPSAkp1XyVkX1Q5mucP2c77hvE9ifLYpVsurhIs+twz0gWqgwgbhnc9qT0FfGMhbUb+uqL6rrBsLnnadPhr3jyAD1LbMVTaIAvH/Cagjm+2g5XDclvzUkbodNdHeLhum5uyxSQd0eqIHVZpO5vKbdA4gv35qYvWuPBvUR/Q2I4/4qAseGSUS2H6LpBnvlwa4Mxca/jsLZOv07ltJF3CfIKKTFZp7fvd8Hi0bjlo1BNkUgHz2zppNgEBdszc8SViO1vKhOPVQgyycgD53jc1/tQKXvqLF0uYc0RNHYXqOpTqVdYQ3XWe5KODN75Dk9KA5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IPhc2pEh; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IPhc2pEh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=shivangu@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkH934NYHz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2026 15:40:22 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5IYoY1656892;
	Mon, 22 Jun 2026 05:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jm2AmF
	yd/QI77zwCG7lII1o6QQJL339NSiscJsVLusI=; b=IPhc2pEh6Hri6NvgZhBxOT
	mUxzlbBriV/LkG5o9AuRVIj4ml3j4HDRK6G2SmQ05f6ZABwzGm1FHfVjGtPfI4Pn
	Grr8k9f1D+m4jqaPsXs8BndoiOecJo8kc02chVRYT6FUU6BysMLnICHUS4kN+ZMp
	/rtujLL2EIfSDuEIdSzAG0jcabFm5iLkOYJZXyntKb9JjO5zGJPll4apiu74l2hG
	XkuoNSAXqp+SklpVR7oR0vSNGOe1O+u/yuqwfHhExEI9ga3hEsa5eXa22kiL99Zy
	D01eXvO/vVUQZ6eytpWXAtLdjYV/uGZr0C93iSNmLTsAIngsFDMuAVoPekfHVipg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk47bc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 05:40:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65M5YcFV005111;
	Mon, 22 Jun 2026 05:40:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyc9ma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 05:40:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65M5e0qa31392450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 05:40:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68D0E20043;
	Mon, 22 Jun 2026 05:40:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDAE520040;
	Mon, 22 Jun 2026 05:39:56 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.124.221.137])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 05:39:56 +0000 (GMT)
Message-ID: <009aa525aaa33d5f64d291c53adf51bba55b4e16.camel@linux.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Cache OPAL check_token() results
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, thuth@redhat.com,
        Aditya Gupta <adityag@linux.ibm.com>,
        Mahesh J Salgaonkar	 <mahesh@linux.ibm.com>
Date: Mon, 22 Jun 2026 11:09:55 +0530
In-Reply-To: <31904199-2635-4c0d-a725-53665185fff8@linux.ibm.com>
References: <20260601112520.161605-1-shivangu@linux.ibm.com>
	 <31904199-2635-4c0d-a725-53665185fff8@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA0OSBTYWx0ZWRfX2/xjCzmpHwDg
 W70TAlQ38wbxD9z4vV2vO4MRV2DpgdYAkk1+/PWNCZPujuTsV1qmmBUonDcm71cQIduNgxbTfw+
 1P5mnKJ35870c0Y16CNoWhkYlnq6xSw=
X-Proofpoint-ORIG-GUID: SjGvJqvPOSWU-IHt9kj1RduoM3rtT_8h
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a38cab5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=d92W-HUjIstk2f35YVcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA0OSBTYWx0ZWRfX0MFFUH51kw1G
 oZiHN0sA3XwPM3sRVPD32TTYbzbByz5acjOYM0h922uF1VqnKbhOQ09B62nJxKcJ4uPeoJaeSwn
 7C4GO9fFVqkebYzbz16jU1pNkpZPCxCLmCHjOLkJyf8tqoit8I3COx7oIbbZllaklgRbr997wmD
 gKS+ZQBXIgbfG6dw44jPuX8OGcKl3zeUQ+Qyx6jNgifKOVp3QetyU1XI820jeVjtS7ZyKnERGfA
 k+FIbhMigAmT91IsgJDa3qf/WEj4nRLcvd18418Y1vVwQZ+XMEM4uwswBWd3zwEG3k0NJHdKnED
 2eN5++sv/MNSgZLiq7vgcPZLRnpvmoacvpGCe24KNS7kVcXXafsYntfiG5alYKNHQawXX43RgBZ
 ++48KEjmwYfdGwtBPlbm6wZolsrye6Od64sGASDrDurPe3nUmt3TE0JPbf3FChdOUwEp8xbQyjb
 P0vZfcV6FDdtmY/Bs2g==
X-Proofpoint-GUID: oOiS0YYUPf0oylJXSoInk-9BvaUQkd2X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220049

Hi Sourabh,
Thanks for reviewing.

On Wed, 2026-06-03 at 09:22 +0530, Sourabh Jain wrote:
> Yes, it is a good idea to avoid making repetitive calls to check
> whether
> an OPAL call is supported by the firmware.
>=20
> But it feels like it would have been better if skiboot itself
> advertised
> support for OPAL calls via the FDT, similar to how RTAS does.
>=20
That's a good suggestion. I can take that up as future scope of
improvements.
> The current approach to finding supported OPAL calls is:
>=20
> - Discover all supported OPAL calls during the first
> opal_check_token()=20
> call.
> - From the second call onward, check whether discovery has already
> been
> =C2=A0=C2=A0 done, and then test the token in opal_token_cache.
>=20
> The approach looks reasonable, but how about doing it this way
> instead:
>=20
> Maintain a tri-state value for each OPAL call:
> 0 - Status needs to be check
> 1 - Supported
> -1 - Not supported
>=20
this tri-state implementation, maybe would get little hard to
implement, along with how currently i've designed the test_token call.=20

So currently on the first call it caches all the results. and then just
returns the output. But as per your suggestion, first one would have to
set all to -1, then set the result in the token that is being checked.

IMO, the current implementation is slightly more clean.

as per your concern with opal_token_cache_initialized, I think we can
instead look at jump_labels to solve this. First lookup is same, but
then we asm_patch the next lookup with nops. I think that would be best
of both worlds.

>=20
>=20
> > =C2=A0=20
> > +/**
> > + * opal_token_cache_init - Initialize the OPAL token cache
> > + *
> > + * Called during opal_init() to populate the token cache by
> > querying
> > + * OPAL firmware for all tokens in the supported range.
>=20
> Seems like the above comment is not correct. I don't see below
> function
> invoked from opal_init().
>=20
yeah, I missed this. this was my first implementation. But turns out
alot of opal_calls actually happend before opal_init(). So i moved to=20
opal_token_cache_initialized method.				=C2=A0=C2=A0=C2=A0=C2=A0=20

Regards
~Shivang.

