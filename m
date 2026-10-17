Return-Path: <linuxppc-dev+bounces-29639-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CD1CCF2C4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 17 Oct 2026 18:40:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j6VxZ4RtQz2ynW;
	Sun, 18 Oct 2026 05:40:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792262450;
	cv=none; b=BACKKAjO5TW3csjENNjTNkfoQX0wJ7kcByttiwnpi3Gu6U3rH4/4x+AGn4vN0xM29O/NwcQUYvp76qdLaz+Inov93yVbAwh3gWaStYACSaAzXzEbEa90hehOlfElfMg60mIHP3UEADfoooiE8EFWD+yRdJReSgwu5qqZiHXpSFhM4JiToVax4DdlYL8Ct6fcncWQdfrN++8HUnlv1HXH8y4kMuhTk1aK6YGxCynqdprLQtX+1lyE0WGFNiFq0f6MYbPSSH2wzW84Qi6qUmct1Ywz/ZgcflvX3XESB8ZCpED8Tya3R3vriODhynXvU0/qWFYdiQfR1hWU+kBlLo+jMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792262450; c=relaxed/relaxed;
	bh=Fh8GoPJl/6INKcbG8T3Eod1TyD4yTvYjTZq2EEbsyGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9FBARylL5VMurCd9RpVjahz7r28SIBAoMDL0z72ykmSHmnPawCZBhggbPpQKNxTJxltavAbnd4wuQBiihYU6WGvX+kmgmjWBJI8gZzuoBv2Tf2zeKR785HLeI/0yc0Jr4aljgDetO0TPFA/7IrNVs+KEQBGrNJBD63Ai3HNrYs7RxhAT99iUl4JRsilX+qxrGgSd9hhSv2pfN2zA6viPIOuYx6NEhLDiaaDlIAou3pxAxDvLKA7DmneswQOGoQDjxdGNSkCLdNb6Qgbo3wO5zDK7JQhXd1Eu+Gf2cvsEzJlb6jspX8QdCZAvULMtVltySJgabBtZxZ0bF6K6dMRzw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DHhH0Rtz; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DHhH0Rtz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=ssrish@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j6VxY2XKBz2ylm
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Oct 2026 05:40:49 +1100 (AEDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGF2rH2884930;
	Sat, 17 Oct 2026 18:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fh8GoPJl/6INKcbG8
	T3Eod1TyD4yTvYjTZq2EEbsyGo=; b=DHhH0Rtzp90iFuv9yMO9Mhp7YRF7uAytu
	OpQlzSwNbxmgrwAzZxQEJCfg7+UECKNDvOcD6Vvnm90EaMJ7k2t3JtxaRHAdp5/5
	oKdjWlXOrq3M/7cipemT5zvc86tK2gV/ac8XhVL0svz2fNX5yjkdBNR/ZPnodBxU
	PMciL5ws+agCMqXkWxUzjnN2zn36uXyb4rD5jJ8RqXRIt3zX5kO+P8seANKVq3n2
	6EnsUxkFKMN8SF5HuGoEI2yGJGDfuuat9ECNjn9/mWafWw4c6/rXHC09ETE31EjW
	0HyEYmGut7MdwMUkSVFLVl08oOfRWx02PHSrKch4Lh/hgQqHW2BWg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvjhad-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:40:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGJxiI1277496;
	Sat, 17 Oct 2026 18:40:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb2398unm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:40:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HIeWYT40305076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:40:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5149520043;
	Sat, 17 Oct 2026 18:40:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3DBE20040;
	Sat, 17 Oct 2026 18:40:23 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:40:23 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v4 9/9] pseries/plpks/wrapkey: expose PKWM wrapping key management to userspace via sysfs
