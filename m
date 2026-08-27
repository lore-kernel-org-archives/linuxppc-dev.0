Return-Path: <linuxppc-dev+bounces-26130-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F091C5DF9D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Aug 2026 06:23:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hVs0d4Xmrz2xwN;
	Thu, 27 Aug 2026 16:23:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787811825;
	cv=none; b=Zkka3AhlU+znD4xu/msB1g1xx9H6xk3oxJ1MxAbHWIq7/rtsh3fV0s8Q0fkNo10amsvx7xCllhOE9I8Ktr7rql5LcViLmhcaubGEW/lHzAtpxrfW5/NewB2RehJHQM5ktf3ZGEhkuLvC/GBbST90j1D687KZLBKy5p4zMzQvL9vmMtQ92A6ZTKxV4PMN/dpfla9hCF2DVgsp7NCot9MMFU1HtisovwsECenDtePO6GrQYlkFIZaN+/joXfh8fXEHAy019DA4PFL/yeLJByUiTL2J9/bYneptmjPmAZdZYSk5dRQ6nvJ/5oADHIu56v81ne+e8JWYn1qZ9TyQ0fXGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787811825; c=relaxed/relaxed;
	bh=wDkkBq/zQRjvyGz/fv752jvBhNJjNG8gKU9apD71wgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VT7OTX5J3GrUhhQc9W2mZPEUzI+qSQpyl4PvVcqH2JlorlX5D5vg1quh+wtO9rHi/sU77xp0MDKOE/J3mfi0fOlzHWFk+O0cvl99x4Zj3C/ksHJ/L0lxJtBALCaZ/JNergi1Z0xd51ifIA3mG6xy2HNVQPU0O9E3VcYWkEXC+Mu0aB5Sr95AlPMqIWkl+O+hwszpO5cMegDl8jd4rukPVPZFtqaIi9sSF+lHEfTuwNnhvNShW6PIiF8YEcGE8xSVnULkzMUFMr8GWqvR19ezODitZXhRh3c/PC+5KV1JJdeeeMgL0x1i/o/BM/+jKz/1z1iBwtVWuCBfamStNPYb+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=reiRl5us; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=reiRl5us;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hVs0b6cdlz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2026 16:23:43 +1000 (AEST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3VdO61715236;
	Thu, 27 Aug 2026 06:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wDkkBq/zQRjvyGz/fv752jvBhNJjNG8gKU9apD71w
	gA=; b=reiRl5usw1lINty/gEgjr9NSOi8+ogsIHO2hurHS9IVGWV4ZnC9AK8/3n
	S8Lr1VDyiwszhT3cz182tiBR9Y9yBD2bvMvfOcVZbXWOsY7eb//76hA+n8EoAkYH
	XFwFgCzCrkV0/69BH1agRMRx911yGHn5in5675Gpcw5tR4U0ZHcIKqFYytRVsH35
	k/ehxI49mzUkVJzhNMGvOs+GwuZSd/whMA6ibyI3iqE3V3/HZEToUuyqv1AY7wHj
	7tCmghJoUDI+CZnpI/3NrQbviaEiAxdcazWoBDCf+a47M+aQ5Cp35XO2Qw0xwMkb
	k9TYRQ8W/M5vU0vxn+2upVKuCjtEA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j3ndd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:23:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6BIfS025454;
	Thu, 27 Aug 2026 06:23:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k6fhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:23:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6NOBe30867940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:23:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81E4920043;
	Thu, 27 Aug 2026 06:23:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DE3520040;
	Thu, 27 Aug 2026 06:23:13 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.76.202.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:23:12 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH 0/8] Extend PKWM to support user-created wrapping keys
Date: Thu, 27 Aug 2026 11:53:00 +0530
Message-ID: <20260827062309.724808-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfX2X5Glst8xwqu
 hMrbTtfNiANWbpwzLVDkyUHzc1wpnAcV7yOU/Rfdk5QHwb0/KUM6McxFTCxC9ko5XXUy93OavkS
 G27q3Y3W+ORuHjGkqPM9o07XbbOKRl8=
X-Proofpoint-GUID: zawEhz905MFPrAEf-En517P1M1_zeAGf
X-Proofpoint-ORIG-GUID: EFJOoTvm_tREc0dQ_TZE1nks12qiD96N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfX8elJOjg6cFbB
 vd1NOyDrNLqntbGxs+6HjFPnOymXqFYRN186HtZ2gkm1257Q4mR6lo+ypRAlx5rd7xzAx86vXVa
 gk2ooxyA1Z6xWGad4WQbm47ln6Wqkny/Xvv5TcTCp2NHnFj98gkoAMhiDRsWKvMiZXdssvzBA/c
 CWIsjVt/Onkk6mV/asRqvkuz2nPryhEIkHymdYwAjQDUlB17aLD7sAV1rr20jgmHeiMGLP4Vd64
 vvgdG8XijK8YlsIau2VkAvTuSaj8kZRRMPHMMsHfigzXw0Bqc8/D9xw888+rDP7mAuO6pIqpUxs
 gZ11U/Z8FmTbvsbhwrmZWV0VUERo6fSNrPZZL5zPELUt0excvIDJ7pYINAyNmzA3qgto3PX1gJX
 7MceXIySo5BDwKYsqAlqg5vDzRJ4a3609HQLYvi8zd/qU9+4vuPBbcnLHI7gzUOEy6rywwhkrN1
 anZQLNXEghAbCF4VK0g==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8fd7e1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=A93gRhB2vYe917ExAJkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270048

The PKWM trusted source currently uses a single default wrapping key per
LPAR. This key is created during trusted source initialization, and all
trusted keys backed by PKWM are sealed and unsealed using it.

Recent versions of PKWM allow users to create and manage their own wrapping
keys through a set of lifecycle operations. This patch series brings these
PKWM capabilities into the kernel, allowing users to create, manage, and
select wrapping keys for sealing and unsealing their trusted keys, rather
than requiring all trusted keys to use the default wrapping key.

In addition to implementing user-created wrapping key support, this series
includes five prerequisite cleanup patches for the PLPKS and PKWM code.
These patches improve error handling and type consistency, rename a macro
for clarity, prevent unsupported capabilities from being exposed through
the sysfs, and make minor documentation and MAINTAINERS updates.

Srish Srinivasan (8):
  pseries/plpks: update PKS documentation and maintainer entry
  pseries/plpks: fix error handling in plpks_read_var()
  pseries/plpks: improve type consistency and parameter validation
  pseries/plpks: rename the default wrapping key macro
  pseries/plpks: hide wrapping_features when unsupported
  pseries/plpks: add HCALLs for PKWM wrapping key life cycle management
  keys/trusted_keys: enable PKWM wrapping key selection by label
  pseries/plpks/wrapkey: expose PKWM wrapping key management to
    userspace via sysfs

 .../ABI/testing/sysfs-firmware-plpks          | 106 ++++
 Documentation/arch/powerpc/papr_hcalls.rst    |  49 +-
 .../security/keys/trusted-encrypted.rst       |   4 +-
 MAINTAINERS                                   |   2 +-
 arch/powerpc/include/asm/hvcall.h             |   5 +-
 arch/powerpc/include/asm/plpks.h              |  40 +-
 arch/powerpc/platforms/pseries/Kconfig        |  13 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  31 +-
 .../platforms/pseries/plpks-wrapkey-sysfs.c   | 407 +++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        | 557 ++++++++++++++++--
 include/keys/trusted_pkwm.h                   |   3 +
 security/keys/trusted-keys/trusted_pkwm.c     |  40 +-
 13 files changed, 1188 insertions(+), 70 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c

-- 
2.52.0


