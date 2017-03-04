Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZqx938DXzDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Mar 2017 13:38:37 +1100 (AEDT)
Date: Sat, 4 Mar 2017 11:38:25 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar
 <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 2/3] perf: kretprobes: offset from reloc_sym if
 kernel supports it
Message-Id: <20170304113825.bda12eb55495bfe8018638f7@kernel.org>
In-Reply-To: <20170304113551.6a008b969a3ed713729cbd57@kernel.org>
References: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <fd619418f5967ca7a77e5c1b49e632862040703b.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170304094911.5f96a10a9f075b6f16fe90d3@kernel.org>
 <20170304113551.6a008b969a3ed713729cbd57@kernel.org>
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

On Sat, 4 Mar 2017 11:35:51 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Sat, 4 Mar 2017 09:49:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
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
> Hi Naveen,
> 
> I've tried following commands
> 
> $ grep "[Tt] user_read$" /proc/kallsyms  
> 0000000000000000 T user_read
> 0000000000000000 t user_read
> $ sudo ./perf probe -D user_read%return
> r:probe/user_read _text+3539616
> r:probe/user_read_1 _text+3653408
> 
> OK, looks good. However, when I set the retprobes, I got an error.
> 
> $ sudo ./perf probe -a user_read%return
> Failed to write event: Invalid argument
>   Error: Failed to add events.
> 
> And kernel rejected that.
> 
> $ dmesg -k | tail -n 1
> [  850.315068] Given offset is not valid for return probe.
> 
> Hmm, curious..
> 
> I tried normal probes
> 
> $ sudo ./perf probe -D user_read
> p:probe/user_read _text+3539616
> p:probe/user_read_1 _text+3653408
> $ sudo ./perf probe -a user_read
> Added new events:
>   probe:user_read      (on user_read)
>   probe:user_read_1    (on user_read)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:user_read_1 -aR sleep 1
> 
> It works!
> 
> $ sudo ./perf probe -l
>   probe:user_read      (on user_read@security/keys/user_defined.c)
>   probe:user_read_1    (on user_read@selinux/ss/policydb.c)
> $ sudo cat /sys/kernel/debug/kprobes/list
> ffffffff9237bf20  k  user_read+0x0    [DISABLED][FTRACE]
> ffffffff923602a0  k  user_read+0x0    [DISABLED][FTRACE]
> 
> So, the both "_text+3539616" and "_text+3653408" are correctly located
> on the entry address of user_read functions. It seems kernel-side
> symbol+offset check is wrong.

FYI, without this patch, perf probe returns same place for same-name
functions. So this patch itself looks good.

$ sudo ./perf probe -D user_read%return
r:probe/user_read user_read+0
r:probe/user_read_1 user_read+0


Thanks,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
