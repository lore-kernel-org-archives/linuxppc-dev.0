Return-Path: <wangnan0@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5687C1A0C57
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 23:03:57 +1100 (AEDT)
Message-ID: <566EADD1.6000609@huawei.com>
Date: Mon, 14 Dec 2015 19:53:53 +0800
From: "Wangnan (F)" <wangnan0@huawei.com>
MIME-Version: 1.0
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "Arnaldo Carvalho de
 Melo" <acme@kernel.org>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa
 <jolsa@redhat.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] perf: bpf: Fix build breakage due to libbpf
References: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Naveen,

On 2015/12/14 18:50, Naveen N. Rao wrote:
> perf build is currently (v4.4-rc5) broken on powerpc:
>
> bpf.c:28:4: error: #error __NR_bpf not defined. libbpf does not support
> your arch.
>   #  error __NR_bpf not defined. libbpf does not support your arch.
>      ^
>
> Fix this by including tools/perf/config/Makefile.arch for the proper
> $ARCH macro. While at it, remove redundant LP64 macro definition.
>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>   tools/lib/bpf/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 636e3dd..050e0e8 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -31,7 +31,8 @@ INSTALL = install
>   DESTDIR ?=
>   DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
>   
> -LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
> +include $(srctree)/tools/perf/config/Makefile.arch
> +
>   ifeq ($(LP64), 1)
>     libdir_relative = lib64
>   else

Are you doing cross compiling? In this case you should provide an 'ARCH' 
to make
through cmdline. For example, this is how yocto help me build perf on
aarch64:

  $ make -C /patch/to/kernel/tools/perf O=/path/to/output \
           CROSS_COMPILE=aarch64-oe-linux- ARCH=arm64 \
           CC=aarch64-oe-linux-gcc  --sysroot=... 
AR=aarch64-oe-linux-ar  ...

If you include Makefile.arch, I think you are seeking for a 'uname -m' 
result,
then you are not doing cross compiling, right? In this case what you 
need is providing
a __NR_bpf entry for your platform, because in some cases that value is 
overrided because
we have

$ find ./tools/ -name "unistd*"
./tools/perf/util/include/asm/unistd_64.h
./tools/perf/util/include/asm/unistd_32.h

You can find the reason of these two files through: 
eae7a755ee81129370c8f555b0d5672e6673735d

I posted a patch by replying this mail. I think you can find it through 
[1] soon.
I don't have PPC environment to check it. Could you please help me check 
this patch
in your environment?

[1] 
http://lkml.kernel.org/g/1450092932-123588-1-git-send-email-wangnan0@huawei.com 
