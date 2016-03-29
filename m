Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qZKF952jJzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Mar 2016 05:34:37 +1100 (AEDT)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Tue, 29 Mar 2016 15:34:32 -0300
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 616261DC0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 14:34:24 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2THXste3801506
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 14:33:55 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2TIYSmb019152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 14:34:28 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Remove kretprobe_trampoline_holder.
Date: Tue, 29 Mar 2016 15:34:22 -0300
Message-ID: <1625864.aO4Q1DYN9d@hactar>
In-Reply-To: <1459208757.8173.3.camel@ellerman.id.au>
References: <3qWbvb0yVwz9sdm@ozlabs.org> <2042788.6sAC9lOLzB@hactar>
 <1459208757.8173.3.camel@ellerman.id.au>
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

Am Dienstag, 29 M=C3=A4rz 2016, 10:45:57 schrieb Michael Ellerman:
> On Mon, 2016-03-28 at 17:29 -0300, Thiago Jung Bauermann wrote:
> > If I do s/_do_fork/._do_fork/ in kprobe_ftrace.tc then all ftrace k=
probe
> > tests pass:
>=20
> OK. We fixed that in 'perf probe', but not if you're using the sysfs =
file
> directly.
>=20
> Do you want to write a patch for ftracetest to try and handle it? I g=
uess
> you'd try "_do_fork" and if that fails then try "._do_fork", and mayb=
e
> only if uname -m says you're running on ppc64?

I did write a patch yesterday (included below for reference), but then =
I
noticed that the other ftrace tests use _do_fork and they work fine (I =
guess
because of the fix you mentioned). I think that ideally the ftrace filt=
er
mechanism should work with dot symbols as well as regular symbols.

I think this could work by creating a mechanism analogous to the
ARCH_HAS_SYSCALL_MATCH_SYM_NAME one in trace_syscalls.c. Ftrace_match_r=
ecord
could call it to adjust the symbol name (like kprobe_lookup_name) befor=
e
calling ftrace_match.

But I=E2=80=99m wondering if it=E2=80=99s really worth the effort and m=
aybe patching the
testcase is enough? Also, I don=E2=80=99t know whether my idea would ha=
ve any
side effects.

--=20
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center


>From 2ea9b3545906932b9aa213506ec0dff03cffdbe5 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Date: Mon, 28 Mar 2016 18:39:56 -0300
Subject: [PATCH] selftests: kprobe: Fix kprobe_ftrace.tc on ppc64

On ppc64 (but not ppc64le), symbols for function entry points start wit=
h
a dot. There's no _do_fork but there is a ._do_fork.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc  | 20 ++++++++++++=
+-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace=
.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
index d6f2f49..c3ec5c2 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_ftrace.tc
@@ -4,33 +4,39 @@
 [ -f kprobe_events ] || exit_unsupported # this is configurable
 grep function available_tracers || exit_unsupported # this is configur=
able
=20
+if [ "$(uname -m)" =3D "ppc64" ]; then
+    FILTER_FUNCTION=3D"._do_fork"
+else
+    FILTER_FUNCTION=3D"_do_fork"
+fi
+
 # prepare
 echo nop > current_tracer
-echo _do_fork > set_ftrace_filter
+echo $FILTER_FUNCTION > set_ftrace_filter
 echo 0 > events/enable
 echo > kprobe_events
-echo 'p:testprobe _do_fork' > kprobe_events
+echo "p:testprobe $FILTER_FUNCTION" > kprobe_events
=20
 # kprobe on / ftrace off
 echo 1 > events/kprobes/testprobe/enable
 echo > trace
 ( echo "forked")
 grep testprobe trace
-! grep '_do_fork <-' trace
+! grep "$FILTER_FUNCTION <-" trace
=20
 # kprobe on / ftrace on
 echo function > current_tracer
 echo > trace
 ( echo "forked")
 grep testprobe trace
-grep '_do_fork <-' trace
+grep "$FILTER_FUNCTION <-" trace
=20
 # kprobe off / ftrace on
 echo 0 > events/kprobes/testprobe/enable
 echo > trace
 ( echo "forked")
 ! grep testprobe trace
-grep '_do_fork <-' trace
+grep "$FILTER_FUNCTION <-" trace
=20
 # kprobe on / ftrace on
 echo 1 > events/kprobes/testprobe/enable
@@ -38,14 +44,14 @@ echo function > current_tracer
 echo > trace
 ( echo "forked")
 grep testprobe trace
-grep '_do_fork <-' trace
+grep "$FILTER_FUNCTION <-" trace
=20
 # kprobe on / ftrace off
 echo nop > current_tracer
 echo > trace
 ( echo "forked")
 grep testprobe trace
-! grep '_do_fork <-' trace
+! grep "$FILTER_FUNCTION <-" trace
=20
 # cleanup
 echo nop > current_tracer
--=20
1.9.1
