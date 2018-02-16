Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjfcD6LlpzF18C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 04:03:40 +1100 (AEDT)
Date: Fri, 16 Feb 2018 14:03:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 alexander.shishkin@linux.intel.com, jolsa@redhat.com,
 namhyung@kernel.org, linux-kernel@vger.kernel.org,
 brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 1/3] tools include powerpc: Grab a copy of
 arch/powerpc/include/uapi/asm/unistd.h
Message-ID: <20180216170336.GG24436@kernel.org>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
 <20180216165245.GD24436@kernel.org>
 <20180216165616.GF24436@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180216165616.GF24436@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Feb 16, 2018 at 01:56:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 16, 2018 at 01:52:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Jan 29, 2018 at 02:04:15PM +0530, Ravi Bangoria escreveu:
> > > Will be used for generating the syscall id/string translation table.
> > > 
> > > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> > > ---
> > >  tools/arch/powerpc/include/uapi/asm/unistd.h | 399 +++++++++++++++++++++++++++
> > >  tools/perf/check-headers.sh                  |   1 +
> > >  2 files changed, 400 insertions(+)
> > >  create mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
> > 
> > Not building on a cross-compiling environment (ubuntu 16.04), I'm checking...
> 
> BTW, details about that environment:
> 
>   46    29.83 ubuntu:16.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609

So, you did it just for ppc64? Because...

  46    29.83 ubuntu:16.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  47    69.81 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  48    68.35 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609

Its just on ppc32 that his is falling apart.
 
>  
> >   CC       /tmp/build/perf/util/syscalltbl.o
> > util/syscalltbl.c: In function 'syscalltbl__init_native':
> > util/syscalltbl.c:64:19: error: 'syscalltbl_native_max_id' undeclared (first use in this function)
> >   for (i = 0; i <= syscalltbl_native_max_id; ++i)
> >                    ^
> > util/syscalltbl.c:64:19: note: each undeclared identifier is reported only once for each function it appears in
> > util/syscalltbl.c:65:7: error: 'syscalltbl_native' undeclared (first use in this function)
> >    if (syscalltbl_native[i])
> >        ^
> > util/syscalltbl.c: In function 'syscalltbl__name':
> > util/syscalltbl.c:105:15: error: 'syscalltbl_native_max_id' undeclared (first use in this function)
> >   return id <= syscalltbl_native_max_id ? syscalltbl_native[id]: NULL;
> >                ^
> > util/syscalltbl.c:105:42: error: 'syscalltbl_native' undeclared (first use in this function)
> >   return id <= syscalltbl_native_max_id ? syscalltbl_native[id]: NULL;
> >                                           ^
> > util/syscalltbl.c:106:1: error: control reaches end of non-void function [-Werror=return-type]
> >  }
> >  ^
> > cc1: all warnings being treated as errors
> > mv: cannot stat '/tmp/build/perf/util/.syscalltbl.o.tmp': No such file or directory
> > /git/linux/tools/build/Makefile.build:96: recipe for target '/tmp/build/perf/util/syscalltbl.o' failed
> > make[4]: *** [/tmp/build/perf/util/syscalltbl.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> >   CC       /tmp/build/perf/tests/sample-parsing.o
> >   CC       /tmp/build/perf/tests/parse-no-sample-id-all.o
> >   CC       /tmp/build/perf/tests/kmod-path.o
> >   CC       /tmp/build/perf/tests/thread-map.o
> >   CC       /tmp/build/perf/tests/llvm.o
> >   CC       /tmp/build/perf/tests/bpf.o
> >   CC       /tmp/build/perf/tests/topology.o
> >   CC       /tmp/build/perf/tests/mem.o
> >   CC       /tmp/build/perf/tests/cpumap.o
> >   CC       /tmp/build/perf/tests/stat.o
> > /git/linux/tools/build/Makefile.build:139: recipe for target 'util' failed
> > make[3]: *** [util] Error 2
> > Makefile.perf:629: recipe for target '/tmp/build/perf/libperf-in.o' failed
> > make[2]: *** [/tmp/build/perf/libperf-in.o] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >   CC       /tmp/build/perf/tests/event_update.o