Date: Sun, 18 Oct 2026 00:08:53 +0530
Message-ID: <20261017183853.596052-10-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183853.596052-1-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX7CEcfuI+PrUf
 f0CjptHHicGXjc7HpHY2vPz4EefTLmvGRLN1TdeG7ErXw2a59ZWu4yh4KrXpeqdGR1EykPKV9Bk
 86Y9RyLAPWFGHC4RzTuefOe6by+ZwoQ=
X-Proofpoint-ORIG-GUID: 5Pk6cT5p3ZkS0hWWUwxXqSDKbCjkFf4y
X-Proofpoint-GUID: tqv8iCj4munAaAbjOUP4r9ipS2fGnAZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX6Yb4GYRCIfBk
 Hn9J0xdwjyF4cqtjtyJLsNltbTCzkLydLJOTn215bTJ3643uHMhWaP1gZUla1wQYiXpaVn2VKb+
 vk4ou9mz4VK/LM9vd6eXkthg+lpd/UYF6SdzDcD3Shr0c8zGLDk7KeNubi7Fd7Xz96w/jQLUQ+r
 Xun7GocjRZk/5sYmkIjwvnL/oal8VQDkQlOBTkwe/EaJVE2EpLwWgOZ9IvqJQJmaFzJY/NlNtMC
 HAuCxVoY6IpUSXFkTisSGyLmH1740G+zGdBQAZzmLIphWWgxu7QHehK3GdNWNjwIS09uUzWku40
 pK4NtMvyMDSskPqOXjlu7392dyuMj4uofpuymGGP8WXtcl7CFOPlhfGdaOSntMwhsI+7TyFqe2h
 4iSf5I4Gzx3wl3C1Mash69nrJ0A7Y97ihYo5skQ42CNapFr45bmuV5V24zGBUSYXnZZ/h4MT8Bu
 y0s14P0iBhfu/+6qcMg==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad3c125 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Dm_dBKYgswZ8qGTShzQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072

The PKWM trusted source currently uses a single default wrapping key
created during initialization. However, PKWM also supports user-created
wrapping keys for better isolation between trusted keys.

Expose wrapping key lifecycle operations through sysfs to allow users to
create and manage their own wrapping keys.

Create a sysfs interface at /sys/firmware/plpks/wrapkey with the following
attributes:

  create        - Create a new wrapping key with a user-provided label
  delete        - Delete a revoked wrapping key by label
  revoke        - Revoke a wrapping key by label
  unrevoke      - Unrevoke a previously revoked wrapping key by label
  list_active   - List labels of all active (non-revoked) wrapping keys
  list_revoked  - List labels of all revoked wrapping keys

User-provided labels are validated to contain only alphanumeric characters.

Wrapping key lifecycle constraints:
- A wrapping key must be revoked before it can be deleted
- Revoked wrapping keys cannot be used for wrap operations until unrevoked
- The default wrapping key cannot be revoked or deleted; it always appears
  in list_active

The wrapping keys themselves are confidential objects stored in PLPKS. Only
the user-provided labels are exposed to userspace for identification and
management purposes.

These user-created wrapping keys can be used in seal operations via the
wrapping_key=<label> option.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 .../ABI/testing/sysfs-firmware-plpks          | 116 +++++
 arch/powerpc/include/asm/plpks.h              |   9 +
 arch/powerpc/platforms/pseries/Kconfig        |  15 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  11 +
 .../platforms/pseries/plpks-wrapkey-sysfs.c   | 408 ++++++++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        |   1 -
 7 files changed, 560 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c

diff --git a/Documentation/ABI/testing/sysfs-firmware-plpks b/Documentation/ABI/testing/sysfs-firmware-plpks
index cba061e4eee2..4144e868da1b 100644
--- a/Documentation/ABI/testing/sysfs-firmware-plpks
+++ b/Documentation/ABI/testing/sysfs-firmware-plpks
@@ -56,3 +56,119 @@ Description:	Bitmask of the wrapping features indicating the wrapping
 		algorithms that are supported for the H_PKS_WRAP_OBJECT requests
 		, represented as a 8 byte hexadecimal ASCII string. Consult the
 		hypervisor documentation for what these flags mean.
