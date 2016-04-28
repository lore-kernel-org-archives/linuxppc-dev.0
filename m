Return-Path: <acme@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwgkM15pgzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 01:30:02 +1000 (AEST)
Date: Thu, 28 Apr 2016 12:29:58 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, jolsa@redhat.com
Subject: Re: [PATCH 0/3] Add support for perf user stack dump in powerpc
Message-ID: <20160428152958.GA2730@redhat.com>
References: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
 <20160428142341.GD7880@naverao1-tp.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160428142341.GD7880@naverao1-tp.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Thu, Apr 28, 2016 at 07:53:41PM +0530, Naveen N. Rao escreveu:
> On 2016/04/28 03:01PM, Chandan Kumar wrote:
> > This patch set enables perf user stack dump on powerpc
> 
> For this patch-set:
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> I suppose that implies my testing, but nonetheless:
> Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> 
> > 
> > Example with "ls" command as user program
> > ./perf record --call-graph=dwarf,8192 ls
> > 
> > ./perf script
> > ---------8< -----
> > ..
> > ...
> > perf 12549 75938.934539:       1771 cycles:ppp: 
> >                   210d90 .perf_event_exec (/boot/vmlinux)
> >                   34b914 .load_elf_binary (/boot/vmlinux)
> >                   2dcabc .search_binary_handler (/boot/vmlinux)
> >                   2dd6f0 .do_execveat_common.isra.28 (/boot/vmlinux)
> >                   2ddcd8 .sys_execve (/boot/vmlinux)
> >                    19258 system_call (/boot/vmlinux)
> 
> To expand on this, with upstream libunwind 
> (git://git.sv.gnu.org/libunwind.git) and with debuginfo installed:
> 
> # ./perf record -e cycles -g --call-graph dwarf -- find . -iname
> '*linux*'
>  ./tests/vmlinux-kallsyms.c
> ./tests/vmlinux-kallsyms.o
> ./tests/.vmlinux-kallsyms.o.cmd
> ./util/include/linux
> [ perf record: Woken up 2 times to write data ]
> [ perf record: Captured and wrote 0.371 MB perf.data (45 samples) ]
> # ./perf script
> <snip>
> find 23858 167788.657182:     881967 cycles: 
>                   8e758c _cond_resched (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
>                   3f83bc selinux_inode_getattr (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
>                   3ee254 security_inode_getattr (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
>                   3063a4 vfs_getattr (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
>                   306530 vfs_fstatat (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
>                   306c60 sys_newfstatat (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
>                    19210 system_call (/lib/modules/4.6.0-rc3-nnr+/build/vmlinux)
>             3fffa31829a8 __fxstatat64 (/usr/lib64/libc-2.17.so)
>                 10025ac8 fts_stat.isra.2 (/usr/bin/find)
>                 10027c04 fts_read (/usr/bin/find)
>                 10003e18 find (/usr/bin/find)
>                 100035ec main (/usr/bin/find)
>             3fffa30a4580 generic_start_main.isra.0 (/usr/lib64/libc-2.17.so)
>             3fffa30a4774 __libc_start_main (/usr/lib64/libc-2.17.so)
> 
> <snip>
> 
> 
> Arnaldo, Michael,
> Can we take this through powerpc/next as well since this pretty much 
> rides on the recent perf regs work?

I haven't tested with the bits that touch the common code, have you? But
I think it should be harmless and overall this patchset looks fine, so,
if you, just in case, have tested this on a x86_64 machine and all seems
well, i.e. perf test, perf record/report with a perf-probe generated
event, to exercise this stuff, then:

Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
