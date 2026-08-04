Return-Path: <linuxppc-dev+bounces-25330-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953F1C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 06:35:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDkLJ0kj5z2yMl;
	Tue, 04 Aug 2026 16:35:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785825304;
	cv=none; b=i9SwiihfSlMosxo0YiWIg+KoO+//odAv66cZ2SRS6HZa541JK2b+GAtnlQka+qqDx9nPpnbHMbh52wwwC0earpsDXvCTtkR+I3kK/H/tfap9GFY8ajpIGNnG2m4KisIREz6dlVYl3mOEjsrmkO1ITRuzwj2f31OeGWovO4szafi+NFhKeW9lgTmCjlC9VgvN66uIeOBTAr9KXI42FPgek15r/4nd8ynknO4AgazuWyYhHh7Yng/5p0w90H1GsqB1gKRwcGhHvbzrWEFMA9Nsx5SeldqWag3ykNgk0TDmgMbk2WRigt/S8emtprIxy+Z0AvWNcq07g0mZZoiEI1Su3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785825304; c=relaxed/relaxed;
	bh=69jP36GPT7Qk7ySuvoYKX90uMs0QfJMHEhobs189QFk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KeRECPPwbDwPRj5/YnyYqXvHiSfuQvW8SGOQ6lb5pvvPR5jFKF5Eb0a1Nx7+HKXIG+GSPHDM2cqPE97CSJ5SalImUbMKNwkKWEKQE+v8TruN06vxNyU84XCG7E5KIMG48nFbau8Tz65k4dM/o/FbcXet9E5Qn4b/oyJLl1y66xEQaL8J86xZG1lqz2xZ5EdHnrz6F0jc6osDWDCM4Fli/d7DLlsJ+KiJsIx4UZlJrEQ5Uv4ALuc0qBrj2VPrdYMbaFFWWR40il0F5+oDVBNfcLJL4tEUzL+qbvohpVync9vfMZq6GraZv/vp51MFi9cT7eAk1MMmokQ1B7XShdNdPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n+8HpsCg; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n+8HpsCg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=mahesh@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDkLH1R98z2y1Y
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 16:35:02 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6741I9u23719269
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2026 06:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:reply-to:subject:to; s=pp1; bh=69jP36GPT7Qk7ySuvoYKX
	90uMs0QfJMHEhobs189QFk=; b=n+8HpsCgvZuynlE6YZazvizDclLiDM363nd1S
	mlmKPgqhUbCwxaD8Z8hKGyWqS619aIu5A9GGIVumXc/hzUNObTa1udFnq8oQBzSz
	E/oVrVDKI+2NUfwSW3hgZbo/oW57b/IvjpA8l+yQtCa+Ta6ZTE8u4Y0IrPaVn6iT
	QUljGbomSboxug0+VBJWef4krTx9r5q6cwApbVOZVbu5QCkyNeN02lkOjWOwdB0O
	u5ZJdw1UKj17wzsM+pxnbO0IZR0QnoqEdGGUT9xAEiPi56XxWgeamqotUkrbn4EK
	PepKmiUBQYB+PP0Cj2Z8qCF8bHHjYacSwnT6erXg3Klm+ukNA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eum2ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 06:35:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6746QOHL016554
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Aug 2026 06:34:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh8q8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 06:34:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6746Yt6826804652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 06:34:55 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD3292004E;
	Tue,  4 Aug 2026 06:34:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAAA420040;
	Tue,  4 Aug 2026 06:34:54 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.123.6.78])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Aug 2026 06:34:54 +0000 (GMT)
Date: Tue, 4 Aug 2026 12:04:52 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Athira Rajeev <atrajeev@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Praveen K Pandey <praveen@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] powerpc/perf: Add power12 Base Performance
 Monitoring support
