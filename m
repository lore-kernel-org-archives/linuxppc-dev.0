Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76BCC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 15:10:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6367220656
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 15:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bPAun3c8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6367220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43VDxg1khzzDqDT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Jan 2019 02:10:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bPAun3c8";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::541; helo=mail-pg1-x541.google.com;
 envelope-from=firoz.khan@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="bPAun3c8"; 
 dkim-atps=neutral
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43VDn10bmxzDqKk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jan 2019 02:02:45 +1100 (AEDT)
Received: by mail-pg1-x541.google.com with SMTP id g189so14695902pgc.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Jan 2019 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QmksWe7tRF2CUX6j+yZoGk06d70fuGnvZ6NC9ZABR0w=;
 b=bPAun3c8Gmb8PdHv/+odBQPHl5b7KisG7WhS5E+57mj+iDKDVo7bfNCpbIFkDzA/ri
 7VMf3jjQCklQoA+ZUcYoG8YCdt6niX90jIDCfjknszfPWWx+WmySMIPhJq9XrJd5HvSO
 yd1RXS52bwsblnE9zgWMpQUN83xbS0jPC5hKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=QmksWe7tRF2CUX6j+yZoGk06d70fuGnvZ6NC9ZABR0w=;
 b=SGu280L1V0HfMNxZYzU9oHkcZH5lejbRp3CX4zQ87VCSjE5ZPGExH0SVsPUji3U1TN
 JGCbVLkuVoueY89vTqRiRxr0nTpZefJO0qBDfPvjpCm8p7BpWd0/pMYfnYdpzLrGFsQW
 Lj+s0I/+7iomYMr7repsJFKCJPGk4W4wAYq8+E7r5LV4KCrzaUZ0dpqmtZ3WqjFb75Q+
 jXAi/xRvtDjpXdzz8tr+GBW2eBqGEacBrsyCPAgYzGExS68C37JYZlY1lMphxBbxF4LS
 CLtX1wsS6mlgS78wJw47xigJvGTf+NIdzluVgJ800LewGHnmBxQf8qo1eh5KFB3YgfmS
 8DDw==
X-Gm-Message-State: AA+aEWaTFSxr9f9BPrWgJpjx6TrgBeo4X2qdHT+uhWBBnDHbU2OUteD1
 70ibJiPoNncea8mEZ3tKCwEyFA==
