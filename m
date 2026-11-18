Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F577606A32C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XQd+nzZe
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTktg45Scz2yST;
	Wed, 18 Nov 2026 12:44:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794966299;
	cv=none; b=QA+1bYp7mZ5zDkKkzghkrwTiTn0JSfgnKlwYzwZsKuoU8zjxm9Ysjz9wvckPkoi02ik2bWTLZY10WgpMNFhCV0YzmGiEfbaK7aw8Z4+Bqt+k/T0p19HRj/FwgG5Lwn/e9EMXz1dXKet7mfKxafgR+BPVwvjkDEGhrzVszlSwnkd/lDkVVACZ5eVnMmfQan+KpzF0btPn43zk7z++CW7S7MAIKDdKyU1fBbcH3cSrCcfxNSvLCnrVEqKE8dHSZ49gl1gs+K0Oz55Jfsg/87KXvVj/f7BheAVizwzgS5VcV+efD/LPUcMy0e1DYr+sIv3vuwNPsOrInRWf30jCi923yw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794966299; c=relaxed/relaxed;
	bh=r1NfD71LFXe16M70T0k5bts91yRnypqM+WYFJNkhDP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8kfHCMTNBifJnBXw4ScB4a6rrKqRI6kW/M0z36paDWVN7QVU3stBuJO+PPfQ9aCjXwy3dq67rQHpK+0SluWNgW1Yct4MCHiU1PxhgRvwvoldlczWLYVnpc+tumDuLs8bbhDoBKgkp4UdSgX4MGbd00ALQY0Ik0gwTSuJcX7YK0iAiSrfhQV2HOMW4OaRRQfBBEEbCo4P26mlZSVQb1Ki49ECpwfT+ke7+aFOzuqN+0OTZ9GXJ42HK9vFjM1DhVEzhffFeMF4GD5y0MdWWZSg2OEYQlqeNZR+a6iY3Q4Yuot0s6Mg9qHjyyGTnsRyBVLiVnSYvpMy1gVyfGP91awRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XQd+nzZe; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XQd+nzZe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTktf5Vg9z2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 12:44:58 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMuXA43803099;
	Wed, 18 Nov 2026 01:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=r1NfD7
	1LFXe16M70T0k5bts91yRnypqM+WYFJNkhDP8=; b=XQd+nzZeqItaz4TwjaDZKX
	MxlY63vODnK2LfE7POV+EaDL/e3JYQ1h/1hieYGSILIlRZPkmHrRyHNz/BeVxLZF
	yE0tpa1/iefcu4tJR+xZyCRadEit9RUXudy3d1Znb6OGjYI1TC3ll5UTuCGCNLuu
	4zukoowpbNePcXnjR2J8YSD0CLEMRpb0rcKVksqKJnWtQ9rG9ykDaooqyM6q0qKF
	0UmV4pMzHRHdEJ/qJ/6FxdMAROuEVVgC08BzlRKmNw6Zl1RiyGfzA+8EZYlPmR8E
	9WDu3B9Ys5fudtrFfPi19d/lFx0Dx/VrAL25FWTeNiCH31AqxjVEZSiprLu6R5dA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n8d4w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMo1L61188989;
	Wed, 18 Nov 2026 01:44:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j02dffbnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1ilCn36897034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:44:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB63F20043;
	Wed, 18 Nov 2026 01:44:46 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5FB820040;
	Wed, 18 Nov 2026 01:44:44 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:44:44 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, chzigotzky@xenosoft.de
Cc: npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
        Christian Zigotzky A-EON Open Source <info@xenosoft.de>,
        Darren Stevens <darren@stevens-zone.net>
Subject: Re: [PATCH] powerpc/pasemi: Defer Nemo IRQ initialization
Date: Wed, 18 Nov 2026 07:14:43 +0530
Message-ID: <179496619900.633156.17813515069324625862.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261024075519.18877-1-chzigotzky@xenosoft.de>
References: <20261024075519.18877-1-chzigotzky@xenosoft.de>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX2M8vFFJvs8PQ
 g7N4JCzesrfsu1YOgt80OXMx1zRzGD6kbwq/WuWPZZFa+4tGnw4sfddirWFvscEqCub07rM+YjZ
 VuLmvAn8qedbZPrMXo83nFGZYQcD5sWrtEc+sDIFfE8x5XcBR71blIusBmTidDovQYw6NjXveSP
 uWqL8/6WAWJs0wJAceyfWV9JLVmP8OdOel2/A+G/QPP2SM95gPRdSinIZHHyvCJR5/swRqqCbe+
 dBadn+6iktstJrVSKjx6VxXOnmwTr3pI1SddAHzJUvY5W/2zGkrne/uT4mCHrFu76SgdOw+eVjb
 QxAYDMmxtylnKQRrkhd6Nl8Swhs8vhsuVCw6bBabOh1Qw+x/I1STfy3JxdI2NgdIEtl0v4BNda9
 MTHTGAcUop7GSY08LtaZq+r5yBwjA9BikBVuwEWLpfLDoJ4AjhWSB4/C3YUToZCqaSEOBwzz16m
 z9Nw2jSph8Evx+Ibe1g==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd0311 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VMUXEH6qRLZFilRPljMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: YkxCkwoDYS1VBN-n66Y03o1cW25-7BW5
X-Proofpoint-ORIG-GUID: _PCizkVd6gaScs15bH3zxOAflcwMFSSS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfXyrtbUSiMgGL8
 d2a+kH5r0jkqGjHvGVyxt80+w6eILRk9iauZ7hNf/UlvaW+NP9XDlmpy2OOmH7ANbbAze9Vd6eo
 rF0STsCIThKL69ta92oDR0kdrijaCfI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180005
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sat, 24 Oct 2026 09:55:19 +0200, chzigotzky@xenosoft.de wrote:
> Since pas_pci_init() is now called later during boot, the i8259
> initialization in pas_init_IRQ() happens too early and accesses
> registers that are not yet mapped, preventing the board from booting.
> 
> Move the Nemo-specific i8259 initialization to pas_add_bridge(),
> after the ISA bridge has been discovered.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pasemi: Defer Nemo IRQ initialization
      https://git.kernel.org/powerpc/c/0a7ad2e55ff0de8c13dbe25aa87cecb0243b245e

cheers

