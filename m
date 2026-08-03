Return-Path: <linuxppc-dev+bounces-25246-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF73DC55162
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Aug 2026 06:58:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hD6vR06qzz3c7K;
	Mon, 03 Aug 2026 16:58:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785740290;
	cv=none; b=IXPir5NhlLd+/0xYOP8U+um72i05ymV6BH8i3XW82QIAJIPn2ftUueg8S7jgt5e5YYzjHLqjLWtDHOKjRwG21VvMNtUDhfQNOhtwiM5whHlSbsdqlu/0OaTftuHxGogGYCNucFuFApAw2tjZ4QiJHcMUl0NwQyiEM2JUsSKZbHINMgyedNImcu4F8igMdOgs/oBgtvdN2pZApTUc/v8Ne7zOowiwEMONwu6fhLLSaa6penD5k3nDcY5QnHDQoQawZHFsGFozVsfBd/pHFIrZIi0H32O78jHqzAVg3eTHon/3di6cihdr5QAZqb5hrFWAZ2MPWfyZH2FPiJDa+wxKPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785740290; c=relaxed/relaxed;
	bh=v2BMWE/9tces3YOwu0eKS9HbqDv4zlD8+G/kcXRKoYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frZEePQMt1WguyYaYAa/txUVNhwL9L+9u8hKCcYeiy6GcQny8xAStAZFK4AtUeopmaAebzr/Dn+owZYDQ95y1iCmmePqqF36R2wphmhkGAHldD6YyNVW/Ehd7OUZJsc90rXsg4qevaLwKzdkBcrP3b8vVJrqfcTjhotLj90buwPwT/pIptGMRb7lai+rYzwRBx9BdJa0jdj1phpu7E8rxnptNJuTbtwdhxYzzjyRFt96zjntKCLvoG/si3lRTkPw4ENtPuZW1Hq+K+ppOqAyklazmJbbLAPHdBMFcWckuhJuGBEK54BttAjULllSQpP1I/TBZplUmAilXfotNEuBvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dSWPTtwz; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dSWPTtwz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hD6vQ0gyXz3c6P
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Aug 2026 16:58:09 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lm706224128;
	Mon, 3 Aug 2026 06:57:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v2BMWE
	/9tces3YOwu0eKS9HbqDv4zlD8+G/kcXRKoYs=; b=dSWPTtwzC7EOO6vPDAdoFQ
	7W897kWhzx8BTHKpBuEsj29XeU+/n9cdIlAoIekp0xeu+uJWMcV9smpmimvyhReZ
	7VfoaFK4CT2XJoFkVaZjQC8FJIhSdUJBbTVQNWgfOrbmJcAKA3vbcjLePIONA726
	x824Gq60peVSMl4tIBdVZg7SOVFELl3uBW4wjN7Tu/lReIGy7snEBGJS0yIYYCuC
	UarCb7wKMm8q2U5KqnOTgxkZSa5oS3VKkbmMVGbmO+dhSxxxeFzf5yyzIBylsNwW
	tc3AJtxCWb2012crQAVZcAEyBGB3vEYQ31GzWgXyWJp5HobZAvyY0Pni03bkw1CA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3qa6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6736uJZv001022;
	Mon, 3 Aug 2026 06:57:57 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh4328-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 06:57:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6736vreX28049802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 06:57:53 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEA9920043;
	Mon,  3 Aug 2026 06:57:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06D4720040;
	Mon,  3 Aug 2026 06:57:51 +0000 (GMT)
Received: from Linuxdev.j9d-in.ibm.com (unknown [9.123.86.85])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 06:57:50 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: rtas: use get_user to simplify manage_flash_write
Date: Mon,  3 Aug 2026 12:27:50 +0530
Message-ID: <178574013461.29744.12674786351214031173.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260528201226.1599977-3-thorsten.blum@linux.dev>
References: <20260528201226.1599977-3-thorsten.blum@linux.dev>
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
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a703bf6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=rZ7AJhTkCmnD_YF7y6EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AVkevH3V42Pbl_ab-layOyxTOrm5tl0p
X-Proofpoint-GUID: yMHBv0cf1C1o1HnHzv1nbGU1F8eqr4sy
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfXyEFPlnnVT3Iq
 7f574j0jy7be8sbda7LJAqt+aqisRb2jajzMnFoiN1WOi0gS19SyzY/zYtq7Yx0doEz3cxajCT6
 amLMiGM8mWbzh9qTZ6lU808yzA7YtkQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA1OCBTYWx0ZWRfXzQ7RPgRQ7hmR
 2JLd48VQk77P3YPPbpIyKtxh6v4uylanLcWsD3ceMW86W8jifNPc+KjeokN/c6KYUE06ivUcg90
 af6VASV+jbOY+tTap5oG7wIWm2qIvp8p2qIOAWf1lxiOPUksZ9zhX9/ZykpNoKJXRHMdWuQgKlM
 WO6+zKmsbuJ92uTdH14rPlACINKfuptMFOhzGcSnhLm8DQc6+pK7/XNvtoxYXES3qm14VnVDbos
 s8his7N/vz7aJStLgR9NPklfwMcXuT2i1E7zp+nYYMA5F3C1l0XJZmV7UMbOx4UtprClOzdzRBK
 8AMAO5JwYgL70sqSTrd679vzouItFISCehYw4tolAqOdAukOYRZOaGzsqpQHnzje+ToiSi100Lu
 8LlGVoPBhW7HLZcwzCmbsV1TC+9PejVKgiwiBotw2yJATm7gwqKBpNF/9okSgeDezoMKHuABLpy
 JaX0ET4hkN2rhrTcccw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030058

On Thu, 28 May 2026 22:12:27 +0200, Thorsten Blum wrote:
> Drop the local 10-byte buffer. The old code copied at most 9 bytes from
> the user buffer, but only the first byte was used to select the RTAS
> operation.
> 
> Use get_user() to read the command byte instead and compare it directly
> with '0' and '1'. Drop the explicit user buffer check, since get_user()
> will fail on a NULL pointer and correctly return -EFAULT instead of
> -EINVAL. Remove the now-obsolete string constants as well as any
> strncmp() and strlen() calls.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: rtas: use get_user to simplify manage_flash_write
      https://git.kernel.org/powerpc/c/c7b7cea42cd4977f95ce520400c9740712b909a2

cheers

