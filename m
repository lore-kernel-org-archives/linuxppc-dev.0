Return-Path: <linuxppc-dev+bounces-18083-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D60C103E2F7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 00:40:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWTKl1Vkhz3cDg;
	Thu, 12 Mar 2026 11:40:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773276011;
	cv=none; b=VRYz2pSEo8a+zqp9dh+Om5zzx6UwhPRTOfP2clG+eEWxN8qQT27FUTjQ/xP1iD5volXoVKVY3SVgJahhKts39YFM+ao5sYNkC/aU4hEcUZijf4PyS7G4zdlKEH09iFNH03pALppJNV7H8/XgaGaAMcKJxAZIYeo9IrBMsQakzdLtVpgPfwEV3JSIU8z6uAHMM9dZSaRwN2zB3Ja9XuvBF0qdDeH1USpDfqff/cJptURT6Od3uNZVO+nTdpd06nsr60T7/j72MZry+V3YidTWJevX1u+d+KFm++5xMh1DejPNXdYQxqU3ie4NNLoO8ShWaTJkoenpzXyScArX7GJkBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773276011; c=relaxed/relaxed;
	bh=zt17eJgcaCmtPqU0NUbDq3q4F61cpuFUJ1rXABkExBs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JL0eu6tYl9c8kfMqFsqIzHzyEtZkzVjTc3X221o4SsMKOm9AFPgc+uNWWHN/ufoluTTzifFQLS7ehLlm5g4tnOylbsMYwVdhr+FaNuHOtBTLPN1vuIvBXjPC4bFVYeI1i22hjXhCRxAu3E31hoTH5lwsW18zm3ma/swZuuksNf/tyqZ0YvG1LRxT5p7hHN7qeTyvpENw81XVXWV+VmX6qmQ59keSbg51qGSptudtlVsQ6/44TcNPmMKBtmE+dBjLhfHDW8LoYZcWnyvn2BmaXnH4OoOCfkw6FjwUpk37uw4WZ7pcB1DtbQXcUgVKeXHA8xPDpskQj8PAD5JGkitLPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mycyTdB0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=mycyTdB0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWTKk1mtmz3cDf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 11:40:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F2FE40B33;
	Thu, 12 Mar 2026 00:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DBBC4CEF7;
	Thu, 12 Mar 2026 00:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773276008;
	bh=nQbnEBithESt6CWLnUtQicYUaszVzxppnpWJix1YO4c=;
	h=From:Date:Subject:To:Cc:From;
	b=mycyTdB0jUEBRJxMCkU9s2dIJp8qM2LyFyXSqjinha7qnpewU7pSnFDftq4TrEf/H
	 W1CqMhZHFofopo6AlQr0AjOqLQvfZ4Ot7kB0Lb0Z1HX5dCFG8jDQsNvlfc6OzdY2P+
	 TbTzXdKE9P3Yz9Ow0byFIgf/ghWMV77mogaHbnPfkwCTtc+cyYcgTMGhd/KCl1vlIy
	 c6jjjcQmWYIGKoTnJWxf8yR/MVP6YFxdnK4TM5mfa1ztfCsd2uLT30dT3wo/C4pJPO
	 w+IWParo2OHLKWYOWze2/NVC69sDI4nZjfnnywCeuLHpXSuY3Qo/8fMAdUdu4UDas3
	 Lu+s23amTNCsg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 11 Mar 2026 17:39:56 -0700
Subject: [PATCH] powerpc/vdso: Drop -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 from 32-bit flags with clang
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-ppc-vdso-drop-cc-using-pfe-define-clang-v1-1-66c790e22650@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNQQrCMBBFr1Jm7UBS0yy8irjQyaSOSBIytgild
 3fU5ePx399AuQsrnIYNOq+iUouBPwxA92uZGSUZw+jG6I7eY2uEa9KKqdeGRLiolBlbZkycpTD
 S03YYYop5csFPIYDVWjf7/j2dL3/W5fZgen3zsO8fescys4sAAAA=
