Return-Path: <linuxppc-dev+bounces-28971-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789FBCA5FED
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:38:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzgPt5gJJz30St;
	Wed, 07 Oct 2026 02:38:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791301090;
	cv=none; b=DraIl0eeT37etHgNoAa3KDGi8pLPTJ6uMolBZLumIgMFG8FTsonKVcLQy57VHG8w6JbxqqF8APGdnYQX8cyDOjQktya4NAMO2waIK2B77VVRSIxoufzUt5XW4EBrMvy1Q3sRZWNbzor1YnE+PjKjBwmaFznH0685NcP5tJGrzzeB/A4MVKGWMX4aRSgHmrtsZBr2LlKliIwLxZD2/OVhIW3yXUeIbZCnNJcmSiw4ZSCO2dRzibA8/v6bg9NJO4x+0bID3njcVYnv2tCyTANxaMFo6znnA3fY0irnwL1DQdrNZiW18YXPcMhqzM9pggrPW2k9HmW3xiqle35Noege6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791301090; c=relaxed/relaxed;
	bh=hw+blFBkhwq0BU6rMK/UkOL4OaYMHv6DGmpRcUpUguU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dw8DuG7bOuJp6qAlK6FAH0EL7wu68mNgJyg7w3Wrcg/iAJuI3Kbcnqu6uAXV4lImZOB25Fw0BoR3b+y4qW7hq4AryfBFppFI0R5oZ6ALa1XodL5Kdur6DihZdSSbB5GNomSJ4V+7TMNmEEFJUPM4+8AAl+/YDIfPBTRjYG2ad1ZGjj+lqJi1+08zASQukJGRtWTvVJHooIgIP/BRskhv0oWPGzJpoPqH58RsEaTW5S87I2qtIA1WmqERoEI0BT5HCmbqxM8kI1sokVH9J99sCGAQ1x/TXXqcKVO3pTBVQl/fq1qejTjBYmm8KWamRGnV+Ap5z5BHRWKKvDqoCktx1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EvwzEAHY; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EvwzEAHY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gautam@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzgPs3mzVz2yjw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Oct 2026 02:38:08 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696EZmLf4059342;
	Tue, 6 Oct 2026 15:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hw+blFBkhwq0BU6rMK/UkOL4OaYMHv
	6DGmpRcUpUguU=; b=EvwzEAHY/XMaMZhSwDCpsVLaoWZsp4wwwO+VQEDtzT5TQS
	NkMVm7w1ANBvr62FzVOSKhS1wLdK5rwyUWsA15jNp1Vhbj2LHn3t3qMrZO8gbBkA
	g8gn0K/3Hf7SiYpAKLjniBrhSFMSkq4yrktTDRb0DJN/kvuHVfd/dSD1NhnKHhnN
	Dz3GU/zlzRV43qh8b+t+iY2fPtnZaWTw9lZQkm1CMBozTIqWv0cO2FGHnMGLEkYA
	OVJN4uNuG9Anl6c4u0hB+VQ4+WK4x6EzZ8bS8RsB74YUkE0XRpsKABB3iv8Fak23
	wKaxjiXdgoyXD3rhu0BsamswWZGKv0cWBiYl4Scw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74rwkj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:37:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696EWRr8405232;
	Tue, 6 Oct 2026 15:37:56 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvtmfm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 15:37:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696Fbqe251183922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 15:37:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08FA62004B;
	Tue,  6 Oct 2026 15:37:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5414820040;
	Tue,  6 Oct 2026 15:37:48 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.24.208])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  6 Oct 2026 15:37:48 +0000 (GMT)
Date: Tue, 6 Oct 2026 21:07:45 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, chzigotzky@xenosoft.de,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, msuchanek@suse.de, ritesh.list@gmail.com,
        harshpb@linux.ibm.com, amachhiw@linux.ibm.com, venkat88@linux.ibm.com,
        nnmlinux@linux.ibm.com
Subject: Re: [PATCH 2/2] KVM: PPC: Replay pending interrupts before entering
 the guest
Message-ID: <asUSJpOzKn3eoELi@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260928110411.844582-1-sshegde@linux.ibm.com>
 <20260928110411.844582-3-sshegde@linux.ibm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928110411.844582-3-sshegde@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Q3UWwK9jQEUaXJXEEMUdLh2-0tZii7B-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfX9rD3zSQ/gXer
 JJFHvSklUES3z2EkxuUcU9eeCdQrMaLy/XOZQIkw8zDdicNxYuVEpkAcTTxxvstsh7OcZe/CYCu
 hE5FG2p1rCRgP10qSQI6kx13DOAoSlQ=
X-Proofpoint-GUID: SMNSYJbOe9yE7vRVdSkN5CJHwtRKCNBo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA2MiBTYWx0ZWRfXy/U72B4Ue8J7
 9S8L+5W6FIIeNphLtGVha39IO2+QLIGriZsX2eZvDUigsGo/2wO0Qk92VvRJ+puGV/Kaup4qHcJ
 Mwq/BoBooNf8B/6E9CTOxAwLQNztXZw6QXUFJVKFX4SgFa7bNBfa+su8HPG3B8jR+xULitz5xcg
 5NY2qUaeyNST+H0NWwOxW7pgDnr9yxwJalRIjBupQqb/ibkzK39Kx4IAKFm2sZBPs+LixSwcx94
 NkNuw1hdwM/hNQk7oxXAV3aSLXzVZ43+NBDeNvffd1aPzwsx/TTiZcs/yxizhnj/kP/pV/sofd5
 qbh2x3xebucjrvQL7xC5QuAAGtnK7XOFaAQvxu/uzHMA8pwJE7FKtzvLsCpKo2u8SiEi8JAhyyP
 1OoOr628hTwWKUiT6cmnaWzTBBkG159R9uKu2GM5WAzznhFLyi/omgQIo5SKkpiUQUlhpVRXbSw
 kVKMws3dfP8o8VQKtWg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac515d6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=iqMu5c-nzsFV77I-cpIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_04,2026-10-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060062


I'll test this with our internal CI to validate the change. Will update
once done.

Thanks,
Gautam

