Return-Path: <lacombar@gmail.com>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by ozlabs.org (Postfix) with ESMTP id 729BAB70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 25 Oct 2010 14:50:45 +1100 (EST)
Received: by yws5 with SMTP id 5so2236869yws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 24 Oct 2010 20:50:42 -0700 (PDT)
From: Arnaud Lacombe <lacombar@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: build warning in Linus' tree
Date: Sun, 24 Oct 2010 23:47:09 -0400
Message-Id: <1287978429-18542-1-git-send-email-lacombar@gmail.com>
In-Reply-To: <20101025135237.337b8321.sfr@canb.auug.org.au>
References: <20101025135237.337b8321.sfr@canb.auug.org.au>
Cc: linuxppc-dev@lists.ozlabs.org, "H. Peter Anvin" <hpa@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Arnaud Lacombe <lacombar@gmail.com>, Jan Beulich <JBeulich@novell.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

[adding linuxppc-dev@lists.ozlabs.org to the CC's list]

On Sun, Oct 24, 2010 at 10:52 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> In building Linus' tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>
> In file included from arch/powerpc/platforms/iseries/exception.S:32:
> arch/powerpc/include/asm/ptrace.h:60:1: warning: "STACK_FRAME_OVERHEAD" redefined
> In file included from arch/powerpc/include/asm/asm-offsets.h:1,
>                 from arch/powerpc/platforms/iseries/exception.S:30:
> include/generated/asm-offsets.h:87:1: warning: this is the location of the previous definition
>
> Caused by commit 3234282f33b29d349bcada40204fc7c8fda7fe72 ("x86, asm: Fix
> CFI macro invocations to deal with shortcomings in gas").

The following patch should fix this warning.

 - Arnaud

From: Arnaud Lacombe <lacombar@gmail.com>
Date: Sun, 24 Oct 2010 20:39:53 -0400
Subject: [PATCH] powerpc: wrap STACK_FRAME_OVERHEAD definition around parenthesis

Although the value does not need protection, wrapping it around parenthesis make
it match the definition from `include/generated/asm-offsets.h' and silent the
following gcc's warning:

In file included from arch/powerpc/kernel/head_32.S:34:0:
arch/powerpc/include/asm/ptrace.h:73:0: warning: "STACK_FRAME_OVERHEAD" redefined
include/generated/asm-offsets.h:28:0: note: this is the location of the previous definition

Signed-off-by: Arnaud Lacombe <lacombar@gmail.com>

---
 arch/powerpc/include/asm/ptrace.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 0175a67..3e18533 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -57,7 +57,7 @@ struct pt_regs {
 
 #ifdef __powerpc64__
 
-#define STACK_FRAME_OVERHEAD	112	/* size of minimum stack frame */
+#define STACK_FRAME_OVERHEAD	(112)	/* size of minimum stack frame */
 #define STACK_FRAME_LR_SAVE	2	/* Location of LR in stack frame */
 #define STACK_FRAME_REGS_MARKER	ASM_CONST(0x7265677368657265)
 #define STACK_INT_FRAME_SIZE	(sizeof(struct pt_regs) + \
@@ -70,7 +70,7 @@ struct pt_regs {
 
 #else /* __powerpc64__ */
 
-#define STACK_FRAME_OVERHEAD	16	/* size of minimum stack frame */
+#define STACK_FRAME_OVERHEAD	(16)	/* size of minimum stack frame */
 #define STACK_FRAME_LR_SAVE	1	/* Location of LR in stack frame */
 #define STACK_FRAME_REGS_MARKER	ASM_CONST(0x72656773)
 #define STACK_INT_FRAME_SIZE	(sizeof(struct pt_regs) + STACK_FRAME_OVERHEAD)
-- 
1.7.3.12.gf5e62.dirty
