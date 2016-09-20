Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdNHz0ykGzDsdx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 10:03:10 +1000 (AEST)
Date: Mon, 19 Sep 2016 21:02:58 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160920000258.GD11991@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160919212017.GA11991@kernel.org>
 <20160919233113.GB11991@kernel.org>
 <20160919233753.GC11991@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160919233753.GC11991@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Sep 19, 2016 at 08:37:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> yeah, changing that typedef + true def to plain include <stdbool.h>
> makes it progress to the next failure, which is in cross compilation
> environments, such as using fedora 24 + the Android NDK to try to build
> a ARM android binary.
> 
> On the bright side, in addition to alpine:3.4 now these are building ok:
> 
>  3 archlinux:latest: Ok
>  4 centos:5: Ok
>  5 centos:6: Ok
>  6 centos:7: Ok
>  7 debian:7: Ok
>  8 debian:8: Ok
>  9 fedora:20: Ok
> 
> Waiting for some extra cross compilation envs to check that hunch...

Yeap:

10 fedora:21: Ok
11 fedora:22: Ok
12 fedora:23: Ok
13 fedora:24: Ok
14 fedora:24-x-ARC-uClibc: FAIL
  GEN      /tmp/build/perf/pmu-events/pmu-events.c
/bin/sh: /tmp/build/perf/pmu-events/jevents: cannot execute binary file: Exec format error
pmu-events/Build:11: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
make[2]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 126
Makefile.perf:461: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
make[1]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
make[1]: *** Waiting for unfinished jobs....
15 fedora:rawhide: Ok
16 mageia:5: Ok
17 opensuse:13.2: Ok
18 opensuse:42.1: Ok
19 86.364838418 opensuse:tumbleweed: Ok
20 62.414227297 ubuntu:12.04.5: Ok
21 41.172970676 ubuntu:14.04: Ok
22 74.243049939 ubuntu:14.04.4: Ok
23 75.634449405 ubuntu:15.10: Ok
24 70.487913217 ubuntu:16.04: Ok
25 33.938554395 ubuntu:16.04-x-arm: FAIL
26 31.902507224 ubuntu:16.04-x-arm64: FAIL
27 32.903876355 ubuntu:16.04-x-powerpc64: FAIL
28 32.849412876 ubuntu:16.04-x-powerpc64el: FAIL
29 79.446950856 ubuntu:16.10: Ok
30 33.443948539 ubuntu:16.10-x-arm64: FAIL
31 33.801496151 ubuntu:16.10-x-powerpc: FAIL
32 32.860975730 ubuntu:16.10-x-s390: FAIL