+
+What:		/sys/firmware/plpks/wrapkey
+Date:		August 2026
+Contact:	Srish Srinivasan <ssrish@linux.ibm.com>
+Description:	This directory provides the interface for creating and managing
+		user-created PKWM wrapping keys.
+
+		The directory is present only when CONFIG_PLPKS_WRAPKEY_SYSFS is
+		enabled and the system supports the H_PKS_{UN}REVOKE_OBJECT
+		interfaces.
+
+		Only alphanumeric characters are accepted in wrapping key
+		labels. The wrapping keys themselves are confidential PLPKS
+		objects and are not exposed to userspace. Only their labels are
+		exposed for identification and management.
+
+		Each write is processed as an independent operation and accepts
+		exactly one wrapping key label. The resulting state can be
+		verified through list_active or list_revoked, as appropriate.
+
+		The default wrapping key, named "default-wrapping-key", cannot
+		be created, revoked, unrevoked, or deleted through this
+		interface.
+
+What:		/sys/firmware/plpks/wrapkey/create
+Date:		August 2026
+Contact:	Srish Srinivasan <ssrish@linux.ibm.com>
+Description:	(WO) Create a wrapping key with the specified label, except
+		"default-wrapping-key", which is reserved for the default
+		wrapping key.
+
+		On success, the label appears in list_active.
+
+		For example, to create a wrapping key labelled "wk1":
+
+			echo -n wk1 > /sys/firmware/plpks/wrapkey/create
+
+		or:
+
+			printf '%s' 'wk1' > /sys/firmware/plpks/wrapkey/create
+
+What:		/sys/firmware/plpks/wrapkey/delete
+Date:		August 2026
+Contact:	Srish Srinivasan <ssrish@linux.ibm.com>
+Description:	(WO) Delete a revoked wrapping key identified by the specified
+		label. A wrapping key must be revoked before it can be deleted.
+		The default wrapping key, named "default-wrapping-key", cannot
+		be deleted.
+
+		On success, the label no longer appears in list_revoked.
+
+		For example, to delete a revoked wrapping key labelled "wk1":
+
+			echo -n wk1 > /sys/firmware/plpks/wrapkey/delete
+
+		or:
+
+			printf '%s' 'wk1' > /sys/firmware/plpks/wrapkey/delete
+
+What:		/sys/firmware/plpks/wrapkey/revoke
+Date:		August 2026
+Contact:	Srish Srinivasan <ssrish@linux.ibm.com>
+Description:	(WO) Revoke a wrapping key identified by the specified label. A
+		revoked wrapping key cannot be used for seal or unseal
+		operations until it is unrevoked. The default wrapping key,
+		named "default-wrapping-key", cannot be revoked.
+
+		On success, the label appears in list_revoked and no longer
+		appears in list_active.
+
+		For example, to revoke a wrapping key labelled "wk1":
+
+			echo -n wk1 > /sys/firmware/plpks/wrapkey/revoke
+
+		or:
+
+			printf '%s' 'wk1' > /sys/firmware/plpks/wrapkey/revoke
+
+What:		/sys/firmware/plpks/wrapkey/unrevoke
+Date:		August 2026
+Contact:	Srish Srinivasan <ssrish@linux.ibm.com>
+Description:	(WO) Unrevoke a revoked wrapping key identified by the specified
+		label. The default wrapping key, named "default-wrapping-key",
+		cannot be unrevoked through this interface because it cannot be
+		revoked.
+
+		On success, the label appears in list_active and no longer
+		appears in list_revoked.
+
+		For example, to unrevoke a revoked wrapping key labelled "wk1":
+
+			echo -n wk1 > /sys/firmware/plpks/wrapkey/unrevoke
+
+		or:
+
+			printf '%s' 'wk1' > /sys/firmware/plpks/wrapkey/unrevoke
+
+What:		/sys/firmware/plpks/wrapkey/list_active
+Date:		August 2026
+Contact:	Srish Srinivasan <ssrish@linux.ibm.com>
+Description:	(RO) List the labels of active, non-revoked wrapping keys. The
+		default wrapping key, named "default-wrapping-key", is always
+		included in this list.
+
+		For example:
+
+			cat /sys/firmware/plpks/wrapkey/list_active
+
+What:		/sys/firmware/plpks/wrapkey/list_revoked
+Date:		August 2026
+Contact:	Srish Srinivasan <ssrish@linux.ibm.com>
+Description:	(RO) List the labels of revoked wrapping keys.
+
+		For example:
+
+			cat /sys/firmware/plpks/wrapkey/list_revoked
diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
index abf8a71cf3f2..fa0380560f12 100644
--- a/arch/powerpc/include/asm/plpks.h
+++ b/arch/powerpc/include/asm/plpks.h
@@ -56,6 +56,8 @@
 // Component for a PKWM wrapping key
 #define PLPKS_WRAPKEY_COMPONENT	"PLPKSWR"
 