X-Change-ID: 20260311-ppc-vdso-drop-cc-using-pfe-define-clang-46d6f5041544
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2955; i=nathan@kernel.org;
 h=from:subject:message-id; bh=nQbnEBithESt6CWLnUtQicYUaszVzxppnpWJix1YO4c=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJmbuFPffHHdcnzStz/ZYr1zUnJestRtvXTi2QXzTf/vK
 /Sa9My52VHKwiDGxSArpshS/Vj1uKHhnLOMN05NgpnDygQyhIGLUwAmcjmV4b+LIrc5w1+lWd4/
 ircvUrrFz9qX1cv5PrbdUqiS+XFaCDPD//QrrpsWmCbtmtP+/c820Y/Xs8sf1Z848UfMcDvLbid
 fNVYA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 73cdf24e81e4 ("powerpc64: make clang cross-build
friendly"), building 64-bit little endian + CONFIG_COMPAT=y with clang
results in many warnings along the lines of:

  $ cat arch/powerpc/configs/compat.config
  CONFIG_COMPAT=y

  $ make -skj"$(nproc)" ARCH=powerpc LLVM=1 ppc64le_defconfig compat.config arch/powerpc/kernel/vdso/
  ...
  In file included from <built-in>:4:
  In file included from lib/vdso/gettimeofday.c:6:
  In file included from include/vdso/datapage.h:15:
  In file included from include/vdso/cache.h:5:
  arch/powerpc/include/asm/cache.h:77:8: warning: unknown attribute 'patchable_function_entry' ignored [-Wunknown-attributes]
     77 | static inline u32 l1_icache_bytes(void)
        |        ^~~~~~
  include/linux/compiler_types.h:235:58: note: expanded from macro 'inline'
    235 | #define inline inline __gnu_inline __inline_maybe_unused notrace
        |                                                          ^~~~~~~
  include/linux/compiler_types.h:215:34: note: expanded from macro 'notrace'
    215 | #define notrace                 __attribute__((patchable_function_entry(0, 0)))
        |                                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ...

arch/powerpc/Makefile adds -DCC_USING_PATCHABLE_FUNCTION_ENTRY to
KBUILD_CPPFLAGS, which is inherited by the 32-bit vDSO. However, the
32-bit little endian target does not support
'-fpatchable-function-entry', resulting in the warnings above.

Remove -DCC_USING_PATCHABLE_FUNCTION_ENTRY from the 32-bit vDSO flags
when building with clang to avoid the warnings.

Fixes: 73cdf24e81e4 ("powerpc64: make clang cross-build friendly")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/powerpc/kernel/vdso/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
index 8834dfe9d727..368759f81708 100644
--- a/arch/powerpc/kernel/vdso/Makefile
+++ b/arch/powerpc/kernel/vdso/Makefile
@@ -62,6 +62,12 @@ CC32FLAGSREMOVE += -fno-stack-clash-protection
 # 32-bit one. clang validates the values passed to these arguments during
 # parsing, even when -fno-stack-protector is passed afterwards.
 CC32FLAGSREMOVE += -mstack-protector-guard%
+# ftrace is disabled for the vdso but arch/powerpc/Makefile adds this define to
+# KBUILD_CPPFLAGS, which enables use of the 'patchable_function_entry'
+# attribute in the 'inline' define via 'notrace'. This attribute is not
+# supported for the powerpcle target, resulting in many instances of
+# -Wunknown-attributes.
+CC32FLAGSREMOVE += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
 endif
 LD32FLAGS := -Wl,-soname=linux-vdso32.so.1
 AS32FLAGS := -D__VDSO32__

---
base-commit: 35e4f2a17eb40288f9bcdb09549fa04a63a96279
change-id: 20260311-ppc-vdso-drop-cc-using-pfe-define-clang-46d6f5041544

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


