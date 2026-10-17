Return-Path: <linuxppc-dev+bounces-29617-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2825ACC6B2A
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 07:49:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6DV33jChz2y8p;
	Sat, 17 Oct 2026 18:49:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792223371;
	cv=none; b=clkGPWkQKqDoE9AeEjCyILtZlgAAoTa6+f0D19yCq9sEAZOl4eQ9T+YipbM0jqXzvfxplM6DnGuj2xcWz+EIPiKmujaj8INwx9MJdxHDP9QNxtm6xnhSBJcHjwdBj2EZjOwCWG8wlLORIRONNbq2OQuV7otbrQ5Dkdvbqotv+Qkfo8HCOlnuwk4TDiZeB6HQhUVbmLx0unLBWwXhS1Fb2doaocfkXtVSP/qz6Gd6hSvLoRTFGWvMQI+ca+/6QpSuOounfiHbkflELY4DdeAjdC0BmtMMdHYtOv6biBr/LTYLPLWZWHz+s0Nge6d8WwdsdSmwtEewktECoMHb7KnJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792223371; c=relaxed/relaxed;
	bh=YGtmJBwKncS1PAThUiWF9iq283hv0ltSY2UFhEGSTPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HIddR+CBTBDBhSNOyYp6b7CkDwr4mrQ2KEqhDGiRb3SlVdyJrfGZf6szQLI8q+1zTkQp+SSafUT2eBCaIq/NK5iUXFJ8Gq+ldlpvPVFOllvFlShLDdhlUqs6qFFLL1Z2bNuBJyfQvxvvFA1XLKWjVpge541fvlqLzoO0MteEyFM/wFTFMtYreJIUYS4P/WmTinak+Th/pp4lGFUzGDvnLKksH4A6KbCh/jtFf3N32C3biNUALfHajgGq3i+TJnslMAp3vP9+wcWcGuKIdsEJ3T7AbCtF1HJ0JmUHvm1lLahGm1HPLnGQZZPsqA5qcccudTLGgAf9oT7ytIMA2OrfMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BnyR++cR; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BnyR++cR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6DV227nPz2y8Z
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 18:49:29 +1100 (AEDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H7EG0Q096800;
	Sat, 17 Oct 2026 07:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YGtmJBwKncS1PAThUiWF9iq283hv0ltSY2UFhEGST
	Pw=; b=BnyR++cRw9tUnJHWX5DmTr2Os/iwMF1c4FW8yTIFEix1KdfrMhMSgX8Dz
	6TLqT4VnAeo4EZ6Ax+JU+9h+mHy0y2gAZzwTyGJMQYCpUWXUGe3Mtv0+6IjVWejT
	QRdSWxn/rqw3MpxLvbb3ZRKcC42B5jES46OQthhjuFho8o006Cg+Ut9sWkAcJqOy
	/NWLl2SozF9IMdm+V8uiOZQe1zgp0Y32mx1Q4EKpv5WmedDoFJSFocFu7IHB2x9F
	B1XMbcmsIAr5X3BP1z/c6IFntbj3JvwSPjZQkpOuQ9qvo5wCjAkw7Ghf1wf0kmOF
	jgVrc9vonz8ftB10kuMBopAHPOH8A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0pt8s5x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6o5HW729247;
	Sat, 17 Oct 2026 07:49:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb36wpuuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69H7n8kJ52953590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 07:49:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC59E20043;
	Sat, 17 Oct 2026 07:49:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFB9A20040;
	Sat, 17 Oct 2026 07:49:00 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 07:49:00 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v3 0/6] Extend PKWM to support user-created wrapping keys
Date: Sat, 17 Oct 2026 13:18:44 +0530
Message-ID: <20261017074850.164031-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX8+mGcT6BvRW1
 zuJLWEiN9oB/KMyRIIf/n+acoPjcx46L8HxGkJXtbZbdiUeYQ/fhFz/rLlyIAJk3jwZOcrQUlg1
 v1mEX8VHZk7pFEIbYbpGv1wfWKQnM4N8/7eVbqzdWKl1EFTzznXT6DzLe+ssrbfmph9MORzG8gn
 HLsj4EZNzdxP4h/EbNMgsLwNk+buKXZ/s8OciMx2dv+ke/DDsyVMkzoyqMomMU4FH4c7JKkXnEk
 fUlaGmVHCcLBB2jjK0zTyKaqRE/jRb9Au8d+/IlDvXXVb7FeC0WiLmsFCZAVwK+N63ibccklIPQ
 1nrEK56MAVAp0ymP+S2nNcr/BkO0FY2M1NobYfzIe4YhAFXi/0mRqfmgi1yvuIHSVpR9ssiG8Jr
 470EyZDqR3sTCpSHi2d42MysXGH4yV5W4mmS4pEZT+gx61W50VyfCpYrnNTULYy5qos0Lfk9sh2
 frpyKitvd9ckmppzh9Q==