+#define PLPKS_OBJLABEL_LEN_FIELD_SIZE	2
+
 struct plpks_var {
 	char *component;
 	u8 *name;
@@ -144,6 +146,9 @@ int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
 
 bool plpks_revoke_is_supported(void);
 
+int plpks_init_child_kobj(struct kobject *kobj, const struct kobj_type *ktype,
+			  const char *name);
+
 #else // CONFIG_PSERIES_PLPKS
 static inline bool plpks_is_available(void) { return false; }
 static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
@@ -151,6 +156,10 @@ static inline void plpks_early_init_devtree(void) { }
 static inline int plpks_populate_fdt(void *fdt) { BUILD_BUG(); }
 static inline int plpks_config_create_softlink(struct kobject *from)
 						{ return 0; }
+static inline int plpks_init_child_kobj(struct kobject *kobj,
+					const struct kobj_type *ktype,
+					const char *name)
+						{ return 0; }
 #endif // CONFIG_PSERIES_PLPKS
 
 #endif // _ASM_POWERPC_PLPKS_H
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 74910ce3a541..d0dcfbae6fc9 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -216,3 +216,18 @@ config PPC_SVM
 	 those guests.
 
 	 If unsure, say "N".
+
+config PLPKS_WRAPKEY_SYSFS
+	bool "Enable sysfs interface for managing PKWM wrapping keys"
+	default n
+	depends on PSERIES_PLPKS
+	depends on SYSFS
+	depends on TRUSTED_KEYS_PKWM
+	help
+	  The PKWM trusted source supports user-created wrapping keys that are
+	  managed by the OS. These wrapping keys can be created, revoked,
+	  unrevoked, and deleted through sysfs. Their labels can also be viewed
+	  through sysfs.
+
+	  Say Y if PLPKS and PKWM are enabled and you want to isolate trusted
+	  keys using user-created wrapping keys.
diff --git a/arch/powerpc/platforms/pseries/Makefile b/arch/powerpc/platforms/pseries/Makefile
index 3ced289a675b..c604be40f546 100644
--- a/arch/powerpc/platforms/pseries/Makefile
+++ b/arch/powerpc/platforms/pseries/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_FA_DUMP)		+= rtas-fadump.o
 obj-$(CONFIG_PSERIES_PLPKS)	+= plpks.o plpks-sysfs.o
 obj-$(CONFIG_PPC_SECURE_BOOT)	+= plpks-secvar.o
 obj-$(CONFIG_PSERIES_PLPKS_SED)	+= plpks_sed_ops.o
+obj-$(CONFIG_PLPKS_WRAPKEY_SYSFS) += plpks-wrapkey-sysfs.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PPC_VAS)		+= vas.o vas-sysfs.o
 
