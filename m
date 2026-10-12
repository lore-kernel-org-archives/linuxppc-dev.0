Return-Path: <linuxppc-dev+bounces-29209-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758CECA9EC5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 03:32:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j330t41zGz3bsT;
	Mon, 12 Oct 2026 14:31:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791775902;
	cv=none; b=KeVV154AQ8qiDINoxqD+AZm17q4mguQri1Ust5hiBNNfZmEeOffJGy5MLkE6ZUxUC3Q925njCBjHWqSXkO5C1FtT2SSEp2AA9q+5AbRwdMXe02U150HcNmWtO0ZHsm1nGSFd+i9UtjHh4LFnCYV/LAbNe3gJ6l9yTcJrQ65y3zWoihIKanYWVu67t343a6bs4lo2MLglUFj9HFl9oSTMmj/yTqPmiVC60iCpcNzawhnI9M/Ck5dtYAVl2oL0Pi9asgS/DXA2mNYlSxsyjNkQVaInHs9mPUEEPcFFCAEpskwwehxHuNtbTDf2ROIyIaUVD0qZcSlZrkr5wS7YG10yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791775902; c=relaxed/relaxed;
	bh=Uqco7Q+Fb0XMHQp460XTpNu/CKnJxThuUHxZbOqikH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YQgeq+TR0Uw6ba0TIKGdDPnGOyFYQhIV6AXxyRC+L0ZvSvNOgnR7U2Z66wHQHxH3y1dF8LPOMH5CI+VvlzUhv9eeIXcjqNU1ut8OLd6wC0Kv+BOxN+LCV96xZ2KTXZBtQH+GxcM7UV12L2FvYfQbjabLudJKnd0DPdqS6MMliRcUR4QA6QJT9ic7HyovV0yxSc0wO1kWhrsuIZVgyRinOhGLtG9aPhGHtK0V+MXaVkMaYa2LeK/3HN5derMP1BnhJHE2CZfMAipppFPUMDs0J5w98Td7Gh1DNQOawH3z8qFobSwuHUu/riTqkTfYWzrT7GRpHjGV23Ade6xtucm9OQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=st0dQy4s; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=st0dQy4s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j330s5Qj9z30YZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 14:31:41 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2EeM92912988;
	Mon, 12 Oct 2026 03:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Uqco7Q
	+Fb0XMHQp460XTpNu/CKnJxThuUHxZbOqikH8=; b=st0dQy4sBAVJ7PyL/KJDNu
	98eRJwJrK6YxMEcsznGWlGCvIoWLHx9J1FqFrNgjKyAWbfTVT/1m4w5UkEHCmujP
	tkx0Pb2rKOlAaBZ2cm1g4JGb9uuzZCmaWBFUhuwTZbPTkRhvetQwN+c982gi0ZSS
	Rc89kU/yJskpAoTcOeTjGb2UxieW1zTMjgSvjsc/sy3V7w4fQYFRY2Qqha+MNLwZ
	8DDCqFBXrM2lUYXxvnzmOHGK72vl6JaxNCPzPDOvlCi0gYas4OlIOSdeespHi48w
	Ly72r14jDS8RD3q3lAEQ/oWmsVzZXNvYbRt2LHiPkIXzDUkfXUGzrZOdHWRbL9Cg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhpqh3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C1nxYL550856;
	Mon, 12 Oct 2026 03:31:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppkpk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C3VK2h43123120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 03:31:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0334920043;
	Mon, 12 Oct 2026 03:31:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8EB620040;
	Mon, 12 Oct 2026 03:31:17 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 03:31:17 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com,
        Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Free the queue pages in error path
Date: Mon, 12 Oct 2026 09:01:16 +0530
Message-ID: <179177344614.763259.9970100482539229999.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917072839.78857-1-gautam@linux.ibm.com>
References: <20260917072839.78857-1-gautam@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX6LXM+vhuJtIs
 aIe7xbtY0nr+IYCFuLix4qsAYUwj9HpiDFrSGry8KZJijzFkkEZ5iw1rV7KpswcDh8WeasS31GV
 G90rugeJt0ddbR05uigLR2jZswPYO6teYINByuDZmVRAlpvoVLHnltXNiHsy1KnkT4By3kIEZsu
 GXsJWgAaohvaVIKAvhYJ8dh+BjG3Y1PRgVVuecCErMTqJt41kUB0agBe89i7G8UH1wD7LOW/Zev
 t8YfDxfMLyi71lUt3dTc5YrqJNE2G1hlvqA/Mpl6w0RIxTnxAkO65D6iVXltc72zTafXaYJkMeX
 Xv+euUsdaiOeeYzJ/ga+BBDa8/toyaaLsJmW0pLLMpRk/TAxHR5aqH+4e7JRkflsIwgf4AceNnk
 bUN4KksHV/7+KKvvC1BIclT7XNbK2SEHANi130RpZ+iF4zpcm2ntrIkXERHvSxm1luD7L9dD/9/
 ilBnbhextGjAx2jaDNw==
X-Proofpoint-GUID: ZUhnLisb0JdbXiYR0fZrFgvjnhlY7pBi
X-Proofpoint-ORIG-GUID: kz4v_NUL-9O-6lq76GBQDGFZnZ4Arn_F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX5MWkAQ8TXWEK
 zWPm+7o2UkPD/k6B25MpuiZ34yFqcNizT48H0Sb2wkQrk56IE7bPCKINLLn/OnntPxrhL602B96
 ibH5sVhu6UmcRRt5U9hI18QJeQca5Nc=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc548c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=YPeKUjBHaTT5xTazbGUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120012

On Thu, 17 Sep 2026 12:58:38 +0530, Gautam Menghani wrote:
> If the xive_native_configure_queue() call fails, the qpage allocated is
> not freed, which results in wasted memory. Fix this by freeing the qpage
> in the error path.
> 
> 

Applied to powerpc/next.

[1/1] KVM: PPC: Book3S HV: Free the queue pages in error path
      https://git.kernel.org/powerpc/c/daf5a5a82ca37ccf5b03c103ca44717b0b2f3e0b

cheers

