Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8004C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:31:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0B620675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0B620675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fp5M51P4zDqdR
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:31:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fp0Z09h8zDqSW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:27:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43fp0X4pzXz9sDB; Thu, 17 Jan 2019 00:27:24 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43fp0W62rFz9sDL; Thu, 17 Jan 2019 00:27:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH v2 2/5] powerpc/syscalls: Remove unused offset parameter
Date: Thu, 17 Jan 2019 00:27:11 +1100
Message-Id: <20190116132714.20094-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116132714.20094-1-mpe@ellerman.id.au>
References: <20190116132714.20094-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: firoz.khan@linaro.org, arnd@arndb.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We never pass a value for offset, nor do we need to, so remove the
offset logic.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/syscalls/Makefile      |  6 ++----
 arch/powerpc/kernel/syscalls/syscallhdr.sh | 10 ++--------
 arch/powerpc/kernel/syscalls/syscalltbl.sh |  8 ++------
 3 files changed, 6 insertions(+), 18 deletions(-)

v2: No change.

diff --git a/arch/powerpc/kernel/syscalls/Makefile b/arch/powerpc/kernel/syscalls/Makefile
index 27b48954808d..5e65f68fb7b7 100644
--- a/arch/powerpc/kernel/syscalls/Makefile
+++ b/arch/powerpc/kernel/syscalls/Makefile
@@ -12,14 +12,12 @@ systbl := $(srctree)/$(src)/syscalltbl.sh
 quiet_cmd_syshdr = SYSHDR  $@
       cmd_syshdr = $(CONFIG_SHELL) '$(syshdr)' '$<' '$@'	\
 		   '$(syshdr_abis_$(basetarget))'		\
-		   '$(syshdr_pfx_$(basetarget))'		\
-		   '$(syshdr_offset_$(basetarget))'
+		   '$(syshdr_pfx_$(basetarget))'
 
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
 		   '$(systbl_abis_$(basetarget))'		\
-		   '$(systbl_abi_$(basetarget))'		\
-		   '$(systbl_offset_$(basetarget))'
+		   '$(systbl_abi_$(basetarget))'
 
 syshdr_abis_unistd_32 := common,nospu,32
 $(uapi)/unistd_32.h: $(syscall) $(syshdr)
diff --git a/arch/powerpc/kernel/syscalls/syscallhdr.sh b/arch/powerpc/kernel/syscalls/syscallhdr.sh
index c0a9a32937f1..e1e490ea10ab 100644
--- a/arch/powerpc/kernel/syscalls/syscallhdr.sh
+++ b/arch/powerpc/kernel/syscalls/syscallhdr.sh
@@ -5,7 +5,6 @@ in="$1"
 out="$2"
 my_abis=`echo "($3)" | tr ',' '|'`
 prefix="$4"
-offset="$5"
 
 fileguard=_UAPI_ASM_POWERPC_`basename "$out" | sed \
 	-e 'y/abcdefghijklmnopqrstuvwxyz/ABCDEFGHIJKLMNOPQRSTUVWXYZ/' \
@@ -17,13 +16,8 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 
 	nxt=0
 	while read nr abi name entry compat ; do
-		if [ -z "$offset" ]; then
-			printf "#define __NR_%s%s\t%s\n" \
-				"${prefix}" "${name}" "${nr}"
-		else
-			printf "#define __NR_%s%s\t(%s + %s)\n" \
-				"${prefix}" "${name}" "${offset}" "${nr}"
-		fi
+		printf "#define __NR_%s%s\t%s\n" \
+			"${prefix}" "${name}" "${nr}"
 		nxt=$((nr+1))
 	done
 
diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
index fd620490a542..01e57093a51a 100644
--- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
+++ b/arch/powerpc/kernel/syscalls/syscalltbl.sh
@@ -5,7 +5,6 @@ in="$1"
 out="$2"
 my_abis=`echo "($3)" | tr ',' '|'`
 my_abi="$4"
-offset="$5"
 
 emit() {
 	t_nxt="$1"
@@ -21,15 +20,12 @@ emit() {
 
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	nxt=0
-	if [ -z "$offset" ]; then
-		offset=0
-	fi
 
 	while read nr abi name entry compat ; do
 		if [ "$my_abi" = "c32" ] && [ ! -z "$compat" ]; then
-			emit $((nxt+offset)) $((nr+offset)) $compat
+			emit $nxt $nr $compat
 		else
-			emit $((nxt+offset)) $((nr+offset)) $entry
+			emit $nxt $nr $entry
 		fi
 		nxt=$((nr+1))
 	done
-- 
2.20.1