diff --git a/arch/powerpc/platforms/pseries/plpks-sysfs.c b/arch/powerpc/platforms/pseries/plpks-sysfs.c
index f2436229f323..0ca13bb6405f 100644
--- a/arch/powerpc/platforms/pseries/plpks-sysfs.c
+++ b/arch/powerpc/platforms/pseries/plpks-sysfs.c
@@ -55,6 +55,17 @@ static umode_t plpks_config_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
+int plpks_init_child_kobj(struct kobject *kobj, const struct kobj_type *ktype,
+			  const char *name)
+{
+	kobject_init(kobj, ktype);
+
+	if (!plpks_kobj)
+		return -ENODEV;
+
+	return kobject_add(kobj, plpks_kobj, "%s", name);
+}
+
 int plpks_config_create_softlink(struct kobject *from)
 {
 	if (!plpks_config_kobj)
diff --git a/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c b/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c
new file mode 100644
index 000000000000..d810d6d64fb9
--- /dev/null
+++ b/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c
@@ -0,0 +1,408 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 IBM Corporation <ssrish@linux.ibm.com>
+ *
+ * This code exposes wrapping key management options to the user via the
+ * sysfs
+ */
+
+#define pr_fmt(fmt) "wrapkey-sysfs: " fmt
+#define PLPKS_WRAPKEY_REVOKED 1
+#define PLPKS_WRAPKEY_UNREVOKED 0
+
+#include <linux/slab.h>
+#include <linux/compat.h>
+#include <linux/string.h>
+#include <linux/of.h>
+#include <linux/ctype.h>
+#include <linux/unaligned.h>
+#include <asm/machdep.h>
+#include <asm/plpks.h>
+
+static struct kobject *wrapkey_kobj;
+
+static bool is_wrapkey_label_alnum(const char *key_label, size_t len)
+{
+	size_t i;
+
+	for (i = 0; i < len; i++) {
+		if (!isalnum((unsigned char)key_label[i])) {
+			pr_err("key label <%*pE> is not alphanumeric\n",
+			       (int)len, key_label);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static ssize_t list_key_labels(char *buf, u8 *obj_labels_buf,
+			       u64 obj_labels_count, int revoked)
+{
+	struct plpks_var var = { 0 };
+	u8 *obj_labels_buf_ptr, *comp_prefix;
+	u8 *key_label_ptr;
+	u16 obj_label_len;
+	int len = 0;
+	int is_revoked;
+	u64 i;
+
+	var.os = PLPKS_VAR_LINUX;
+	var.component = PLPKS_WRAPKEY_COMPONENT;
+	obj_labels_buf_ptr = obj_labels_buf;
+
+	for (i = 0; i < obj_labels_count; ++i) {
+		obj_label_len = get_unaligned_be16(obj_labels_buf_ptr);
+		comp_prefix = obj_labels_buf_ptr +
+			      PLPKS_OBJLABEL_LEN_FIELD_SIZE;
+
+		var.namelen = obj_label_len - PLPKS_MAX_LABEL_ATTR_SIZE;
+		var.name = kzalloc(var.namelen + 1, GFP_KERNEL);
+
+		if (!var.name)
+			return -ENOMEM;
+
+		key_label_ptr = comp_prefix + PLPKS_MAX_LABEL_ATTR_SIZE;
+		memcpy(var.name, key_label_ptr, var.namelen);
+
+		is_revoked = plpks_is_wrapping_key_revoked(&var);
+		if (is_revoked == revoked)
+			len += sysfs_emit_at(buf, len, "<%s>\n",
+					     (char *)var.name);
+		else if (is_revoked < 0)
+			pr_warn("Failed to get revocation status for <%s>\n",
+				(char *)var.name);
+
+		kfree(var.name);
+		obj_labels_buf_ptr = key_label_ptr + var.namelen;
+	}
+
+	return len;
+}
+
+static ssize_t list_active_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	u8 *obj_labels_buf;
+	u64 obj_labels_count = 0;
+	int rc;
+
+	rc = plpks_get_object_labels(&obj_labels_buf, &obj_labels_count,
+				     PLPKS_WRAPKEY_COMPONENT);
+	if (rc) {
+		pr_err("Retrieving object labels failed. rc=%d\n", rc);
+		goto out;
+	}
+
+	rc = list_key_labels(buf, obj_labels_buf, obj_labels_count,
+			     PLPKS_WRAPKEY_UNREVOKED);
+
+out:
+	kfree(obj_labels_buf);
+	return rc;
+}
+
+static ssize_t list_revoked_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	u8 *obj_labels_buf;
+	u64 obj_labels_count = 0;
+	int rc;
+
+	rc = plpks_get_object_labels(&obj_labels_buf, &obj_labels_count,
+				     PLPKS_WRAPKEY_COMPONENT);
+	if (rc) {
+		pr_err("Retrieving object labels failed. rc=%d\n", rc);
+		goto out;
+	}
+
+	rc = list_key_labels(buf, obj_labels_buf, obj_labels_count,
+			     PLPKS_WRAPKEY_REVOKED);
+
+out:
+	kfree(obj_labels_buf);
+	return rc;
+}
+
+static ssize_t create_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct plpks_var var = { 0 };
+	int rc;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (!count) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (count > PLPKS_MAX_NAME_SIZE) {
+		rc = -ENAMETOOLONG;
+		goto out;
+	}
+
+	if (!strcmp(buf, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
+		rc = -EEXIST;
+		goto out;
+	}
+
+	if (!is_wrapkey_label_alnum(buf, count)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	var.name = kstrndup(buf, count, GFP_KERNEL);
+	if (!var.name) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	var.namelen = count;
+	var.policy = PLPKS_WRAPPINGKEY;
+	var.os = PLPKS_VAR_LINUX;
+	var.component = PLPKS_WRAPKEY_COMPONENT;
+
+	rc = plpks_gen_wrapping_key(&var);
+	if (rc) {
+		pr_err("creation of wrapping key <%s> failed. rc = %d\n",
+		       (char *)var.name, rc);
+		goto out;
+	}
+
+	rc = count;
+out:
+	kfree(var.name);
+	return rc;
+}
+
+static ssize_t revoke_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct plpks_var var = { 0 };
+	int rc;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (!count) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (count > PLPKS_MAX_NAME_SIZE) {
+		rc = -ENAMETOOLONG;
+		goto out;
+	}
+
+	if (!strcmp(buf, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (!is_wrapkey_label_alnum(buf, count)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	var.name = kstrndup(buf, count, GFP_KERNEL);
+	if (!var.name) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	var.namelen = count;
+	var.os = PLPKS_VAR_LINUX;
+	var.component = PLPKS_WRAPKEY_COMPONENT;
+
+	rc = plpks_revoke_wrapping_key(&var);
+
+	if (rc) {
+		pr_err("revocation of wrapping key <%s> failed. rc = %d\n",
+		       (char *)var.name, rc);
+		goto out;
+	}
+
+	rc = count;
+out:
+	kfree(var.name);
+	return rc;
+}
+
+static ssize_t unrevoke_store(struct kobject *kobj, struct kobj_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct plpks_var var = { 0 };
+	int rc;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (!count) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (count > PLPKS_MAX_NAME_SIZE) {
+		rc = -ENAMETOOLONG;
+		goto out;
+	}
+
+	if (!strcmp(buf, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (!is_wrapkey_label_alnum(buf, count)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	var.name = kstrndup(buf, count, GFP_KERNEL);
+	if (!var.name) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	var.namelen = count;
+	var.os = PLPKS_VAR_LINUX;
+	var.component = PLPKS_WRAPKEY_COMPONENT;
+
+	rc = plpks_unrevoke_wrapping_key(&var);
+
+	if (rc) {
+		pr_err("un-revocation of wrapping key <%s> failed. rc = %d\n",
+		       (char *)var.name, rc);
+		goto out;
+	}
+
+	rc = count;
+out:
+	kfree(var.name);
+	return rc;
+}
+
+static ssize_t delete_store(struct kobject *kobj, struct kobj_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct plpks_var var = { 0 };
+	int rc;
+
+	if (!capable(CAP_SYS_ADMIN)) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (!count) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	if (count > PLPKS_MAX_NAME_SIZE) {
+		rc = -ENAMETOOLONG;
+		goto out;
+	}
+
+	if (!strcmp(buf, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
+		rc = -EPERM;
+		goto out;
+	}
+
+	if (!is_wrapkey_label_alnum(buf, count)) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	var.name = kstrndup(buf, count, GFP_KERNEL);
+	if (!var.name) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	var.namelen = count;
+	var.os = PLPKS_VAR_LINUX;
+	var.component = PLPKS_WRAPKEY_COMPONENT;
+
+	rc = plpks_del_wrapping_key(&var);
+
+	if (rc) {
+		pr_err("deletion of wrapping key <%s> failed. rc = %d\n",
+		       (char *)var.name, rc);
+		goto out;
+	}
+
+	rc = count;
+out:
+	kfree(var.name);
+	return rc;
+}
+
+static void wrapkey_kobj_release(struct kobject *kobj)
+{
+	kfree(kobj);
+}
+
+static struct kobj_attribute view_active_attr = __ATTR_RO(list_active);
+
+static struct kobj_attribute view_revoked_attr = __ATTR_RO(list_revoked);
+
+static struct kobj_attribute create_attr = __ATTR_WO(create);
+
+static struct kobj_attribute revoke_attr = __ATTR_WO(revoke);
+
+static struct kobj_attribute unrevoke_attr = __ATTR_WO(unrevoke);
+
+static struct kobj_attribute delete_attr = __ATTR_WO(delete);
+
+static struct attribute *wrapkey_attrs[] = {
+	&view_active_attr.attr,
+	&view_revoked_attr.attr,
+	&create_attr.attr,
+	&revoke_attr.attr,
+	&unrevoke_attr.attr,
+	&delete_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group wrapkey_attr_group = {
+	.attrs = wrapkey_attrs,
+};
+__ATTRIBUTE_GROUPS(wrapkey_attr);
+
+static const struct kobj_type wrapkey_ktype = {
+	.release	= wrapkey_kobj_release,
+	.sysfs_ops	= &kobj_sysfs_ops,
+	.default_groups = wrapkey_attr_groups,
+};
+
+static __init int wrapkey_sysfs_init(void)
+{
+	int rc;
+
+	if (!plpks_revoke_is_supported()) {
+		pr_err("H_PKS_{UN}REVOKE_OBJECT interface not supported\n");
+		return -ENODEV;
+	}
+
+	wrapkey_kobj = kzalloc_obj(*wrapkey_kobj);
+	if (!wrapkey_kobj)
+		return -ENOMEM;
+
+	rc = plpks_init_child_kobj(wrapkey_kobj, &wrapkey_ktype, "wrapkey");
+
+	if (rc) {
+		kobject_put(wrapkey_kobj);
+		wrapkey_kobj = NULL;
+	}
+
+	return rc;
+}
+
+machine_late_initcall(pseries, wrapkey_sysfs_init);
diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 6a7b84e087f0..c483f68c7a47 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -28,7 +28,6 @@
 #define PLPKS_OBJLABEL_BUF_SIZE	\
 	roundup_pow_of_two(PLPKS_OBJLABEL_BUF_BASE_SIZE)
 
-#define PLPKS_OBJLABEL_LEN_FIELD_SIZE	2
 #define PLPKS_OBJLABEL_PREFIX_LEN	8
 
 #define PLPKS_WRAP_INTERFACE_BIT	3
-- 
2.52.0


