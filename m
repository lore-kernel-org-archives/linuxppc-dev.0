Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0F16C1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 02:18:21 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 20:48:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EC8E3125801E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:48:42 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBEFIDlt7274952
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:48:14 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBEFICrl015291
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:48:13 +0530
Date: Mon, 14 Dec 2015 20:47:31 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: "Wangnan (F)" <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Jiri Olsa <jolsa@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: bpf: Fix build breakage due to libbpf
Message-ID: <20151214151731.GD23726@naverao1-tp.in.ibm.com>
References: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <566EADD1.6000609@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <566EADD1.6000609@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/12/14 07:53PM, Wang Nan wrote:
> Hi Naveen,
> 
> On 2015/12/14 18:50, Naveen N. Rao wrote:
> >perf build is currently (v4.4-rc5) broken on powerpc:
> >
> >bpf.c:28:4: error: #error __NR_bpf not defined. libbpf does not support
> >your arch.
> >  #  error __NR_bpf not defined. libbpf does not support your arch.
> >     ^
> >
> >Fix this by including tools/perf/config/Makefile.arch for the proper
> >$ARCH macro. While at it, remove redundant LP64 macro definition.
> >
> >Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >---
> >  tools/lib/bpf/Makefile | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> >index 636e3dd..050e0e8 100644
> >--- a/tools/lib/bpf/Makefile
> >+++ b/tools/lib/bpf/Makefile
> >@@ -31,7 +31,8 @@ INSTALL = install
> >  DESTDIR ?=
> >  DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
> >-LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
> >+include $(srctree)/tools/perf/config/Makefile.arch
> >+
> >  ifeq ($(LP64), 1)
> >    libdir_relative = lib64
> >  else
> 
> Are you doing cross compiling? In this case you should provide an 'ARCH' to
> make
> through cmdline. For example, this is how yocto help me build perf on
> aarch64:
> 
>  $ make -C /patch/to/kernel/tools/perf O=/path/to/output \
>           CROSS_COMPILE=aarch64-oe-linux- ARCH=arm64 \
>           CC=aarch64-oe-linux-gcc  --sysroot=... AR=aarch64-oe-linux-ar  ...

I am not cross-compiling - the build error was with trying to build perf 
on ppc64le. Even with cross-compiling (and explicitly specifying $ARCH), 
Makefile.arch should still work.

> 
> If you include Makefile.arch, I think you are seeking for a 'uname -m'
> result,
> then you are not doing cross compiling, right? In this case what you need is
> providing
> a __NR_bpf entry for your platform, because in some cases that value is
> overrided because
> we have
> 
> $ find ./tools/ -name "unistd*"
> ./tools/perf/util/include/asm/unistd_64.h
> ./tools/perf/util/include/asm/unistd_32.h
> 
> You can find the reason of these two files through:
> eae7a755ee81129370c8f555b0d5672e6673735d

I thought of just defining __NR_bpf for powerpc, but it will still break 
perf build for most other architectures. Moreover, 
tools/lib/bpf/Makefile explicitly includes headers from the linux kernel 
build tree (rather than the system headers) and I thought this was 
specifically to pull in __NR_bpf, among others -- just that we were not 
properly including the right headers since $ARCH was not defined. More 
specifically:

$ make V=1
<snip>
  gcc -Wp,-MD,./.bpf.o.d,-MT,bpf.o -g -Wall -DHAVE_LIBELF_MMAP_SUPPORT 
  -DHAVE_ELF_GETPHDRNUM_SUPPORT -Wbad-function-cast 
  -Wdeclaration-after-statement -Wformat-security -Wformat-y2k 
  -Winit-self -Wmissing-declarations -Wmissing-prototypes 
  -Wnested-externs -Wno-system-headers -Wold-style-definition -Wpacked 
  -Wredundant-decls -Wshadow -Wstrict-aliasing=3 -Wstrict-prototypes 
  -Wswitch-default -Wswitch-enum -Wundef -Wwrite-strings -Wformat 
  -Werror -Wall -fPIC -I. -I/root/linux/tools/include 
  -I/root/linux/arch//include/uapi -I/root/linux/include/uapi 
  -D"BUILD_STR(s)=#s"   -c -o bpf.o bpf.c

Notice // in -I/root/linux/arch//include/uapi. Hence, my patch to ensure 
the right headers get included.

I'm thinking the explicit __NR_bpf definitions are only needed for x86 
-- since I don't see the definitions in the kernel tree headers.


Regards,
Naveen

> 
> I posted a patch by replying this mail. I think you can find it through [1]
> soon.
> I don't have PPC environment to check it. Could you please help me check
> this patch
> in your environment?
> 
> [1] http://lkml.kernel.org/g/1450092932-123588-1-git-send-email-wangnan0@huawei.com
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
