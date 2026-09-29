Return-Path: <linuxppc-dev+bounces-28503-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12356CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:31:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvLGd2dh8z30WF;
	Wed, 30 Sep 2026 00:31:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790692313;
	cv=none; b=j7AX+YnuysuUKoUGLD5jq9sh28JrcbUQtRh6OjkGAMoPT3ao4Z+lnE7pjzmIhM2KtyQlg1ZHTGaKaXwglgIKeNPW+wy4E2jrAGe/iEv+kSGBPn5DeJVsUw1JgO5fSQOA74810/lQSLz5IqHfQ1K+QUvWwLbRqGLzQ1drkEj+d3CYZ/7mcCrvNTBqkYWw31x2F+Rhl0RTeOd9tJXBCkH8iWpC57c+TfwOKBrqs+jDakz1YivVdBBU36+EY6C4Q4QXJ84TKMaDyTR1Ezw4lUgk/Ol9gxRxUYeQEXNXqMtX+qPuLhMLAdoH9alPiFTg3n/N3NuC5Ya1UGNrn9qcklLYWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790692313; c=relaxed/relaxed;
	bh=Cvf5Xfu+khajZRhnM2vhFUes+Kbf/fmv87LY0yilRxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B1c61A9P5WxQHoKRpjr7u5BbMvJ4JDEZ2KnnCu+6PLYzErizZs1pP7TlG38q6uuUXqA6hEobzD+jNYYAgOjxps974aS/98eX1R2T4fy4LI+o4/TX3uJjNsDIvks+MiVly4rNrfoppmgDsgk6uPIIvt2UBbuM9RdBSw2aHcrbRtHQ5NkrnsqRqtf9Js2q2ibnn2iXfkkM4drcxbN0wE9lcYrbrMyvtfW77umTsIM6ptABdL0CZPlJATdVtixGLHNkf20AweYcjS7Uiag43DxQirqHjNvN7+ms/jqlU7/jr54wpJZdX43+zZH1JXip51cV1Jjae+QMET48vD5U4paOFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pp3s2yHs; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pp3s2yHs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvLGc4L41z2yvy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 00:31:52 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB5Lvt2187741;
	Tue, 29 Sep 2026 11:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Cvf5Xf
	u+khajZRhnM2vhFUes+Kbf/fmv87LY0yilRxY=; b=pp3s2yHsuRE+s68seff0Rn
	CzE9bvDk6a2aoGeiOHkWGnZVXSYdQxnt9IlOWY7g1/hmBCR6OrZyy2QZbZAO4aHi
	mHyVWo7SJUrVJq78S1bGIpGrM3OjYc2akMwJttV+5e67A+dXfySgrcsbk5/mdXzs
	nirg3qcvJwwKVEQY2euggXjUAnohWEoZ/Y+odXZESEo9YhIZD36+q/19TCn844ql
	xIm1Hp5QtNMb6cWNSuHkTH9n4wramp+QLMRn7qkFc/WvAtthudFMy/h2HbFnGTLi
	IcmLqs8ml1l1b2bUfEue3Bqf/KeqRGM1oRf2yVkz1Os+WruMSPaYdRRIg2ykueHA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr6p89-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlWOe1617007;
	Tue, 29 Sep 2026 11:30:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw9kcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:30:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBUsVj47776004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:30:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 738EE2004B;
	Tue, 29 Sep 2026 11:30:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E93E20040;
	Tue, 29 Sep 2026 11:30:52 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.88.139])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:30:52 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, Bui Nguyen Nhu Quynh <kaylovefoss@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
Date: Tue, 29 Sep 2026 17:00:51 +0530
Message-ID: <179066556642.265207.5042470829768833413.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918143124.9913-1-kaylovefoss@gmail.com>
References: <20260907145626.7675e892-56-amachhiw@linux.ibm.com> <20260918143124.9913-1-kaylovefoss@gmail.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfXxQrIG4TXKTm7
 kJgmDjFNCK38PrsZ7/iZIncsD61bt1wPlYOqhTTJ+TjYQobDKPoagF8+P4FpRFXxw8iiHWCq8jO
 vJ7yEebkb7iqNeYtjjZeX6litoHUPSvfTyPL/llbprPY1F4o3f7I25hJh5Tp8gugrCmTD+8DgbI
 f9abyQiuMzIKDgLir+gy7P/nUHFCMAjZxthq8BY6V+aG3bBtAXKytn/deqt4i36Wt8xN34fHPjI
 iEExOu+ELtxAvmobbfLTy3OCjvPf2dVyPkVwLtVNw2uNAIYT6kk839YcyrH9AxNMAPryU0f9b9a
 +3qCLD7UcPk7iGk9LgUrZeEzVzlWBC/CELouE0rWBwKbViKU+FRrq7QBvdLcj9mQUk6iWCjxoOK
 3EhwY3Ac9Kiz9DfgXva3HF9C+l6r/uffUa8HJpjdlS/qsQ3jDm8HK9g99o4CaB0DWpgvMojJQml
 faIBDsk9f23sobRPmOg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abba171 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=YIANAUWjHg1vaRIBkk0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: IS5Q3jFlb55IySXQVDdL7Wgcz21oD-tY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX69obAp5echqk
 44bhsbuKdLBxVfDNBI1r2/XghGQ8e/rhHlrGAVrSTh6otrG0BQTXu+Spke7ViQRIug5E6C/WIik
 K/E9syQNz+xCgWH1RqkQ/mZK1ADIR88=
X-Proofpoint-GUID: HEir2pvLhUj7b05oo2dcFlXWw7a4oYZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044

On Fri, 18 Sep 2026 21:31:24 +0700, Bui Nguyen Nhu Quynh wrote:
> The kvmppc_gsm_refresh_info() function incorrectly checks for the
> presence of the fill_info callback instead of refresh_info.
> 
> This can lead to:
> - NULL pointer dereference if refresh_info is NULL but fill_info is present
> - EINVAL return if refresh_info is present but fill_info is NULL
> 
> [...]

Applied to powerpc/next.

[1/1] KVM: PPC: Fix callback check in kvmppc_gsm_refresh_info
      https://git.kernel.org/powerpc/c/a7ea67879af09438d38032107b89a62739b09e96

cheers

