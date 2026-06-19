Return-Path: <linuxppc-dev+bounces-22839-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AABCD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:01:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs3V0JTnz3bsf;
	Sat, 20 Jun 2026 08:00:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906437;
	cv=none; b=b6hzNJMbB5mqyfBQD6yx0uw3aG/mjYrHXWizI9yXMTinQDdVbuNlg4Iayn+VqsMTVI1WhYFb+E4B+lYf+Gfkdsgyzra1Eno2FJdn/XoL8c+HRsvMJwF73Jcx/W+Y8P0dXNVvMyMEW0o8bFroOHLbCvWVPUOs/bBLm7BH41Klce3hFI3VYF+AOlLTozyJfWE/ykq7+rdHGCflg+zrmzgMQhJRf3ParQ18+wsT+3gZ0pZ1DV1r12iECSNtMTu8gFp08TzCP5k+60F0E+VfkNFfQPb0syPV0sCBynHgvkhFtuKuWs1uw1TicoucBt3pSXYvM6zlCLqgPPE2IVonlQseTg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906437; c=relaxed/relaxed;
	bh=IzppVlOaZQSXZpfblF+R/pTf34zMM6lWWUodJI5cgPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehMSe23sUHKqXcOc7gygI4tJq+BKo4k0+wIXlhWgp+wrB81K4NKCiuBLTfTTdSfrcrOWzN2vHICSeIkWfRQMVZDoWmYGDa1sg9CjVgOg9kijjDInD1+XhmpIC8qx2JMmSfD86RW2iAaCoYtK/gYTX+UUM0Oxz4xAaOofLigiL33JiADicFuunBN2d6bWsOvZ0UN+r0+vIMTgZp1B30FoqABM+HEVqPKF+DLXIQEQXACrJtbbaB+VizjfyKU3MFFcivbU2D1V13q4NbwVm5SfB7pjBH0m8DH+SnI5nl0l5sHde2igYGRGi14vVJV4EHFT06kfMXSzVFiHinXasGeLqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bv20R88H; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bv20R88H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs3T2M8vz2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 08:00:37 +1000 (AEST)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmCUg3609682;
	Fri, 19 Jun 2026 22:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=IzppVl
	OaZQSXZpfblF+R/pTf34zMM6lWWUodJI5cgPQ=; b=bv20R88HU/ht7nnhDpGkPF
	GpeOV2Dr9oQJZsNsW/ozJqdO7SnhJDe0Ol9wTk8hNFOQzw50Rc3n3/5b8vT0cSoL
	pO1a2L0VtQUuSWsnHVAKbXeUoOFngN53MR6iLR0Zqet/cpz+ywb+iLPpVCEr6pzh
	Ro2kJ3q4KO/tsCqztbn5iPfLh5u63EvHyfz0LvuL4TvkglONKz1koR6bukx5A7lg
	59YB9Ki9EF4xhQeQ6pQgHV7IHzkZ7/IZW3vmROSZVj8Y8tbspxFKeyHiCVXtQr4S
	aVT8GN490iWonY2eCPg8kZ/V/RgWfpOdw/BI74Cm5dimkqmEWIyObKGw4Ccp9d0g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequfrfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:26 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLng0x032167;
	Fri, 19 Jun 2026 22:00:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172as7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 22:00:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JM0MbL39649672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 22:00:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 550752004B;
	Fri, 19 Jun 2026 22:00:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6080A20043;
	Fri, 19 Jun 2026 22:00:20 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 22:00:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: peterz@infradead.org, tglx@kernel.org, linux-kernel@vger.kernel.org,
        venkat88@linux.ibm.com, mkchauras@gmail.com,
        Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH v2] powerpc/entry: Disable interrupts before irqentry_exit
Date: Sat, 20 Jun 2026 03:30:02 +0530
Message-ID: <178190618805.653308.16618902378707016210.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603131054.216235-1-sshegde@linux.ibm.com>
References: <20260603131054.216235-1-sshegde@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX54cY8CnV5wgN
 29bRuSR81H4ClIbYMGQfbDqzJ5KklfLs/3vXcH2TniAq6ZVZ/BnbTeZXa+k6ewZGJ5byq41V+fM
 IJpJLySk0V0Mi8U841BZQYkeJb/D/jI=
X-Proofpoint-ORIG-GUID: JuQcitmQwQuVW5pJyisdDisjfjufUbcf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX8c88ySkjocE8
 7Ak3SsKWrJA5ocQuXC9luvNW9sPXkC2yLNOdciruTuLYEI8NQb2yaYiijbjnvdOcDQpXWuQIkh1
 WID+xOLDAuXe0AfexyuHCd+aYFXG1ZvYxVVBvaKUno/hbdTb7CVNeBs/GNMiOJlI0RWoDgZ/VNb
 ezvkQYu2kLMo1pjfl3a8i65Ucgby4Z53ieA57ajdYLq/zxgl8HUWp5uL4ulHNZX/O0qy5/gpFqS
 5uP46hpvkNYEcoIHOR9tja7vM0wWvPQfYQiczpG16/Us/+3q3prua9RXxhc4OZMNY9BjXpf/9ow
 pth+tNrXgfepCT3CCb6FwJ2vFR6FHMQSw1ORChEi5Gkjzy3i8B/Uo6VBqrmwcA08qILT53MIOHe
 pJs/dK7T2U/vbCGK9AMgwKn0LAt1UgnxjMoH9yLuiYnuFzesu4Bzlpw3fK0zzcV/0/Dgbv6kn22
 GcWc+TWvK1NlI/Hi2Bw==
X-Proofpoint-GUID: VHizWueufGyDZ56H4rBfmNK2hypMmbor
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a35bbfa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=jCyMpr-v3DULSFoDcqoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Wed, 03 Jun 2026 18:40:54 +0530, Shrikanth Hegde wrote:
> Venkat reported a panic on powerpc-next tree where GENERIC_ENTRY has
> been enabled.
> 
> kernel BUG at kernel/sched/core.c:7512!
> NIP  preempt_schedule_irq+0x44/0x118
> LR   dynamic_irqentry_exit_cond_resched+0x40/0x1a4
> Call Trace:
>  dynamic_irqentry_exit_cond_resched+0x40/0x1a4
>  do_page_fault+0xc0/0x104
>  data_access_common_virt+0x210/0x220
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/entry: Disable interrupts before irqentry_exit
      https://git.kernel.org/powerpc/c/334f3f6d7a1660fd65597bad9960bfa33a716d35

cheers

