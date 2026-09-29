Return-Path: <linuxppc-dev+bounces-28508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190B6CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:40:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvP6f6dqwz30WJ;
	Wed, 30 Sep 2026 02:40:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790700010;
	cv=none; b=ByzZ10SpQi9qVVewnTD6Ku3sh+sFBYInk+CQa3k5oZaxOf9LIQc9sOqaJdO1X0CUxDgmhQ0FOwpMxHYrdxv4czvo5UL2Lp5TIQbu1Sff8em4CyaGiq259DHfMlRopgIb13FG10+tR7w9ApUb5H8q+QuPAGswixYoGZU3PyAVTPfiToWtuFVcBdXgoFl7ltoVTWG/qT8dD2SfwNza9k3DqLGkF8mSMCOsPFjBZn9xfSqKGLEbZT3Pv1aqO0P7A4WtoaKQyMAdCXtRt272Cx3LEkNz7i3kAYKvvzuyMRbQaWdq5uIslO2s8Y1GnNBDCTxSkdg8MriY6LQk3xr7OaujeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790700010; c=relaxed/relaxed;
	bh=3OoNFS3jCJrMuG+OTzIRVQAr779T6sCKddO+/uLriWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpUWmIOs6jdjX5DNalhgpvex2/P7O8Tzr4zeOBAgbWsUP0leEIi+5wZv8nSdxkU4rcCO+7kcM8Lxc3x3NSk6saLiq3hCJ9sS4012CoU9rchZlMG0Dp3G93HTTowErKIa3ybQXpRKxsxYUqB3wcmOrFuPTUgaKXeGSzyktIbmWPJBSWx9zALiWUwcyrEh7o0mh7zGCzYn+FDB4RrJxDgOTCay0nTEIoSE1PvRDjhePnWCfjacqTjCa0pjjCNymYm9iPOAhrmpU9NSVYPSUBJUWX/IFsnu6ZJ6xeZ4eOXpSgBlZW2Uk5w4lATub03SBpGxbV2EXoF17WtEXnq+3FODlA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i54dObVD; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i54dObVD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvP6f09crz30Vv
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 02:40:09 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TB65tK2784022;
	Tue, 29 Sep 2026 11:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3OoNFS
	3jCJrMuG+OTzIRVQAr779T6sCKddO+/uLriWQ=; b=i54dObVDMPK2CrNMaVsnaa
	u74V+T1DDtitI5oyDlepTlEhxEEBAW5wIXxJFLyVcyRmfLuM5mKNPQRJS1VcK2EC
	Gwt1vpJefC+y5j4Q+NSeUotc7gWJcuxoHQNCWaQDm7qAHkas3Vd+jcikORBwpHUi
	kJ7zs2fdhjNFWYDP+kseybKV+WwcOIjwCMP381PLRH4Nr+sysqX+lEdeU7JSaeHX
	POEii5fw0yFfArWCjCaa/ERNbfMfXxw2h2S32JMRbDwnfuP9lEppNPp0Dwmah37N
	8nkNk+t5k0wyzi0BCoxTILoa76Y/5CYHoy56+jkP2IL3lrdNwPNxrLtRpiX5xydw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fe63q0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:31:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAlZD01617030;
	Tue, 29 Sep 2026 11:31:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw9kdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 11:31:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68TBUwQr46727622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Sep 2026 11:30:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F0902004B;
	Tue, 29 Sep 2026 11:30:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4423A20040;
	Tue, 29 Sep 2026 11:30:56 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.88.139])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 29 Sep 2026 11:30:55 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Rashmica Gupta <rashmica.g@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ABI: Fix powerpc memtrace Kconfig symbol
Date: Tue, 29 Sep 2026 17:00:54 +0530
Message-ID: <179066556651.265207.13199455241158262731.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822081253.86256-1-kmehltretter@gmail.com>
References: <20260822081253.86256-1-kmehltretter@gmail.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abba175 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VdFJkbfUe5Q2UCklYtUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfX3xyK7o+0ep/U
 j0nt3cK46n8QCFntxEMd47ftAl3oblviSEVxxS5c8RV6DMXTeZCOz8B11cjr2oqmN1Lm1IS4oZI
 4OsXHEbRfrWvscLYxupQAFH0eZnuPWU=
X-Proofpoint-ORIG-GUID: OGc2UqwpFuvOuyUZ5Mw5V7QdBbIkOdTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NCBTYWx0ZWRfXwm3DwSbyJUa5
 DFTsSPzFaJAnTvhtSQgjcNL4+5c+mvuAcM2wI5GVh2E1E+tiLEAqhiIWP37T1ch122q8HTIt2RS
 3YlnIA2GjLqv1deYGRpG9iRwoar+Bc87fqQxQhiYMjVXuGXte94LwI4ogIW3vzOBLFfexZCQcFV
 ZWvRB41X14bvBqg//M9YIYEKF4GQOcQMB8XK6Z8htUnMoJV0vGG3Ogi+gMi4TpDw5YIBl3Kizur
 wa0AlDoHccVTwo3uHETNXfOoSEZ7/wJrw45kEupGEtQgK87bDad8otLYJA8v2T0pimFl2xCModO
 kUd5E4bPfAWKxmn7p4diCzu5+ZpuckdzQk+06TCFDtDKOSTvg/xQYicsuZpNyciggZd7tmZI47e
 mkay5FJa9bRR6GlsSxkOi41unDPpzEvwn55ZFd6s/mscDvutERwwllVKRqqQduQBDvPoaTKQDkz
 MPOzCmJ2X8KHFGqOUJg==
X-Proofpoint-GUID: LMcyk_wLbRD0slPRodbZol0VAecP0H4m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290044

On Sat, 22 Aug 2026 10:12:53 +0200, Karl Mehltretter wrote:
> The memtrace interface is controlled by CONFIG_PPC_MEMTRACE. The
> documented CONFIG_PPC64_HARDWARE_TRACING symbol does not exist.
> 
> 

Applied to powerpc/next.

[1/1] docs: ABI: Fix powerpc memtrace Kconfig symbol
      https://git.kernel.org/powerpc/c/cb3502d2e57ab2b73cee7d69756becbe241db0e1

cheers