X-Google-Smtp-Source: AFSGD/UJL0hoxvE92eX0JsULn+9JaQR8nwVft83Bk0IVMAsFJGZstWgeY9y7DUmleJGiRa+Re3BurA==
X-Received: by 2002:a62:4851:: with SMTP id v78mr45164684pfa.97.1546441363337; 
 Wed, 02 Jan 2019 07:02:43 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com
 (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id z14sm66180213pgv.47.2019.01.02.07.02.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 02 Jan 2019 07:02:42 -0800 (PST)
From: Firoz Khan <firoz.khan@linaro.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Al Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Kate Stewart <kstewart@linuxfoundation.org>
Subject: [PATCH 2/2] powerpc: generate uapi header and system call table files
Date: Wed,  2 Jan 2019 20:32:04 +0530
Message-Id: <1546441324-19774-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546441324-19774-1-git-send-email-firoz.khan@linaro.org>
References: <1546441324-19774-1-git-send-email-firoz.khan@linaro.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, marcin.juszkiewicz@linaro.org,
 firoz.khan@linaro.org, deepa.kernel@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Unified system call table generation script must be run to
generate unistd_32/64.h and syscall_table_32/64/c32/spu.h
files. This patch will have changes which will invokes the
script.

This patch will generate unistd_32/64.h and syscall_table-
_32/64/c32/spu.h files by the syscall table generation
script invoked by parisc/Makefile and the generated files
against the removed files must be identical.

The generated uapi header file will be included in uapi/-
asm/unistd.h and generated system call table header file
will be included by kernel/systbl.S file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/kernel/syscalls/Makefile      | 11 +++++++--
 arch/powerpc/kernel/syscalls/syscallhdr.sh | 37 ------------------------------
 arch/powerpc/kernel/syscalls/syscalltbl.sh | 36 -----------------------------
 3 files changed, 9 insertions(+), 75 deletions(-)
 delete mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 delete mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh

diff --git a/arch/powerpc/kernel/syscalls/Makefile b/arch/powerpc/kernel/syscalls/Makefile
index 27b4895..5cbbd70 100644
--- a/arch/powerpc/kernel/syscalls/Makefile
+++ b/arch/powerpc/kernel/syscalls/Makefile
@@ -6,8 +6,9 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
 
 syscall := $(srctree)/$(src)/syscall.tbl
-syshdr := $(srctree)/$(src)/syscallhdr.sh
-systbl := $(srctree)/$(src)/syscalltbl.sh
+syshdr := $(srctree)/scripts/syscallhdr.sh
+sysnr := $(srctree)/scripts/syscallnr.sh
+systbl := $(srctree)/scripts/syscalltbl.sh
 
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
@@ -15,6 +16,12 @@ quiet_cmd_syshdr = SYSHDR  $@
 		   '$(syshdr_pfx_$(basetarget))'		\
 		   '$(syshdr_offset_$(basetarget))'
 
+quiet_cmd_sysnr = SYSNR  $@
+      cmd_sysnr = $(CONFIG_SHELL) '$(sysnr)' '$<' '$@'		\
+		  '$(sysnr_abis_$(basetarget))'			\
+		  '$(sysnr_pfx_$(basetarget))'			\
+		  '$(sysnr_offset_$(basetarget))'
+
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
 		   '$(systbl_abis_$(basetarget))'		\
diff --git a/arch/powerpc/kernel/syscalls/syscallhdr.sh b/arch/powerpc/kernel/syscalls/syscallhdr.sh
deleted file mode 100644
index c0a9a32..0000000
--- a/arch/powerpc/kernel/syscalls/syscallhdr.sh
+++ /dev/null
@@ -1,37 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-prefix="$4"
-offset="$5"
-
-fileguard=_UAPI_ASM_POWERPC_`basename "$out" | sed \
-	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
-	-e 's/[^A-Z0-9_]/_/g' -e 's/__/_/g'`
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	printf "#ifndef %s\n" "${fileguard}"
-	printf "#define %s\n" "${fileguard}"
-	printf "\n"
-
-	nxt=0
-	while read nr abi name entry compat ; do
-		if [ -z "$offset" ]; then
-			printf "#define __NR_%s%s\t%s\n" \
-				"${prefix}" "${name}" "${nr}"
-		else
-			printf "#define __NR_%s%s\t(%s + %s)\n" \
-				"${prefix}" "${name}" "${offset}" "${nr}"
-		fi
-		nxt=$((nr+1))
-	done
-
-	printf "\n"
-	printf "#ifdef __KERNEL__\n"
-	printf "#define __NR_syscalls\t%s\n" "${nxt}"
-	printf "#endif\n"
-	printf "\n"
-	printf "#endif /* %s */" "${fileguard}"
-	printf "\n"
-) > "$out"
diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
deleted file mode 100644
index f7393a7..0000000
--- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-in="$1"
-out="$2"
-my_abis=`echo "($3)" | tr ',' '|'`
-my_abi="$4"
-offset="$5"
-
-emit() {
-	t_nxt="$1"
-	t_nr="$2"
-	t_entry="$3"
-
-	while [ $t_nxt -lt $t_nr ]; do
-		printf "__SYSCALL(%s,sys_ni_syscall)\n" "${t_nxt}"
-		t_nxt=$((t_nxt+1))
-	done
-	printf "__SYSCALL(%s,%s)\n" "${t_nxt}" "${t_entry}"
-}
-
-grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
-	nxt=0
-	if [ -z "$offset" ]; then
-		offset=0
-	fi
-
-	while read nr abi name entry compat ; do
-		if [ "$my_abi" = "c32" ] && [ ! -z "$compat" ]; then
-			emit $((nxt+offset)) $((nr+offset)) $compat
-		else
-			emit $((nxt+offset)) $((nr+offset)) $entry
-		fi
-		nxt=$((nr+1))
-	done
-) > "$out"
-- 
1.9.1

