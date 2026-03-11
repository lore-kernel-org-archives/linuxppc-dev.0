Return-Path: <linuxppc-dev+bounces-17997-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A67F4FD88D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 02:15:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVvTJ2xcXz3cM2;
	Wed, 11 Mar 2026 13:14:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773195284;
	cv=none; b=GlT6lRd5qg9BRxQSB9y0OHxmPX5H4kgi/a/+IZOktYhMM4aZcLvv8V06UEgSDMM3skC7yOH2CY+4irM13mgJfDsIrUw8nrDwZ1lNWIN2VzOoSPvI/uVddpMshCeo+zu/z3y9fdINUBdJ3+XBCpEVTBHzw0lMDJRSAhtwr8n4ui98RCRHh5/6n57DeY9GMLcpk0iplf927pERUMuAeJdhtZyTcAd8Bx94OlVrEadB6SSFBh+eyRXHkMxOK069jhSLrxBVTfFmZcaRbNPy7U0g5lzYqWtZcldQTAdZQmzMMoeNMqGcvfYM1ZGRmeos+NU9LLfaztxXzm0nTA43Cjpv2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773195284; c=relaxed/relaxed;
	bh=P1u+GHcoGo3ixiU8QeGLcoBNxT5/0eBj4P4MQ4gG9QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPKLswMt4WN0Zivz62f4H+bWmbMFNt47+rHVDER7uQ+VGU+ta7EdEOZ12mpvm4R4jq26V2F973X63EES2ORuP2Ee8QtcVMfs6+IDXJ8YDRnu1ki7BpExxHJJ1xCxJl9BVZgUv/xcjAMB+zY4qYQ5zBBOnniIEsV5qgrzg2kg4s+lPc1lmSa3uYKZiM69uN37hX3YtlSn+vQUGi8tD9/TMgW8Ml9i80bGWcX+DH7aJBsggpbOp2b5bq+aYCEboZWjrn1MIbzgyeJc1Jbc0hNqzzu+yNX5/KJgPgXzm+ts14L1szBRk7RFLKibhUykwcUjNnvkoxyHBqDiUsjnZ/hmMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n0oi1lz+; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=n0oi1lz+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVvTH5F0jz3cL8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 13:14:43 +1100 (AEDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AKVY3p1538857;
	Wed, 11 Mar 2026 02:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=P1u+GH
	coGo3ixiU8QeGLcoBNxT5/0eBj4P4MQ4gG9QE=; b=n0oi1lz+9Q6J6W1HxN+lB+
	xhrRVL+gX33qvGBixXnWgDO3Vc/WgSZCMKx2CZ1ynuxw0LGjJBHkZ2BzA/apRokw
	iyYv6cv6qFwK9hILTJZdlB55EzJ+wlQhCind6qRJA4NSIoCR4M2Ehld8h8qFt1sW
	pBR4u0i2XYAntAM+2LO1IoLjWmFWeWFZ3yeLsze6ZZ8jN77lW+VK0zP2RHu1y3RZ
	Ol9+x8gutL85BcK51h2ycPmV4kpwXxsC6HVIQXTfcQmITLFGIhqyEbMUW7QXncOS
	DITmvHfeiLPG5Ip7ETYJQI5kZ0CbiuC94Jaw6ARRmCKZj/jnQzi6KhgWhBJAtwKA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywdsf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62B1DEsj022994;
	Wed, 11 Mar 2026 02:14:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng4kr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 02:14:34 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62B2EWVd46727672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Mar 2026 02:14:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B8FA2004E;
	Wed, 11 Mar 2026 02:14:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DCF320067;
	Wed, 11 Mar 2026 02:14:30 +0000 (GMT)
Received: from Linuxdev (unknown [9.43.124.195])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Mar 2026 02:14:30 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        "Rob Herring (Arm)" <robh@kernel.org>
Cc: Stan Johnson <userm57@yahoo.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/prom_init: Fixup missing #size-cells on PowerMac media-bay nodes
Date: Wed, 11 Mar 2026 07:44:29 +0530
Message-ID: <177319508338.269267.14820702875001464193.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20251029174047.1620073-1-robh@kernel.org>
References: <20251029174047.1620073-1-robh@kernel.org>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAxNiBTYWx0ZWRfX0Yg0g4I24bFQ
 9wxc1AvVZN/JzC4EKd9QDWfqioXDO4kIWs3kCKowoIoXcoR2JsvmuzebCBvnixxX2TAYvZEeaKu
 ZIx44qNMjv2Ag+PxJJMOn1UaeezSxn86EHs1V/NSM2OJ8e9E4LDd0F7hqm81FG59q0hadTofA3v
 uI00tJdG/v8rFi4C3pKRGIReGtF+oQt1FqajQ6h12nVUPu9kobma2EPhYv17AMZoBy8NOi4lu6o
 spN8jAl6/6+O+TjwdiQbazRnmdhYYocXJiiKOFKUZCXNzQPxLZCeHLJeIkb8C/h7vVysNp1N0im
 yTm/aWrQU67eT2fWxjzE58IGvcZd2Zn3qzOoCCWfOYvXB2VpFPo097JzjNKzNS2MnoAxOHNA1Zh
 g+qVtv58kEJfysmYSwlO/dDCEiuNodnSGwerbYgJNOdIIN0nTWWbl7G3LJHlqOP9XVbXjLRE93F
 UYvO/cS3A33W/Iy0yzA==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b0d00c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=y8SWPHF0B-CyNfAKcXcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jYeTGg88REANNiybnhNNE9UCHNMLZBXV
X-Proofpoint-ORIG-GUID: TpzW9psPQvqyyILaRl718ZTt64IhBvln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1011 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110016

On Wed, 29 Oct 2025 12:40:46 -0500, Rob Herring (Arm) wrote:
> Similar to other PowerMac mac-io devices, the media-bay node is missing the
> "#size-cells" property.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/prom_init: Fixup missing #size-cells on PowerMac media-bay nodes
      https://git.kernel.org/powerpc/c/6fc5d63c6ff5fe5e5beea3e7fe2ca3058351ae99

cheers

