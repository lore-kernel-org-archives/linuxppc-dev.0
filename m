Return-Path: <linuxppc-dev+bounces-29469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEC4CC6B1F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:15:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4QXK3gTgz3bw9;
	Wed, 14 Oct 2026 20:15:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791969313;
	cv=none; b=SxpIMRtIWbuf5TSIxmT5N6QDE0Td1npsIS6/EKvGQXFUD+p6cZeixDiS4TCirXDO/wz8vKV/na+SB6qlcoGv3eqI0L12jUOLQWcA0aBRLDxQZ06XLeDQ3ysBzVUSkqSYCI2EhvPUlietX4Ef9pDElTIFZ4WMHO/1+ZebrDawxlKTbcy/b5BYeEYh5ipsBRCxh/8wQdNxn8lonAGr9vqMnTViahwEAHFaGcewfgROy8CiSuv3Rsz+h23zhPxS7QWo/VIbecI3crNvfPCSbPDQIokpEkgcIyjEdsWguQCaNeNMzhDOKYDSI19sZ8H1fb4xHfd2Ibr3WCxfWTLzDdgCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791969313; c=relaxed/relaxed;
	bh=F6zwCKJycjN3/G32pjEaZ4GcgPsCNrAehIzHiF0hrBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gsi42MRmGJ97lAvKkJMlkDRGwNu6koGY/57JZwvVbaUCWFXiqQfahf6qScN01n7r5hvvJowENrEG2y+vu1fMZUNZNTLPoGk958aPUsNjfl7wX0ntDDurxLGeV5jGl6RCm5Z2r1Yqt4YU+REPk29kOZk8NxtPWzuzA61yqTRpwmL1L/FHBv2ubIoDh/9Fj7RVo0wpH46V3ZDir1kIt3SqeCdraWKm5C3+btZD21X3knkMbWuUkmC/DWs8c6xkLnnTHx8H6sgTYX05IRTRdJzHY2GrBbrZWf0ylwpGLoWsPliSHuCVJahTm/FROA1WsqJuDT/hSzhmgVZ3UzUiNUVxtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=il38Ibx+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=il38Ibx+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4QXJ4jyMz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 20:15:12 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DNONH91890823;
	Wed, 14 Oct 2026 09:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F6zwCK
	JycjN3/G32pjEaZ4GcgPsCNrAehIzHiF0hrBY=; b=il38Ibx+xbu7CIrK9Vd4do
	hPSi2i7JP6jl1fMR6SlW9iBXczWbKTgdWZabNhKnLstUYT2tGts/TtyqdhDYeYm9
	FVDxV/kmvQCRsyz6QpG2//02o6W32e3TKa0AoVbEBbYkjGERk8Aiv76F2a4gTyl3
	yWZgH9gynnsFyXKr4pvan528T1FCmY+Uqf7qbUFhrASmlf5x1XBBKhnGRAVlJkeF
	r/Yt06/Pt9D7eJaILRd10Wp6No7PzG2Ctyu3JaJfdbk454hrZmOcQqJGUKqTUOfo
	Ht7xefhy0p9DlEGEEg8VvPxD+/BmhmsMD4psjMo+X1rX5diQhDvYbR0IOMkU2uFA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3kfga-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 09:15:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8gcZW2585758;
	Wed, 14 Oct 2026 09:15:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9wvg1vrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 09:15:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E9Eu6Z53608788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 09:14:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9D8A2004B;
	Wed, 14 Oct 2026 09:14:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EEDC20043;
	Wed, 14 Oct 2026 09:14:54 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 09:14:53 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: mkchauras@gmail.com, adityag@linux.ibm.com, adri.vero.dev@gmail.com,
        chleroy@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com,
        sourabhjain@linux.ibm.com,
        Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: Re: [PATCH v5] ppc/fadump: collect dump when CPU_STATE_DATA is less than reserved
Date: Wed, 14 Oct 2026 14:44:53 +0530
Message-ID: <179196918694.1557523.3314871006563327823.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928101646.415278-1-shivangu@linux.ibm.com>
References: <20260928101646.415278-1-shivangu@linux.ibm.com>
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
X-Proofpoint-GUID: tcrEtWYVAhYFBk99FbDOcdlNEmSHkJv0
X-Proofpoint-ORIG-GUID: BMfIDi9rF_j9hiUtWhI0Kcw5ULNl9HjG
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acf4815 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=j-GUJipNv5NrMHqF8vgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX35USDwC4XoXs
 w71IAfdsv6XQ86JF3tpiA0sWMzLpMYIKpWm4RBt/8I4t7wMoV9s5f5tcysXrk/Wj6WWN6bwt6kY
 4hISlWwKqndg8LN+vrz35u+0bZJ97XM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAzNiBTYWx0ZWRfX8AB+iYzymbdj
 HOTvgp5uYWay7/290/nKWXJhJVhoWGH49FmfFtvzmbJfp/t+Ci8DmMPEHdcXsk1Qz6Oud5og8rk
 KeOit4lRYXycz/moQthRhu0HNp83zjkVEyN9Z4H/tZ2R9FCzhitOr8oeyOPT9rbbgBbqtBrqgP/
 j25QO7ZEOe1dAO0hjxxLaUwYllRAf/wXnI0H/dmrK6wtXUB6/gkPi3+i4WpLM5wcW+a4cEMMbJO
 /gasn2hPVy33RvJO0i9KDpgFMc1zbvKEZ0UGTj+gTxsM9Ky8PZijoz/8RhiL29NqIfMCFatahut
 Dxn/gellaezQlMmnbzWmGq2CD4UKJ9roM13ZL7WRySCGjTEjgFiCyu5Yk9Gjqepud3N03g6rx4E
 vouBePWXUdxcwxWHZeIHjW7tdksLCinZQRtANvOfM49UNNsmNwN7D+QXUnJoBemLBzrxlUalrLk
 e5OaIxmf1dW3tNom52g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140036

On Mon, 28 Sep 2026 15:46:46 +0530, Shivang Upadhyay wrote:
> During Fadump in Qemu VM, when maxcpus value is set to more than current
> cpus, following failure is observed.
> 
>     [    0.045806] [      T1] rtas fadump: Dump taken by platform is
>         incomplete (0)
> 
> This is because the CPU_STATE_DATA is allocated for maxcpus, while the
> data is only filled for current cpus. As per current implementation
> of Fadump, dumped_bytes and source_len for a region have to match,
> Which is failing for qemu's case, Even tough the dumped bytes are
> reported correctly for only the current cpus. After this /proc/vmcore
> generatition also fails.
> 
> [...]

Applied to powerpc/next.

[1/1] ppc/fadump: collect dump when CPU_STATE_DATA is less than reserved
      https://git.kernel.org/powerpc/c/b3d75e2bc299a759de2fd11649c7ed275b1b2067

cheers

