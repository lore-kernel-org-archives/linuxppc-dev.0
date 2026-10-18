Return-Path: <linuxppc-dev+bounces-29659-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053B6CCA490
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Oct 2026 17:09:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j74sT6Y8lz2xg9;
	Mon, 19 Oct 2026 04:09:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792343357;
	cv=none; b=l1sQnd/0PZ5UNRxlCzdvYqxr13ryz7qoJ+yz0clwipciZlvq0NAsHcgpJY7aBX8LxXQvQm+LASVJGjw/St3qvmf2CeeHn4JA2rdvim7xB/pNlnsSTbP1kxeTM91DK3443XJ9w2nNdjHzAkeLKaCXgYICTxcjcIAx/fnw0IHzE6PQR5+wyG3S3PtZ0oHpabhnphyHFPsCBCNewRyU9vLxELlWKC2skdDf/QmFhznpEo9c0XFbrv8LS47BxVPs0CdWRhW4Wqxrxrw+JuiaSifu5sEWR6/OGESqxCk559ENGdyXYtigMvy1WDIqMjiVYEcVin9GRZBFNJ5NZN28DhYutg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792343357; c=relaxed/relaxed;
	bh=z1YNJsMZKY0pIEjHAFIPmMyU4jaylQ8ZddsOePGToF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwS4kgQcP7GlUNIxBastPLX0LJzUYRyPoHMQu5PUpp03MBnhdXSgV9euOybYKviu3P7TxGJcPucyfkS2LxpM+8won/1Ij2VOYX084+jiG7O5WAcIiAgxPssv51VmxvjxbkNmgxbCSOTJyKTWIMQGRV/xxUNyqBSXIyDouGq6fly+eKexi+iWI8wIvTNfaHYWIY0wbANuKzIlaTaYUTAxsiwhjUPPTkOSNwTDyGDwOq5Z8DKJD6QiPj+01SRjSyQYPqptL73R3vXccunE8K//okdxVA4uXeURKgBA8vR3rZDH0axKm4JKVR02EPop4pKDBS1GGgp8o3L5g6ma5MSSHQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DUyEeDg5; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DUyEeDg5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j74sS62sPz2xg3
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 04:09:16 +1100 (AEDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFERAX1411751;
	Sun, 18 Oct 2026 17:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=z1YNJsMZKY0pIEjHAFIPmMyU4jaylQ8ZddsOePGTo
	F0=; b=DUyEeDg5RBS2lYZ0XoGcdpcy+lLHhlGi+6eenLJAfUB3TN0ItaWQocLoQ
	H50fJCFqJSlStm4zgz/woH7BlZFgUJ8+P/psXB34JurdOBbiudqs38lI6e0f8KQk
	3ZyKFYvJgkhR3Prm6XAX7RdLdoJh8daMBBPUhltbs16kKIYktY98moto9OSFDH57
	hyN4WBzKndNPQy0rMCQZbVB3f8zjpl1JFHN9n5JNJFfMY9p7Ho4gLpgJSbQAFoNc
	obSOwgjwJ5QY7pkWw/Ar70Fg9e220xOBgdjpNoCC3IXPj0pbe8gfYgI8Spa8i5n3
	VBv66c5q95dFML3koUbSfQ3nRgScg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h56qhx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFK3Om2729546;
	Sun, 18 Oct 2026 17:09:01 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hckbq2c3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IH8vkQ39911848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:08:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FC6520043;
	Sun, 18 Oct 2026 17:08:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50B8620040;
	Sun, 18 Oct 2026 17:08:49 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:08:48 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v5 0/9] Extend PKWM to support user-created wrapping keys
Date: Sun, 18 Oct 2026 22:38:35 +0530
Message-ID: <20261018170844.491252-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX2stFgm+DBDrR
 oTSb6C0TnKrPbhOGbGbdIhZq3U2F9UcAIhDINMsOE64yXnONb1titFIInTlJGEon6mfoXFbFk+O
 ulSAg63wZVmiUg0fy/ZVc5cnu1OGDz4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX9hBQM+7KAnAt
 1jhi1N1D5+EeMIEUaQff/C6TlAjbOqJ/cjcXhlugx1MNl47r43kKduHWMGfxUwiaT4+svZZKw9k
 odWY3e3uLpH/njC4xZdYJS8s9xNULva94bmv8pX+0bpl3HmiuSWE1A9jBvsLn7Hzo+Hojal2I9C
 IWx3qsQC0eWMLYvJifGsdWymcZUKxHrTkSzmv9gDq9+ZskmkWa1venqgRDYwVh77/oplYO67lab
 cNgZzt2qKZLQXW1p2q8JjlVLBKc96JjqhXY0XogSNTdARJ4XgKAMREeSDhnZJBCFQDIalEIrflm
 NWpy64CBUUmjs//nLfTgCPqtQq1RmCitD2UvXetW+PfHBlOCYscM1qGYtS1MXXwqE9+SASQPjDB
 aiReG6pgvz3H78+F65GF36LgbuNzw3Oy9W5nTa2BtCANGhorJVVFuwmavT2hYBpqcVn7zluvuRb
 UlkIAmzA9cpF6J7s1rQ==
X-Proofpoint-ORIG-GUID: JXUucpztJqizeWSHQJv4ZpdQBo0HsSbQ
X-Proofpoint-GUID: l4ye9GKlZtaaOTJRlWeCxKxsBd9gy7oN
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad4fd2e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=gmB00ZAkE4nazKOq6vkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180066

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

This series depends on the following PLPKS refactoring and hardening series
and must be applied on top of it:

https://lore.kernel.org/all/20260923182816.151451-1-ssrish@linux.ibm.com/

Changelog:

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
  pseries/plpks: fix double conversion of write and remove flush errors
  pseries/plpks: fix double conversion of wrapping key flush errors
  pseries/plpks: fix length types for wrapping operations
  keys/trusted_keys: propagate wrapping key generation errors
  keys/trusted_keys: fix PKWM output buffer cleanup
  keys/trusted_keys: clear sensitive PKWM buffers
  pseries/plpks: add HCALLs for PKWM wrapping key life cycle management
  keys/trusted_keys: enable PKWM wrapping key selection by label
  pseries/plpks/wrapkey: expose PKWM wrapping key management to
    userspace via sysfs

 .../ABI/testing/sysfs-firmware-plpks          | 113 ++++
 Documentation/arch/powerpc/papr_hcalls.rst    |  33 ++
 .../security/keys/trusted-encrypted.rst       |   4 +-
 arch/powerpc/include/asm/hvcall.h             |   5 +-
 arch/powerpc/include/asm/plpks.h              |  40 +-
 arch/powerpc/platforms/pseries/Kconfig        |  15 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  14 +
 .../platforms/pseries/plpks-wrapkey-sysfs.c   | 408 +++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        | 536 ++++++++++++++++--
 include/keys/trusted_pkwm.h                   |   3 +
 security/keys/trusted-keys/trusted_pkwm.c     |  52 +-
 12 files changed, 1164 insertions(+), 60 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c

-- 
2.52.0