X-Authority-Analysis: v=2.4 cv=WNvqzXsR c=1 sm=1 tr=0 ts=6ad3287a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UMd8ISttMeN8S66s6c4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX4yaf8oFa67a9
 h8EBVoi994u4nJjED2M0/cBs09OfjwYkFsuG+w/fgLNr5228tEkZTE9avjmVWtRrxFTYR59biYg
 Oi8cGVYFbn9vNsW61yBlIxp+qm9R2Dk=
X-Proofpoint-GUID: oyrami6cW6x-CayfwHU7c7pVvgygQcB9
X-Proofpoint-ORIG-GUID: tca4IdchuDNSe4N3CVqNcUUFkAcn0Skj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170030

The PKWM trusted source currently uses a single default wrapping key per
LPAR. This key is created during trusted source initialization, and all
trusted keys backed by PKWM are sealed and unsealed using it.

Recent versions of PKWM allow users to create and manage their own wrapping
keys through a set of lifecycle operations. This patch series brings these
PKWM capabilities into the kernel, allowing users to create, manage, and
select wrapping keys for sealing and unsealing their trusted keys, rather
than requiring all trusted keys to use the default wrapping key.

This series extends PKWM to support user-created wrapping keys. It adds
the required hcalls, allows users to select a wrapping key by label when
creating PKWM-backed trusted keys, and introduces a sysfs interface for
managing wrapping keys from userspace.

This patchset also includes three fixes: one aligning the PLPKS wrapping
length types with the underlying hcall interfaces, another preserving the
original error returned when default wrapping key generation fails, and a
third clearing sensitive PKWM seal and unseal buffers before freeing them.

This series depends on the following PLPKS refactoring and hardening series
and must be applied on top of it:

https://lore.kernel.org/all/20260923182816.151451-1-ssrish@linux.ibm.com/

Changelog:

v2 -> v3:
- Moved most of the refactoring and hardening patches into a separate
  series:
  https://lore.kernel.org/all/20260923182816.151451-1-ssrish@linux.ibm.com/
- Added a fix to clear sensitive PKWM seal and unseal buffers before
  freeing them
- Retained Nageswara's Tested-by tag
- Refined error handling and documented default wrapping key restrictions

v1 -> v2:
- Addressed parameter validation issues reported by Nageswara
- Tweaked PLPKS_WRAPKEY_SYSFS Kconfig help text
- Added two preparatory bug-fix patches
- Cc'd stable@vger.kernel.org where applicable

Srish Srinivasan (6):
  pseries/plpks: fix length types for wrapping operations
  keys/trusted_keys: propagate wrapping key generation errors
  keys/trusted_keys: clear sensitive PKWM buffers
  pseries/plpks: add HCALLs for PKWM wrapping key life cycle management
  keys/trusted_keys: enable PKWM wrapping key selection by label
  pseries/plpks/wrapkey: expose PKWM wrapping key management to
    userspace via sysfs

 .../ABI/testing/sysfs-firmware-plpks          | 116 ++++
 Documentation/arch/powerpc/papr_hcalls.rst    |  33 ++
 .../security/keys/trusted-encrypted.rst       |   4 +-
 arch/powerpc/include/asm/hvcall.h             |   5 +-
 arch/powerpc/include/asm/plpks.h              |  40 +-
 arch/powerpc/platforms/pseries/Kconfig        |  15 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  11 +
 .../platforms/pseries/plpks-wrapkey-sysfs.c   | 399 ++++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        | 502 ++++++++++++++++--
 include/keys/trusted_pkwm.h                   |   3 +
 security/keys/trusted-keys/trusted_pkwm.c     |  48 +-
 12 files changed, 1126 insertions(+), 51 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c

-- 
2.52.0


