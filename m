Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjfjY4WjyzF1GX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 04:08:17 +1100 (AEDT)
Date: Fri, 16 Feb 2018 14:08:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
 namhyung@kernel.org, linux-kernel@vger.kernel.org,
 brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 1/3] tools include powerpc: Grab a copy of
 arch/powerpc/include/uapi/asm/unistd.h
Message-ID: <20180216170812.GA16919@kernel.org>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
 <20180129083417.31240-2-ravi.bangoria@linux.vnet.ibm.com>
 <20180216165245.GD24436@kernel.org>
 <20180216165616.GF24436@kernel.org>
 <20180216170336.GG24436@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180216170336.GG24436@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Feb 16, 2018 at 02:03:36PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 16, 2018 at 01:56:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Feb 16, 2018 at 01:52:45PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Mon, Jan 29, 2018 at 02:04:15PM +0530, Ravi Bangoria escreveu:
> > > > Will be used for generating the syscall id/string translation table.
> > > > 
> > > > Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> > > > ---
> > > >  tools/arch/powerpc/include/uapi/asm/unistd.h | 399 +++++++++++++++++++++++++++
> > > >  tools/perf/check-headers.sh                  |   1 +
> > > >  2 files changed, 400 insertions(+)
> > > >  create mode 100644 tools/arch/powerpc/include/uapi/asm/unistd.h
> > > 
> > > Not building on a cross-compiling environment (ubuntu 16.04), I'm checking...
> > 
> > BTW, details about that environment:
> > 
> >   46    29.83 ubuntu:16.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
> 
> So, you did it just for ppc64? Because...
> 
>   46    29.83 ubuntu:16.04-x-powerpc        : FAIL powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
>   47    69.81 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
>   48    68.35 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
> 
> Its just on ppc32 that his is falling apart.

So, $(SRCARCH) maps to both powerpc and powerpc64m which will set
NO_SYSCALL_TABLE to zero, thus linking against
tools/perf/util/syscalltbl.o, which will include the generated
syscalls_64.c only for ppc64, b00m.

+++ b/tools/perf/Makefile.config
@@ -27,6 +27,8 @@ NO_SYSCALL_TABLE := 1
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
   NO_PERF_REGS := 0
+  NO_SYSCALL_TABLE := 0
+  CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
   LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
 endif
 
+++ b/tools/perf/util/syscalltbl.c
 static const char **syscalltbl_native = syscalltbl_s390_64;
+#elif defined(__powerpc64__)
+#include <asm/syscalls_64.c>
+const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_64_MAX_ID;
+static const char **syscalltbl_native = syscalltbl_powerpc_64;
 #endif
