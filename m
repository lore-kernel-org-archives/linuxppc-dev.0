Return-Path: <linuxppc-dev+bounces-27202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15449C88E64
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Sep 2026 07:20:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjxQF4fbsz30Pp;
	Mon, 14 Sep 2026 17:20:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789370453;
	cv=none; b=a6UD5PagjGv2MCHjWgQ+oTdQGVPINj0lCbPxmFneCfUXXP+7ydnubqigRzdarz72+Rzw7uFu+tTSgvMqVa8UIqeKOh/J/K6jTnU3/bJDegHIz6FzxO6R6kJHJvUbV1q9WUAp+BG61Fqbowk3e2l+3GRxGxGpREkPJ2/6tFhfLl56Ms63Xx5cUGW8eCvdApbA+tz8K5JnSriap9zGV2QRYaWLZhqAhJoqr4ohCWVP61muXCVz8w/V3/3wONewcyeLNwjZ7VCZ0dRYwJ9qClkZK3gE4uaUuACHr5yszezcemv65b230/4/ARqykjnLMxqV6lux+IYRBV/I6W4McOwlrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789370453; c=relaxed/relaxed;
	bh=xVSilR3odMjYzoMt7znOsXEZ/z5TiRV/4SUAPQDjfr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4ScPeGai0uLQtyAvgekjhBzH8rpffLdOj9zC3rsqryjg7fp1k4qfOP5ngJkt08Odvo53RYZ6oa20BZ0ABg8dy9RfBohgahGB/uWc5HWD2uEPFGag1vy90yROpHw5e+KZ5U/0DgRJbNcRL1S6w/GiWqV2+sVDFNMz6Cw7fxvmIQXD/NAaGJJy7J3NJWtJYa+0MrKeU8J2bnuL6SnpAY0kGRk5iTekj7okpgl0iuPj5oGHNKUgrAezQe68mKWAW6bWSoZRvBSRfJcERdZc6Uf6Zd+TSe+qfmPYq5BOYoDWF8ZmiyP4q510hSMN7gUJqxXMKx3PDm9SXVb3Q7mPeOPhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aU4+sgyV; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aU4+sgyV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjxQD4Y3fz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 17:20:51 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E61qk21073839
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 07:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xVSilR
	3odMjYzoMt7znOsXEZ/z5TiRV/4SUAPQDjfr4=; b=aU4+sgyVhdFYUGahr1a1/b
	XRhIs4IzJNTaLz5/5JPltyiVP8mhUCTezMMpVlllnH+lRiDNug/ZwNYK1404vCve
	UUIPm4IQlvOkEECLdA4TB8C57ZpowGX/PtCP7lvOXDTHBi+oLybLx6LnmsLsD1x0
	jUW0FJojNTsx/tU7apNXqniJQ3so17urruaX9RzZpuuateHRuvQMZeuimZ9A/D9P
	ZF+PhZ3y2oZBCGTzIYrJqgpmBvexHSyZ/oFDFVofaCVtuF02aiwKkkWyi8XHx+as
	NJuqQgOQ0IhHPQDX+Kj0wwU7v2wEPg+bjs+ye2c0Pml8Jf2i399da9iY2bsH9Q7g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5hfx57-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 07:20:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5o5ww1813966
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 07:20:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gnh2pvqe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2026 07:20:48 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68E7KjdC39125356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Sep 2026 07:20:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F36A720040;
	Mon, 14 Sep 2026 07:20:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E169D2004D;
	Mon, 14 Sep 2026 07:20:41 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.93.83])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Sep 2026 07:20:41 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Athira Rajeev <atrajeev@linux.ibm.com>
Cc: hbathini@linux.ibm.com, tejas05@linux.ibm.com, venkat88@linux.ibm.com,
        tshah@linux.ibm.com
Subject: Re: [PATCH] selftests/powerpc/pmu/ebb: fix lost_exception_test hang with sched yield change
Date: Mon, 14 Sep 2026 12:50:40 +0530
Message-ID: <178919368035.441103.11272830182061296758.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903074036.63309-1-atrajeev@linux.ibm.com>
References: <20260903074036.63309-1-atrajeev@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX+dBvFOxS87xK
 nv/GxCvoqF+q19jGJ89SqVnQBMVVMuHFV+44mZ1dFsLx/CF7Z4gyCjXmjpbWmdUlrbS6Mu7nFLT
 NmDgGVXgnY0YIgbA0q0rUqBmnWIVfjH1OQwA2CCCpyWLHcvMl6d1WerVFiRXyfy5rnqHUd6QpaL
 X5dGW9N62NOVptZpdCK2j1b5BmEukPJ4I7vWnmsRSZongFeu/gRNFF/6Q0A3flQdPhgnIt/PMKr
 O98m+BXcQnWPP11mGEQFTb8/W/4VS8N7GQgz1a9M04WVJcVF7aVM6DZPqur2EiM5tPWBJqthbEK
 iwmQc9+YrFx2losKEmebGgq7xdAKFjzOIjxpSKPe7f3eLzeC8g0G4n8UxPsWlTERZiAwduv+G0H
 AG5qnD0XGAUWqj/AT6gSelAQDgHiK/sPLVemqdgAxQcwERoa5hKJgsgnMvGnUtnU6OZDxOn3uP+
 s9CZ+FMH0WfGGXq0E4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDA5OCBTYWx0ZWRfX9PwDtXhv0HYZ
 kyOxdgVAVXEUwcQNx+L5tXAKuUIQ9sVFXqUT6E7r8h1QpQXcrY5fhzGOmstOdP0h1NToeOQ087X
 TGHOKkJLdW4q0JZ/2bHZhD0mj3rGeLc=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aa7a051 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=udkqglkMwI8dJt6VmWcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7tQv8rKh4K2gKBZ2BZwPgYDOiBHhTqou
X-Proofpoint-GUID: 7tQv8rKh4K2gKBZ2BZwPgYDOiBHhTqou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140098

On Thu, 03 Sep 2026 13:10:36 +0530, Athira Rajeev wrote:
> commit 79104becf42b ("sched/fair: Forfeit vruntime on yield") changed
> yield_task_fair() to only bump the deadline when the entity is eligible
> (vruntime <= avg_vruntime). When the entity is ineligible the yield
> becomes a complete no-op from scheduling perspective.
> 
> lost_exception_test calls sched_yield() 100,000 times per iteration to
> race the EBB exception delivery with a context switch to the eat_cpu
> companion process. After enough iterations the test process's vruntime
> races ahead of avg_vruntime (each eligible yield bumps vruntime to
> deadline, then advances deadline by one slice). Once ineligible,
> yield_task_fair() does nothing: so the scheduler won't pick the
> eat_cpu child. No context switch occurs, the PMAO race is never
> triggered, and ebb_count stays at 0 forever causing the test to
> hang until timeout.
> 
> [...]

Applied to powerpc/fixes.

[1/1] selftests/powerpc/pmu/ebb: fix lost_exception_test hang with sched yield change
      https://git.kernel.org/powerpc/c/ef17515a8ef88c246c342a6c532aa10f9ecdcfaf

cheers

