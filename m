Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcXcN3g3gzDqYP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 08:15:00 +1100 (AEDT)
Date: Mon, 6 Mar 2017 22:14:52 +0100
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 2/3] perf: kretprobes: offset from reloc_sym if
 kernel supports it
Message-Id: <20170306221452.3368809af710e573d582689d@kernel.org>
In-Reply-To: <20170306150410.GA7467@naverao1-tp.localdomain>
References: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <fd619418f5967ca7a77e5c1b49e632862040703b.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170304094911.5f96a10a9f075b6f16fe90d3@kernel.org>
 <20170306150410.GA7467@naverao1-tp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 6 Mar 2017 20:34:10 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/03/04 09:49AM, Masami Hiramatsu wrote:
> > On Thu,  2 Mar 2017 23:25:06 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > We indicate support for accepting sym+offset with kretprobes through a
> > > line in ftrace README. Parse the same to identify support and choose the
> > > appropriate format for kprobe_events.
> > 
> > Could you give us an example of this change here? :)
> > for example, comment of commit 613f050d68a8 .
> > 
> > I think the code is OK, but we need actual example of result.
> 
> Sure :)
> As an example, without this perf patch, but with the ftrace changes:
> 
>   naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/tracing/README | grep kretprobe
>   place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>
>   naveen@ubuntu:~/linux/tools/perf$ 
>   naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -v do_open%return
>   probe-definition(0): do_open%return 
>   symbol:do_open file:(null) line:0 offset:0 return:1 lazy:(null)
>   0 arguments
>   Looking at the vmlinux_path (8 entries long)
>   Using /boot/vmlinux for symbols
>   Open Debuginfo file: /boot/vmlinux
>   Try to find probe point from debuginfo.
>   Matched function: do_open [2d0c7d8]
>   Probe point found: do_open+0
>   Matched function: do_open [35d76b5]
>   found inline addr: 0xc0000000004ba984
>   Failed to find "do_open%return",
>    because do_open is an inlined function and has no return point.
>   An error occurred in debuginfo analysis (-22).
>   Trying to use symbols.
>   Opening /sys/kernel/debug/tracing//kprobe_events write=1
>   Writing event: r:probe/do_open do_open+0
>   Writing event: r:probe/do_open_1 do_open+0
>   Added new events:
>     probe:do_open        (on do_open%return)
>     probe:do_open_1      (on do_open%return)
> 
>   You can now use it in all perf tools, such as:
> 
> 	  perf record -e probe:do_open_1 -aR sleep 1
> 
>   naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/kprobes/list
>   c000000000041370  k  kretprobe_trampoline+0x0    [OPTIMIZED]
>   c0000000004433d0  r  do_open+0x0    [DISABLED]
>   c0000000004433d0  r  do_open+0x0    [DISABLED]
> 
> And after this patch (and the subsequent powerpc patch):
> 
>   naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -v do_open%return
>   probe-definition(0): do_open%return 
>   symbol:do_open file:(null) line:0 offset:0 return:1 lazy:(null)
>   0 arguments
>   Looking at the vmlinux_path (8 entries long)
>   Using /boot/vmlinux for symbols
>   Open Debuginfo file: /boot/vmlinux
>   Try to find probe point from debuginfo.
>   Matched function: do_open [2d0c7d8]
>   Probe point found: do_open+0
>   Matched function: do_open [35d76b5]
>   found inline addr: 0xc0000000004ba984
>   Failed to find "do_open%return",
>    because do_open is an inlined function and has no return point.
>   An error occurred in debuginfo analysis (-22).
>   Trying to use symbols.
>   Opening /sys/kernel/debug/tracing//README write=0
>   Opening /sys/kernel/debug/tracing//kprobe_events write=1
>   Writing event: r:probe/do_open _text+4469712
>   Writing event: r:probe/do_open_1 _text+4956248
>   Added new events:
>     probe:do_open        (on do_open%return)
>     probe:do_open_1      (on do_open%return)
> 
>   You can now use it in all perf tools, such as:
> 
> 	  perf record -e probe:do_open_1 -aR sleep 1
> 
>   naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/kprobes/list
>   c000000000041370  k  kretprobe_trampoline+0x0    [OPTIMIZED]
>   c0000000004433d0  r  do_open+0x0    [DISABLED]
>   c0000000004ba058  r  do_open+0x8    [DISABLED]

Ok, with this usage example.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> 
> Thanks,
> - Naveen
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
