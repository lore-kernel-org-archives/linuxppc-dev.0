Return-Path: <linuxppc-dev+bounces-21716-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6982DCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 12:41:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRjdY6ZsXz2ySg;
	Fri, 29 May 2026 22:41:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780058465;
	cv=none; b=DMgSbwBvg8ZLE54fsILSYKRxSUoGaPMN8F09ORyzpLSqB+aGJ3TL+LBln7dktKWhPIRUHl0HvmLFT03gGdLZ2VIhoEKsLTmv5Fw7UpWRdTH464R2oGzHychU7mzDdWHLffrkFIfZKuURN3+cu9lOtPsErsIk3PbCJ1bTWGqn3cFN5Xk6DXaAdvMDx3hnEpN9PrtASYibY+16oTUiD+aL8TfWI/Fug1VzOsWYTAeDu5McIzTyx9vV8DLtHzbjko0QpQKa3yjSBPkCkBJgReWk0lg1NUb4UC+WG9sXvt+9PFBzqWV37Zvr5wsdSPVBYexiZQUOkALEWw232+RXAkM9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780058465; c=relaxed/relaxed;
	bh=Z/XXViwI3nviGMgaGzIGpCI188Z0AZxT1kn8y6Ym1I8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kuo30mPenZZJgmv/0UqEHaBDg41DceVJy/ElsxSAOrVdE4LCQQTQ5WGaFh6eL4YcA068Z73yLpfWf4AMJl1lQLu+lziPFqGiDn7Fc8NhXquocgzwO7Mdg0qWlHNTQ8we9NEMt4BU2jX0qCKAaVpsOqS0JvBg+IYRCkVUCcgAWHeG06vbG06NfUSAOwbQ0QXJr0pT26UNk/chKjLEwLlOJlKx0lOPEzagEQQvLDbBmgoyFW3u0w9P0rDNjIMk+xGAHk4wnJ2g7JaQjDacelVF+0Qv+C8LT2n91bZvViTHFxiiIH3hIc8ZLTQbvm0IQaVlRFykeMYQSKYrxP2PKrelqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XPYRfzkI; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XPYRfzkI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=sshegde@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gRjdX5SH9z2yQL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 22:41:03 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TBbKmx2418177;
	Fri, 29 May 2026 12:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Z/XXViwI3nviGMgaGzIGpCI188Z0AZxT1kn8y6Ym1
	I8=; b=XPYRfzkIma4cPmND8YC3JT8Zs56Bo9KVurGR1YJZgMhmezsOBMKMJ2loa
	NdZ+Fnmue1CeHf0VtZB41daTQ/7PSKSVaZmCUFXwHHmPEUVrFfq3zEHmUyYANHuZ
	5U59nrwbTEzylwjl6/saxbxDWwhkIaUqHmoCoJXTeX8SC0j19tWRkKa12/S7tZah
	kX9SJZNOvHJ5surzNV6ePiBijrOnvSt882lV4hLWxmemBdqzacGHU+pyuTp1XkuR
	T0rqfwM2RaI8epBZFVvfe2vqwBHJn3FAcEhZ4D1OzbklD+oHGc7Yi5Z+CQRZinKF
	lFqJokXfndu0U6Xcl/MUpfeTiFwxg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884rp22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 12:40:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TCdBIg021884;
	Fri, 29 May 2026 12:40:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc5jb3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 12:40:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TCeqRI38535556
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 12:40:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EC8320043;
	Fri, 29 May 2026 12:40:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A3B920040;
	Fri, 29 May 2026 12:40:50 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.221.69])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 12:40:50 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: christophe.leroy@csgroup.eu, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, tglx@kernel.org
Cc: sshegde@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] powerpc/irq: Use optimizations for /proc/interrupts
Date: Fri, 29 May 2026 18:10:42 +0530
Message-ID: <20260529124045.1208539-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
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
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a198958 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZHew1V-Ef7zmNSL-XegA:9
X-Proofpoint-ORIG-GUID: GJzKI5lpGCIssdHIYTG8immaGgD7RDDk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEyNiBTYWx0ZWRfX1MR8/35MHYsh
 902qgjF0pG3Z6bmw5/CYhCHslfO38qhlZsBuZZyh2aVexnHGMn8FpPXh53H5zwGLXFQcDtsfhX8
 5z1qs/MndY6ChL5XfiYMyVSpimov5aoTVZwrpbPfTlgDXCCKJzu7WbHEiKOjUeJYHzwIj2hdVZa
 Kzdh/UX3yEQWpZOPW9DWcBcS+wsEgpKkz/ntznPUFvWGsrkCHOnXXMqVb+ea3Cxh6ZqrNDp4cns
 h8SDdB/pSB3S3gKnR1bK+wo7MJRoRza39hf43ghpC44S7eDbSe6lhhflJHOF1rvOewsJ3UW6hDX
 x+9sliZZ6LXgyHAUmOkqvu5Rv8gb4mje9lMnYiYHUgwrMR8AA74opDhF6fsFKOnGbgNto+CM/OF
 6YwVWAbSNF7LMcXqq2hOw16/lb2QcE5xeExXJwHe+pitkCDLF3KnivYIBnd9RgLth/1YMSHJ8Ll
 poZhFU2zRTcge8Y3UQg==
X-Proofpoint-GUID: GJzKI5lpGCIssdHIYTG8immaGgD7RDDk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290126

v1-> v2:
- Collected the tags (Thanks to Christophe Leroy)
- Rename skip to optional and check optional while printing
  (Christophe Leroy)
- Decided not to add cpu_has_feature(CPU_FTR_DBELL) while printing.
  This feature is mostly true for majority of platforms and adding check
  means more ifdefs in that path. Prinitng "Doorbell interrupts" shouldn't
  cause any issue when feature if off since all entries would be zero.
  (sashiko)

This series is based on work by Thomas Gleixner[1].
Further details can be found in cover-letter of v1.

======== Performance Data ==================
Time taken to read /proc/interrupts 1000 times[2]
Base		:  103us 
v6[1]		:   63us
v6+patch 1+2	:   57us
v6+patch 1+2+3	:   54us

Base: tip/master at 'ddfd3966d0d4 ("Merge branch into tip/master: 'x86/tdx'")'

[1]: https://lore.kernel.org/all/20260517194421.705253664@kernel.org/
[2]: https://lore.kernel.org/all/87jysxw65f.ffs@tglx/
v1: https://lore.kernel.org/all/20260523174016.999456-1-sshegde@linux.ibm.com/

Shrikanth Hegde (3):
  powerpc/irq: Move __softirq_pending out of irq_stat
  powerpc/irq: Make irqstats array based
  powerpc/irq: Suppress unlikely interrupt stats by default

 arch/powerpc/include/asm/hardirq.h |  31 ++++---
 arch/powerpc/kernel/dbell.c        |   2 +-
 arch/powerpc/kernel/irq.c          | 131 +++++++++++++++--------------
 arch/powerpc/kernel/time.c         |   6 +-
 arch/powerpc/kernel/traps.c        |  11 +--
 arch/powerpc/kernel/watchdog.c     |   2 +-
 6 files changed, 95 insertions(+), 88 deletions(-)

-- 
2.47.3