Message-ID: <anGAwsc1tsjJDdYW@linux.ibm.com>
Reply-To: mahesh@linux.ibm.com
References: <20260803155724.3272052-1-mahesh@linux.ibm.com>
 <20260803155724.3272052-5-mahesh@linux.ibm.com>
 <20260804010013.56770a8e-e4-amachhiw@linux.ibm.com>
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
In-Reply-To: <20260804010013.56770a8e-e4-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9ceZ6TTAUUanMAVPNT-aOz97xgr-Av96
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfXyYaY1o9tlJn6
 upo2fSYy4Fp3Mr/xGQULhJrwyGcetZ5ye3oHV+xsDH98tAz+qktgIhk5zFi+uGrlCJSeIbchzxK
 zFz9ObtDCHw2jY5JyGWtqRxunbMLre4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA0OCBTYWx0ZWRfX3WCNXSmNGzp2
 oc/7B5YThOfPm9YaDW+m+5XLVvNeNH0NVGtgksthk1BFZYaI4lrFWdn+gfwOmtsEzZ+iS7cUQ86
 eOugwvHj29bj/LtkfDG6nmwoK7ofmXMFOGuz3W3QxMpPqnKeCcMNfPio2KjhMWhQribD2NLvyeg
 HEgzFrrjO7BHYrxhJEVdhQv1Cw6TCqZKE9BniQyi+1oGBsnLhbMojQkhwGR9ta0K661/TusCe53
 GGGEP1sKsFa3Fs42XOTdtig6r6B8rK1bD4m31YkuOWZkCDLfMywLmF2N89iA7ZVB6YKXWr0AeOa
 WW2ZtDgAiMhSVW0cDKxwjwEqF7D7rwuUhm0q+bKgTEEiw+6gba7Hl3aLJZdCg803lRzCDwqV0Zl
 hA2iP7frmXUkGF1O3dkcvjOsZRPpIpx65REj7f9hDPiDMpu1FmZUbdzEpR6ZYnByXHyTvqYmxt4
 6eLqbbsfLkBobk/WGag==
X-Proofpoint-GUID: 9ceZ6TTAUUanMAVPNT-aOz97xgr-Av96
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a718814 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=wTiWe-0IA2uJMisoC-gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040048

On 2026-08-04 01:02:49 Tue, Amit Machhiwal wrote:
> On 2026/08/03 09:27 PM, Mahesh Salgaonkar wrote:
> > From: Athira Rajeev <atrajeev@linux.ibm.com>
> > 
> > Base enablement patch to register performance monitoring hardware
> > support for power12. Patch introduce the raw event encoding format,
> > defines the supported list of events, config fields for the event
> > attributes and their corresponding bit values which are exported via
> > sysfs.
> > 
> > Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
> > Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> > Signed-off-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>
> > Tested-by: Praveen K Pandey <praveen@linux.ibm.com>
> > ---
> > Change in v2:
> > - Fix typo reported by Nikhil
> > ---
> >  arch/powerpc/perf/Makefile              |   2 +-
> >  arch/powerpc/perf/core-book3s.c         |   2 +
> >  arch/powerpc/perf/internal.h            |   1 +
> >  arch/powerpc/perf/power12-events-list.h |  78 ++++
> >  arch/powerpc/perf/power12-pmu.c         | 466 ++++++++++++++++++++++++
> >  5 files changed, 548 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/powerpc/perf/power12-events-list.h
> >  create mode 100644 arch/powerpc/perf/power12-pmu.c
> > 
> > diff --git a/arch/powerpc/perf/Makefile b/arch/powerpc/perf/Makefile
> > index 78dd7e25219ee..bcc804c413381 100644
> > --- a/arch/powerpc/perf/Makefile
> > +++ b/arch/powerpc/perf/Makefile
> > @@ -7,7 +7,7 @@ obj-$(CONFIG_PPC_PERF_CTRS)	+= core-book3s.o
> >  obj64-$(CONFIG_PPC_PERF_CTRS)	+= ppc970-pmu.o power5-pmu.o \
> >  				   power5+-pmu.o power6-pmu.o power7-pmu.o \
> >  				   isa207-common.o power8-pmu.o power9-pmu.o \
> > -				   generic-compat-pmu.o power10-pmu.o bhrb.o
> > +				   generic-compat-pmu.o power10-pmu.o bhrb.o power12-pmu.o
> 
> Minor: Line exceeds 80 columns (with tabs expanded). Please wrap
> power12-pmu.o onto its own continuation line aligned with the entries
> above it.

As I mentioned in my response to previous patch, 80 column is no more
hard limit.

Thanks,
-Mahesh.


