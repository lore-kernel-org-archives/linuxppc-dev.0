Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYZr10tZHzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 00:43:44 +1100 (AEDT)
Date: Mon, 28 Mar 2016 10:43:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/1] perf tools: Fix build break on powerpc
Message-ID: <20160328134336.GD8706@kernel.org>
References: <20160326180146.GA32441@us.ibm.com>
 <20160327111903.GC4015@krava.sund.root.ku.dk>
 <20160328123531.GB8706@kernel.org>
 <20160328132145.GC8706@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160328132145.GC8706@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Mar 28, 2016 at 10:21:45AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Mar 28, 2016 at 09:35:31AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Sun, Mar 27, 2016 at 01:19:03PM +0200, Jiri Olsa escreveu:
> > > On Sat, Mar 26, 2016 at 11:01:47AM -0700, Sukadev Bhattiprolu wrote:
> > > > +++ b/tools/perf/arch/powerpc/util/header.c
> > > > @@ -4,6 +4,7 @@
> > > >  #include <stdlib.h>
> > > >  #include <string.h>
> > > >  #include <linux/stringify.h>
> > > > +#include "../../util/header.h"
> > > 
> > > you could use just "header.h" right?
> > 
> > Like this? I'm trying to find a way to do ppc cross builds, one more
> > thing to have in the build-tests...
> 
> Argh, only kernel x-builds are supported on Fedora, checking if this is
> the case with Debian, if this is supported there, one more Docker image
> for building perf :-)
> 
> [acme@jouet linux]$ make ARCH=ppc64 CROSS_COMPILE=ppc64-linux-gnu-
> O=/tmp/build/perf-ppc64/ -C tools/perf install-bin
> make: Entering directory '/home/acme/git/linux/tools/perf'
>   BUILD:   Doing 'make -j4' parallel build

Ok, couldn't quickly find it on Debian, but found it for ppc64el on
Ubuntu, this way I can reproduce the problem:

root@df2c38ce15fe:/git/linux# make ARCH=ppc64el CROSS_COMPILE=powerpc64le-linux-gnu- -C tools/perf O=/tmp/build/perf install-bin
make: Entering directory `/git/linux/tools/perf'
  BUILD:   Doing 'make -j4' parallel build

Auto-detecting system features:
...                         dwarf: [ OFF ]
...                         glibc: [ on  ]
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
...                           bpf: [ on  ]

config/Makefile:246: No libelf found, disables 'probe' tool and BPF support in 'perf record', please install elfutils-libelf-devel/libelf-dev
config/Makefile:364: Disabling post unwind, no support found.
config/Makefile:405: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
config/Makefile:416: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
config/Makefile:431: slang not found, disables TUI support. Please install slang-devel or libslang-dev
config/Makefile:445: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
config/Makefile:473: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
config/Makefile:516: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
config/Makefile:606: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
config/Makefile:619: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
config/Makefile:676: Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc
  CC       /tmp/build/perf/arch/powerpc/util/header.o
arch/powerpc/util/header.c:18:1: error: no previous prototype for 'get_cpuid' [-Werror=missing-prototypes]
 get_cpuid(char *buffer, size_t sz)
 ^
arch/powerpc/util/header.c: In function 'get_cpuid':
arch/powerpc/util/header.c:25:2: error: implicit declaration of function 'scnprintf' [-Werror=implicit-function-declaration]
  nb = scnprintf(buffer, sz, "%lu,%lu$", PVR_VER(pvr), PVR_REV(pvr));
  ^
arch/powerpc/util/header.c:25:2: error: nested extern declaration of 'scnprintf' [-Werror=nested-externs]
cc1: all warnings being treated as errors
  INSTALL  binaries
  INSTALL  tests
  INSTALL  libexec
  INSTALL  perf-archive
  INSTALL  perf-with-kcore
  INSTALL  perf_completion-script
  INSTALL  perf-tip
make: Leaving directory `/git/linux/tools/perf'
root@df2c38ce15fe:/git/linux#

----------------------------------------------------------------
And test the fix:
----------------------------------------------------------------

root@df2c38ce15fe:/git/linux# make ARCH=ppc64el CROSS_COMPILE=powerpc64le-linux-gnu- -C tools/perf O=/tmp/build/perf install-bin
make: Entering directory `/git/linux/tools/perf'
  BUILD:   Doing 'make -j4' parallel build

Auto-detecting system features:
...                         dwarf: [ OFF ]
...                         glibc: [ on  ]
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
...                           bpf: [ on  ]

config/Makefile:246: No libelf found, disables 'probe' tool and BPF support in 'perf record', please install elfutils-libelf-devel/libelf-dev
config/Makefile:364: Disabling post unwind, no support found.
config/Makefile:405: No libaudit.h found, disables 'trace' tool, please install audit-libs-devel or libaudit-dev
config/Makefile:416: No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev
config/Makefile:431: slang not found, disables TUI support. Please install slang-devel or libslang-dev
config/Makefile:445: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev
config/Makefile:473: Missing perl devel files. Disabling perl scripting support, please install perl-ExtUtils-Embed/libperl-dev
config/Makefile:516: No 'Python.h' (for Python 2.x support) was found: disables Python support - please install python-devel/python-dev
config/Makefile:606: No liblzma found, disables xz kernel module decompression, please install xz-devel/liblzma-dev
config/Makefile:619: No numa.h found, disables 'perf bench numa mem' benchmark, please install numactl-devel/libnuma-devel/libnuma-dev
config/Makefile:676: Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc
  CC       /tmp/build/perf/arch/powerpc/util/header.o
  LD       /tmp/build/perf/arch/powerpc/util/libperf-in.o
  LD       /tmp/build/perf/arch/powerpc/libperf-in.o
  LD       /tmp/build/perf/arch/libperf-in.o
  LD       /tmp/build/perf/libperf-in.o
  AR       /tmp/build/perf/libperf.a
  LINK     /tmp/build/perf/perf
  INSTALL  binaries
  INSTALL  tests
  INSTALL  libexec
  INSTALL  perf-archive
  INSTALL  perf-with-kcore
  INSTALL  perf_completion-script
  INSTALL  perf-tip
make: Leaving directory `/git/linux/tools/perf'
root@df2c38ce15fe:/git/linux#

Adding this container to the set I run when testing perf csets, with this in
place we'll catch such bugs sooner in the future.

- Arnaldo
