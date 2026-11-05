Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D880606A32E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QWxinNsQ
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL4nV1Zj4z2xN4;
	Fri, 06 Nov 2026 01:43:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793889838;
	cv=none; b=Padb0Mp9UAj+EOqwnl7vX2tD7dydQo8IQDH3CMa3UNQg5cBL6qK6Vhm8H67mJ785nD+0zxrJnqS89PQLN/730g3qf6EI1BzugmZ6uhKy04OZOefIvWJn+HJDnxYJmULg5IH82rzA95Q7QuQWB3xwYTOSR9WGHDh7aZuQBSTW+1XYv3qQU6QjJ2Arx8gWFwWbQGBKyk3afX4Ua9W/osmot+sB2DHTUBN4GW7mbn+Y0W6G3gVKEIaZo7Mck6u0KdLfOxkndKXgXl284AVzoY3iao8bwh0haGAlLN4ZgR52QRuUkOtIkyzYNhzEP5+BF0PR0xPaITI4dWafZQv8nMln+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793889838; c=relaxed/relaxed;
	bh=sQrCRoliZd1zlb3rt/5YQhInFDdr0lZwJn246gGNKTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3QWhJoWeNqYwS/+rHtUq8aLFMkrk/1+COiwW+vrFgskiv50TWDqmUrSvRE6Wf9vBKPf+zPWMh7MvImxZNq+wj0nq23CPgA4/08Y8MDeXtLCept6HXMvwmUB5g8rKfbLlDsUE25mTNT1nQNzIWLQlaT6AlxzEbbxx5RjP7LSA/kJmQqJN11baA5U1Fz7SNPsTw+5cA18ML/Kzok0sntlGqSZile9vNaz81gTzCvIbHot5gpFd+CnLJf/BweuGvEFGP0NPkW9ak/2A7DrJdqH5xWyfwiH9teyV4tG3vSMZtMUJs/4qwbuN7R+rbgQttB13SaV+Qi2DfK54dP2eAD5Rg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QWxinNsQ; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QWxinNsQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL4nT31Xyz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 01:43:57 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AEBVE3166383;
	Thu, 5 Nov 2026 14:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=sQrCRoliZd1zlb3rt/5YQhInFDdr0lZwJn246gGNK
	TE=; b=QWxinNsQ/dT+S/Sln4aYpQYtPAGzaClCWkV3uad7N7XFMkLS8gDWeRxP/
	mHlKhSzS+oSdq8RHb9ryvrkJXTZWNHGFggN1q/wHTFeakoJAbobw2QASC3czYnHd
	1mzmu+r63NTUzk8qGu/HrlI+K2Ki802OJ4gmFB4PIyVQDELpYPd1784+CRjsiQec
	rGtAWApffSETUWOI9fI7gW0yF4QO8YCcCmoA5Jl7BpshV2lzaHZJQmOZy7azSVnG
	JQmIjRJecWjyN3mcd97/KGzb5ltZoKvX/jz+kSWge8kbtfUmGZoA75AMjhFtQ/DS
	jLoJOngLZpYNoLU+hp2FM+AI00s2A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rj2mnw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:43:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZApf1796824;
	Thu, 5 Nov 2026 14:43:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka6tech-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:43:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5EhW0X47120720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:43:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12DE220040;
	Thu,  5 Nov 2026 14:43:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFB7120049;
	Thu,  5 Nov 2026 14:43:25 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.70.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:43:25 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v6 0/9] Extend PKWM to support user-created wrapping keys
Date: Thu,  5 Nov 2026 20:13:11 +0530
Message-ID: <20261105144320.357260-1-ssrish@linux.ibm.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 3irOr4P377RmltnbQVN8xsmcAw-fAKDh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NiBTYWx0ZWRfX8SFuTe989GVG
 40LBK1/63bgaBd7jx3pugk9x+q5JorpqVuOq33C1fLVH3np7A1EG0Z852+3mjt//y583hQkhRZK
 bkhdrXAnd9xJsXm630dyarHnQ/YwKTg=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aec9619 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=ZmkVjOJ7g21S_g4humkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NiBTYWx0ZWRfXzxKSvWymtLlt
 T9OdGfKPq2zWi82MRM4+KACsx1+75qSNPnzusgIPsmBj/icEW1WqnW/qwUHTykntHowp6FcRGE8
 mNZLh4andbZCfYwohcJ/bqOiwoXZ2BrTTfgbbQRzyrd+ppLv37LX8G8dJpbdXgX8/qAg5OxbtHR
 16euz3gl/bsdeh4l4kECd6LlmkUFWL504Kp0nlssMpvs7tAP6/js7M7Ubul9XCqASdirgGpbEE2
 8lcO+xkbW9gxOCoQDD67SYeyIKeZa+mvyoip8l3w04lCFcLGNdperQnpazkwKzfDZnlvhce6aAT
 9Ya5AwwJkN9NlOinC2mcNbr7dJsisx5tLM6fFX94bYqLkGE6CcgRz8QrPBlldTD/O7guFnhtufZ
 h08BVjRV0cFKeL3AL8lgLPV3T8sxk2VraK3+BqQDg8/K1kApNVEZ2fb0e4lcUD3pWWSmS52uRGO
 Sq6efiZjqJn4upivEuQ==
