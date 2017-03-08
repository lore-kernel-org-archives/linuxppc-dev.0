Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdWQ65mjKzDqYv
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 22:24:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Tobin C. Harding" <me@tobin.cc>, Ingo Molnar <mingo@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH] powerpc/ftrace: add ftrace.h, fix sparse warning
In-Reply-To: <1488790186-4828-1-git-send-email-me@tobin.cc>
References: <1488790186-4828-1-git-send-email-me@tobin.cc>
Date: Wed, 08 Mar 2017 22:24:28 +1100
Message-ID: <87innkui37.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Tobin C. Harding" <me@tobin.cc> writes:

> Sparse emits warning: symbol 'prepare_ftrace_return' was not
> declared. Should it be static? prepare_ftrace_return() is called
> from assembler and should not be static. Adding a header file
> declaring the function will fix the sparse warning while adding
> documentation to the call.
>
> Add header file ftrace.h with single function declaration. Protect
> declaration with preprocessor guard so it may be included in
> assembly. Include new header in all files that call
> prepare_ftrace_return() and in ftrace.c where function is defined.
>
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
>
> Github issue: #37 Fix sparse warnings
>
> Tested by building on Power8.
>
> There are a bunch of these in arch/powerpc/kernel/. Do we want to add
> a header for each one, cluttering up the directory to fix the sparse
> warnings? 

No we don't.

In fact we already have a header for this, ie. functions defined in asm
but called from C, it's arch/powerpc/include/asm/asm-prototypes.h.

So I've reworked it to:

diff --git a/arch/powerpc/include/asm/asm-prototypes.h b/arch/powerpc/include/asm/asm-prototypes.h
index f6c5264287e5..e02db66a77e3 100644
--- a/arch/powerpc/include/asm/asm-prototypes.h
+++ b/arch/powerpc/include/asm/asm-prototypes.h
@@ -120,6 +120,8 @@ extern s64 __ashrdi3(s64, int);
 extern int __cmpdi2(s64, s64);
 extern int __ucmpdi2(u64, u64);
 
+/* tracing */
 void _mcount(void);
+unsigned long prepare_ftrace_return(unsigned long parent, unsigned long ip);
 
 #endif /* _ASM_POWERPC_ASM_PROTOTYPES_H */
diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
index 5c9f50c1aa99..32509de6ce4c 100644
--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 
+#include <asm/asm-prototypes.h>
 #include <asm/cacheflush.h>
 #include <asm/code-patching.h>
 #include <asm/ftrace.h>



cheers
