Return-Path: <paulus@bilbo.ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6F4E8B71F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 21:56:23 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D23CDDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 21:56:23 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <19000.55666.866148.559620@cargo.ozlabs.ibm.com>
Date: Wed, 17 Jun 2009 21:54:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ingo Molnar <mingo@elte.hu>, benh@kernel.crashing.org
Subject: [PATCH 6/6] perf_counter: tools: Makefile tweaks for 64-bit powerpc
In-Reply-To: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
References: <19000.55404.103840.393470@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 64-bit powerpc, perf needs to be built as a 64-bit executable.
This arranges to add the -m64 flag to CFLAGS if we are running on
a 64-bit machine, indicated by the result of uname -m ending in "64".
This means that we'll use -m64 on x86_64 machines as well.

This also removes the -Werror flag when building on a 64-bit powerpc
machine.  The userspace definition of u64 is unsigned long rather
than unsigned long long, meaning that gcc warns every time a u64
is printed with %Lx or %llx (though that does work properly).
In future we may use PRI64 etc. for printing 64-bit quantities,
which would eliminate these warnings.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 tools/perf/Makefile |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index e8346f9..eddd61a 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -157,9 +157,21 @@ uname_R := $(shell sh -c 'uname -r 2>/dev/null || echo not')
 uname_P := $(shell sh -c 'uname -p 2>/dev/null || echo not')
 uname_V := $(shell sh -c 'uname -v 2>/dev/null || echo not')
 
+# If we're on a 64-bit kernel, use -m64
+ifneq ($(patsubst %64,%,$(uname_M)),$(uname_M))
+  M64 := -m64
+endif
+
+# Don't use -Werror on ppc64; we get warnings due to using
+# %Lx formats on __u64, which is unsigned long.
+Werror := -Werror
+ifeq ($(uname_M),ppc64)
+  Werror :=
+endif
+
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -ggdb3 -Wall -Werror -Wstrict-prototypes -Wmissing-declarations -Wmissing-prototypes -std=gnu99 -Wdeclaration-after-statement -O6
+CFLAGS = $(M64) -ggdb3 -Wall $(Werror) -Wstrict-prototypes -Wmissing-declarations -Wmissing-prototypes -std=gnu99 -Wdeclaration-after-statement -O6
 LDFLAGS = -lpthread -lrt -lelf -lm
 ALL_CFLAGS = $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
-- 
1.6.0.4
