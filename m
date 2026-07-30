Return-Path: <linuxppc-dev+bounces-25053-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C45CC54FDF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:42:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dPC5jxqz2ypk;
	Thu, 30 Jul 2026 15:41:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390111;
	cv=none; b=kNaVCXU9noCo4E1bnkzCLQFN0HjOckK6+ZnpUJQGDHHMsglrLr6wW06C4gl+eoNWDlVk+9lg2akDU5SZpvNAP40E1tziT6izMk4oGl6Mz2b8QdbI8uU7wE2l41cipW6uey8T0AxiEnkon94YavO8IOCrPSfJYVcASLFxFRXIiLpwjVwMcLlPLeLlD7Cm2vXupm0zWbK1Dze0TrpaG71uhXFva4F7l0eHoU2qetRHMTd5WTrVhyW380tMETmqTxi0axzzDqBB0yYKoNR6BldKHQ5OW0lYqM1n6l1FCWUcqukwcyJirwaymmel0fopL9f6xE56MWvPqKyTWUEMv0Cdpg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390111; c=relaxed/relaxed;
	bh=x6X8rNBvV+zwOptzyX5CRe/F4RgMaz2QCz4urycFty4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eK1SVGIbq+AmJgyYhRHLnQl2A7Y4e9sCFcLqYuBafVtUbooPQ/ho9QkGLni5PyZKK54QyKUxqBAkZK1+26QZT6Y9yH+zP75fg9qLLtO+3mR5u6wD4MTVStpw7qTagTRmFnBqoZ73/yO6QPJahteNzyyyFFxhYEwKE5k+uAi6hl9IhCv1MbiO7w3BWwJKjUHiUyrb/sxLdS7FywYaO97a/VjaiHKMjBZXtuTHv5kWjetNdSSUeu0aQZXJjo+Klqm/cO94QR6oKzmIVKElVi4tZoZf9NQ9y9yT9j6ij27ANLeLK+MiIXdb3ehRvXAvWjDSto8CZLZIf7Ds1pKRkxxUAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bOAwuuDC; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bOAwuuDC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dPC0nc4z2yng
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:41:50 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mjiI1949780;
	Thu, 30 Jul 2026 05:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x6X8rN
	BvV+zwOptzyX5CRe/F4RgMaz2QCz4urycFty4=; b=bOAwuuDC/B7Oj36ujEcmlJ
	Z5Q9W0AdawVQmJF2m22Zu8ZXeYhVPv+QbZVvB+0bw5fppTkz0kNhTzNxueDt3b/E
	Vr8NENOMAZtQwieiWaQpPWQBjk5CJ4jEea0jToQYO0JVole7Z9a67CdC/NDLhk1g
	mZB+QziLEIivlzLpWiE+PhNNj56wfJeEYetWATmEqLoIC+zVy4hzScj7RkTso+Bb
	r7w8xP6HtLgj+caYuX8/wujgA9t0sDtexu2LK3Z0eAF45Zl5mPosziw/dTPXnLLz
	RLfbo9oi/DVccNzGahcS0k7y2bzwFM6/V7GaYs5UNAyGkhk5BwgEr0VRhkUGcquA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd5br6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fIeG027071;
	Thu, 30 Jul 2026 05:41:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqj450-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5fagO32899348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4358E20043;
	Thu, 30 Jul 2026 05:41:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A136420040;
	Thu, 30 Jul 2026 05:41:33 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:33 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Kees Cook <kees@kernel.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
        Yury Norov <ynorov@gmail.com>, Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/perf: Use strstarts() to simplify is_thread_imc_pmu()
Date: Thu, 30 Jul 2026 11:11:32 +0530
Message-ID: <178538948395.1278583.5459452795548152868.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704121353.201583-3-thorsten.blum@linux.dev>
References: <20260704121353.201583-3-thorsten.blum@linux.dev>
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
X-Proofpoint-ORIG-GUID: H8MSBIxNfho0jby6tjbDWOx1cfa0NiZc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX2fBu4ItiDciR
 DZLQswcZwjvbgiNPRZ0RtHXL5AFgrBvTkGJFqJsajvBJ0otibC19aUgpIq6YcNI0FZ0tdsooJ7b
 1H/CoO2fyvmF8Qcaj0QzckWH/gZ6ceo=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6ae413 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=GNBC0S2lGpyGl7xEGWsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX/YfC6dQvxlQu
 9AX9Z32hhz6DmJ0JCOunl00+rSdxd/77+ETvcbdYQ5Z6l+/pNcCqHW73fxkUO84++zETI7QvpNg
 HIO16b8NMCqEftaBsar9YdZhfdx132SdFiSqkXj3wuUk0ojY8Xv18eMEEcPU6pf9P8LfMzSytTW
 h4j7YJam0YakOggdpA8JVphIvbdA8Embs+JGcet/2ML0BBv30F9bHeQ/RubNQzcpmxQCGPRc7hK
 YKI4E8oQXbXLCEqAglMoOPSi6reMFtlbob5VtOakV2hu5IzGBgcjy6zi/OckF4TErP0Sn6GLPEY
 9vNaBry4KZCnN90nz8aWkloC9DeTwDt5BwDGMKCTtm16HUQNV60T7wmIbi+QyMA9wTEjAuyEw+z
 47cBw3yfGC7o7PAtoEcrT5FsSsOx+ig/E5A1snW65J/zOiJ9K5vHxSCkF/OVC0FH51Ox8oHVvfV
 A5i0fiOfmt/MVeTnFTA==
X-Proofpoint-GUID: yFHHndjv5JVsLOGs9WyeAHbsJV0vPaD8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Sat, 04 Jul 2026 14:13:54 +0200, Thorsten Blum wrote:
> Replace the open-coded implementation with strstarts() to simplify
> is_thread_imc_pmu().
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/perf: Use strstarts() to simplify is_thread_imc_pmu()
      https://git.kernel.org/powerpc/c/d71b3ca5231750fecdefb3390595e7db30979ac4

cheers

