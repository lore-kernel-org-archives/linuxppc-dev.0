Return-Path: <linuxppc-dev+bounces-24589-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C655C44529
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jul 2026 09:17:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4Bbr6bSTz2xjd;
	Tue, 21 Jul 2026 19:17:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784625432;
	cv=none; b=cVAOjSZxziAJBcxGUEbzsG8oHJW+wOqu0Mtx39f7H9MCZvGkmj/RO8z+1Yrf04g0HzDCj/IdA6SXZABrL8m68RU4sm8BY9vk+iegQja4HsvQhaNJi6zvTjdpcG6Pn/6rICtEFWme0jDc4yZ5vc7btHm9giRC1HvNcW3Xgt9fCY+hTDP2AgIKponRc5pFkBdogn4nna5LvS4SKr3KL/IS0Ji7KUzGbLRSEowjy7nhKIW53Uq2nZ/h2aCDnePJzu2cIl78S5zm+MnvRb1j/9m8X4Z7Qzsa1BM98i7+3qunx46zEv4f7mQUwR3Y+ZoaWulztRtS3b2bcbWJkDwHP5YPhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784625432; c=relaxed/relaxed;
	bh=2JgPrNutar/imfqnkLIre+0C0eBmg5o+qQyR+gJKdOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HFlQDnhce/iwJNcBwAe09Kci8xue4XGod2+T0MEDlQYcdgKm1vITI6W3FXkJd7t2+mCBDM6AbFizk6Vt9s8ZaSLN2ywrMWHcuz+hpfwnqxnoE0JCYEMMX7kzCaKW/OeSvl6pOLAOHjtRmAS+7i8q1adW75wPDYjRtTFgiAsVi91+idUJzgXW1qd8fCQXo8DJlZU8MbAlicvSNpPo86Zpmzr2GgFYYBWPDcoTAr2uYND7GypLZiw0J6t6PWe8ML1Uo29inW14/4lsKMCvNz2sv0omGN9SHE0kk6a3THc8T4g7o1v/4CGNfkCefL/IsBmB8FE46R9sU0ZqNfVGRIKJhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D34tSwcL; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=D34tSwcL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4Bbr1nClz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 19:17:12 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCpqP1675641;
	Tue, 21 Jul 2026 08:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2JgPrN
	utar/imfqnkLIre+0C0eBmg5o+qQyR+gJKdOw=; b=D34tSwcLyUYyfuVe9YU2Yx
	NXc7GUq8XqMWbcz4DqCIgI9pqH3lgMTRVMSzrDRTszsZWPETu28aq2EgU61jqrGN
	tjw7A/h8xFlC+vA3otvwLy8b7lUh0UYP1kPg3gYK6D7jLwRoPnRVdFis/tR41VJj
	2x4hPk12rv1kAxre6bCTv0yiOZgfI2nMHmrgqfMVnJoVUIWadm0jEsGOTxDq6Phg
	T/7UTC5XgTgqLu6JA40QdnRimIfCkLYc0FyXXb/Gx4E6ttoP8ysO2WxMyD8t/cQg
	Swg5a15oe5rDE3CiDENBXooJW3ymXyylBo97GkhtiCHb6TFkN+LYTCjythZduSmw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77abjde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84cFv013951;
	Tue, 21 Jul 2026 08:15:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy949m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8F9Xp29098246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA76A20040;
	Tue, 21 Jul 2026 08:15:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CB9520043;
	Tue, 21 Jul 2026 08:15:07 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:15:07 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v5] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
Date: Tue, 21 Jul 2026 13:45:06 +0530
Message-ID: <178462153931.1974055.6909734950502953277.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260615091120.84169-1-gautam@linux.ibm.com>
References: <20260615091120.84169-1-gautam@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lOyiRZfWXEW1fDNuk55oN-0owJ5qntFB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX0rIKSSAXdZNw
 U0gRnpKWjBtxjxklcp59HZAmaPX/G/wSDhKtoNPf3bmfsprUBGAj3kGQ9sjAInWAFe+T0r0VnCw
 3ojsjMhNrZxOj2zNuyKnvFGNvkirfV4=
X-Proofpoint-GUID: CQsigfg91z_dWHaLAEejibuIv2NWmUn6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX31As21Q5rR2Q
 PpsGB4pi01S2d6zFNs1yzfECqnb60GLG+pDiP6vCKdcmQdJFA3teOkxWrCZSyeV38zJdBpM6b8T
 NeOToTT5y+ZG6TwMSkxB2V3vKQn6B9Q4IZ6EcT5n/czLGOdlEgAD9xGe39uFIZHraNYuaaSlM2B
 YgicnFDceiUVsaCdXfK1CetSEqdwYj5MzasjHCadyf9d4stpANp0nv7tktYHsQzUI4VuEAvtCwP
 upLSON/+S358XtCvK0Mu/7HlhbpKAVZTQ/uWqDNJ4LXRD+6f0mWPF2l5kl4iSH8cNFnCMvtcXe4
 DIQMRClTe/68tqZS22UTYsIjpWciiiLh/7l+kt9ydpuO+5BKUOyh/NBx/I6Uo6obcoIOGpXxUqV
 L/Qz99UNwNOY3eg6+9cDiSfiBjxFThcE2n2R3mUX+LSWUzU43F8ai7QtWKk7iVTnwaJSSPt5eBB
 GKkAUcyZrpUf5Q3hPTg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5f2a92 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=QaScOLqAlooG59okbtUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210085

On Mon, 15 Jun 2026 14:41:19 +0530, Gautam Menghani wrote:
> Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
> cannot be used for KVM guests at all, unless explicitly enabled on
> host kernel.
> 
> Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> being used.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
      https://git.kernel.org/powerpc/c/fe179677b6dcb4b658586038a811f87265e97777

cheers

