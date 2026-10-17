Return-Path: <linuxppc-dev+bounces-29630-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4AACCF2C9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 18:39:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6Vvz1dVGz2xnh;
	Sun, 18 Oct 2026 05:39:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792262367;
	cv=none; b=iiZaPABpWwUcNU5L7svBoeH9mgUX8gfSDt3Ve0hIAenZOyGsf/d4a16xT0jJ+19z/qAyWVO+3MFFH6oYFswFr7vKz6Osj899BnIJ51pt4zwbJlvfiElLQ+fB/G1KBNaj5qRfLSlI+vWv4rIVVq+pstfxwoKoZFZPEKQaOc6VgxfPuqfUQJE+97CsvN1gQnAbMgqmgT0RI6K89YaeZkLmENHDzqK+VcLu2lgIfDxuoc+8nl48qBijg9PabvplDlRnLQpM78cRuxilIfB2F8EX5fw4t8lb/Z6nRLCQ1fKSuq64C8f1LM9gp+l64GhIGMT/h3FuymYMZ+bLgWv4onmw8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792262367; c=relaxed/relaxed;
	bh=okRYtv+hv1E0LEm9G7AUkWWpVlUvWs6SGbMVxXzRB9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltv4P3VmPaah2zeqvv+wOXp9dvR+VJCsYSzZbUAbM2d1D4/lapgmU08bU/dGA/qQlTxJ608moOiArBxkcjTgDwMW+8ch9MGU70+6NzLMOOiaMR8D4YqUKfuAHhyCJ1+wGYXz8/QvMIQpJGblRiq8u0GoQTwR/ueADn+W3fc9Wnw/T4lGSfZ/YqrDwRb2V/rN3AOix8TG0KRfq5UWFpDQNFC5sYV14wcVoSy7108LA9JR0YUeCsdLObI0o8r/koabZW90jBGjyMPNPc1Ub02D2piiVhH4A9cfgUD/uWzeWBSI1y+ZorhReKiKsmeVodXNBNMKBNcV7R3b03VgPoTDkg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nDADB32n; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=nDADB32n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6Vvx4L62z2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 05:39:24 +1100 (AEDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGEE8w2776324;
	Sat, 17 Oct 2026 18:39:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=okRYtv+hv1E0LEm9G7AUkWWpVlUvWs6SGbMVxXzRB
	9c=; b=nDADB32nBSXKbAhT9hB/0x0jFAo1frjFakcJcJFR1IqAfhW++CXJntIvB
	9ItKRV96GuYqjxw03AAXyi0+VVdGnzxUuQ59bbv7NPjGk9Dvw6o009BrxU4bfq03
	3e8BW8nz5IACBn5bEy6mP/yqaV6pAqnbg7j04UwjGykYKScRFZHhom/wbhO/99db
	mu34OMBC7agr6rvLrywhHqwe2LvwfPmqZToF/thM/+oo1bnzrYdMszzjltBMvHGO
	olzmPjcjnXNE7e5PMUba/L2JvL4t207vnrCEzCE4ubKcCeBQnTsbhEyvy5/MWkxa
	HOE/Lk/l907F3SgstFnf9QTD3kZGw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehjww7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGJtV8078167;
	Sat, 17 Oct 2026 18:39:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hbne4vs05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:39:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HId4nW51118562
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:39:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC58720040;
	Sat, 17 Oct 2026 18:39:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D320720043;
	Sat, 17 Oct 2026 18:38:57 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:38:57 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v4 0/9] Extend PKWM to support user-created wrapping keys
Date: Sun, 18 Oct 2026 00:08:44 +0530
Message-ID: <20261017183853.596052-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX/lfLSb+QEp9y
 M7zqIn3Wd/fBZ0eQveJpwX+9ALmyZm1+mU9v/nD0iiPz5C+Tca3HokAkl69n6yfefTBAqakPAb2
 /tSzh3fkgDRdUF2ERM+Lm8C1IR8WQeJWHP7n5unsA1yium5UT9ehYZiLN27t6yL7TMBYQPO0aJJ
 6kJ3q1hWT8NqBJot71H8U4Vr4VsKZR7RQxTIjWPESpdbeqVlPubWXSai31pGYnb247uJ31BbmVW
 lmbqBaRxgzuZK0yj+A1jP5odqUk2lAqqRa14oI/xfpn2HRiu2rTt3bFHD9lQ8UT6borUFvt7WIB
 AM4wu+tOmKHlWhOgOvacTXQg7w+edrcf3DtHLqXO5LMtELVXGGF3ws9NnnsF1oRG48JjPcE/Ufn
 PiX5r3tozR5MNIIHQLW+IjMBNZ3f2vJ5pQRO8b5//v2OhHW+GDLXXr6alPFbsOhzU2A2mevioME
 r9OJ3uqWBjuwo9kAm5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX9oST7SMBnlBz
 pKCkl9T4L+EGEdWCoRxw7biRsKra2PfDvitHUIHbafDhX+U0H3Q1IW8SlE2Vpe8TvpCzN41JLp3
 nf/7265na7OVI9i3r7yUIN0T3yk20J8=
X-Proofpoint-GUID: GHkwzwDdToujb2YhcMuShb9yUed9rkb_
X-Proofpoint-ORIG-GUID: 0LUYb_2so38ld6OvEhQxsadvU8EaHGvn
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad3c0cd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AgqpLgk7dxv-3Z7t9NMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072

The PKWM trusted source currently uses a single default wrapping key per
LPAR. This key is created during trusted source initialization, and all
trusted keys backed by PKWM are sealed and unsealed using it.

Recent versions of PKWM allow users to create and manage their own wrapping
keys through a set of lifecycle operations. This patch series brings these
PKWM capabilities into the kernel, allowing users to create, manage, and
select wrapping keys for sealing their trusted keys, rather than requiring
all trusted keys to use the default wrapping key.

This series extends PKWM to support user-created wrapping keys. It adds
the required hcalls, allows users to select a wrapping key by label when
creating PKWM-backed trusted keys, and introduces a sysfs interface for
managing wrapping keys from userspace.

This patchset also includes six preparatory fixes. These correct double
conversion of PLPKS write, remove, and wrapping key flush errors; align
wrapping length types with the underlying hcall interfaces; preserve the
original error returned when default wrapping key generation fails;
initialize PKWM output buffer pointers before cleanup; and clear sensitive
PKWM seal and unseal buffers before freeing them.

This series depends on the following PLPKS refactoring and hardening series
and must be applied on top of it:

https://lore.kernel.org/all/20260923182816.151451-1-ssrish@linux.ibm.com/

Changelog:

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

 .../ABI/testing/sysfs-firmware-plpks          | 116 ++++
 Documentation/arch/powerpc/papr_hcalls.rst    |  33 ++
 .../security/keys/trusted-encrypted.rst       |   4 +-
 arch/powerpc/include/asm/hvcall.h             |   5 +-
 arch/powerpc/include/asm/plpks.h              |  40 +-
 arch/powerpc/platforms/pseries/Kconfig        |  15 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  11 +
 .../platforms/pseries/plpks-wrapkey-sysfs.c   | 408 ++++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        | 526 ++++++++++++++++--
 include/keys/trusted_pkwm.h                   |   3 +
 security/keys/trusted-keys/trusted_pkwm.c     |  52 +-
 12 files changed, 1154 insertions(+), 60 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c

-- 
2.52.0


