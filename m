Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdMl375HbzDsgM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 09:38:07 +1000 (AEST)
Date: Mon, 19 Sep 2016 20:37:53 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, peterz@infradead.org,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v21 00/20] perf, tools: Add support for PMU events in
 JSON format
Message-ID: <20160919233753.GC11991@kernel.org>
References: <1473978296-20712-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <20160919212017.GA11991@kernel.org>
 <20160919233113.GB11991@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160919233113.GB11991@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Sep 19, 2016 at 08:31:13PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Sep 19, 2016 at 06:20:17PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Sep 15, 2016 at 03:24:37PM -0700, Sukadev Bhattiprolu escreveu:
> > > CPUs support a large number of performance monitoring events (PMU events)
> > > and often these events are very specific to an architecture/model of the
> > > CPU. To use most of these PMU events with perf, we currently have to identify
> > > them by their raw codes:
> > > 
> > > 	perf stat -e r100f2 sleep 1
> > 
> > So, trying to build this with my set of containers I get lots of failures,
> > double checking running on another machine with those containers for the
> > segfault cases, changing sys/fcntl.h to fcntl.h cures the build on alpine:3.4
> > (musl libc), will try to fix all of them.
> > 
> > The list is incomplete, lots of other systems failed as well.
> > 
> > - Arnaldo
> > 
>  1 alpine:3.4: Ok
> 
> Fixed with fcntl.h + capping the maxfds parameter to nftw to avoid it
> exploding on alloca() in environments where rlim_max is set to a high
> value, like in docker.
> 
> Now looking at:
> 
>   CC       /tmp/build/perf/fs/tracing_path.o
> In file included from /git/linux/tools/include/linux/types.h:4:0,
>                  from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/sys/types.h:35,
>                  from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/strings.h:42,
>                  from /opt/android-ndk-r12b/platforms/android-24/arch-arm/usr/include/stdlib.h:36,
>                  from pmu-events/json.c:31:
> pmu-events/json.h:15:22: error: two or more data types in declaration specifiers
>  typedef unsigned int bool;
> 
> 
> Which looks like clashing with stdbool.h...

yeah, changing that typedef + true def to plain include <stdbool.h>
makes it progress to the next failure, which is in cross compilation
environments, such as using fedora 24 + the Android NDK to try to build
a ARM android binary.

On the bright side, in addition to alpine:3.4 now these are building ok:

 3 archlinux:latest: Ok
 4 centos:5: Ok
 5 centos:6: Ok
 6 centos:7: Ok
 7 debian:7: Ok
 8 debian:8: Ok
 9 fedora:20: Ok

Waiting for some extra cross compilation envs to check that hunch...

- Arnaldo
