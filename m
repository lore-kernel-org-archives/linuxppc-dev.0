Return-Path: <linuxppc-dev+bounces-25249-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F2AC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:59:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vm6h2Hz30DZ;
	Mon, 03 Aug 2026 16:58:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740308;
	cv=none; b=Q3l6YBGhW2zT5hzV4X/FAdUVz7Meb4bFduiLCATjswbRjNJr7z8eJuljYdzfu8EKGi2TYfU0P/dZjd51u6/QOevic0f3esmHUnBqnwniwU4oMZBODRiLyMjW0RGX/vT28yBh8NkRitZhWoxMNAhEEiFBIjmB0GGavf7ocJBLpTKAstgN5IKYs0obyz6w8l1sbElKK14k8s+iHcVtXZGfAcUi6VE4yAsBshKgjbqh4TaZK8kJEpyyRwf37/S8sVkQUfP76OEFTpa0h4EzuCFxM/vBYx2y/C6ZNs17Jy7fGw92H9uq4cNq8xw+Jus10H39lHd0cjOh+Zy+/GEO42vstA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740308; c=relaxed/relaxed;
	bh=HK8Sih/O7/pUQN240tbl3whlGaMSyOyNdnlEdAmpDHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KceZ9vqz9/JiTBY5ZlBtF+EJUSDAF4lUSShr4hwbFEijcqoBtxsiva9mwYuzojfOxJPvtS2AfoGcS6MQF9J1v0OduI7r3pBiEC4F/LO58x+ncTHx6MK2qIZtPIMHYdscS68BoiYlFWU+z18PFk/j1HwNSb1WDVN6CvjQGSAk/YmXVkMpCENEFH9M0c7JJDbcPWgScLcjaaMByE4AxKa80DL8hXFcWsFzTzMDmo8IWzPcSD0LZAiTB7u9dd2BfPvf3TADbw1t4I9UOf/UDyw6kTZNEiP9MIEsacp2j5jJWPsqfvNeCcwrNadqJzQTAMCgp9kRKb39ep0Q5bH7pMHKQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PfFPEZfP; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PfFPEZfP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6vm0c7Fz309r
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:58:27 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmVuW169288;
	Mon, 3 Aug 2026 06:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HK8Sih
	/O7/pUQN240tbl3whlGaMSyOyNdnlEdAmpDHA=; b=PfFPEZfPb6jONi402oFI64
	h3cfqXxMA00vJi+yg5VtaNK1Aj7xOwF1+a/zLoIn1B2CVhUdm78JWQ95zlN+Teen
	WhKPh3MPL8nf/g98evh6vxq9BU9W9vXy07pZZTOKRlMJP8KhzajwMrkonl/Z0XbS
	OvtBFeocU5LOmk8nfY5rsvUDvNE3iw0saJIaTvXCgLCmFl19dDozF8fI7/ngcRXS
	OO6a3nX1biF33K4bU147xS2hxuvvQw2RbLtNKgC9ljAZM8wutnITtRC93n+tqj3x
	lIpHnFS+LGefgP77jS87D+gUdVrSd9wzj3n6iW2isgFvfkddIBih5SzGKGJplKDg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fy5mj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:58:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uSuZ019404;
	Mon, 3 Aug 2026 06:58:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qc9mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:58:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736w57329884786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:58:05 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C08CF20049;
	Mon,  3 Aug 2026 06:58:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E14462004B;
	Mon,  3 Aug 2026 06:58:02 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:58:02 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: peterz@infradead.org, frederic@kernel.org, npiggin@gmail.com,
        mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com,
        gautam@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] KVM: powerpc: Use generic xfer to guest work function
Date: Mon,  3 Aug 2026 12:28:02 +0530
Message-ID: <178574013459.29744.14268082002008456960.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709092140.1753715-2-vishalc@linux.ibm.com>
References: <20260709092140.1753715-2-vishalc@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfX8ffrc5J4nAHK
 vH0+Q9XBCLdiegmcOYxvyyKNnvUxCP2KvqsQ3vz8AobgUwn0UdWI4ktqo85no3m5pIAi858QWg2
 ca3jDyRpGZdhxwpthZznO3ZSKNREhC4ReXx0xmg6aYa8AvX1m+P+IBHBnh7uhNJNI8hYqBnGKon
 X3UuoW1siD9hmJ4qFzlOKY8vS5IQ77U04IS9T5VaesQ8KIA9ecOGd5ts1hYufo/tr+8mDK/MO/M
 kRr5aL1pyhkB8iqmHXgAZ+LRYhzIoe6V4Bwhg8FMRUMW4srptT2OsiQBAslfiNym3cDok7aSmsp
 fvFNfg+nwMMqtq2YgAH87SexYcsN9g4XK3YcM9NBW02N4/Kaw2b5UO3Yuo3czZKIdGBtPdaXFam
 zs8ulExvMjBXyCnVfvgCBPRlEsZkhwwTApzcl1L8ESQRbIW+X2JJRn/WZu+CRxij2iatMYcrHO1
 VlZT70Qfvi5/ct6gMsA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a703c02 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=HOfZ0xPUYLTITXtUa5IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Vyf5O9lbPYgGCKingTMYhlKUBhx8kaK9
X-Proofpoint-ORIG-GUID: rRkzfVMjvXWlizzBobUaxG7SB7_HjGwC
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfXx5gDHJcZnTEF
 PCGE9pTuihnUSK3oXlAa6BGMTECBz5mLP8zhy2kgLO280TE/YgfyTnsDyLy8jInMYhTdlSioHOz
 9J492Z4c4oK2+kKqOmFLWY7AyN5c+UE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Thu, 09 Jul 2026 14:51:38 +0530, Vishal Chourasia wrote:
> This series fixes a KVM scheduling bug on Book3S HV where a guest VM
> under a cpu.max bandwidth limit can run arbitrarily past its quota and
> then appear frozen for minutes afterwards.
> 
> == Problem ==
> 
> Since commit 2cd571245b43 ("sched/fair: Add related data structure for
> task based throttle"), merged in v6.18, CFS bandwidth throttling no
> longer dequeues a task directly. Instead it queues a task_work item via
> task_work_add(..., TWA_RESUME), sets TIF_NOTIFY_RESUME, and relies on
> that work running on the return path to actually dequeue the task.
> 
> [...]

Applied to powerpc/next.

[1/2] KVM: powerpc: Use generic xfer to guest work function
      https://git.kernel.org/powerpc/c/12013e3d4695721ef83b2e32fdfd20e2eb9b0cc9
[2/2] powerpc: enable to run posix cpu timers in task context
      https://git.kernel.org/powerpc/c/c2c8844316a12c2e1a3314e4f021815dd7fc7b47

cheers

