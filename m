Return-Path: <linuxppc-dev+bounces-26875-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35E5C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:18:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrGh3yzPz2yrg;
	Wed, 09 Sep 2026 16:18:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934716;
	cv=none; b=ewQLWNKfkZ31jiUqwl5t9Fmp6jOM0BaDjCLntl01Zjokb44OOpyF7T6ZYiJ3814s4NMTPWO80p+g5vnbYoQjY1FinDzit2IHAyc1qiixV0o5IEnz/GVK9Y4vB8+lgld7M4MrMQshiXTGvHeOzDJt3QEJkpWY2+PXVdLpB63r7pdx06z0kJZj84yO7vtuNQYbioTInee1+ixxXoaVNWV1tktnbdB3EJhpTmi2WOezFYNH+OdsChdCM6mNfrMLrId8EcOkxVfbeJA5Rbf0x9kuEtVRq3UeQgmfpbL+0HD8jzBLkUXcbi47Aq5M22v2r3pORtoyxP8PozbGTeZdNejvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934716; c=relaxed/relaxed;
	bh=MiJXhmV5LLbbf9HphUneZwWJSxJZ8AGDzuu7s+NYgbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lk1op13TOSzw7j0Qul3Ypg+f5qpHi3DZVmYpbNaxHKblMLTK0qGhWjbOvmh4fd325XHarEqEj/YvrrEAjRO6yYr6NNgpMy8UyA9dCrH7ZQck31i5PVzXx8ZMyvQ+ARK/EnjLeP3SoA04uAQ9ZY5keVA5mV+znxbKcB6vaSDmCoOCHpd94b5JpP1HCGU7PKkSTdQmn113zVPHXGaz48ZG6SjEFWD1Ohwi9B944dsxrbBU+a5FeHPg4Cpk3hZGGs7mJJNjFOvN8DNAgBbGvE37UJhEDsR+XI01LgXhfcu+nkAp+3bSTAxW7NW+4wgkj4FS7IMue0xBtfNvH4qTLi2hvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nr1VMljr; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Nr1VMljr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrGg4qxkz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:18:35 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1qwR2126487;
	Wed, 9 Sep 2026 06:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MiJXhm
	V5LLbbf9HphUneZwWJSxJZ8AGDzuu7s+NYgbU=; b=Nr1VMljrpmY29MVFA6E3yC
	nrT4ytCweD9mZvrVym6Kks03kbozPw/gBqMJLh8kUE70eTFzD8DY0GRlmYJvsG6q
	Xtd+OgMaPUE53LYz46wSluVz4KbosWDSWahbNbJzaeCTIx88PekHctv1vVLeulkG
	PgxvhM62bXicXHq9ElF/uEVCmYlgKRS2U/qzi265TvmFYeTOU8ptm7EFqMQvEKgA
	lL/fxFRx7Hdwu8pw6VAFw0ilTWgvZzqxbBqV19DkduhUwV9a9rMjo44RGZ5wKMeq
	pv/vRQP3U20j7Y+WIN+FLbJ51tpyRyx+SJ10fU9dpYXPzmeQnoOol3FkR1MC8Ksg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbj8bpwd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BDLt008822;
	Wed, 9 Sep 2026 06:18:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymggfsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:23 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896IK1i36962576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:18:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA2E62004E;
	Wed,  9 Sep 2026 06:18:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BD4720049;
	Wed,  9 Sep 2026 06:18:16 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:18:16 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        sshegde@linux.ibm.com, mchauras@linux.ibm.com, ritesh.list@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: Re: [PATCH V3] powerpc/entry: Fix irq_soft_mask corruption on replayed interrupt exit
Date: Wed,  9 Sep 2026 11:48:14 +0530
Message-ID: <178893459273.174069.8912547625393303120.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904090858.128563-1-mkchauras@gmail.com>
References: <20260904090858.128563-1-mkchauras@gmail.com>
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
X-Proofpoint-GUID: BRk4wG7-s-XXzmpclLPhHV4WjY-Edi1N
X-Proofpoint-ORIG-GUID: ci5ab4vG31emS0jsG_vx0VO7kCooTfn6
X-Authority-Analysis: v=2.4 cv=RNCD2Yi+ c=1 sm=1 tr=0 ts=6aa0fa30 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=tlrf50vHQoypey2jUEwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX+o+Zr9i2igMb
 kY/T3MCCqgtg6GhCxk4ZN6gpcYED7LH8wLB8+B46wbZgLi/rgsxFBmV2s/eEYyQlUJrSUclGjP0
 rZUlujGMwqWCNlCvgKLFiJNjnekBzOI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX7TJWSKTjDRO/
 g+O2rTlrZZaNMYnkGdClW6jlnIYtYfGjgjdgXxF/JxUGsbEC0fQfSNeeevmu+MJpS3mGcNU+0k4
 bzyuGx/2g4okzYSwo0ouIPfuNxlyi2DRlL1mffCuuGiUGUzwboBCo9/fSWsy69FErTLip77UiPh
 MGjrMmoJ5RCtgyAUz+SarOKyUwmnTVjaxOeUbxm4vcWDDNlh0eyZgBZ2M9M4/Gn9Dap6U3X6+tO
 dNoNsbnqOfw95narpho2S52Z1f2L5kgYD9TnT0zUzSfxIMBQ4Oatcpyqe9sMolxvVnw6MEx1r5W
 dWPIOrcdazY7kgL8bmvQgQ9pUSiR1w+w3duuZBi91DYAH+GXapImHl5Mtv4BFGwKJm3Sq1E8oMN
 pNBzyXKI4xd1KKLg3FuPOU4HGJZc7rRmQvUD0lLWQUno2QbixJzLd19oVhkSkHNj5/fG7aPbBud
 TSQsGrzKv8YB1lZgOHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Fri, 04 Sep 2026 14:38:58 +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> When __replay_soft_interrupts() replays a pending interrupt (e.g.
> PACA_IRQ_DEC -> timer_interrupt), it calls the handler directly with a
> synthetic pt_regs. The DEFINE_INTERRUPT_HANDLER_ASYNC wrapper around
> each handler calls arch_interrupt_async_exit_prepare() on the way out,
> which calls arch_interrupt_exit_prepare() -> local_irq_disable() ->
> arch_local_irq_disable(), which does:
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/entry: Fix irq_soft_mask corruption on replayed interrupt exit
      https://git.kernel.org/powerpc/c/63a7531ca31f9f097d9cc1cc3fe86ae683cdabdd

cheers

