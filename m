Return-Path: <linuxppc-dev+bounces-21056-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6386CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 May 2026 05:43:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJmvD3wNlz3clp;
	Mon, 18 May 2026 15:43:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779083032;
	cv=none; b=a8RKQMQ8BxcJ5lA5MB3I1Z29MouHaWF1G9z1UBsYvvNpUnRXEjhz1nHwsK4fDoQj5lAF+40xdRFG1HTqUSQY3Xl5LniHei8vvZDCX05A5ewGJUpyP/pQMnTlrgQZsjrAqN9bWqtkBltao0l450g/+68q6Fl0t7cRkicPzIhqDYE7SM9wvjC1CYI5JMtCjElFt3c+nQo7cqeUc8rNTdaRBNj8w0PHRzS73aknuNmawijRDvNgFiFHQdhtBTSlN15poCXrD1ySk5Y3YT4Rasm7yzw1rseoOLAVK/e5z5EFUEkM72MshzoyoY8bU/iMckhSTWu02D9PDPr4DyWuB86Olw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779083032; c=relaxed/relaxed;
	bh=0MFTqkB9YT3lg3uiD3DsPQuxigHAkDYGz1wywiRsjC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bl9Dt1SkpfJ+Fg82ISTKHLJYjRl+dvNtk9m9oH2INntX6W4fsuMHovFmomzQxhAf4VzU1yjL2OS1kXrz60pYMjJ0pA4SwVKbjZ+4nqTipdUlL8dptzP7o6FbrlgDGDvOjS0WRpMpM87XFuLdEGHVv89+2+IfHdVaKKB20jo+gNi08b9ZoC15GmZOOMYzU4nb3HOHU6ICQf3vCm3Iab9siZy7YldkSNnMgdEioxqv5vhSdEprot8w07CWWgztLCc+SDGk/K9Xft+xXafG9t9fbRaTZmrtVMQsnApimUpOofISkkwpPOWV1sPtG77DM5FcFyFiisQzktqIfBy9amPXcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PEseBgir; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PEseBgir;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJmvC5Ff4z3ckc
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2026 15:43:51 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64H8iaBW3690499;
	Mon, 18 May 2026 05:43:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0MFTqk
	B9YT3lg3uiD3DsPQuxigHAkDYGz1wywiRsjC4=; b=PEseBgiroP+cw5HBiFj4xs
	WjKrh+tUy3OvwSbKT6eChTOLdOVvX8yOqiIjfTt+p1IBmXzRMkTIqaDOTk7oKlww
	xav2O8zwibap8T0KIwb2RAVQsuu/raf151DwxHRqF7cBJny2wj5iT+S9SD1PLqQR
	/oBkTojdP6t7cTYAiRiJvFsV3zK7Nnw/2gIL35u5XYMM3JZEoEH1X2yYLoaFwZGi
	i8KbpTKI04/PKVrdmWvGNr3Wboj5092qQtf8Xzmuba6z10sy/DrDnILpkV5xIHKm
	GBDuKEn671fQDqLRxJa+j38qB0eRJ6Q5Zsojs4SZqdrBuWeUxUt+S22Zh6YJt1Yw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6havwx8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64I5dPuc004556;
	Mon, 18 May 2026 05:43:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wjvce0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 05:43:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64I5hc2945875686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 05:43:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 706C920049;
	Mon, 18 May 2026 05:43:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31C5620040;
	Mon, 18 May 2026 05:43:36 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.43.25])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 05:43:35 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/g5: Enable all windfarms by default
Date: Mon, 18 May 2026 11:13:34 +0530
Message-ID: <177908291157.287704.14634664126196215980.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
References: <20260505-powermac-g5-config-v3-1-7747bf72f874@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1MSBTYWx0ZWRfXzx4WaRvgGrlL
 zpWgEwSGncXtR6gX8O9Ao59ddUfGw5pu76AFKWlMF/MYjXq7y00accQwLTmJxe7huFDZd1ciqoN
 JfNRNNYC5j4qlNFo0++3PKMbbuXi4/GXyKeD4W4MfxT2ckjsxIZMhNoDcuAy4/GCioX6oQ58IQv
 6/pTXZYZ2pGi2ChaVSccsg9MbLkFoG3MEf7p58uLSD8ioLC702PFJnmxK0H56XCMLw8hrC4BVce
 AXUDipg4IgBkqbawS9CsP1S6VLsQWjA1kJZ/Dzs5LoKtNd7DIya+I/ODQkKxVDZZNL3nc8cdWlH
 ip4cXwFhkk+yRd7VkZjFv2JK6WqFPeXhNF0sZRs5iZF+umosT0IRHY+gdyVAm2ATiZdqxnIhJ3n
 ejh4MI4aVa4IN45b4hIoQ2xrFkV7BEbKhmKHHKA4rFlOQQEfIAkpSLgaz2kJ93AaidfoGT43hAJ
 mK2cqW6wowy4Ddo0hVw==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a0aa70d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=9pqVCz2-_mbrqAO3xvYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: AcBFBBlZsNHVHZtJ6g8Itz5a4WEMbphB
X-Proofpoint-GUID: 6ekzacTsovBhXJ9hPO0Dwqo2CxoUW3vB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180051

On Tue, 05 May 2026 20:47:56 +0200, Linus Walleij wrote:
> The G5 defconfig is clearly intended for the G5 Powermac
> series, and that should enable all the available
> windfarm drivers, or the machine will overheat a short
> while after booting and shut itself down, which is
> annoying.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/g5: Enable all windfarms by default
      https://git.kernel.org/powerpc/c/8d57bb61734b23f6342e9de781173f1d83f90d3a

cheers

