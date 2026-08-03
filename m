Return-Path: <linuxppc-dev+bounces-25241-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32384C55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:58:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vD2fm1z3c2V;
	Mon, 03 Aug 2026 16:58:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740280;
	cv=none; b=am913JPA96hOp88YDV1UItiCcM9SfjdKPJPafL8X4Z3vLp+i9HlHuGDdEseaJQ3zShvJyJvVLE5g+36s4htHndWSeBEGPZ0WZfeDo0RGDZbRFVdC4uuCdHuODPZiXqgQPoinTkfzXjtTMN6O1da9KIZ7Cy/Ech1KUM16rSBP4x//I1NIYqJBe6MbzNxR98IQAEwiYy5SO2HX97xp3Q6ZpuEci39H8FTA11nO6YXAwlPZp5CFQnvZZ5+xcKYOBHUD8kWF4b3e7UAbHLptRtSggh4MLF5z9NZ5nEAEvCg2Vzfr3P6khXtVGzG5WI3S3DQxff6aqxwWPsxsChXBCsenRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740280; c=relaxed/relaxed;
	bh=X6ExJXcUCOTPYEmFXAZb/skNgImJ8k9YWwWQZbkYQv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJxn27Gosz7vn5O91K9y60NGhp3lqBCYYvigbZT5bejiYr0Yi1Y+cBIRnezqEhb81XQFY+pWINbevr34vBsotAJoyUKWrGOQkVwHOhgN++Loh1Dt4Nk+eqHEf164lHM/P6dkTQoWWjAb4mJhhLfklBLEKL9G8rNZKKs05/y3UHaWeuw4YOt1KbF3Bhp3kf20OSiMNPcQOIj27fQk7fGi8HALjTHtcSXAvcXtJijQv7jHk2zAUdb+RWVmYotjEiP7bMpRBYN7hBRevL+yPDmjVdr5GLwwSkVOiIHIrk/cZ6o9DxH3xxaNMTXdxIzpGlJj9xq59DV/ksl2UQ2SqoiS0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oKI/Ms8H; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oKI/Ms8H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6vC4MdDz30C6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:57:59 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmaVO224870;
	Mon, 3 Aug 2026 06:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X6ExJX
	cUCOTPYEmFXAZb/skNgImJ8k9YWwWQZbkYQv0=; b=oKI/Ms8Hji2N0/ssTaRYxU
	9hjgWv93W6mMGj2BG6/d2jDE+73LBATAWxy+CGzazdyYmfVKG8C3gBEmegQdW7KA
	FMxy/FLY+hNpiZdgEp3+IAjHTUnqYsnD+MpyUchVDoV7g6cTY5l8SRv5MDQz2sXh
	ewbgi+aV+GAnp3YFts9ZIFhFGn7YBZXx7rSHGSMW5NpoqNt9+R49Zb7uReCHbsD/
	/Rba116x0Ji8/vHhXJvgujrafksQY4tmy3C8JCX544YjbH/ahoUM7hPo+B8gRf9V
	tGhUNmO3sdT5Laq1oxQS4+mGFcjZouQ+zGLuVutVRXLQBzEmQt0jLM3cFl9FPajQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3qa68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736us9n019488;
	Mon, 3 Aug 2026 06:57:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtybvv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vh1p28901754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B96692004D;
	Mon,  3 Aug 2026 06:57:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 384D020043;
	Mon,  3 Aug 2026 06:57:42 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:41 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/powermac: Simplify bootx_scan_dt_build_struct()
Date: Mon,  3 Aug 2026 12:27:41 +0530
Message-ID: <178574013464.29744.15585280108491375805.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720231453.117271-2-thorsten.blum@linux.dev>
References: <20260720231453.117271-2-thorsten.blum@linux.dev>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a703bea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=sgLAt9ZIq0sEtGZ8NXYA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: 0i6fJSe_X7Kkr9oK9b-dDTTe2gYBQxGx
X-Proofpoint-GUID: 4oHkVJDAfMXLtOe1yYWg7Z_bLyPmxV40
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX9mVJccF+gL/+
 QGoZtBsTqpAJmpM7cew0JMYazVKkfdczaoahOqRyOQTZxMeLBv5mZgrvxvZ47BS4kWms/RqYnv4
 D5OEO6Ba+2FhjYLhUy81+2G/aH8fx8c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfXyVttvtv/zd/S
 VjThDhrbFICm/2bhd54dsZ3dvt5c6koN0mnN2jtEOuPD2TX7dCfzzh71NCW8LoXH1KCBNhYShcd
 DqpR1HEbljO40tJDkkwdvY1XPH8geRzTkxanbyerLdLPYXKjlZUURq5akDF7U7ptjTavWHjAW2x
 PKvIR2dnm22ko3BR6ZiQc3uoV0PYk5DMSHhN4SOTJWpBCD8UStA/Rbqz4rhiZUt0ANzH0MRTKAD
 IqTZH1GDDRvGLUL8Ovaz04m1EnszKbRo9a/bYp+Vx1PVLP4tlSyXcqR8Wa8TYfUOSU7QwzcaZ+A
 MugXUH3iuw3g82riOqRy3jI3Jrx7lnVvhDKZ6wwhuN0D0oK846gN9dr3U511tJKUmKn+Rt82PTr
 B6x9M0rZHN8YnXfCAjFoGYggCVkSXCKXXbZqqUZir/u0ch32SGGrGmuf4LLoUF3OOleS6uiHoQE
 GWeFko6x1rVJiXNoTDw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030058

On Tue, 21 Jul 2026 01:14:52 +0200, Thorsten Blum wrote:
> Assign the empty string directly instead of NULL checking namep again.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/powermac: Simplify bootx_scan_dt_build_struct()
      https://git.kernel.org/powerpc/c/a2144b13a6ec01e2298c88548af2e3f6d1163de6

cheers

