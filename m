Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcQ4p63JtzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 03:20:42 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26GDmTx047014
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 11:20:39 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2917d3kn3c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 11:20:39 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 21:50:34 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 71AE7125804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:50:46 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26GKRDT15728796
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:50:27 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26GKU6r002412
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:50:30 +0530
Date: Mon, 6 Mar 2017 21:50:29 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/3] perf: kretprobes: offset from reloc_sym if kernel
 supports it
References: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <fd619418f5967ca7a77e5c1b49e632862040703b.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170304094911.5f96a10a9f075b6f16fe90d3@kernel.org>
 <20170304113551.6a008b969a3ed713729cbd57@kernel.org>
 <20170304133405.176da43d40cec7cb00e757e1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170304133405.176da43d40cec7cb00e757e1@kernel.org>
Message-Id: <20170306162029.GB7467@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/04 01:34PM, Masami Hiramatsu wrote:
> On Sat, 4 Mar 2017 11:35:51 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Sat, 4 Mar 2017 09:49:11 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > On Thu,  2 Mar 2017 23:25:06 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > > 
> > > > We indicate support for accepting sym+offset with kretprobes through a
> > > > line in ftrace README. Parse the same to identify support and choose the
> > > > appropriate format for kprobe_events.
> > > 
> > > Could you give us an example of this change here? :)
> > > for example, comment of commit 613f050d68a8 .
> > > 
> > > I think the code is OK, but we need actual example of result.
> > 
> > Hi Naveen,
> > 
> > I've tried following commands
> > 
> > $ grep "[Tt] user_read$" /proc/kallsyms  
> > 0000000000000000 T user_read
> > 0000000000000000 t user_read
> > $ sudo ./perf probe -D user_read%return
> > r:probe/user_read _text+3539616
> > r:probe/user_read_1 _text+3653408
> > 
> > OK, looks good. However, when I set the retprobes, I got an error.
> > 
> > $ sudo ./perf probe -a user_read%return
> > Failed to write event: Invalid argument
> >   Error: Failed to add events.
> > 
> > And kernel rejected that.
> > 
> > $ dmesg -k | tail -n 1
> > [  850.315068] Given offset is not valid for return probe.
> > 
> > Hmm, curious..
> 
> Ah, I see.
> 
> static int create_trace_kprobe(int argc, char **argv)
> ...
>         } else {
>                 /* a symbol specified */
>                 symbol = argv[1];
>                 /* TODO: support .init module functions */
>                 ret = traceprobe_split_symbol_offset(symbol, &offset);
>                 if (ret) {
>                         pr_info("Failed to parse symbol.\n");
>                         return ret;
>                 }
>                 if (offset && is_return &&
>                     !arch_function_offset_within_entry(offset)) {
>                         pr_info("Given offset is not valid for return probe.\n");
>                         return -EINVAL;
>                 }
>         }
> 
> So, actually, traceprobe_split_symbol_offset() just split out symbol
> and offset from symbol string (e.g. "_text+3539616").
> So, you should use kallsyms_lookup_size_offset() here again to check
> offset.

Ah, nice catch! I should have tested Steven's patch...

> 
> Please try attached patch (I've already tested on x86-64).
> 
> $ sudo ./perf probe -a user_read%return
> Added new events:
>   probe:user_read      (on user_read%return)
>   probe:user_read_1    (on user_read%return)
> 
> You can now use it in all perf tools, such as:
> 
> 	perf record -e probe:user_read_1 -aR sleep 1
> 
> $ sudo ./perf probe -l
>   probe:user_read      (on user_read%return@security/keys/user_defined.c)
>   probe:user_read_1    (on user_read%return@selinux/ss/policydb.c)
> $ sudo cat /sys/kernel/debug/kprobes/list
> ffffffff9637bf70  r  user_read+0x0    [DISABLED][FTRACE]
> ffffffff963602f0  r  user_read+0x0    [DISABLED][FTRACE]

Thanks, I will test this.


- Naveen
