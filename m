Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDF691A2DED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:41:35 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 15 Dec 2015 17:11:32 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 88271E0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 17:12:22 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBFBfSMh58589274
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 17:11:28 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBFBfSUC005296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 17:11:28 +0530
Date: Tue, 15 Dec 2015 17:10:46 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Wang Nan <wangnan0@huawei.com>
Cc: acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH v4] perf: bpf: Fix build breakage due to libbpf
Message-ID: <20151215114046.GG23726@naverao1-tp.in.ibm.com>
References: <1450150557-127942-4-git-send-email-wangnan0@huawei.com>
 <1450169473-137129-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450169473-137129-1-git-send-email-wangnan0@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/12/15 08:51AM, Wang Nan wrote:
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> 
> perf build is currently (v4.4-rc5) broken on powerpc:
> 
> bpf.c:28:4: error: #error __NR_bpf not defined. libbpf does not support
> your arch.
>  #  error __NR_bpf not defined. libbpf does not support your arch.
>     ^
> 
> Fix this by including tools/scripts/Makefile.arch for the proper
> $ARCH macro. While at it, remove redundant LP64 macro definition.
> 
> Also, since libbpf require $(srctree) now, detect the path of
> srctree like perf.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> 
> v3 -> v4: Add srctree detector code so directly run 'make' in libbpf
>           directory would not cause error.

Good catch!

Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>


> 
> ---
>  tools/lib/bpf/Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 636e3dd..0b6e013 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -6,6 +6,12 @@ BPF_EXTRAVERSION = 1
> 
>  MAKEFLAGS += --no-print-directory
> 
> +ifeq ($(srctree),)
> +srctree := $(patsubst %/,%,$(dir $(shell pwd)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +srctree := $(patsubst %/,%,$(dir $(srctree)))
> +#$(info Determined 'srctree' to be $(srctree))
> +endif
> 
>  # Makefiles suck: This macro sets a default value of $(2) for the
>  # variable named by $(1), unless the variable has been set by
> @@ -31,7 +37,8 @@ INSTALL = install
>  DESTDIR ?=
>  DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
> 
> -LP64 := $(shell echo __LP64__ | ${CC} ${CFLAGS} -E -x c - | tail -n 1)
> +include $(srctree)/tools/scripts/Makefile.arch
> +
>  ifeq ($(LP64), 1)
>    libdir_relative = lib64
>  else
> -- 
> 1.8.3.4
> 
