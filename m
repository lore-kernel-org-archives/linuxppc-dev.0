Return-Path: <linuxppc-dev+bounces-26880-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C88C79FAD
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:19:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfrH71hVyz2yvc;
	Wed, 09 Sep 2026 16:18:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934739;
	cv=none; b=QZ5jB94XREnpNog43sSkqVjCNMapJEgFMMLfAEow6OThMS4KNu68EHLhrX/P+bm/KpD5JwtdeSIe4tevUiE/2/CLX/u0a5i0i0FVbERcH+cQFAAM9tOiNPwqsXi0Pib9LSHSWoi9SCrJo678BvZ6k4sp92X46VSuB2uUXr0cleO4QGL7lw6HZvp236aajrK9CV9zyop7+u0J30/vEje42QmRDYVXUIIjnplbiko7Il1G/UynoMxEmLI3WE6S7tJQV/aNMrSAXS7RcJr2prvET0wdwGxYonZV0z971E7WWEVojoiquerfiWgjtKSw1VR6NhtrjQqCEBicAX4aOXUcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934739; c=relaxed/relaxed;
	bh=AfW9jvobzHptCj9jByfSTduufg2fJlESvuyzzsZDulM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i9j6xlWHHdEe5uqCU3jdV2wID5RiTM/OkVpiLMa5FnUoJVJWL+qm2qiMrUIchVNjToa/LJeea3lT1FvmbQzxZ8zlal/xgWeOKgF/tdO76ZEHaDnOW/amysAri2hdUO2y5+FORcDYVykLP+JC5VGcEMrM7mpdkQwaiAXo5BLfTdz1icHOcjxuBvIWxNKBYUiUvW/PokZTPHayl5P08IFOyNit3USYZa0C7C7iwN+GrkXpH3rks1p2NP0OLGSyI5ZGsnv4QGrGE6qxSZgHrpWAClk7p9X+tRqr1PRsq6qitA6xEZq1VtlfKRuRr5okUDhXJ885JchotGP3n8ggd1voyA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Yi6dFYd5; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Yi6dFYd5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfrH648vmz2yyq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:18:58 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688N1aFR1116388;
	Wed, 9 Sep 2026 06:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AfW9jv
	obzHptCj9jByfSTduufg2fJlESvuyzzsZDulM=; b=Yi6dFYd5qDoeLJxETskDiI
	X269oWnXuOWuwJodx6na9vfSsrOGDJ8MVFtRmyaqgVZ1jA/6vABh/70ashNsGFQX
	XvKNRRUGmU3uDIbBPmWAxUzvaG03zIZr7umQaP7mL6VEk3xpo4OsE7xZvDkyhkQu
	ptveFyoWOHYb3FV8kk9HyNACjjITVciBJhn06tuhl2G4mK/vaaUzFvcNPlU6UxOB
	f5rqyndstEYvseHCPh4Io8/PRGf/rqlKflpk3Qm8ucY5yl7cxgJ5cN18ZI64+EQX
	6UoSz3vKWOoDs1ZTpbCIrGDT68zZcjr/qB/3oKUs5i1QYRebBMBJUTHlvtYv5sAw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjruqa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6896BG8E008854;
	Wed, 9 Sep 2026 06:18:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ggymggfud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Sep 2026 06:18:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6896IhEq12976436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Sep 2026 06:18:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AAB22004B;
	Wed,  9 Sep 2026 06:18:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF95320040;
	Wed,  9 Sep 2026 06:18:40 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.64.17])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Sep 2026 06:18:40 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: harshpb@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        chleroy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc/rtas_pci: No hotplug on permanently removed device on pSeries
Date: Wed,  9 Sep 2026 11:48:39 +0530
Message-ID: <178893459268.174069.7218159641256371080.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <178246517230.1267.12206176311111155505.stgit@linux.ibm.com>
References: <178246517230.1267.12206176311111155505.stgit@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa0fa48 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=qijzckNTzarPzakSIqsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfX5NARwKKi+fUp
 RdSpS5e5UrAWB4+4PBk4A21jYvuwBwRWmmLhXQl04ghf68xqy/ei35BUuocx9HELzvqlQeUz8x+
 U+OZ+DmCUmJh2XpevIvzpNkpTvJGVpg=
X-Proofpoint-ORIG-GUID: 9xqDOOZUuXR0ER7KmAI8p6-eepTbkP_r
X-Proofpoint-GUID: t0bO93KtdksHmrQ-dutBcVU84pGI-GnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA2NiBTYWx0ZWRfXwASHMQ7ua1Hn
 7Vg7r200yxoldN4rLFzF81dsc5J4BHHsqiXFrOJ78obIShBxSoL9Fu12xHXLWUiTHMSGwVjqwBX
 mLh8DyI3bz7iWlohFQv5mHHFelszRwqRGKET+8k8OtFbUUVk6jXtjK3ZSORrsXWiQaJ6P7VBlmO
 ZmvmvwtnPo7aK109M0PbhF4lq682TUt4yCK3a+lagDmMjmV7zsW4ktPXvCvKTO4P2nDcgf1mKUK
 brx8v6e10g5uaKFRD0PH09vCCcg9BuGVxVT+sOo7TCiw9+7kM3HIovQDD9VMim2WLDzzsMdh1Bu
 Uhm1yzfWWj5M/WvMAXO4AzDBWEvs24UhhI/C2gExstxK9PgbD3+vSsHNLpe+Ldw7pjsIRDxPpj+
 hF42l9XKACKPlcvyQAO0CJ+9sN90o1MT1LI8JqEYTzj1fmXUS6LORrE3dBgCvJN6krelMEBo2dA
 wR9BqNNqJGhjPXnOIBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090066

On Fri, 26 Jun 2026 09:13:03 +0000, Shivaprasad G Bhat wrote:
> The eeh_driver disables and offlines the PE permanently when it
> exceeds the freeze count beyond eeh_max_freeze within the last hour.
> The PE is only offline, so the device tree entries, eeh device
> references are all intact till the real unplug of the device from
> the guest/host takes place.
> 
> On pSeries, with a new hotplug of any PCI device, the drmgr initiates
> a system-wide PCI rescan, which finds devices offlined by the eeh_driver
> and there will be attempts to bring them online. This leads to
> recurring EEHs either at the config read time itself or a bit
> later depending on the type of the problem.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/rtas_pci: No hotplug on permanently removed device on pSeries
      https://git.kernel.org/powerpc/c/8a4978c17a144a6583478cce933bcb2dbb25298d

cheers

