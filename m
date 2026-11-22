Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D1606A33F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 22 Nov 2026 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SPzJBfOb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXGwm1S98z2ykT;
	Sun, 22 Nov 2026 15:55:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795323336;
	cv=none; b=BM1fw5gf4azBZrRNRzWbOtdFCMZ/XPICzG3uUIyo3rpQn35jbBvK/hpfY5iVxf0ATaG6+llWx1vZXj/Xgv/ySOopjV4pwrnOXFEfpY07wsTCMH/AAZSJXqODktcceatc1gUL7BxhKbATuYXjYcVU3EkjUCRg3JICKmroGPiTFCJBlGQHsEIlBn/PvIQYgD3HKlcNgBkaTCFlN1w++25RIjMzFiYigsdHLsOztFV0sF2uBoO+lBGjbXdQdfynV+n5WLxdDnlia5he5gALslSA/2qHawgFDPx2KU4+D4Re8oq5tzWHbAKy1YiebyT6tKksWQSNgMBssD0nN1SHwBtoig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795323336; c=relaxed/relaxed;
	bh=8FFWpgKMkZMl0CyaUXSGR72Ts+mYz3xgwim+USIx5gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kI2oTrnuqvd//EeS/vFg9Pje+ROxg+a2I8dl3TFoZ5vCCAsB2tnXFHJWHd+dTavBvlCekz+mTu27GV3wbaWaDVvoPaAv1mQhBIDykI+E8mVzBnlQMariuoDp4Kz8Y0ZPodxzjlqHLqFORSHe+xZ27nKnkXQzdhBjL3N5AJPCvAaseo0T+a3th3UgPEXkcWWmPl8bVG1N4xAgajZCZnPDFbsJIDI9P5FV32bal1cl1r+yd3fdfj3K71gO+1K7U+3XiGl4v0wlUAPU8TaOlvOOkMFUkyv49Rjfw5wE5MbJ8oBXu0zYn/1RLqZJWuqJZ6SW0NQxeZjRkXioTUYByArFKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SPzJBfOb; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=SPzJBfOb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jXGwl0rdSz2x99
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Nov 2026 15:55:34 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM44cMn3865381;
	Sun, 22 Nov 2026 04:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8FFWpg
	KMkZMl0CyaUXSGR72Ts+mYz3xgwim+USIx5gk=; b=SPzJBfObRLOEKJEdoarR2t
	Cvrs2dXXc/6AxkMZ4wqk6WZ7o7HRU/w3lKPBuDRHYAbLX0fv9n9GFvTDtwkgRW+p
	R9GLtPAxjzR/IbdSRWZB1wvyFHS3WSpQQd10ITBtQyaUQJDhkJhTW258xu+FhWBE
	3U1YwQcW2oQPuI1mwuq+P8T0keY6+6Jp35V7o/vU+PiNg4m3JWHgxD69rYEazDRW
	bYb35joAhyPNM+w3rjk4Lz9yR7b1VictuR7lJwli90xCCNrrcL/NG4C4tdBM8fhs
	glfQRDzDGHwVjjwH3nKVu2kkc7wzoWe9Rfc46od9b+fX80Z6cpeQEFVTly8rl+Pg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34f9w0sy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AM3o6Hr3197290;
	Sun, 22 Nov 2026 04:55:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3p0v8q30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 22 Nov 2026 04:55:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AM4tJlV31654652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 22 Nov 2026 04:55:19 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E438020040;
	Sun, 22 Nov 2026 04:55:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B10A2004B;
	Sun, 22 Nov 2026 04:55:15 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.90.96])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 22 Nov 2026 04:55:14 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org, chleroy@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, kvm@vger.kernel.org,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCHv3 0/7] KVM: PPC: Misc fixes and nestedv2 vCPU limit fixes
