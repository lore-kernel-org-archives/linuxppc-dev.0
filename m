Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8028E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XKB+HWlL
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTktf5nd1z2yMP;
	Wed, 18 Nov 2026 12:44:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794966298;
	cv=none; b=lFcn/DjSXi4s3O54y7cg8K3MqRy68smzIzWVnRpPc4ZtBKpNJy1UmPOmqDCo9ck3GOo/2j/A3ZFZlR0h7yglT58NxV9wWcWKkBZmhSdIQlmRMlh3zi7yli5CV9cKneIYeS6mdGmMO8VgMp1U0N2JNHmduT/Ue+PskzPcM3DJ6MXl0mS6O2pc6bYEhd4L5gFV2Fl856GxzpmgkTcQLGTicMrdb6pST2fB/8LkIe10RR0iLYOu1/td4DUFoURYl8KZZ4FpaE7XGae7lilBv5sT4edmOpRFthqld048L+RewpHd3eAM1IlxZ8D0IP73EhzHxS77IH3i6CBPksaP8fjULg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794966298; c=relaxed/relaxed;
	bh=FhsWre7s25P08uI0qcISOa6wmrfrsuEOm+zRffw29R0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nvyGmJrsz2kGYKUj/Lbxwen8DwsbibvZGbBPHUoNnzh34kEh+6YtbsWLRf3FgjvfWkAtEg9uvpQJmtakexiHV+aAIaK09+4YrrOzcaBw/dlkypa49lmx4jfS3R0doE5Pp9X6kB6taqBmUL6RcSv1ET0cVdcJs2nJ6JwoZgclcS7NEWZGKm0B56yCRo5Yc+51qIIkqFtiU55a4d1WAHR4UeBrWVXpdManZlCzA0pm27IxJaSXJOFgp6akRq9SdYjOECLIWmVRINXw5qll58U4r4a5lMX8GhmajyqkO6SZaGK8EMGbRlWFnMsT9gFGdmc6uwxm40956vDw/OO4sFSCsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XKB+HWlL; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XKB+HWlL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=maddy@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTktd6Nbgz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 12:44:57 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMv6UJ3623639;
	Wed, 18 Nov 2026 01:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FhsWre
	7s25P08uI0qcISOa6wmrfrsuEOm+zRffw29R0=; b=XKB+HWlLXzoJrsNVHC0btO
	i7Y3H6W1BsYdioGXw9oBlxTFJctbIPJ4mFGshOUPKm51cQsdfTTgJ6/uz5cu4wS4
	7/hG20TG+aKeB2CTZGt80yaVxY8Iy+UXqIF+lQRbz4j3vI9X4MABht19/XaFgsTs
	8s3YRBRNBhekwbFay/qtLLKVV3CqvZMFM8fza5zUJbyly8jzbvdZDHZNpqMT9N/z
	fYuaNxJP5ZSsWVUj6kyaSbc+rzAbJblDcgctY4YB/pTwLsxx77WREreDgOpRhdZ+
	98dKuUFJPx6AFoKodRLaCy3VOdz057MiN7bC3FMADQLBrmsACY/t9KLzzCdIuEpw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wrcq8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AHMo0FR030817;
	Wed, 18 Nov 2026 01:44:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067ne2k3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 01:44:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI1ihkY45023672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 01:44:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10E6620043;
	Wed, 18 Nov 2026 01:44:43 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D99A520040;
	Wed, 18 Nov 2026 01:44:40 +0000 (GMT)
Received: from Linuxdev.ibmuc.com (unknown [9.43.63.250])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 01:44:40 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Bradley Morgan <brads@mainlining.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc32/modules: Reserve a PLT entry for ftrace_regs_caller
Date: Wed, 18 Nov 2026 07:14:39 +0530
Message-ID: <179496619906.633156.17246570621817447596.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20260923175631.235276-1-brads@mainlining.org>
References: <20260923175631.235276-1-brads@mainlining.org>
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
X-Proofpoint-ORIG-GUID: 1s_HBfrDsnlBO_BIREVmM_UyfFYkQ2-o
X-Proofpoint-GUID: 0Bvrgta659mSx_KFmFZCbN9weHMh7SKw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfXznMdgfEXKlXs
 Z+kYSF7DPZ5eGLwx4DIhPUEwqpCupCwoyoVq0RmaFwcA3Y0woYl0Q/sv2FBZFvQETPSZ8jqrFBT
 goh/cEZ3kHAYgZTAHWT270wkww0aogi1CBn//KPNfxT6BWRhK6Dzwx/tZC31hRRTox56PPXSg2E
 ehopgTXnQkjh6JTQ/xag9zE4WrmBlJHvAhl0xfNPXoCxdHqzTKASMMR7niuOIhh29oyMIq3rCP1
 mfeLTD58Dcej907sXN7F5eb+r3NY1SrzkJctsI7Kg9aHeQm1C6frMa/CtUdMTZe+VCJDzNbOcdN
 sOrS1IjKVealnEafulbq18gxHdb4iAvwJDHqthyImj0E/QtwqnphMSkos3NVKA+CMye+HQjB2qY
 tUf//P9/on3+4QYT9/sZXlP+B6RWH9FDKgMOeWrC9l+1HesntNVxSEPkdqJi8D9l6z8vnsj7bT9
 m99JrGZWBhLOVDsBsgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAwNSBTYWx0ZWRfX79tXqR3KpD0Y
 QJGkjyE/nH2KV16uxZaHFw97lu/pX+2+XHG5WSSXKa2aNk6Th0KQMXqxVfXXJmEGv25Z4RnaRyp
 AUTOqjOxhAsbtEzmWNybfU1Q2YZi5DI=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afd030d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=zYSBeUX9ewWLthcKsckA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180005
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 23 Sep 2026 17:56:31 +0000, Bradley Morgan wrote:
> Commit 7dfbfb87c243 ("powerpc/ftrace: Activate
> HAVE_DYNAMIC_FTRACE_WITH_REGS on PPC32") made count_relocs()
> undercount the PLT entries the loader
> consumes: module_finalize_ftrace() now creates two trampolines
> (mod->arch.tramp for ftrace_caller() and mod->arch.tramp_regs for
> ftrace_regs_caller()), while count_relocs() reserves only one entry
> for ftrace.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc32/modules: Reserve a PLT entry for ftrace_regs_caller
      https://git.kernel.org/powerpc/c/dc6eb6f08be536223e8289c7a8b1f515b1355721

cheers

