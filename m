Return-Path: <linuxppc-dev+bounces-21600-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C41CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 16:17:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQZWf2Mycz3cnK;
	Thu, 28 May 2026 02:17:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779898622;
	cv=none; b=jWrSnKJGv7uk/O33NKpTUhQ2BT2QgoHqFKeRUhPO04Sgk+5KTtPGRS8lQN3efMz+Sxl6iYYO3CbBf6N4dmK8+brrjfvbya/bA2UKgWKigc2BimUf04RIucTkTA7cBQYkJrl4v3hRhxN5cWpxo6yHmvo756hnAbXE6R0ezl43rU7nPCcYuZR80/IXlCfdmnyoN0wRUpwnnK6LEQVLj+9DMpcKaPJnmL4bfNBSUhhNfdCFbCHgL0bL8m6GbnSuGtwz2zeCyTYnl60bcsfsyPu6f0FOFiIMfQ4k6we2TyJl1vq0rkuxXQJyQXn4RdpuO7pldr6UvYz8Dx/IEI741CGVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779898622; c=relaxed/relaxed;
	bh=b9F+AmgWvYDlJzmEdke60GpHwUtQVzDqf0WjOaCEDh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXRfNwnXhPN6DncZ+++vLMxUxh99itpS+bDslTQoxthzlrz+KJw5RJpPEtTpuQvcAdCC1CMWpsJNfaAlZnNRczk6mXqUuRoQG0Z3IPziASbR6CnA7X/qJtFAvbBuuNO8KAObkAosaZ/fnZbaaonNUP5WHhxLbkHPIHx4caam6F9htnWQufAsCtSSdEdc2HH/fVloihqBJUsTMGmQWzWj+z+dztXxxYoclS9J3urS/mfU+A4YXZi4U9iH04B4SAiKan+XwKF7sjeB8UoHN1idFgPPxsv5S5TGgPEuad7c7Qgk2pwbaJlCT6k8qjRl86T7QEC5Eoar9j7YJhcBoN1lRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B+cTT3I9; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=B+cTT3I9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQZWc2f8kz3ckP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 02:16:59 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RC0gSF272240;
	Wed, 27 May 2026 16:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=b9F+AmgWvYDlJzmEdke60GpHwUtQVz
	Dqf0WjOaCEDh0=; b=B+cTT3I9cHjb6BNxLlOprt9Z+T973dcNKzaK5AOiECzjIr
	manQXwCv1j2GW2sL7WZcIRv6Yi0lt6gjtNZ9OknuAzzuGNrhWDRxD1jxysFQ8Why
	GnKDcwVLGWwsgWUG0NMtT53WZ1cu0I8tDkQ/WtxS/ZWugiMOKPX8dldJmEQxssL/
	Omax6bdFYMejZpIbYYz85HChlDfA7PZ9bEEuf2qFCD8oQGrhM2guaTyLQ9xXP0PE
	weiUsw0wp9EbxiajT34+3BZc67bDMhlmPrg77aUDLLSUXkLN461O8+gVGaWZb5kE
	IPwT3M+ImY08HMtRuBqPgcU88hfB2jbfxMJ6JU1g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nq91d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 16:16:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64RG96gu002888;
	Wed, 27 May 2026 16:16:45 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4edjrb3tt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 16:16:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RGGfTI47907136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 16:16:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDDE020043;
	Wed, 27 May 2026 16:16:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AF520040;
	Wed, 27 May 2026 16:16:40 +0000 (GMT)
Received: from Gautams-MacBook-Pro.local (unknown [9.43.117.77])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 27 May 2026 16:16:39 +0000 (GMT)
Date: Wed, 27 May 2026 21:46:33 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Sean Christopherson <seanjc@google.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, atrajeev@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Kconfig: Enable CONFIG_VPA_PMU with KVM
Message-ID: <ahcY4S7shzG_kDt6@Gautams-MacBook-Pro.local>
References: <20260518044150.34632-1-gautam@linux.ibm.com>
 <agu2UAi6lWclxFYh@google.com>
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
In-Reply-To: <agu2UAi6lWclxFYh@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: Xu6BugMKoIkhkjlN9TsXGZnUcHw_o0Aa
X-Proofpoint-ORIG-GUID: b4h-zIYe_oohMh7MgSS0yqDDW51hSHfT
X-Authority-Analysis: v=2.4 cv=QIJYgALL c=1 sm=1 tr=0 ts=6a1718ee cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=kH-xMUQrV69S-q4FAwAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE2MiBTYWx0ZWRfX2QhgFulZW/6g
 Hy7Sug3x7czsigDCKgOh/cCVjtkTjghZP+Dz/ef744228AR1+LwgPyGw7dsgss2fBD1Cz6AqKgO
 A/Qr25KvlfSitOv9ndVQacMFGfWA1PvBqNCad0OdoVIH9VWr/oklw1B2uHcIshV5B3iXJG6IyET
 TtR/Y55rm5e8ypHl0w8i+rG7TfF4TX85HEcXVQ6Ny4ZbtAMt9QHzs3eKNbP4M1XjGf9UUbwxX56
 6bg7UyZymYshjdD4/UMye7nw6k/kplm5t6jZAC0ZstDFYkfSzWhDFkbvVeo5uS988VdjTz6wU7a
 OdPHAoNvhY7kZZ9eJ9GTCiK/9+cA2tend9bHw3itshzDh9zPsMzycuKi7nlTfdq2jnsPUPioof2
 UqUgEkoM+sk1yzN6JSn11CHdCn4lx6ZScHfjfxHwggMX2olJIEV6KStSYurHyDP0q6MGsfeWKlJ
 EDpY9n0DTI+AIVsGxyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605270162

On Mon, May 18, 2026 at 06:01:04PM -0700, Sean Christopherson wrote:
> On Mon, May 18, 2026, Gautam Menghani wrote:
> > Enable CONFIG_VPA_PMU with KVM to enable its usage. Currently, the
> > vpa-pmu driver cannot be used since it is not enabled in distro configs.
> 
> That seems like a problem to take up with distros, no?

Rather than enabling individually for different distros, wouldn't it be
better if it is enabled with KVM automatically? I can rephrase the
commit log to emphasize that this config option is only relevant for
KVM (similar to CONFIG_KVM_BOOK3S_HV_PMU).


Thanks,
Gautam

