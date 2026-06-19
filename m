Return-Path: <linuxppc-dev+bounces-22830-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B87CD98F2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Jun 2026 22:00:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghs2Y3FQzz3btS;
	Sat, 20 Jun 2026 07:59:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781906389;
	cv=none; b=oPEZkK7VcOuedJhnbqsl3I/8pQm7WB1ix71PWZ928F1KNDf4QddvZItcvJWvr6kbkVJ7CGn+Fe5yjunOqrdL6mBDmNlh1HM+YMeTE1uvPmSB2BOU21mfoVTNc4hlONUwL9j+E5TT9Ho1zIUlLDdqE80qjuGrR3Idxh6Z82RQbxKpVgoH6N/DR6bh4ouMPB+AeQ8wO5vf9QdYf7gBvAvHRbSzPw56opREcfgdcfYLA3oWIRXsC1stXIUXxb57l74gNobgIQdKuroXaKL65A0ACjxPLMqjRLNTtzGKxEAPZlW6q/iy2vZ1HqI65D0ZzmytkO2uMWP6e01/kcV9PB8l4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781906389; c=relaxed/relaxed;
	bh=UPFFKVnjPRcJlrejaRDl4HcOoZnBfhEFRM7LH+T9U58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4/LBrEAmgw6OgXkNG0iyx+w5dM8Hnt08QoadPYZUQWxLGIdHh5S7FZfHTYYA4bHI5E8vPSMs3+rkendf1YuhQx5Yamlmlv/jBFbxhTnw5QNJ3T1oi3nJqKR0vskreE5ClQ7vFXLHQpwNzlikZhdb93gL9pjVPdObUWJXqzTLYk0uTpSKXUjnLyfvnlch99upkNL7F6d2JfPDyIuTQ032xA5WS0RsuRpDoXordqqntXmh/Jlt8EMdCd16h0mOHA/c9LgARbh8vhYK5hNFymZZGwftjOymVJj/BjsXRF7POL99N/lMswS6gh6NrE4oveU4BapCpHgXqsbsYvE8n6gog==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IUU8oAyT; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=IUU8oAyT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ghs2X5rzBz3bqV
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jun 2026 07:59:48 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JLmEAr3445126;
	Fri, 19 Jun 2026 21:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UPFFKV
	njPRcJlrejaRDl4HcOoZnBfhEFRM7LH+T9U58=; b=IUU8oAyTp6qLxyMt2KC76P
	wzIVSp7SARcojmfoXrcY6Zqfpf22jrVntG/k9r1axdoe0L2ahGZI3zF/X1RLVI5H
	V/IsKVlQR5AyXO1tsg0ioMBGiYPdZzq8CjF4rw0sGP6dnHdV6JYH08k6wu/zgDSF
	LAW0/oj/JVo7zqW/N7RtVTeSFUtyvRzi/ucOTyWgf6XgYpnERkdI9Zyzdj5PdLm9
	TzAUfkO5dTlKD89/5bTI58DfRbSuOqgLYyohwud9Sbq35FKhKT9s/YJh7FTb+Kwm
	1+nRgkSqHKFF2fsgjZgyCmKQKC/OTatKlmmMCSGnsXK8twovyVtcIxxt2eLgvzNA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqw7rtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JLnexA032149;
	Fri, 19 Jun 2026 21:59:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev172as1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 21:59:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JLxZpg33292678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 21:59:35 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B74220040;
	Fri, 19 Jun 2026 21:59:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DB8420043;
	Fri, 19 Jun 2026 21:59:33 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.77.5])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 21:59:32 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Antonio Alvarez Feijoo <antonio.feijoo@suse.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/boot: Allow text relocations for pseries wrapper with binutils 2.46+
Date: Sat, 20 Jun 2026 03:29:14 +0530
Message-ID: <178190618808.653308.18352486691343110152.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525161601.32097-1-amachhiw@linux.ibm.com>
References: <20260525161601.32097-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX5wZCVc6FzdX6
 kjVIW4u7ZTk/mwAe72GbebuxfNpiZieGR+4YTaOh3JiXyXLsdB7iRIhycOkXUR6S0B0CrqUFpok
 VpSEGxnaJuKxKHtgVQJQ2kmwXAszpt4=
X-Proofpoint-GUID: 0-i3CHLpPNWIqO968TW4OGDmeA_-urA_
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a35bbcc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=3lEvA_1nkS3yhqY4XaMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: rq3dP110s1LknpwyhdPSBrr1EZAgfLKI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIxMCBTYWx0ZWRfX9L18AcWK/yIb
 FXgTsiIgKx11yQeB4EQY1EZCPXHZJ+a2L78vJsPKfimiIAjyGo2cG6gL5r/ISyz1Jk8tLqdFbPa
 FTvn07O5XpvodvwxzfYaUuxmxTVRkgIc2p5kHe3UcarYuu6ODeAviTkrwf9qZwSrNm2eWIKPGdc
 StoQC84dd4bdLXeUp6syQWlVJHdl0LbAZznOYZIwCfIkudEAujPTEwiFijSJBw10UN4xqoz7+VA
 oo0PU5/2djDGOcsOu6cE1o9FV971MtsA/Y1kMjUM1/EHDuXPzWCkxXVNYzjQA8D67ZBBmeIBARn
 VVpG2SN1ZNRT4xyvoG3yD/TpHXnoyumB+JkVC5CUmoMvOXguuuxANL96f+aQOQXUkP4Vmj2mXsq
 Fkh99RL5zuPmxvBuTbIO1ZXRF8mHMYjKrKsG1BBNkcqjajz1BMG5/yawAWMP8b1SWpE1pT/FdlI
 MpsOq+wNcMhNfuKoLxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190210

On Mon, 25 May 2026 21:46:01 +0530, Amit Machhiwal wrote:
> Binutils 2.46 changed the default linker behavior from '-z notext' to
> '-z text', which treats dynamic relocations in read-only segments as
> errors rather than warnings. This causes the pseries boot wrapper build
> to fail with:
> 
>   /usr/bin/ld.bfd: arch/powerpc/boot/wrapper.a(crt0.o): warning:
>     relocation against `_platform_stack_top' in read-only section `.text'
>   /usr/bin/ld.bfd: error: read-only segment has dynamic relocations
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/boot: Allow text relocations for pseries wrapper with binutils 2.46+
      https://git.kernel.org/powerpc/c/97f902dd4c99f8d085da5343dc58ae4f6ce7bdd9

cheers

