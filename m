Return-Path: <linuxppc-dev+bounces-18000-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5A4FD88D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:15:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvTb14zMz3cDT;
	Wed, 11 Mar 2026 13:14:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195299;
	cv=none; b=ZCvkgDH8tlLc72I511DqRPbPiLLDUCD5R9fc/saymTGQPYO5taC0nzlVwii9h6jJh2avxZFccnY8mqayYv/EFIbvsyUhGrth3onUa0rWr2CDveMrNcPzTBpIOv509xVu96uyyYffrIRX1CX70wkUVAYAQmUsEBAhUWB3RAaVvCPlLoIPAU83+5HNXZfl+OdkbkNzwwqJo8fUQgwQEdFAUixWebk28suqi1Joot79uAkvg4hvXXRBLDbvdBL85r02A8/Dh1rLA1hMEL7iWlA4GYnWsBE39GnCbrwBpgzVuWs76hzbdSx56zUgij2bIX23GoS+9HtDiv2fW1Q//fkx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195299; c=relaxed/relaxed;
	bh=2MWSpH9FvXPMPfQOubS4scinmNzLxM1+H3KRkOEZ/Js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRLb/GKf5B4HDpB+8/4CW477avQs00rd5bCnGLPTb+t++c8UZ4Vl87CRCafIJFBI3eTFHGoNyKqR9QUsjuR2X8ob1pxsv8DxK9MLtHed+vGzkieb1tyjFPxN/lBYYyXWtU93MWmG40CmZo7vWL8DRPwbb1XlKLoMax9kvq17boHT1zg/8fSpf3pTscIPEx8Zac0lEGJHf0Jd3mglC1hLq+QhDodwo1bL3Kfjgc6iT34mt8xzUEVks3LTOzJA5eOusOLCW80rGDUOIYUYam6C1SuOLlGBswheMwxbyHw+UGFnRbNKzyoFFZvWc7NEMlbez5NLbLorbyQsSpRANlLXrA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F29gA9MA; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=F29gA9MA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvTZ2p6Mz3c9r
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:58 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AMEXx31594484;
	Wed, 11 Mar 2026 02:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2MWSpH
	9FvXPMPfQOubS4scinmNzLxM1+H3KRkOEZ/Js=; b=F29gA9MASS8w1rf6yAzz9E
	aeLmpZjZv0iJonXmY86CXR2HFIymbMDbhgcc+xC9+10D2ARF2P1A6sbv9X1jtTpQ
	DkF2J1zb/QSmOGjCEGOLEl0gdnXSJ5MYWr+lrnbRU7Nhc7H6g/cKXoyKAst+gJtc
	jhD8FtCEg/NHmcZH0mKsy+rR/jB3FekjVP2jvhca5YCeASwkUqHDi6kLBbM61nRv
	Gl3tlnnA8YmScoEE8Cb3FWlQvQDyoV/ui08cHe/YUmkc67OLOnsFIeznUwTYvy9m
	iXzWhSkUdKPgp/2nKJyJY67c97xeSnLAS1InVIOsmJj7YjM6yDhVEg6LWSg+PsMA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrdcub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ALKPFL025052;
	Wed, 11 Mar 2026 02:14:41 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jk3fsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2EbpL57540908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 868B120067;
	Wed, 11 Mar 2026 02:14:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 281CF2004B;
	Wed, 11 Mar 2026 02:14:34 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:33 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: kernel test robot <lkp@intel.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Mahesh Salgaonkar <mahesh@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Sachin Sant <sachinp@linux.ibm.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        kexec@lists.infradead.org
Subject: Re: [PATCH] powerpc/kexec/core: use big-endian types for crash variables
Date: Wed, 11 Mar 2026 07:44:32 +0530
Message-ID: <177319508340.269267.14742705106176639516.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251224151257.28672-1-sourabhjain@linux.ibm.com>
References: <20251224151257.28672-1-sourabhjain@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfXxds8FJnQxUpv
 9ruvVtKeu69jZFh8sBDanBw4pDkWTmE4R1RZI/Yyoj9WJnO8seFG4JZMfehWtEBkTWPRIeEV+A8
 pBt2ZQD92gXE+PXlEz206YMocDdQdnsYUIkNy0lD5rbgfmbscrLiNe9EEOdhWUuOQfAGT/C7ama
 BBaLrEUjv/zMglp6xwNxe5kV6PIQPI0IloVZ1PgF5Q1EOxna2htv5SvYKBIFmH/QMz4wH6sbB3N
 nz7QlXZh7LwM6/L5KHLWuZiVXqDNTFg5kjYO/s5ukHi0lskGigPIPuum5zIm2z6AjzGv6Zoy2hI
 Y/Z/fVEMmDP/8wjldWvAsayOyZXWGXMXV8K6ZLa1+K0zG6Kw0L9c3k6k+gcRmEG3Ts46POcVHbY
 c99/AJnmUvLWAwef+TMHWTwKHGJaEFr97nK6lXVZVAD9suKNOJaTyP3+u5feyRDcZZkGmDtSThn
 38vM323nA+Cvrb1eZUQ==
X-Proofpoint-GUID: 3aav-ZHLpvVPrmyA0QoL0pvoD0ZcDNI_
X-Proofpoint-ORIG-GUID: iJ4tafNgLV2Ta3r6ntWSGPhq8xMpYz5E
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b0d012 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=-K50HR8UOdKsrgnMF3AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110016

On Wed, 24 Dec 2025 20:42:57 +0530, Sourabh Jain wrote:
> Use explicit word-sized big-endian types for kexec and crash related
> variables. This makes the endianness unambiguous and avoids type
> mismatches that trigger sparse warnings.
> 
> The change addresses sparse warnings like below (seen on both 32-bit
> and 64-bit builds):
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/kexec/core: use big-endian types for crash variables
      https://git.kernel.org/powerpc/c/20197b967a6a29dab81495f25a988515bda84cfe

cheers

