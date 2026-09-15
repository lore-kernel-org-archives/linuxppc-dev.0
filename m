Return-Path: <linuxppc-dev+bounces-27443-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDDAC88E7D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Sep 2026 18:15:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hkqtm5LSJz2y8m;
	Wed, 16 Sep 2026 04:15:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789496112;
	cv=none; b=LVniNg+mrhWFZMDkSxM8keWkJH8TAU+x/KhKvkuPHc4Y1S3IV5dJyIqzUR8Pjxq5h/F2yfucjw/S8EuQPl0mmxTBvu1pavhHw3k7ivPdbSzUluJUY4fBcXbqyr6ozKFfEgv9f0IJzLoRw+4c4jr59Tq/N7SzUAP/BCrIeqhLcEeeQPxjkl/pS1Rm0QMewmZERn6zbj2WhV+1uKpLSLiYNdNiVJBiGHfwaD2MM9bY4Whq9xOtD+siZr9pyNRkKBU22EHHd4WZ++nvcuS+8Z797MsaDv1vR/a218q0AkrzDqT4q8XwLDC55V41BqJ+Qm8CCajK+ZI/hyD0IsRykB2cag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789496112; c=relaxed/relaxed;
	bh=uvA5/TO5P6M2Idzun76aKSR7Ui7dxaoPG4sX66ahxek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSqfdooq+ur+PklTpcOzz9vhZa5ibtvFjSWxMh4ZQRQONzoP8zgYQpVUZqf3r3M5pykx81w0lWm9SFXq19mi0bKEs+BBxHkhOSjVW2H9adsxpoVZBhGVUWa71dtZijI2V4WLOFgtmdxmLoc3ld91tug950zHacFQdeeUKhW0Ne1PzTBEEhXYK5+yzelBQMu84F/rVO47oAAYoKtzvmi7CBBQGvGByF8LspeN+GFsYsfWfZRuQVFkemTWVCIJT3C02DrxEscdN3vVw7yON8+xE5ewSID6yn7rlPRrxFxNHHe40SLWaFqhoJpJ6KZLZ5q7wKYnVEia0boY1KoySJELFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sf4VVuCq; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=sf4VVuCq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=amachhiw@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hkqtl6kx5z2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2026 04:15:11 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FI1ZCX3831659;
	Tue, 15 Sep 2026 18:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uvA5/TO5P6M2Idzun76aKSR7Ui7dxa
	oPG4sX66ahxek=; b=sf4VVuCqDoK7FQEDSt+IONGJTetoikI08XcuAKQnYNg9VD
	VdXJtrpzh3O3dL6A28beHZJh6ww+E3tWA5QmrJj7rE+VU3ZL8ygm5MmckWBEBqc6
	xIoWWkVAL0P406zI344YrDpl2KP4vmnctwgtfROWbyASxHM/Rt/s7LTuCOMfcBMZ
	rmuwVhltwBwB0BL81k4UibtIOnjI0Z7cLLhr4JDmVf9dXqoYirejxioPmBwhEFLE
	HS4Z2DmzolDsPRLE+xc/hcdLZwfu2IjwhsAcIhNIVNpB3PGe22OgjHW5ykd8uSxN
	EPtQprJVoavsw9IkXEr7yaiCyOaTJ5DOg/7zjNvQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq8mda-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 18:14:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68FHphnL113848;
	Tue, 15 Sep 2026 18:14:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsaps1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 18:14:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68FIEo9n42402140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 18:14:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1FEB2004B;
	Tue, 15 Sep 2026 18:14:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5B4920049;
	Tue, 15 Sep 2026 18:14:48 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Sep 2026 18:14:48 +0000 (GMT)
Date: Tue, 15 Sep 2026 23:52:34 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Thorsten Blum <blum@kernel.org>
Cc: Geoff Levand <geoff@infradead.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Simplify control flow in
 ps3_{virq,irq_plug}_setup()
Message-ID: <20260915235154.256e29f4-4d-amachhiw@linux.ibm.com>
Mail-Followup-To: Thorsten Blum <blum@kernel.org>, 
	Geoff Levand <geoff@infradead.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260914215900.84712-2-blum@kernel.org>
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
In-Reply-To: <20260914215900.84712-2-blum@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI2MyBTYWx0ZWRfX5Ix5HMNypj3Q
 yd/pQXofY8+OYzdfD9kcMniI1L9Ia+PTUE/CsQVAcVxXVS+8dmqkgjTM4rxWiZaPnhfKTQCBXZF
 EBlijAgHCT3MeJnRlV4XExcqQgH28Avm5OXU/0xd4X4ocwxctA1YijFvJbEgqQcRVZfycAdZpNH
 cOwzmWDu+ZyHzjCN6RjmUmVp0I0NNSJm3QHxvW8usHt9UVNEmKN3qrYPM66AXFudKCmquISYUKW
 pxCJ5BFXnIITnFHXNiYdidf/QCZe0CCMYx7vqwAu6UstJ9/FWzk3BFXLNb3We82d9ltTMu96zc3
 6HwJ5ti7jClSvHrc9KDY/9Q9fQENXqbEFKqKdEb4n7UPgul6gQUqx8Vp8on1qDiHat4DBGtjXDH
 JDsOpZGJiuO3uGjG1uq6Mocfe9+eJozv7s9SKhsV+tocmioeTub5wvRyqJGisefKrXQ5CKH4q+Z
 7wtmUTtPdx9NgaTNGDA==
X-Proofpoint-GUID: tH6YjG9xqc7pUooKYDQJj6BrSpKMbia6
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa98b20 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=d86c0OqMtwPQ0Kf90R0A:9 a=CjuIK1q_8ugA:10 a=L9aGTTkzY1kA:10
X-Proofpoint-ORIG-GUID: kxIfSZc-r_7RBTAsKrbHm9ZJ9N5hVPl-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI2MyBTYWx0ZWRfX89glYB6yDMXP
 xgpiRnEzudIwcOh3euq12bGMlr5uxVpk4gSt0eLa7oT5S8d1uo0F/nkbS5Xn3Nn9x5JfLgtF20w
 rf45L5vWvpTYeEkkreC6eZOk0XcGqJo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150263

On 2026/09/14 11:59 PM, Thorsten Blum wrote:
> In ps3_virq_setup() and ps3_irq_plug_setup(), remove the goto statements
> and handle errors directly.
> 
> Signed-off-by: Thorsten Blum <blum@kernel.org>

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks,
Amit