Date: Sun, 22 Nov 2026 10:25:13 +0530
Message-ID: <179532322370.92012.11778191262378780337.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1793546707.git.ritesh.list@gmail.com>
References: <cover.1793546707.git.ritesh.list@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX8rpHc7zeFL88
 67HLj2B8XegXHgTGGlymf2Ogz+NZ8xeMqyWtwpG0EgydLOIlIzN7cn7WaRpeNlj5S9vwpTmXo17
 iBjpBy9clp21xzuPDLKxzotGZsXpHFOlITqu/yQ3VxXI7c97gpkMvSJTKezBW2+ynJH3WIc8uZX
 PEFAAwI5VPcd8LbjYhz4dFC1zz+CaihN4dkn3CNuE40YvipDK0qMUL0jjmthsVA68CahwMVcLod
 48vzhcuqQRZ3PEwhW1x9uy3Oow5V+4UrH9XS+Krfg91LxTZyrAjxKQGz2gCppE8sBsnAjaGKqv3
 +YVYTlCp3cFenApftwH10eUPQcjLngtIpcn0ckS82PVZN/HFz8K2+yVrB4R8woPfvoRm+JeUwET
 ju9SHtByoqnuXhvqHpETA52GKo2KGfvJjtvguUMFkcxeeRisQ4A0ZBl4JN+0xWgEWQl4H2JCPAp
 Z2L93gyDo01d3qHA6xg==
X-Proofpoint-ORIG-GUID: _AY3Xri_GmekMDdQbmRTvWKLCePYhUoB
X-Authority-Analysis: v=2.4 cv=U6QHnuru c=1 sm=1 tr=0 ts=6b0275bc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=J81d5-eMGWSQt8CazSoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cQj25jZ8X9RCV2i-QA2yweXEZXXabs6A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIyMDAxOCBTYWx0ZWRfX1HpIo0vTsLIT
 ttxuv4qSqB2zseqXzP0pAx9ZdDKBllAAxxJIsVxYCk1c/chFyS1W2kVFC/D7TJ71KFm+WarGD1P
 OoDHyNlbL/8pI5+mHh4JFazS6cJY4OE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-22_01,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611220018
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 01 Nov 2026 20:58:05 +0530, Ritesh Harjani (IBM) wrote:
> v2 -> v3:
> =========
> - Fixed logic bug in patch-2 & patch-6.
>   (realized after sending + sashiko caught this as well).
> 
> RFC -> v2:
> =========
> - Addressed sashiko review comments
>   - added patch-3 to address similar __ffs(0) problem on booke
>   - fixed build issues in patch-4
>   - added patch-5 to reject vcpu ids beyond the PAPR limit
> - Few more patches were added. Few of them were reported by Sashiko and few
>   others were caught while doing vcpu create path code walkthrough
> 
> [...]

Applied to powerpc/fixes.

[1/7] KVM: PPC: Book3S HV: Read EX_DSISR as a 32-bit field on guest exit
      https://git.kernel.org/powerpc/c/b282541b555b9ddc64b85fbe00bbc39522aaa911
[2/7] KVM: PPC: Book3S: Don't call __ffs() on an empty pending_exceptions bitmap
      https://git.kernel.org/powerpc/c/3aa91029dedaa00780f5aa15763e88d31c43eac5
[3/7] KVM: PPC: BookE: Don't call __ffs() on an empty pending_exceptions bitmap
      https://git.kernel.org/powerpc/c/d9801c9fa4a4befc512b43c6b3406fb0bddb00d4
[4/7] KVM: PPC: Book3S HV nestedv2: cap max vcpus to PAPR limit
      https://git.kernel.org/powerpc/c/2b1e236cb3dba4353feb9c77116645e57ba91669
[5/7] KVM: PPC: Book3S HV nestedv2: reject vCPU ids beyond the PAPR limit
      https://git.kernel.org/powerpc/c/b8c0f82d60c7d149b271cec9364ffb815866cc80
[6/7] KVM: PPC: Book3S HV: Fix error handling during vcore create
      https://git.kernel.org/powerpc/c/d76620d9e2ce87963b993a44acae7ce1a47eca24
[7/7] KVM: PPC: Book3s: nestedv2: Free the guest state buffers if vcpu create fails
      https://git.kernel.org/powerpc/c/f6f88b0aa156a7df2477950fddf6b413d1c76a31

cheers

