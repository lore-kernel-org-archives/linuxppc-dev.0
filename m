Return-Path: <linuxppc-dev+bounces-25244-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E665C55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:58:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vP5mXbz30C6;
	Mon, 03 Aug 2026 16:58:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740289;
	cv=none; b=hfBqio8dYY48XIc4A8LbqC2PIGahCFiIMXOUMkjrCN3smU3Y42k6r6ST106VY1TT6MyMz4EGsq2iG/D8Dyh1ZWp6INPDPOXQxLbWNn3ShxN9myX/QU4qa+xuAXD07FMrh6CFD5IVq8+Kahusvcc+Jnc8R+5CRDcnqwNedrnSomyBUnte+Gb4ckTpEH+7yQFHzmIyRCWBr9UDWOnu+qlfNU7pe+HmpCyVNeDzo9pCDkunBApSZlvH3TgvDYY8Jy8Tozkrz9gps4xhdYC5twBWf54RcQfuZtgu0eHibb3+SichvsNGekIWK/3J7ywt8OdHRjUXPJ23sTqouf2yrKagUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740289; c=relaxed/relaxed;
	bh=V1MuPeqPGNUj3781xVfAo+S7VanrLECLiQKEGOFBJsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoR7Vv0iKxNCCiJLL8faQh1a35MbKpyib8Bt2XLrtKceQBRpY0LXaXDiG1/FLvBirLxxiVMymcKwWOUWa0MgyXJ2Hn1V2j3Hg60V6Sk7Bc7l9OUwEP7+EYZBLsreLH1hkccLIo7llSsXcLqfSPcdtqhAO/DFVv+HC2J6Efzs1j1bEmG1eGTLr2OlM/wNKG+byH7h9JMKeQWm3LuQgOswPMcFCZenZi+ROo8qedgJqVJlVdb+iHDTChzcccH8hv7i06UTZSADCSuBao31SZs0DH4KmRb84OLVN4Uu3yOX5b0xCIf3wlS0QoKj0yU5ZVG2UJdNbfvOGOC6XzlZf9OHZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cF7P4Hty; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=cF7P4Hty;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6vP0H4Qz3090
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:58:08 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lm9N4168336;
	Mon, 3 Aug 2026 06:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V1MuPe
	qPGNUj3781xVfAo+S7VanrLECLiQKEGOFBJsE=; b=cF7P4Htyf+M/3ilUri+Two
	aUyXhoL0Tu5nIiwuYX5E/IloXIFKk8Mrc/mT+uNBd6+jneLVAIUN0cCL3pprLeNk
	rCm0rnEDg/OLCgHBRF2ithecrx/QHldZhptahPBpnPaazciOuyQfD/u0+UyHfmuX
	QX3NnuuA5A6Di8vAKfZ92ANjXBK0fBGCOvlqpxYMbfCigqCKm4ZmiJAziEpPDDXc
	WV7qhNfuUhGddVS59Nb/wnm7HptezniHMsNR3kUoA9JbHJnwBqxIBGwF7Uxi0brm
	IKdpl4gykhudAkjbCulJ7H/i8q2ONETAYxMYwkZgXG8oWrNHuo9O48qDXpWav2dg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77fy5k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uOqq017057;
	Mon, 3 Aug 2026 06:57:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg3xda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vkMd39911784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:46 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B90A320043;
	Mon,  3 Aug 2026 06:57:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15F1420040;
	Mon,  3 Aug 2026 06:57:45 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:44 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Geoff Levand <geoff@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/ps3: Use cpu_relax() in ps3_create_spu()
Date: Mon,  3 Aug 2026 12:27:44 +0530
Message-ID: <178574013463.29744.16614940620876882341.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720231153.116827-2-thorsten.blum@linux.dev>
References: <20260720231153.116827-2-thorsten.blum@linux.dev>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfXx7vokHwE4m7M
 WDwmhjzCy2VuCz2+0I5YBMrSilJk4m6dVrT/fuH6GxgcILSEdcPZHbllXL9Y7yaNGJPj1Rsf5cA
 4QbVtSh2jSshtPSs1xqyozypXE0vYW7WJ4/dHheYRBpF+9MOC+XX2iNxyvn54Vtz8yo6+JeeVEc
 TjzdYtWk6rXednjnAnnBhuWleKccW9S3PSVHTwnxe8RBSb3VIQPNWTjsDBf0HReUCiL8+aEpqPA
 RQp1lag+evuHGxqJD0qtT+DEGMUryL1TrNK5EvgW14IbP5KeOyYqE5iGQygVn4Frsn5wCMjsn63
 iIDKg1a4+YD0ls9TFaeBE/rBHjvLYS8DQGoPALQgYjIV2o51NO9B8uwjzx1qZcUCTglfk9dtLSf
 Um7q8IsJ0NpbYjugKr4otHBd6f1MO7LM1eYOQEjOFsv9ahWhjDHbqO3EfL+XyyjQGUFXYW4aZGx
 LiDQaBiVQCLc1BCHddA==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a703bed cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=1QDqhKSG0xbYqaTIjMUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: u0R0GIj-2jCR-aj20qtiUupCeXLG04Rd
X-Proofpoint-ORIG-GUID: dvzxARnbQLUwiUQgxSOs3S8Vca-kt7jB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfXxuj14FsPTJcH
 b0JbniGHKe2Z8NIsf8xrcT0veUx/qj/53HjKUDYrqVohghyyUTxoyjQHDRz477CBKQzkcDd0giV
 6YNwJWh+SmjTsY4Xk8Zmo9GVD6QuWgk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030058

On Tue, 21 Jul 2026 01:11:53 +0200, Thorsten Blum wrote:
> Use cpu_relax() to wait for the execution status SPE_EX_STATE_EXECUTED.
> Drop the comments while at it.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/ps3: Use cpu_relax() in ps3_create_spu()
      https://git.kernel.org/powerpc/c/6050e3196d97c679ea06c035dbb3c64264c01281

cheers

