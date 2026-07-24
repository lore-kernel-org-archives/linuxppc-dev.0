Return-Path: <linuxppc-dev+bounces-24767-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C8DC531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 03:52:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5vFy3nk7z2xYh;
	Fri, 24 Jul 2026 13:52:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784865158;
	cv=none; b=jHimIPH+FhrJw8aaEnwFgdU1eWijUAGoI17m/fhGFf3G0LDuwqEhgZn9htNdE3PeRAvbYqVIb4rYuxHbkiFQ20j917q2XendgpiKyGUFhiRgyiHZsq5yK1Ou2eupDf1N07u4ym06yuqky7BLcyohPNd6QxisoCRO4DwP4IPnYlS4FKTlDEZ0ZRuj2MSoMygazgyf0ulOJLfnB0qaAwbTWqELJVF6tjeBSUR97wduDHHmpmtClunrAjAG1E3T9uXDjzK0upPWb1YGFFx7MR4PlwQq0lAL281bXzGE6vQ28oqgDcqBOT0kIom5/gHMliAb0SHDa9OIcNWV14QB78I27w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784865158; c=relaxed/relaxed;
	bh=AnFlBDvFE4f4gf2zpigswmnFOjeM7Bj+4bzfKCuL/4k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QIgRNrjFnW/SrWFd5XxhiOfNNjtbKaD6fz+vDYDy0RTM2qjzClI56Nm3tNhAISBCWNYV8Eiu/pOr+FzJLiEuq5FThH1YoSzlt4MPQzWUUwD+60I7Zi/uoqZBixqMgB2NSfbliimhtlb80GgS4DzcOc1NmIDrMMsMQTAhW5HEx3/mV46ZET2XuStun1eQoiauy3j0Nff8hN+ozsj7r9YHUuh1P4nmu3hrlVckAqXxUBqJdMA1aI/vFP/zUhJFPuoW9L7N/UEedJ7WGFebG40I+yeqqiZ1aaLpirVFt0CbMq2MUp6zNrPdZaa21XriLp9xtJ/cC+U7Ts5M2Z2YnU6dTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I6yDHu1R; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=I6yDHu1R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=atrajeev@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5vFx24xpz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2026 13:52:36 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLfuXY4080470;
	Fri, 24 Jul 2026 03:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AnFlBD
	vFE4f4gf2zpigswmnFOjeM7Bj+4bzfKCuL/4k=; b=I6yDHu1RfBUH0O4iRcbsFI
	3NeEiZEmBzFINNP7jMf0ppQFoa7X1ni+vzaCj/6y2gBmrO2b+hSuyZjlVRqSeRWp
	zNONJhRAqm5oogMGagLUqZZvRA3kTOHf/lELvn4A9Y6thbEVZ4bdtHJ6GujHThAs
	W+gA6aLJAjYZCv9FwSI9tQ0io6EmhjJClBPZuV0tdxwP7BHYDi/OjvshoWoURPNI
	ciwNBQ9WjVUz0t8T3vST3XEwE+eWnbe3geJU6CQUyoSqMDgkFO248/g/g3RRa/im
	XALDlBSzbOu3hh9S+sPqNWp/h/9nSV0T6KOfp/A7chODASmDnZbHtDKTOdfAzxrA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gj5kd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 03:52:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66O3nbGM003143;
	Fri, 24 Jul 2026 03:52:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtk796e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 03:52:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66O3qCbU46465296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 03:52:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 506262010D;
	Fri, 24 Jul 2026 03:52:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 934E320111;
	Fri, 24 Jul 2026 03:52:09 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.222.110])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 24 Jul 2026 03:52:09 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] powerpc/perf: Use strstarts() to simplify
 is_thread_imc_pmu()
From: Athira Rajeev <atrajeev@linux.ibm.com>
In-Reply-To: <20260704121353.201583-3-thorsten.blum@linux.dev>
Date: Fri, 24 Jul 2026 09:21:56 +0530
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Kees Cook <kees@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
        Yury Norov <ynorov@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB483C96-97AD-4F3E-A513-141D6AD4186A@linux.ibm.com>
References: <20260704121353.201583-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDAzMSBTYWx0ZWRfX2Sa++PNjJ7ou
 kNvoFi+D7p+rqZu4HRpCw5DpgDcEWN7HMwrqAX6t7WL/xMYNlU/m5D3GsASqaDy9llFD0SA2U6x
 qFYfnRo3cuNfV6RWFkIi53CSH0Y55rjovoESLpQ9z7UIJTMngy+ZUfp7KTbWhQcAm12gmMqucat
 8f5Ny9UGTRvjU1XJBQlgxDYgQdi3cyiyWXulQhXW02K7ppaUe2z5Q0F9s2obqy8xQCrMkdR7VWa
 LXdd/0CSSf+ZVqh1SuQT3FWO4w0QC6hGF0I1HCqrmAy8RDYYX822rlb81p3LGpTxsDtj+K0FV0t
 TGrmthhnqiFUaQ2d5og0XaIsrQsVYr/lf2sC24xbMfIiO/CKoSimZykcZwT8EJ2fjegF5Z/dT2v
 wIDCJaQCucbzd221DnGHHk7R61RMbR9PDURCUsur54jgMqCiJXo87EzVeODmLw9n1A6fWBAUeoO
 HkT8k9oGszmrc4mMkKg==
X-Proofpoint-GUID: -RaiNgnBe2qWdLOD8l49rDHOqEPHp0-D
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a62e171 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Cw_hki6syGx7dABp6GMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDAzMSBTYWx0ZWRfX0GJ1Vdog9ex4
 TOQ7MJLywYJQahKmYNHW+33T0jxUXSLrUXWZz4PYIWpL5rRWtO4b4Br3gDoFSj6mnFSV2+NdS7T
 blD6YQ1KemINeZ2RSWCpvmiQBMU6U6U=
X-Proofpoint-ORIG-GUID: 7-f_pZfEC4vuewt5VHtGP0LepScp6Juz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1011 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240031



> On 4 Jul 2026, at 5:43=E2=80=AFPM, Thorsten Blum =
<thorsten.blum@linux.dev> wrote:
>=20
> Replace the open-coded implementation with strstarts() to simplify
> is_thread_imc_pmu().
>=20
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> arch/powerpc/perf/imc-pmu.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
> index e3822f36c419..1d2db6d3e226 100644
> --- a/arch/powerpc/perf/imc-pmu.c
> +++ b/arch/powerpc/perf/imc-pmu.c
> @@ -1023,10 +1023,7 @@ static int thread_imc_event_init(struct =
perf_event *event)
>=20
> static bool is_thread_imc_pmu(struct perf_event *event)
> {
> - if (!strncmp(event->pmu->name, "thread_imc", strlen("thread_imc")))
> - return true;
> -
> - return false;
> + return strstarts(event->pmu->name, "thread_imc");
> }
>=20

Reviewed-by: Athira Rajeev <atrajeev@linux.ibm.com>

Thanks
Athira

> static __be64 *get_event_base_addr(struct perf_event *event)
>=20
>=20


