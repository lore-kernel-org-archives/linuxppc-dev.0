Return-Path: <linuxppc-dev+bounces-18298-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1E0FD8740
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 11:33:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZqZg6rq2z2yjm;
	Tue, 17 Mar 2026 22:32:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773747179;
	cv=none; b=nL4LvJyCzSlBglNVcg2ErK+fcevjs1GVmND/CCTZhzjoJz+QQwhZNLlkxKytRiSqjVaB5iI7e8GzRIT1wlqRlYQthYXmS18v7khPmHwJ807A8Ve4pfRvX2Lf6bakJrDgN9oNycKErIog8t4m4wO7ZO1f/RhRWeVeqidz20wOtLXkrAKSMPfEFDuMDTA/wEzbiRk1UE5dz5FURrKMp6LmBpsmN+GzXG5P2XJOS+rpVh0+GccCyehD29xuXJezQQwBcRNPjzwgaR8QjLR4YDKvsiL1C6BswVd3jK0ARS18gQGHzl/qxRAG6vdmEyO4MGxRVAI5fgqCRRKOmdvN/cDoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773747179; c=relaxed/relaxed;
	bh=21n+kj8uKSvBePfi3l6lglPHR4GUMxSb5/xstsj2sf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apCGtUr8Opa5QibhmB3u/OxohoPbfdehobUJ5jj/7vptQ7BdU7vnooup4tUrhhAcKe+O4gP5KVAaVYzd73w/275/HM8H48IZnEimHhapWh7Pxi/lrwKJ2g/ihx0zSm6nvlWnRYHW9k+7nKqG/60Z+LkxBdoHSMAOvl0jcz4/B1ogBNU2FcZyWx6kijgQ+FdV+fS58/DYr4tHurJ3bR43Enm6uTG1SX1VfwVkXpZlVLDdqieYqYcliqcKwSZxFAX8rSrIerK9I+d+M1MTbVDpU23phJGawbXD5o9kwc01xiICWslyuVon4YRBhqygjiMqSuZeHS7Wq2LWtHJQ5Q478w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V60w4glQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=V60w4glQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZqZf6QC6z2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 22:32:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C31FB6111A;
	Tue, 17 Mar 2026 11:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495C7C19425;
	Tue, 17 Mar 2026 11:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773747175;
	bh=UGyqG5Iwe9p4eN1rv2Et9opy6IVj+2NBMBzUOhP/oP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V60w4glQOg+t3XUc3M46GSpTXAVBkIq/aU9RZrPCTxpBsSuyveCK9APO2w6c10dsu
	 OWytaz1zRQ3MQ7XiVtgD/AB3GJyBCBE1QvfUUyRRnp60JLHDzFXKLTCqJ5pGJEIWRG
	 8M3V53GSyU1x0faNdmE9Ke/zoUNVwbQrerQBETxNpqqqF13upp2EhEMfndsPS0eZtN
	 EY7gTMCkGRXB6knWvUsb+AjQpTaneG/p8Gak1sTnGS9DGsMJ9WiQOMNRogTKkuRoVG
	 bZLhiiWYXZiS/znIbFK1I0uVOjSfUCuzGnfaFOelDYzA8vejs+x5cl4C7p+4qsAIVa
	 AVb7Rw5+DybMg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Hari Bathini <hbathini@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mpe@ellerman.id.au,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.19-6.18] powerpc64/ftrace: fix OOL stub count with clang
Date: Tue, 17 Mar 2026 07:32:35 -0400
Message-ID: <20260317113249.117771-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317113249.117771-1-sashal@kernel.org>
References: <20260317113249.117771-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.8
Content-Transfer-Encoding: 8bit

From: Hari Bathini <hbathini@linux.ibm.com>

[ Upstream commit 875612a7745013a43c67493cb0583ee3f7476344 ]

The total number of out-of-line (OOL) stubs required for function
tracing is determined using the following command:

    $(OBJDUMP) -r -j __patchable_function_entries vmlinux.o

While this works correctly with GNU objdump, llvm-objdump does not
list the expected relocation records for this section. Fix this by
using the -d option and counting R_PPC64_ADDR64 relocation entries.
This works as desired with both objdump and llvm-objdump.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260127084926.34497-3-hbathini@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

This is a **build fix**. When building with clang/LLVM toolchain:
1. `llvm-objdump -r -j __patchable_function_entries` produces no
   relocation records
