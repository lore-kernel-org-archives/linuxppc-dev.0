Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A6606A32D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OScYwUzc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZRpG16KNz2yD3;
	Thu, 26 Nov 2026 04:42:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795628550;
	cv=none; b=aKYE/dl5S7edXPXHrBLZw9Ji2N6J1SmfeyiISZ7G4R6etG/7lAA8nCAWInUeNpM8OJSLdWLJU3zsW09A+bvJ+7Bxvvrxjv6noYEQYaHQYNpQko3ttmBheJcOycy+evg5SEIGAzuF0kS+lnfRZZ3RsqJS6RgA1VqkQR6gxRyXpPRmRR9phg3hI0+Rm4lFu7QFqKRFoyJmAJ+BFCWL7h/ajUgAULxIzgBREIRDxdqhYBQXHjKG2cFlXJjABVU+OtWr77z7xyKVSQNAhyEBahhyK8gjc+scHi8uHdZ67PDFb/VULmriwfi84oFcuEz9WhH2lddVhn8QKpra1i5zTKK9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795628550; c=relaxed/relaxed;
	bh=LPPHuulaikQiXaCnvkruNCKWaFum7YwbaWHAGhlKNQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ve30R/coGFfghisJp4Av7pFV0GxH05jmhLCIrBZQwPBB47exLNhMuUgQHRuVS2WxRrE/ok6iWbZPeNnKEtKgnjBLyI4B4Q7P+qF9aZCyXWPm2SBeDCnY9LNM0TSnEyRcsW4WBM5mU9AjHJ+7cosmdYrkZSdV/+tZIo0NRu626yyhrfRcCQlANyhCTNDnGDK/2ggotFyq6jr5MMHDqphIl66ca+SQIs6YyQ8a1F9cH4fvtxUlmOzKESl1xDKboVdu10sBAawyNo6scKrR/lkmHp8vxn1gO5e/jSGoX+NbO1hwLZcgCIWkanmry5NB9LtRvVojciT3E/fNC2Xuvn0/dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OScYwUzc; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nysal@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OScYwUzc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=nysal@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZRpF2lpkz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2026 04:42:29 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYjkS1799432;
	Wed, 25 Nov 2026 17:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LPPHuulaikQiXaCnv
	kruNCKWaFum7YwbaWHAGhlKNQg=; b=OScYwUzcShj8wuDCj1uKdZkKLlMoe06K2
	ujCe7rK3VJ43JROktCsgfwR2W8Z3nEuZD4ORibikLun9N+yJy2KFFQNhoCTuDvu/
	SJDz1NFAXBLYFlwLmFP7VRt7I6egnOVzE+AlZ1NEWa9QK5UPhtIUo667uBLNfP2a
	ACmcLVyXNaKdXxaYxYqIOK2C2I3ImIH65D5uYyR4hydKKflqZ7YoPiwS2VZmLKaR
	3Kou+o8nzQvIOBM6CXVy3lRE9OULPHY2hseNoNFGi+lhsbOi8lQyC44p2YEWTG3n
	7bWN7o1alkXS++0EQn2Lx2hdUhQhYCDNeNo2CtZvr3obNX1QdbHtQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvd8y5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 17:42:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APGYFNx4082063;
	Wed, 25 Nov 2026 17:42:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5kfa31m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 17:42:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APHfxYC15728904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 17:41:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CDE52004D;
	Wed, 25 Nov 2026 17:41:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88E3F20049;
	Wed, 25 Nov 2026 17:41:54 +0000 (GMT)
Received: from li-398ad3cc-28e7-11b2-a85c-e030a5b10d54.ibm.com.com (unknown [9.43.127.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 17:41:54 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Jeevitha Palanisamy <jeevitha@linux.ibm.com>,
        "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David Hildenbrand (Arm)" <david@kernel.org>, SJ Park <sj@kernel.org>,
        "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
        "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
        Usama Arif <usama.arif@linux.dev>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH 3/3] powerpc: Enable lbarx/lharx for Power10
Date: Wed, 25 Nov 2026 23:10:24 +0530
Message-ID: <20261125174035.1412724-4-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125174035.1412724-1-nysal@linux.ibm.com>
References: <20261125174035.1412724-1-nysal@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b071dec cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Evex6xRZPpu2fT-j4YAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA3MCBTYWx0ZWRfXyNCUHAgykHi/
 9XdHScJXtbTZfIy3jGOy4VwjQEeTAmcA6ZT38JmGa1Y0SA3bym131v6ZDFIwd4RGriXZ11G88R5
 RuCJN87Q/IeQNtSwctEv128FB/9pnP8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA3MCBTYWx0ZWRfX4OSbR1+HHNZ7
 98lk/MHXqEe7Jdkknfx3XjnL4WW/DSGNhzSY68GmdPE4qFrXTajseXiMxjCqNtDiaVJTh0d4nyP
 0V/pSegTar/8KryBkcIkZ0J8zecInTZqZ1IQuMXNCNEqtB8sU2k7lXoQWA7l9sa/KCL0XQM9in7
 arWSMFTYcv3ZFWKhb4mbsyyg1i4whhENM15/u9v5CqQlhx5cvpjAerYcy10K8KbU71Mr9Ca8NlL
 C9SRA9qPQ3jhxHxqtHeVeqGWIQNmJW3hvzZ8Od0qNe4Mms+0vu2L9HWHleBMmg5JcMTBV4lLhFs
 hZ9CjgT00txaeb6qjXWjsb+ymUH2lOub8Lt0+kI3t/DLKTEukHD7YOjLakZxtImEwj/4oUDooJC
 j5dsgJiZaOp1mm9bXVh2cKEzWGsrFBF3fJ/wiFSv1BBVBh5gcff7zupR3XlU5gNCuosbS2cX2Jc
 1gCQb80lcZKIxoR2+qA==
X-Proofpoint-ORIG-GUID: 8ZVI26mnbQf7HP68G4ZAKBvoWCUThTwB
X-Proofpoint-GUID: WRtz2hBEVgaOrUexqvW1O5PHpVOaFx-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250070
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Byte (lbarx/stbcx.) and half word (lharx/sthcx.) atomic instructions
were introduced in Power ISA 2.06 and are implemented on POWER7 and
later CPUs. Select PPC_HAS_LBARX_LHARX for Power10 as well.

Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
---
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a42fd4c64159..25d4a5eb3216 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -178,6 +178,7 @@ config POWER10_CPU
 	select ARCH_HAS_FAST_MULTIPLIER
 	select PPC_HAVE_PREFIXED_SUPPORT
 	select PPC_HAVE_PCREL_SUPPORT
+	select PPC_HAS_LBARX_LHARX
 	select PPC_HAS_LQARX
 
 config E5500_CPU
-- 
2.52.0


