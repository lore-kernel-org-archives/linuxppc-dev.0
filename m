Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qcDyC0KBXzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Apr 2016 08:28:18 +1100 (AEDT)
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Fri, 1 Apr 2016 18:28:12 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id BA3EC352005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Apr 2016 17:27:58 -0400 (EDT)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u31KPrYC4694124
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 17:25:54 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u31LS8US016017
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Apr 2016 18:28:09 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
 linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>,
 bauerman@linux.vnet.ibm.com
Subject: Re: [PATCH] ftrace: filter: Match dot symbols when searching
 functions on ppc64.
Date: Fri, 01 Apr 2016 18:28:06 -0300
Message-ID: <3507082.VaWR3lh7Ni@hactar>
In-Reply-To: <201604020331.kEOeyhX0%fengguang.wu@intel.com>
References: <201604020331.kEOeyhX0%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Samstag, 02 April 2016, 03:51:21 schrieb kbuild test robot:
> >> arch/powerpc/include/asm/ftrace.h:62:5: error: "CONFIG_PPC64" is n=
ot
> >> defined [-Werror=3Dundef]
>     #if CONFIG_PPC64 && (!defined(_CALL_ELF) || _CALL_ELF !=3D 2)
>         ^
>    cc1: all warnings being treated as errors

I forgot to use defined() in the #if expression. Here=E2=80=99s the fix=
ed version.

--=20
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


---- 8< ---- 8< ---- 8< ---- 8< ----


>From 27660a3b6c4147f9e1811b103cc47a34a53817c1 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Date: Wed, 30 Mar 2016 21:26:32 -0300
Subject: [PATCH] ftrace: Match dot symbols when searching functions on =
ppc64

In the ppc64 big endian ABI, function symbols point to function
descriptors. The symbols which point to the function entry points
have a dot in front of the function name. Consequently, when the
ftrace filter mechanism searches for the symbol corresponding to
an entry point address, it gets the dot symbol.

As a result, ftrace filter users have to be aware of this ABI detail on=

ppc64 and prepend a dot to the function name when setting the filter.

The perf probe command insulates the user from this by ignoring the dot=

in front of the symbol name when matching function names to symbols,
but the sysfs interface does not. This patch makes the ftrace filter
mechanism do the same when searching symbols.

Fixes the following failure in ftracetest's kprobe_ftrace.tc:

  .../kprobe_ftrace.tc: line 9: echo: write error: Invalid argument

That failure is on this line of kprobe_ftrace.tc:

  echo _do_fork > set_ftrace_filter

This is because there's no _do_fork entry in the functions list:

  # cat available_filter_functions | grep _do_fork
  ._do_fork

This change introduces no regressions on the perf and ftracetest
testsuite results.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ftrace.h |  9 +++++++++
 kernel/trace/ftrace.c             | 13 +++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/a=
sm/ftrace.h
index 50ca7585abe2..f6ed1908f0f7 100644
--- a/arch/powerpc/include/asm/ftrace.h
+++ b/arch/powerpc/include/asm/ftrace.h
@@ -58,6 +58,15 @@ struct dyn_arch_ftrace {
 =09struct module *mod;
 };
 #endif /*  CONFIG_DYNAMIC_FTRACE */
+
+#if defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF !=3D 2)=

+#define ARCH_HAS_FTRACE_MATCH_ADJUST
+static inline void arch_ftrace_match_adjust(char **str, char *search)
+{
+=09if ((*str)[0] =3D=3D '.' && search[0] !=3D '.')
+=09=09(*str)++;
+}
+#endif /* defined(CONFIG_PPC64) && (!defined(_CALL_ELF) || _CALL_ELF !=
=3D 2) */
 #endif /* __ASSEMBLY__ */
=20
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b1870fbd2b67..e806c2a3b7a8 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3444,11 +3444,24 @@ struct ftrace_glob {
 =09int type;
 };
=20
+#ifndef ARCH_HAS_FTRACE_MATCH_ADJUST
+/*
+ * If symbols in an architecture don't correspond exactly to the user-=
visible
+ * name of what they represent, it is possible to define this function=
 to
+ * perform the necessary adjustments.
+*/
+static inline void arch_ftrace_match_adjust(char **str, char *search)
+{
+}
+#endif
+
 static int ftrace_match(char *str, struct ftrace_glob *g)
 {
 =09int matched =3D 0;
 =09int slen;
=20
+=09arch_ftrace_match_adjust(&str, g->search);
+
 =09switch (g->type) {
 =09case MATCH_FULL:
 =09=09if (strcmp(str, g->search) =3D=3D 0)
--=20
1.9.1
