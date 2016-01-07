Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 07C261A02D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 08:23:10 +1100 (AEDT)
Date: Thu, 7 Jan 2016 18:23:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: "Wangnan (F)" <wangnan0@huawei.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH v4] perf: bpf: Fix build breakage due to libbpf
Message-ID: <20160107212303.GI18457@kernel.org>
References: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
 <1450169473-137129-1-git-send-email-wangnan0@huawei.com>
 <20151215114046.GG23726@naverao1-tp.in.ibm.com>
 <20151216194234.GA19926@kernel.org> <56720FFB.5060407@huawei.com>
 <20151217050714.GB21524@naverao1-tp.ibm.com>
 <20151217121939.GH19926@kernel.org>
 <20160107065709.GA2459@naverao1-tp.ibm.com>
 <20160107203957.GG18457@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160107203957.GG18457@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Jan 07, 2016 at 05:39:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Jan 07, 2016 at 12:28:15PM +0530, Naveen N. Rao escreveu:
> > Can you please push at least the initial 3 patches of this for v4.4?  
> > Wang Nan has posted v6 here:
> > http://thread.gmane.org/gmane.linux.kernel/2110626
 
> So I tried it again today, from the v6, the latest patch with that
> subject line in my inbox, and I get this, after applying the first three
> patches:
 
> [acme@zoo linux]$ make -C tools clean > /dev/null
> [acme@zoo linux]$ make -C tools/perf build-test
> make: Entering directory '/home/git/linux/tools/perf'
> Testing Makefile
> tests/make:15: /scripts/Makefile.arch: No such file or directory
> make[2]: *** No rule to make target '/scripts/Makefile.arch'.  Stop.
> tests/make:5: recipe for target 'all' failed
> make[1]: *** [all] Error 2
> Makefile:81: recipe for target 'build-test' failed
> make: *** [build-test] Error 2
> make: Leaving directory '/home/git/linux/tools/perf'
> [acme@zoo linux]$

> Trying to figure this out...

So, this doesn't seem to have been tessted, this part, specifically:

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 8ea3dffc5065..cd9c3ce1a5c2 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -12,7 +12,7 @@ endif
 else
 PERF := .
 
-include config/Makefile.arch
+include $(srctree)/scripts/Makefile.arch
 
 # FIXME looks like x86 is the only arch running tests ;-)
 # we need some IS_(32/64) flag to make this generic


----------------------------------------------------

Because $(srctree) is not set at that point, I copied the needed bits from
tools/perf/Makefile.perf and got the patch below, which makes:L

  make -C tools/perf build-test

Work for me again.

This should wrap up the day nicely, making me think of Jens Axboe recent
cool reaction to an untested patch:

http://lkml.kernel.org/r/5661C2BC.9030007@kernel.dk

:-)

Jiri, are you ok with the patch below, on top of the second patch in
Wang's series, that you acked?

- Arnaldo

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index cd9c3ce1a5c2..377654f862ec 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -1,3 +1,5 @@
+include ../scripts/Makefile.include
+
 ifndef MK
 ifeq ($(MAKECMDGOALS),)
 # no target specified, trigger the whole suite
@@ -12,7 +14,19 @@ endif
 else
 PERF := .
 
-include $(srctree)/scripts/Makefile.arch
+# As per kernel Makefile, avoid funny character set dependencies
+unexport LC_ALL
+LC_COLLATE=C
+LC_NUMERIC=C
+export LC_COLLATE LC_NUMERIC
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(shell pwd)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+#$(info Determined 'srctree' to be $(srctree))
+endif
+
+include $(srctree)/tools/scripts/Makefile.arch
 
 # FIXME looks like x86 is the only arch running tests ;-)
 # we need some IS_(32/64) flag to make this generic
