Return-Path: <linuxppc-dev+bounces-26876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70327C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:18:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrGk3Qfzz2xYh;
	Wed, 09 Sep 2026 16:18:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934718;
	cv=none; b=AeCmvSCqRJtDtGipzr/1oHlvuFDEQjW10FgNm7U1eOB3gaMrsHiWhnHo24HajtzGgOwjXcktEwQ80gBHumeXwOpU9ZbEO7qUkidXmaydcdrblomOSMusZ/9YW5gUeeFiUKYLI7YvuCV97JTaJOsaRrHSlt0/4vBR8C/8szwUkrv4vHKOyKFQUSUl2wFsqWNROdMi2ScXmuKUGGyzxyAu2NOoqEZQFMEJCMr4WLzS6pAdB5GeSdQIxz6yf/hdeilMeVQmvvL0iK0vpUWwuCCWpMUbCHnTXBVu6vawNIafCM0UwCQ9vFvpiQTMxoFmLBncTILfTYiUpnUutY+F5z8GTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934718; c=relaxed/relaxed;
	bh=GQdzyMRDDJLF/c5lWhUdyYPZr3gPWmSVnVj5FrwusNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EmWsQlsKgUmrtObnaaTxrQRBM2AldhyTH2Y/9uTJ6aNhoM8cq22pHp/udN0N0VyTb4ZNXiPP1pdFkVvsma+cknLJeQCIt8PMp/Q7vQ0FWosqB4S+6sjxymX939d7J9kSoZW+et60lqmoJXCrGB7VvKRNBhumWvDcq6xGJdUcyLKmC3nHHTj8BTW2fibKu3GdBEslFCRrwL8+woLWpSjlDpBoKPC1vBlR3C7RaD89s1NegcjOUo3+LMe8gTtlYvE9Q8TcpNEqbxY/tpToie+NMu4xaRDv4XGk+1wXBfkujeMUIPuBijFZ9dGIj0n48fh5iwMTtTnBup6T4WXaBGoo8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jV2FBGjl; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jV2FBGjl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrGj40vqz2yv0
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:18:37 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1ohL1116906;
	Wed, 9 Sep 2026 06:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GQdzyM
	RDDJLF/c5lWhUdyYPZr3gPWmSVnVj5FrwusNo=; b=jV2FBGjlrv9BKspWsifNsF
	q/JRHXWtmOoctB6RD2XhVS+WJy1rsh4Xux1HUDdf8+IQeVs8BDi12yGDptNjKHmH
	lAZz2TrGvrIOgdOybhELksEPwUFnzR5gz2yiy4sVFd+sssbT3eOKyLgr8AT9ba6k
	YV2fKgHtshMjizfbohWBg+z2TMnT4sa4vCsgbwnoiv/77gYPVZmFhccliiHqjsgn
	FXSNdzErEZXSFpDdspGgrhExPi2d4LveY3w1WdqKZ1RgFtgfxyY2xrCGsKPOA5K7
	fHcwNLofrTUEl12vBXwjY/jYQNcVD71n2VaVf2k6a+53EY1y8nV2SXhgmTQwvjog
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjruq8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BF9x027871;
	Wed, 9 Sep 2026 06:18:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxwh8j8s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896ISmT35455418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:18:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107832004E;
	Wed,  9 Sep 2026 06:18:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D545B20043;
	Wed,  9 Sep 2026 06:18:25 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:18:25 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
Date: Wed,  9 Sep 2026 11:48:24 +0530
Message-ID: <178893459266.174069.9032555408999243668.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
References: <10c86c909f870d90b3094f76b692b44ebe9caeac.1787976185.git.ritesh.list@gmail.com>
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
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa0fa39 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=4rLUWpDMcftmeZ8SJrQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfXzCJK3nd6/Ohw
 E9jtPGzbCsR0Y2ADN137T4fDESKqRvSMJgXSfo2jnac2xLZDjHrOu+/VNDi+hLyQV7m7N+pgPEk
 GLvf5G6VOAM3M6LTqJ8A44/4zBUAxVk=
X-Proofpoint-ORIG-GUID: IX1ad2RO39_8DDvUwaiZWZVF4XXUfngK
X-Proofpoint-GUID: 8b7n6re8lDBEVf8IFmreZSSX1lMB7HqM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX7lzvb+fx7Y4M
 3eEQj59HKqv8AwJLj9GnSYhZN+W6ZDoawkS/mO5/pgVwWBk31whUBXfX3ryfHVy3AsVHUIvI26j
 9fiHwbuonwtt/7e0g/ZPRqa+HNUa8qNMYw5Z44DqypPJICwgjvibmc39pQcSqILqpXRI4CyVHBL
 eID1QtvvMukIZuvZFjdP4Se/LhR8SGHTsfYaiEqYUtba66jRNbHX8CrlhuGJICumbq8gFtEbqo4
 K8wQFX5RNvTdZDWMJFmNhcAaiz808DyQV56cL/bkFRiSFQag+uakVhfQoRpvKWraztG86i17nUG
 vbD2rPjuk7OpLCanPbOjKZ6j/TxMJtlEa7Li77unWvX6KxS8LiGuwtL1jXdT53a9/wraAkd5/lv
 8n/vkC5p9DotPfzpIy0eCCNkFj2yEipgx3BEll1kYjwr2z4rNTwLr1IHhJotx0kBO0kp7/epHC2
 bLZPiyBn1sig3i1mUOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Sat, 29 Aug 2026 09:49:00 +0530, Ritesh Harjani (IBM) wrote:
> So the syscall return sequence is as follows:
> A syscall return to userspace is prepared and then a short asm sequence
> that actually does the RFI. Note that this asm range is restartable i.e.
> EE is still on, so an interrupt (e.g. decrementer or external interrupt)
> can hit while SRR/GPRs are being loaded. This is defined via:
> 
> RESTART_TABLE(.Lsyscall_rst_start, .Lsyscall_rst_end, syscall_restart)
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: Don't drop _TIF_RESTOREALL on syscall restart
      https://git.kernel.org/powerpc/c/c7585b8e99ad97a0f5dd21e45c90a33aeab0d92b

cheers

