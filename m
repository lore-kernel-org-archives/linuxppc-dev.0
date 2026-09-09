Return-Path: <linuxppc-dev+bounces-26881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8B4C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:19:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrHT549Kz2yqX;
	Wed, 09 Sep 2026 16:19:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934757;
	cv=none; b=QVfdy5ejuT6zi+qIwxHFJxxqJuEujgMBaIbtEyOQNlfK7IoZVESHDpf+CgoA8iDBNUf3nums2CF9y004u3DHCa+ZIukiAT2MgX352R2q8v/wahmIddSejWBBRq6iqC2dlya1HnyTK9Oj9a/gcsXf0eYuEF6pdrbkGYH8w7Q0wInK3MmL+CfxYtxcsi7Ntyu1/oDxM8BvYa6QPSIhgq1ynqh/pR0iCO1ZrXUl6ef2azFUnqHxKiAvh5MnxWNnGOUzHVUSgzaClv77IYxRL7i32ez3vNX1dkZkh1zoiBvi1pgkn/n/ESRE4fdiQO0rg8UHM8rt5Wx9Eu/jicUTR2jF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934757; c=relaxed/relaxed;
	bh=36Y+28hjQ9L+4NyprQcBwKp45JSBLhHqK21qer0CriQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEc/93Fq/aW+cOXN5uaZVowkuJJIYSKZCvYcvR54VQVlkGZI2Z6nytdmIdepOS3kpEX0xjuYMb5XnopMGelNZDp0FGl0kw6Txt7Q0lrHDfa9eIt3otJ/6iFAS4R9i+iW5/mZDwmpO5SQx6Q9KEG8rH70joYeSwhsH6DSdHe39tcE11RmNfo10XTKhMIkq+JqJCnOpOQ72rclxAxLvbsULUURbF4h3Y+2ExNP+Dd+ccQNhyp7z0vyy7Uj85JOf3AknM7MtJooopkaGSlzVAIPe2wcPRUHjnzsUwfJaWItQBuIUzXfpKaeOgH7h5UiDeCwT0D0mbMEXnTmE8xTqcL93A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UyYB7qOQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UyYB7qOQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrHS63SLz2yps
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:19:16 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1YkE2299221;
	Wed, 9 Sep 2026 06:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=36Y+28
	hjQ9L+4NyprQcBwKp45JSBLhHqK21qer0CriQ=; b=UyYB7qOQydPc2Jve0iJhkb
	97TLrfJo/UT1qdTmItU9ijM/0GY1JA+QFD2+biffxQ3bFo58/LyYmFcwF7lb3LPB
	pT1P1X4B0kOGm9YLT57I1NduVaqyK8c0IlJOpzmiYvgwMFoMAiSOJhlpBZPSBxi7
	DvkAu1dIQiMr+NLex7NZXSWCH2LWn0frt1QxfhLPRR87upAi/jnJu8A0XKUGs2Nx
	a1m8F59I+7IpQcjlBnOEVlUnli4LDa+jYQ9PTwM2BUtIFiNA98L0t24u7vjvcww3
	Oiaf7hKjB6/vsz90mAR4btChOdpogDRbum+wUpEpWGbs9gfnIHdVnKeieQGuYE9A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhf3q8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BGCM012908;
	Wed, 9 Sep 2026 06:18:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggwdqgrya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896IskK44040646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:18:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9D8720043;
	Wed,  9 Sep 2026 06:18:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1220120040;
	Wed,  9 Sep 2026 06:18:50 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:18:49 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/kexec_file: Use inclusive range checks for excluded memory
Date: Wed,  9 Sep 2026 11:48:48 +0530
Message-ID: <178893459271.174069.12910729821958749066.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810145827.157972-3-thorsten.blum@linux.dev>
References: <20260810145827.157972-3-thorsten.blum@linux.dev>
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
X-Proofpoint-GUID: CpAz1mZVupbDZGSPGVzRlX1b2f3mizfV
X-Authority-Analysis: v=2.4 cv=RIaD2Yi+ c=1 sm=1 tr=0 ts=6aa0fa53 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=Nnc9RaRy9hPcq58hLzkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX3RGrnNvVdINF
 kZLF5c3xmJtHSqaBm4Ujm97a/9dCY57IH4k8Q8HFH5Di7yv8MgM0waQm+uEB/jVHKCkhrDzxwVJ
 8szy/4SnYsfju21fnjDSWZAB44rOkcI=
X-Proofpoint-ORIG-GUID: 9WRSbRZRiPTMfSyEVrMVvw-MfhX8YO6l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfXwq3KtZcuVdWF
 2pO8FrODDzwFeMMas608ZV2uFucJuNn1jfCBM/O9LC7+hXuqfJMSiy2CDhaJpP3e15oeLZnfGhJ
 OGxLaDwgy3w8a7QP5nrkrariw68xaUEwK8QSZuCXPFXF2iTRL9M0blN9XPoULH5JB84PSc+PxJP
 DlAaYpt2+mpT8gJzeLHqUJCQarGjG9i0RcDQL9MGsmmEz0hxZrC3D7BzBnfpZiMVyrDsPbUvdIM
 9K7cPAi7Y3BPngoVhhPpbSQCGzIuxkgwXRQnlfPkh4cH3XSKjwQP8Pnt4D96+gYjqC5pep3AtWQ
 WxdJgEQkMHbF3jBaEH60fbBmsmWLl+GleiAhK4IcNzoWBnn5x7RWHSlzRuvdcy4R0E1U41MtHev
 fz8x0TzH8ReD8Tsu9cxWxz+cGXeQf/UdQwsvpl/NGoImQ+IQyBzSoI9TA7PFivTQGvlqPhVwBHh
 J0ZiPq4fbACC0BiLf3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Mon, 10 Aug 2026 16:58:27 +0200, Thorsten Blum wrote:
> arch_check_excluded_range() checks if a kexec segment overlaps an
> excluded memory range.
> 
> Both ranges use inclusive end addresses, but the overlap check uses
> exclusive comparisons. This skips ranges with start == ->ranges[i].end
> or end == ->ranges[i].start. Use inclusive comparisons instead.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/kexec_file: Use inclusive range checks for excluded memory
      https://git.kernel.org/powerpc/c/449f60f99f8f3cbe80a9bd2242945e827c5ed003

cheers

