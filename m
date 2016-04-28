Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwfGB6yPfzDqgY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 00:24:02 +1000 (AEST)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 19:53:58 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 333AEE0062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:56:51 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3SENtVd25755652
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:53:56 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3SENs4A023258
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:53:55 +0530
Date: Thu, 28 Apr 2016 19:53:41 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, acme@redhat.com, hemant@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, jolsa@redhat.com
Subject: Re: [PATCH 0/3] Add support for perf user stack dump in powerpc
Message-ID: <20160428142341.GD7880@naverao1-tp.in.ibm.com>
References: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/04/28 03:01PM, Chandan Kumar wrote:
> This patch set enables perf user stack dump on powerpc

For this patch-set:
Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

I suppose that implies my testing, but nonetheless:
Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

> 
> Example with "ls" command as user program
> ./perf record --call-graph=dwarf,8192 ls
> 
> ./perf script
> ---------8< -----
> ..
> ...
> perf 12549 75938.934539:       1771 cycles:ppp: 
>                   210d90 .perf_event_exec (/boot/vmlinux)
>                   34b914 .load_elf_binary (/boot/vmlinux)
>                   2dcabc .search_binary_handler (/boot/vmlinux)
>                   2dd6f0 .do_execveat_common.isra.28 (/boot/vmlinux)
>                   2ddcd8 .sys_execve (/boot/vmlinux)
>                    19258 system_call (/boot/vmlinux)

To expand on this, with upstream libunwind 
(git://git.sv.gnu.org/libunwind.git) and with debuginfo installed:

# ./perf record -e cycles -g --call-graph dwarf -- find . -iname
'*linux*'
 ./tests/vmlinux-kallsyms.c
./tests/vmlinux-kallsyms.o
./tests/.vmlinux-kallsyms.o.cmd
./util/include/linux
[ perf record: Woken up 2 times to write data ]
[ perf record: Captured and wrote 0.371 MB perf.data (45 samples) ]
# ./perf script
<snip>
find 23858 167788.657182:     881967 cycles: 
                  8e758c _cond_resched (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
                  3f83bc selinux_inode_getattr (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
                  3ee254 security_inode_getattr (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
                  3063a4 vfs_getattr (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
                  306530 vfs_fstatat (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
                  306c60 sys_newfstatat (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
                   19210 system_call (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
            3fffa31829a8 __fxstatat64 (/usr/lib64/libc-2.17.so)
                10025ac8 fts_stat.isra.2 (/usr/bin/find)
                10027c04 fts_read (/usr/bin/find)
                10003e18 find (/usr/bin/find)
                100035ec main (/usr/bin/find)
            3fffa30a4580 generic_start_main.isra.0 (/usr/lib64/libc-2.17.so)
            3fffa30a4774 __libc_start_main (/usr/lib64/libc-2.17.so)

<snip>


Arnaldo, Michael,
Can we take this through powerpc/next as well since this pretty much 
rides on the recent perf regs work?

- Naveen
