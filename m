Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdNsH2MPRzDsMT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 10:28:34 +1000 (AEST)
Date: Mon, 19 Sep 2016 21:28:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160920002820.GE11991@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160919212017.GA11991@kernel.org>
 <20160919233113.GB11991@kernel.org>
 <20160919233753.GC11991@kernel.org>
 <20160920000258.GD11991@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160920000258.GD11991@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Sep 19, 2016 at 09:02:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Sep 19, 2016 at 08:37:53PM -0300, Arnaldo Carvalho de Melo escreveu:
> > yeah, changing that typedef + true def to plain include <stdbool.h>
> > makes it progress to the next failure, which is in cross compilation
> > environments, such as using fedora 24 + the Android NDK to try to build
> > a ARM android binary.

> 14 fedora:24-x-ARC-uClibc: FAIL
>   GEN      /tmp/build/perf/pmu-events/pmu-events.c
> /bin/sh: /tmp/build/perf/pmu-events/jevents: cannot execute binary file: Exec format error
> pmu-events/Build:11: recipe for target '/tmp/build/perf/pmu-events/pmu-events.c' failed
> make[2]: *** [/tmp/build/perf/pmu-events/pmu-events.c] Error 126
> Makefile.perf:461: recipe for target '/tmp/build/perf/pmu-events/pmu-events-in.o' failed
> make[1]: *** [/tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
> make[1]: *** Waiting for unfinished jobs....

Jiri, we need something similar to scripts/Makefile.host :-\

Calling it a day, perhaps, for now, we should just detect that it is a
corss compile env (CROSS_COMPILE is set) and exclude all this code from
the build, emitting a warning.

I left what I did at the tmp.perf/core branch of my repo at
git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git.

- Arnaldo
