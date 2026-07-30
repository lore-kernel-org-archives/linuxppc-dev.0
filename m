Return-Path: <linuxppc-dev+bounces-25055-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B233C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 05:42:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dPQ0Flvz2yjR;
	Thu, 30 Jul 2026 15:42:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785390121;
	cv=none; b=hnxPvE9SN2ECY3fw6gYVmITDEHjWNO0e0OMlAy8wk/0MJ2cAFq6Dx9XfW5c+7jr8byXA0JmJJYCZPcQPu1YP8cN4gHhe/KAInnfEzPgglLbzc2dTHId2SRrFI2azzZmv4s4QeLhwRIA14MXxv+r6Eibxg8EwoCCfSFvNpJtuREdNJlF02T3UsWk3ivPr1Sxym0aPn5QM9B2JtzWGM6NXnJF5OR5lpPRJNg8nMaLy9gn89HkUPfrIzJeZozqTwiecG2C0VR/+XkmQrK5h8ri6yP4dVWFgSRlmMECFVJ56B7Zd3vDyN50LrPcdeqZZ/8JWfkHW5wKYbWRsROge+LNzTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785390121; c=relaxed/relaxed;
	bh=54dBXUe34jj4zZ25cpqf+D5XN/p9XtmYtZjT02AsxCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cXt8JZUUuoBoR92i7rlxD6pvwNLYUaUksRgCKUdMdZ652jTG/m+iFDUaP9i+DWNTdhpvzQ7+a007YvRZ4fCz2+hn9/pLI31SFweZ/Pl0L+UqzznTEA1SMng7/XL02ojgdeBv1nI5xASSRBnnOXHnIVX6ruMaXIX75gB4ea0l5I+BMRyw509ZsilvKnYdObxoOED66/shtN6nxB8G3J1iJ8QE8VA8SwGxrILvcE21n2emUD8sl6PJ4eBFs/uiqZodhoK0Qq7gLMz3xAKWggsmzVmbOJybTqHM1lW0cjHqqPVM+IBTCD3iaybs06oPpswXKh4jFRQWoJotv9XdXhEiCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BgoNnsZ8; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BgoNnsZ8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dPP1KdWz2xwH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 15:42:00 +1000 (AEST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U3mr0U1831679;
	Thu, 30 Jul 2026 05:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=54dBXU
	e34jj4zZ25cpqf+D5XN/p9XtmYtZjT02AsxCI=; b=BgoNnsZ8/aSU27qJXhO0an
	Gq2zT06dEfUcFNhsYkflEavumishPu2yl5J0H8Y8VaEW4UsAAi0JNFy4vQEPRlAY
	1g7UU6czsep56lwGGlQ5sxtwjxp0GspeAz9XYpxNBCdP3OThv8LKB4Ef6nqVisbr
	pysPqlGkmv8ADGrQ+GtUf8d/Rov7yraUxdfOMZaL4FQzdvjTTb/f+exx15fYfIe+
	5C4UEQStl4GgeCZPaZ74wXHHTk61HiGGyQrrl4HbQ2ZSkFD7X5scGiChVXyzrN2c
	Qxck/2tS1iG2eY+SKy08ge5Hz1qJJP4v/Qp/3oDMJ+DSx+K5zSU9aOsc0BGD4u2Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nwatj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66U5fGNU021842;
	Thu, 30 Jul 2026 05:41:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhhu83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 05:41:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66U5fjMR28705102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 05:41:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65C0320043;
	Thu, 30 Jul 2026 05:41:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64CCC20040;
	Thu, 30 Jul 2026 05:41:43 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.85.187])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 30 Jul 2026 05:41:43 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/serial: Fix include guard comment
Date: Thu, 30 Jul 2026 11:11:42 +0530
Message-ID: <178538948396.1278583.4798553077103188271.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260623153825.403819-2-thorsten.blum@linux.dev>
References: <20260623153825.403819-2-thorsten.blum@linux.dev>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX5UIjN6egj1Xk
 Qp393RIQcsJ0mOYDdsARryqdj7WDWytvwR6lLxkJYYWbGGz8Yoas+Vq6CZJZmrtq0b57iaXzG0Y
 hRaiZr6tR+xdN665Au8eJyMrg4v6Ogw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAzMyBTYWx0ZWRfX+uzOJ9JeKPOa
 3njbaUjHYq4mFEyLCIDGoVaxT0RBqmQvWSukJKpUKnuMtUJRw1oAB0tSGdzKES0+TlxsMeoe0J1
 u2/etCZvATMx8/UGp6eHKS88oqXIFf3inoyN0wdhaf0jWb6IXaO/DU0MEoEMbNc1EjqQ8s5f2fI
 fyjIA39VHZivcoSp7udQr0h4uvgMgITsyt6MC6Ylp3FO2SmvK2So9uXahyYHNjTf8gufWQLkogu
 SK29Dq7t/58zcI0vLLGNH79XVvzmB2/pnaBly2j7yTP2vkP0JKA7G/RsKKsT3DjlMG7Zmpfwyhf
 OCEwMPp/OzQsDGzRoD03yq6qpkV5iSV//nAzWeis4HDlcnR2ZSSqsU4uXtkNfHjqAHt+SZdbJS7
 5PtiMKkUX8DVtmFTm+5+LoJJS40NXEPE+DltNiv2pu8w8waua3qIiZolspcJ82ijsz2XR2Ls9ud
 w+Edm9YObaLpG+2ZZNA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6ae41c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=aj8UUxVp193FZWfucH4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: yI6xuLtbH5nAqzu2isIyXZs_Ynyzti0C
X-Proofpoint-ORIG-GUID: xoRnqRbqJ-z8VskmkErUmrpYyxfmhgy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_01,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300033

On Tue, 23 Jun 2026 17:38:25 +0200, Thorsten Blum wrote:
> Replace _PPC64_SERIAL_H with _ASM_POWERPC_SERIAL_H to match the actual
> macro name. Remove an empty comment while at it.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/serial: Fix include guard comment
      https://git.kernel.org/powerpc/c/86f057c19fbe089ec8a2020ef5f1579b99d87ac7

cheers