2. `grep -c "$RELOCATION"` finds 0 matches, returns exit code 1
3. With `set -e` at the top of the script, the script aborts
4. The kernel build fails

This is a clear build failure for the LLVM/clang toolchain on powerpc64
with ftrace OOL stubs enabled.

## Analysis

### What the commit fixes
This commit fixes a **build failure** when compiling the Linux kernel
with the LLVM/clang toolchain on powerpc64 with
`CONFIG_PPC_FTRACE_OUT_OF_LINE` enabled. The `llvm-objdump` tool does
not list relocation records the same way as GNU objdump when using `-r
-j __patchable_function_entries`. Adding the `-d` flag makes both GNU
objdump and llvm-objdump produce the expected output.

### Stable kernel criteria assessment
1. **Obviously correct and tested**: Yes. The fix adds `-d` to objdump
   invocations. It has `Tested-by:` from Venkat Rao Bagalkote. The
   commit message clearly explains the problem and solution.
2. **Fixes a real bug**: Yes. Build failure with LLVM/clang toolchain.
3. **Fixes an important issue**: Yes. Build fixes are explicitly listed
   as acceptable for stable trees per stable kernel rules. Users
   building with LLVM toolchain cannot build a working kernel without
   this fix.
4. **Small and contained**: Yes. Only 2 lines changed - adding `-d` flag
   to two objdump invocations in a shell script.
5. **No new features or APIs**: Correct. No new features.

### Scope and risk
- **2 lines changed**: Minimal scope, adding a single flag to objdump
  commands.
- **Only affects build tooling**: A shell script used during build, not
  runtime kernel code.
- **Cross-toolchain compatible**: The fix works with both GNU objdump
  and llvm-objdump.
- **Risk**: Extremely low. The `-d` (disassemble) flag is standard for
  both objdump implementations and the commit message confirms testing
  with both.

### Affected versions
- The file was introduced in v6.13 (commit eec37961a56aa)
- The fix is in v7.0-rc4
- Stable trees v6.13.y and v6.14.y are affected

### Dependencies
No dependencies on other commits. The fix is self-contained.

### User impact
Anyone building the powerpc64 kernel with clang/LLVM and
CONFIG_PPC_FTRACE_OUT_OF_LINE enabled hits a build failure. The
clang/LLVM toolchain is increasingly used for kernel builds
(ClangBuiltLinux project), making this a real-world issue.

## Verification

- `git log --follow -- arch/powerpc/tools/ftrace-gen-ool-stubs.sh`
  confirmed the file was introduced in commit eec37961a56aa (v6.13)
- `git merge-base --is-ancestor eec37961a56aa v6.13` confirmed the file
  is in v6.13 but not v6.12
- `git tag --contains 875612a774501` confirmed the fix landed in
  v7.0-rc4
- Read `arch/powerpc/kernel/trace/ftrace.c:190-239` confirmed that wrong
  stub count leads to WARN_ON and -EINVAL (ftrace failure)
- Read `arch/powerpc/tools/ftrace-gen-ool-stubs.sh` confirmed `set -e`
  at line 5, meaning grep returning exit code 1 (zero matches) would
  abort the script and fail the build
- `git tag -l 'v6.13.*'` and `git tag -l 'v6.14.*'` confirmed both
  stable trees exist and need this fix
- The diff is exactly 2 lines changed (adding `-d` flag) - verified from
  the commit diff

**YES**

 arch/powerpc/tools/ftrace-gen-ool-stubs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
index bac186bdf64a7..9218d43aeb548 100755
--- a/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
+++ b/arch/powerpc/tools/ftrace-gen-ool-stubs.sh
@@ -15,9 +15,9 @@ if [ -z "$is_64bit" ]; then
 	RELOCATION=R_PPC_ADDR32
 fi
 
-num_ool_stubs_total=$($objdump -r -j __patchable_function_entries "$vmlinux_o" |
+num_ool_stubs_total=$($objdump -r -j __patchable_function_entries -d "$vmlinux_o" |
 		      grep -c "$RELOCATION")
-num_ool_stubs_inittext=$($objdump -r -j __patchable_function_entries "$vmlinux_o" |
+num_ool_stubs_inittext=$($objdump -r -j __patchable_function_entries -d "$vmlinux_o" |
 			 grep -e ".init.text" -e ".text.startup" | grep -c "$RELOCATION")
 num_ool_stubs_text=$((num_ool_stubs_total - num_ool_stubs_inittext))
 
-- 
2.51.0