X-Proofpoint-GUID: Ve7yx-SFnF9ClQIkML5-lQsjtc5od3ap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050056
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The PKWM trusted source currently uses a single default wrapping key per
LPAR. This key is created during trusted source initialization, and all
trusted keys backed by PKWM are sealed and unsealed using it.

Recent versions of PKWM allow users to create and manage their own wrapping
keys through a set of lifecycle operations. This patch series brings these
PKWM capabilities into the kernel, allowing users to create, manage, and
select wrapping keys for sealing their trusted keys, rather than requiring
all trusted keys to use the default wrapping key.

This series extends PKWM to support user-created wrapping keys. It adds
the required HCALLs, allows users to select a wrapping key by label when
creating PKWM-backed trusted keys, and introduces a sysfs interface for
managing wrapping keys from userspace.

This patchset also includes six preparatory fixes. These correct double
conversion of PLPKS write, remove, and wrapping key flush errors; align
wrapping length types with the underlying HCALL interfaces; preserve the
original error returned when default wrapping key generation fails;
initialize PKWM output buffer pointers before cleanup; and clear sensitive
PKWM seal and unseal buffers before freeing them.

Changelog:

v5 -> v6:
- Hardened wrapping key lifecycle HCALL helpers
  - Default wrapping key check
  - Component prefix and wrapping key handling
  - Label length validation
  - -ENXIO when revoke/unrevoke are unsupported
- Rejected non-ASCII characters in wrapping key labels
- Added stable prerequisite to the wrapping key flush error fix
- Re-ordered the stable fixes

v4 -> v5:
- Addressed issues reported by Sashiko
  - Added HCALL-defined length validation for wrapping operations
  - Cleared stale PLPKS sysfs kobject pointers on initialization failure
  - Documented "default-wrapping-key" as a reserved label without assuming
    it exists
- Dropped Tested-by tags from modified patches

v3 -> v4:
- Addressed issues reported by Sashiko
  - Fixed double conversion of PLPKS object flush errors
  - Initialized PKWM output buffer pointers before cleanup
  - Corrected the documented H_PKS_GET_OBJECTLABELS output field order
  - Prevented stale policy use and caller data modification during
    revocation checks
  - Fixed wrapping key sysfs kobject cleanup
  - Restricted wrapping key sysfs initialization to pseries
- Dropped Tested-by tags from modified patches

v2 -> v3:
- Moved most of the refactoring and hardening patches into a separate
  series:
  https://lore.kernel.org/all/20260923182816.151451-1-ssrish@linux.ibm.com/
- Added a fix to clear sensitive PKWM seal and unseal buffers before
  freeing them
- Added Nageswara's Tested-by tag
- Refined error handling and documented default wrapping key restrictions

v1 -> v2:
- Addressed parameter validation issues reported by Nageswara
- Tweaked PLPKS_WRAPKEY_SYSFS Kconfig help text
- Added two preparatory bug-fix patches
- Cc'd stable@vger.kernel.org where applicable

Srish Srinivasan (9):
  keys/trusted_keys: propagate wrapping key generation errors
  keys/trusted_keys: fix PKWM output buffer cleanup
  keys/trusted_keys: clear sensitive PKWM buffers
  pseries/plpks: fix double conversion of write and remove flush errors
  pseries/plpks: fix double conversion of wrapping key flush errors
  pseries/plpks: fix length types for wrapping operations
  pseries/plpks: add HCALLs for PKWM wrapping key life cycle management
  keys/trusted_keys: enable PKWM wrapping key selection by label
  pseries/plpks/wrapkey: expose PKWM wrapping key management to
    userspace via sysfs

 .../ABI/testing/sysfs-firmware-plpks          | 113 ++++
 Documentation/arch/powerpc/papr_hcalls.rst    |  33 +
 .../security/keys/trusted-encrypted.rst       |   4 +-
 arch/powerpc/include/asm/hvcall.h             |   5 +-
 arch/powerpc/include/asm/plpks.h              |  40 +-
 arch/powerpc/platforms/pseries/Kconfig        |  15 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  14 +
 .../platforms/pseries/plpks-wrapkey-sysfs.c   | 408 +++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        | 576 ++++++++++++++++--
 include/keys/trusted_pkwm.h                   |   3 +
 security/keys/trusted-keys/trusted_pkwm.c     |  52 +-
 12 files changed, 1203 insertions(+), 61 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c

-- 
2.52.0


