Return-Path: <linuxppc-dev+bounces-17070-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AFFEC1124
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Feb 2026 19:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKVnb63jxz3bZm;
	Tue, 24 Feb 2026 06:11:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771873875;
	cv=none; b=ClkZlvGm1bCnQTw1QEzGCaGlgoQ4AWUkR7HlBjjORmr+82AOlEo0FQEfGNk1GsDEwQn7JoeC3z9YPNn7Ge8jOW3GSOBad2dOmVfDmhKcrsNWIZTwRsnvobcfl1EB1dOeN/iMT5oRyf/2DvRE36HukCrTBfcr02aGbLnI4SnVyAv5qrDQP7UYi5h9ZuME8lOkk+V5bfRUNEHAzEcjZ4SEiANKkywISlG9pnyqy1lz2lEXzvt2uNEJjnStp1oXxgKLosf4m1gxl0AhL5Xod9ELw8OJWJx5CXdIAktbakEXBxcB6nka+/hSj+GFVOwejfSV45ZYA7D5gLRf2iXsgGd71A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771873875; c=relaxed/relaxed;
	bh=JQMEKXUSkaG7neBfJPWJGw4i7WIIDOqWY1P7BMsbh/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oovpPx5dCgHX3sYAbBaOf0XQlNOVMgbFDqd88a+x357ZwlOTbVNh9QfAjaiYz0zTHFZHheL1DcIXLOO49uDyQtsRv2OP1mh3q2VchNm95tXI526Fdf/Ehm9DJkU3aU0cQD1FAI6App+3zYUVIkc+bFko4K16/CGf+Dk3fR3JXXWQYB/DuoQhRsk0WONEjDrGO3eI6zSqgngAkn76OEWe6sq9O5FhY8clGbSDaUGJOwzIzzF7D1UnBVqPGBN4nlMgjdH6wpaVxSm7W63MSzBRzkTORe5+RTTkIX9jjRhGxNlE+s0q+H4Fti2GWqAqTBLM9abmgWxDHlgWrxaS918iqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ec7rpLCA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ec7rpLCA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKVnZ6Y5qz3bW7
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 06:11:14 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2FFC24052E;
	Mon, 23 Feb 2026 19:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEF7C2BCB5;
	Mon, 23 Feb 2026 19:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771873873;
	bh=HnBXmWSMpA4wuIlOSxrj2rJBVS6hgScD9wUDZt2+qlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ec7rpLCAzCv/KZRrk93iS8TKBy0dmX0TGeVU6K4v5xX/A3r84WlF1+spB2Ck3L8+F
	 Ly7Wrk5nDJOONGQAATDn57wpDwS2nId7NK4Vw6pPbxqhuUY3hzAD8tHDKWPeYQ16aq
	 CDGEXsS4binEbD98XFg/kkeskjcNzRQjVBeAbf9hU+krUTPdo4EdS3QsbFUpmWqK+x
	 83fmxFV+JzQ6K58ijzWKw7NoMdRiJVu6YnkQ+ER5K9bPSOKZ9CiQSYDQwcw9L4xCAq
	 zh+5+/I2WpfYgv6lc5TMsUwpiBXIECDLTQU1MmY+kExyurkj5huthCznFvUTJv9pGV
	 pHQjm+oF6bRiA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 23 Feb 2026 12:10:29 -0700
Subject: [PATCH 2/2] kbuild: Use '-fms-anonymous-structs' if it is
 available
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
Message-Id: <20260223-fms-anonymous-structs-v1-2-8ee406d3c36c@kernel.org>
References: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
In-Reply-To: <20260223-fms-anonymous-structs-v1-0-8ee406d3c36c@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Kees Cook <kees@kernel.org>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
 linux-efi@vger.kernel.org, llvm@lists.linux.dev
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2260; i=nathan@kernel.org;
 h=from:subject:message-id; bh=HnBXmWSMpA4wuIlOSxrj2rJBVS6hgScD9wUDZt2+qlw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJlzllnaL/tzZJ9j+UqRFKP/HVNX104yzPm+PPiz5Fdep
 pLXR1Z0d5SyMIhxMciKKbJUP1Y9bmg45yzjjVOTYOawMoEMYeDiFICJlJ1h+Gf2bHvS3EU6Cuzv
 6lVV6lZmRpcf6jghx2ystVX28+qCK1GMDBd67Cest0lolmS6u+nMHYW1j73/xRXE1p4vP+5/d3u
 xCTcA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Clang recently added '-fms-anonymous-structs' [1] to specifically enable
the Microsoft tagged anonymous structure / union extension, for which
the kernel added '-fms-extensions' in commit c4781dc3d1cf ("Kbuild:
enable -fms-extensions"). Switch to this more narrow option if it is
available, which would have helped avoid the issue addressed by
commit a6773e6932cb ("jfs: Rename _inline to avoid conflict with clang's
'-fms-extensions'"). GCC has talked about adding a similar flag [2] as
well but potentially naming it differently.

Move the selection of the flag to Kconfig to make it easier to use
cc-option (as CC_FLAGS_DIALECT may be used in arch Makefiles, which may
be too early for cc-option in Kbuild) and customize based on compiler
flag names.

Link: https://github.com/llvm/llvm-project/commit/c391efe6fb67329d8e2fd231692cc6b0ea902956 [1]
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=123623 [2]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 Makefile     | 2 +-
 init/Kconfig | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 06ff3032a6bc..1d5c0ab9ed5c 100644
--- a/Makefile
+++ b/Makefile
@@ -791,7 +791,7 @@ endif
 
 CC_FLAGS_DIALECT := -std=gnu11
 # Allow including a tagged struct or union anonymously in another struct/union.
-CC_FLAGS_DIALECT += -fms-extensions
+CC_FLAGS_DIALECT += $(CONFIG_CC_MS_EXTENSIONS)
 # Clang enables warnings about GNU and Microsoft extensions by default, disable
 # them because this is expected with the above options.
 ifdef CONFIG_CC_IS_CLANG
diff --git a/init/Kconfig b/init/Kconfig
index c25869cf59c1..c4282d049463 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -960,6 +960,11 @@ config CC_IMPLICIT_FALLTHROUGH
 	default "-Wimplicit-fallthrough=5" if CC_IS_GCC && $(cc-option,-Wimplicit-fallthrough=5)
 	default "-Wimplicit-fallthrough" if CC_IS_CLANG && $(cc-option,-Wunreachable-code-fallthrough)
 
+config CC_MS_EXTENSIONS
+	string
+	default "-fms-anonymous-structs" if $(cc-option,-fms-anonymous-structs)
+	default "-fms-extensions"
+
 # Currently, disable gcc-10+ array-bounds globally.
 # It's still broken in gcc-13, so no upper bound yet.
 config GCC10_NO_ARRAY_BOUNDS

-- 
2.53.0


