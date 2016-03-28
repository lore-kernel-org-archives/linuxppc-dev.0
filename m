Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYZLp1zJ6zDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 00:21:53 +1100 (AEDT)
Date: Mon, 28 Mar 2016 10:21:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] perf tools: Fix build break on powerpc
Message-ID: <20160328132145.GC8706@kernel.org>
References: <20160326180146.GA32441@us.ibm.com>
 <20160327111903.GC4015@krava.sund.root.ku.dk>
 <20160328123531.GB8706@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160328123531.GB8706@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Mar 28, 2016 at 09:35:31AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Sun, Mar 27, 2016 at 01:19:03PM +0200, Jiri Olsa escreveu:
> > On Sat, Mar 26, 2016 at 11:01:47AM -0700, Sukadev Bhattiprolu wrote:
> > > From 502e8236082412db1d33abfad95aaf14b539502e Mon Sep 17 00:00:00 2001
> > > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > > Date: Sat, 26 Mar 2016 17:31:39 -0400
> > > Subject: [PATCH 1/1] perf tools: Fix build break on powerpc
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=UTF-8
> > > Content-Transfer-Encoding: 8bit
> > > 
> > > 'Commit 531d2410635c ("perf tools: Do not include stringify.h from the
> > > kernel sources")' seems to have accidentially removed the inclusion of
> > > "util/header.h" from "arch/powerpc/util/header.c".
> > > 
> > > "util/header.h" provides the prototype for get_cpuid() and is needed to
> > > build perf on Powerpc.
> > > 
> > > 	arch/powerpc/util/header.c:17:1: error: no previous prototype for
> > > 	‘get_cpuid’ [-Werror=missing-prototypes]
> > > 
> > > Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > > Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > > ---
> > >  tools/perf/arch/powerpc/util/header.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
> > > index 6138bde..5111e34 100644
> > > --- a/tools/perf/arch/powerpc/util/header.c
> > > +++ b/tools/perf/arch/powerpc/util/header.c
> > > @@ -4,6 +4,7 @@
> > >  #include <stdlib.h>
> > >  #include <string.h>
> > >  #include <linux/stringify.h>
> > > +#include "../../util/header.h"
> > 
> > you could use just "header.h" right?
> 
> Like this? I'm trying to find a way to do ppc cross builds, one more
> thing to have in the build-tests...

Argh, only kernel x-builds are supported on Fedora, checking if this is
the case with Debian, if this is supported there, one more Docker image
for building perf :-)

[acme@jouet linux]$ make ARCH=ppc64 CROSS_COMPILE=ppc64-linux-gnu-
O=/tmp/build/perf-ppc64/ -C tools/perf install-bin
make: Entering directory '/home/acme/git/linux/tools/perf'
  BUILD:   Doing 'make -j4' parallel build

Auto-detecting system features:
...                         dwarf: [ OFF ]
...                         glibc: [ OFF ]
...                          gtk2: [ OFF ]
...                      libaudit: [ OFF ]
...                        libbfd: [ OFF ]
...                        libelf: [ OFF ]
...                       libnuma: [ OFF ]
...        numa_num_possible_cpus: [ OFF ]
...                       libperl: [ OFF ]
...                     libpython: [ OFF ]
...                      libslang: [ OFF ]
...                     libcrypto: [ OFF ]
...                     libunwind: [ OFF ]
...            libdw-dwarf-unwind: [ OFF ]
...                          zlib: [ OFF ]
...                          lzma: [ OFF ]
...                     get_cpuid: [ OFF ]
...                           bpf: [ OFF ]

config/Makefile:258: *** No gnu/libc-version.h found, please install
glibc-dev[el].  Stop.
Makefile:108: recipe for target 'install-bin' failed
make: *** [install-bin] Error 2
make: Leaving directory '/home/acme/git/linux/tools/perf'
[acme@jouet linux]$ rpm -q --qf "%{description}\n"
gcc-powerpc64-linux-gnu 
Cross-build GNU C compiler.

Only building kernels is currently supported.  Support for
cross-building user space programs is not currently provided as that
would massively multiply the number of packages.
[acme@jouet linux]$
