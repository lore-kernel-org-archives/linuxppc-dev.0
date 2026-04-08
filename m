Return-Path: <linuxppc-dev+bounces-19473-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACE6FD5F6F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 04:30:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fr97d56Bpz30Vw;
	Wed, 08 Apr 2026 14:29:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775622557;
	cv=none; b=ON9lyeUW+HvHjfgYkr0js1VBiALkHM37kQcvzivYimHj1jCoNmWDQeivWkce293A3k0Am1raDuNx9tlazWoYnO9lvXFinCLf9vpyZQsAy4/d/uw25KR8UiRTt0o7S0E50Iacm5zfFpYnTY5d/PwyibRn2tasCF1W/Aamk1Z1wB8TV/4e/3TrkMzN5mMv72Cemf9O/tzRlc2S8et8zo88g0Dtt4yQuIbliIk+4x4lUjvttLSxtrJ7tHgOnLpe3S6etxyZldQSrwOY5CRVnjVAnMn2CjXNHV8aFu6yiVrES/lbDFlDCpthLdS/IyVabX4UKF/DgcGGD3EefceCYWW7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775622557; c=relaxed/relaxed;
	bh=GrL7AklwYWAabTGz2yx8uEFByng55CRUTdSa4dNgh/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gjO/MmtYbHTsQU8zwb/g+PJOyvD4fhU20mLBfZS9wlMwLnEySzD/C0kJBansvrTMuxFjT2GH4J8gFmnOQRr2ctIs/+ahOwkfreXTZSHsjtCwgr2Dpfozw8R/Ic0f6TpQHq29MbW0P8DGRZXXzFukXvhYcOFl9FRp40uf2OCGZPdKkGD6k6tjn9vm6wd+892JJS+ggI9fKJfqqAHglY4cThfRgDfqajVD/Th6pMkAFYbuPTOOW4Qhp0wEGLRzDgw5eyDYZEhIXCwyErpB/ArM+yqyiVa17T+biwX1cwTyysvh0uMqvwBwanzRILTyHQBW7Ks3QfF5I/9K+VmZvfXqxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=goqIeBYn; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=goqIeBYn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fr97d0Cx9z2xm5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 14:29:16 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638461ZY2325933;
	Wed, 8 Apr 2026 04:28:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GrL7Ak
	lwYWAabTGz2yx8uEFByng55CRUTdSa4dNgh/g=; b=goqIeBYnxQfEwv8jrh5Cvf
	X5+N1YNMu08Ps1fEpPk13rrpr9EOhxC6uadd/JNK3cTzjXJoINJ9xeV2AFIYX3hz
	p68bf4a2zRCknrgvFyTf8jHihKsS6bRmfv+ecHWUIu+8FQbB9TgXp5S2PhviEdbV
	I4w+7V18hPwd0Z15SmaV7oeta5QfDK+Lj14jkO3GUpCEClgTlCGfb4EMvYJJaANQ
	yetfn30F+1aj+9XB4EsXPjy6VHieZo1vB3mYFWn+Q9T9ZYyJmM9CjBNP5sGoDdEC
	f4VwsHZQf2MP8dDRiMMSSqv/YYaoH3O8yqA1esO9ptucE3YFkLIb6ADZWS+YQyAQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2kdreb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6380IjMM030030;
	Wed, 8 Apr 2026 04:28:56 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7dysg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 04:28:56 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6384SsD041484630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 04:28:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10AAA20043;
	Wed,  8 Apr 2026 04:28:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8A2B20040;
	Wed,  8 Apr 2026 04:28:51 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.3.0])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 04:28:51 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: agust@denx.de, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        tglx@kernel.org, brgl@kernel.org, jirislaby@kernel.org,
        Chen Ni <nichen@iscas.ac.cn>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/52xx/mpc52xx_gpt: consolidate chained IRQ handler install/remove
Date: Wed,  8 Apr 2026 09:58:50 +0530
Message-ID: <177562236424.1381144.11818543807303664458.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260119061232.889236-1-nichen@iscas.ac.cn>
References: <20260119061232.889236-1-nichen@iscas.ac.cn>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX8ViZA/Q9XaYt
 22Ixn71nF2qWT3gCqmM58QE4DCKUvOu4vyEG1GwWL2rHyyr6FJ7PWB+BoeTk05cmNXxUreiawB5
 DqpmjeF+WmJLuIUH6jL83LuGHGmsuMzDD6sSk/pAYeQbhjCCZdSuaxj8sKTlRkwekqhJ+3v0UQT
 9AQjLxG5Gp49g05ttSbieL8iCG0mkt59X7BuLSiv1ToIm57EHGIV4/E23k25TmjRyuoMpp72OfZ
 CU6MnxTiYZdANavNMd0QFHwf2EyC7yrFT9OrVKSvWL/bhe6qeRCiBx8+DPnQtsUxT13ZhjYwIBH
 Gi2X90/BEWsc5eoDNgJnBJlAncNTu0LT5hUWnnUVEHD2okYYSihwZ0+/kPk8SPLrEZPtLbXZ6R8
 EwSDF2NNEfh3oVQNNCkU1mzyl9H9dfCKU1hAj3kaOAPECMMpZkEUfJszu40CqZ3YxwWR2Kl4zyG
 0jQJEy8wNuKHEkbGsuA==
X-Proofpoint-ORIG-GUID: 9crW__DA8rL1WeUEvXSLy0f2xOAv28Li
X-Authority-Analysis: v=2.4 cv=e9k2j6p/ c=1 sm=1 tr=0 ts=69d5d989 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=INnRM6tJwyZGxOc-LzAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6pzj7p3xjNze1z-aMufrvE7ocsDBOek3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080036

On Mon, 19 Jan 2026 14:12:32 +0800, Chen Ni wrote:
> The driver currently sets the handler data and the chained handler in
> two separate steps. This creates a theoretical race window where an
> interrupt could fire after the handler is set but before the data is
> assigned, leading to a NULL pointer dereference.
> 
> Replace the two calls with irq_set_chained_handler_and_data() to set
> both the handler and its data atomically under the irq_desc->lock.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/52xx/mpc52xx_gpt: consolidate chained IRQ handler install/remove
      https://git.kernel.org/powerpc/c/7593721cd7c1315557956d5241bbb65fb33115eb

cheers

