Return-Path: <linuxppc-dev+bounces-22844-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C00CD98F6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:01:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs3p6c04z3cJG;
	Sat, 20 Jun 2026 08:00:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906454;
	cv=none; b=e+xvfdJ8eLiZ0vv081Gl67W32jlsMqceMYoLu/xuqoMtMoi829xCtrmj3V2JhTZmEdZ9Nf+2UuGJodRuEUSckQejDi+7Kec/yarcvMbtXHph4pk4v3CtiPyZwUe2/Me0WA+tYpJny8GVuo2jx29YkzW1It+KcSX4idkpijuK3XNoxST6sgPufdEVhdAToMSnEhBzItwI/jkyQTZReCMdqa6MdHnquBJZb73oUJpEQrxZozoP/gpE9NZvBhqeaAbUkhIYcfovj80BItRXQ980gwbd4+/iaINo8fnWk7+z+VEVQNe03A1sNo42f8k39veMKXj8PaU4y4rCxBIo+nS+TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906454; c=relaxed/relaxed;
	bh=ClNOW8KVencRyp+ZeD/bahG+VTrjgJbAa8k5i6iOr6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLhjQrPDnFPLrzFvyEE/ut1GA09F8v+9m5AioODHIg6gFIpyUmieIUUeLVc444zLt+kClYPqqT7WpEuT06mB71/l5AgC5qRrXD9DRHz484HDQnwg0CwcKkvB345TLZy8GQ5Yj3fYL/UmJIxOfFmlltDqmkrpYFk3Reh5ecILPth1cfWblWvNSsNoiob7IByLuDNZCzJNa3qQ83DWpgBl0Nm6nf0d30LEqaqsof/W99KIrD425JvcZx62PvLzstQ9sNfRoM+BKIuDKjdfO1N8NuTcR4DZ3T3/t7e2SerD+UE4IOwzz9G3m2ER9HKnE3CsnNMRC86rrpeQhHwiG7wcsQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XplqhLWt; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XplqhLWt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs3p1gycz3c7j
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:54 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmSdi3609931;
	Fri, 19 Jun 2026 22:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ClNOW8
	KVencRyp+ZeD/bahG+VTrjgJbAa8k5i6iOr6E=; b=XplqhLWtPV8Ts+cbOoJ1Lw
	fKacrHsZ/ayDBEpdNn7J5lYp3c9V9wpMCSjJGr4GMbrV1r44Ldl9zdw5QMVYc7Fj
	ojABpagKhhbU+t/zQGT1A03W2O6dU1nJm6tJNMhFiGqSd4YNc0DUmrC9oOdlYyvT
	mTdkBe/CUUU6vNFrPWqEX4KawF5U7iLiVRxvXc7SqWs6oyW0dlC49p4H60QGXzlK
	uf8P3USxXDthn+eRGF3aVWkSt4qjwfqnisgZ1WBkcOMbbmilCuho5BBcxo84rTgQ
	Vp45ZlvPNB0UTaUxO3BYAoOLxY0vYiN1zG/YV/7VmaSTGjXBNPrBXwmbL6yzxCQw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequfrgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnakH011319;
	Fri, 19 Jun 2026 22:00:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172as1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM0eMF36897214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B3C82004B;
	Fri, 19 Jun 2026 22:00:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E7C920043;
	Fri, 19 Jun 2026 22:00:38 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:38 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Christophe Leroy <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] powerpc/rtas: Replace one-element array with flexible array member
Date: Sat, 20 Jun 2026 03:30:19 +0530
Message-ID: <178190618800.653308.1884823944339024184.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20250813103101.163698-2-thorsten.blum@linux.dev>
References: <20250813103101.163698-2-thorsten.blum@linux.dev>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX5eN5rzXPQUZf
 8rHXGJ3LiZBl9naLUkI/HyRvhX8VNV46cWmXx1KYR682qy9MKQu/tEK0eqrlycN4oPTQQPWILBQ
 LMUz/cn28zLamh55HO8mK2gQDbju6Ec=
X-Proofpoint-ORIG-GUID: w-LA3uPqvsm27DtHTyPUbo8UO_qIG_es
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX1Rk6IDsIubVP
 cC4gadTwMvKwzkPy9RTDFyPctBXgdLZ7Ja86owr2YByPkH41klkrUwuDiI7HE15ex1IuPkCGl6G
 kaUdwp56Et8SrPa8Q6jg4nLDMfzZAhj0RqzH16UbBTbXOy7DYELQKashszqA1hZYi9oplrLa3EF
 nMGV340X3/rVgdAkglKeHdwLOVr4C4Dggi/WEG3qv0tcz3ycyk3LzdStDAyCts07mmVVoHOEnuq
 /P6z/jjWrxD9t5th/iClThwWqdpwGKvZZM21rWGROG6XtzdMvISSjENTCq6ssdXHApwAhX+JJ4P
 4zO/j9dsO8LAwzCsQ9bwH6hG/3lTlfneA9UDkPgTs2ZAxESvb0LiKlwNFWU5rhIUb/SBkp63ibn
 Zdono6xlJpfHvVAonlAHs5TVqs2uTuZyXki/McHiSzuX7lZuFcApcGi0FRo4bU5pSfixWRP1HU9
 DP2zlJiKOZhpdlM7ptQ==
X-Proofpoint-GUID: sN1esR9T3P1PVaU6jw_vr16nj4JSHQ6l
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a35bc0b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=vX9PE3_zFguC5AT05XQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1011 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Wed, 13 Aug 2025 12:30:59 +0200, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct rtas_error_log and add the __counted_by_be()
> compiler attribute to improve access bounds-checking via
> CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/rtas: Replace one-element array with flexible array member
      https://git.kernel.org/powerpc/c/ab8bbf8024b7434e2b630965fd373fba5b89f29f

cheers

