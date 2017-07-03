Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1CXv4lC8zDr4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 13:38:55 +1000 (AEST)
Date: Mon, 3 Jul 2017 12:38:51 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shuah
 Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] selftests/ftrace: Add a testcase for kprobe
 event naming
Message-Id: <20170703123851.3756a6c81e9e6faef8a63eb9@kernel.org>
In-Reply-To: <0f4f7b1d8bdcb068245ebb791845a0bc08e91921.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
 <0f4f7b1d8bdcb068245ebb791845a0bc08e91921.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 29 Jun 2017 19:05:39 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Add a testcase for kprobe event naming. This testcase
> checks whether the kprobe events can automatically ganerate
> its event name on normal function and dot-suffixed function.
> Also it checks whether the kprobe events can correctly
> define new event with given event name and group name.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> [Updated tests to use vfs_read and symbols with '.isra.',
> added check for kprobe_events and a command to clear it on exit]
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  .../ftrace/test.d/kprobe/kprobe_eventname.tc       | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> new file mode 100644
> index 000000000000..182e5a78ef4b
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_eventname.tc
> @@ -0,0 +1,32 @@
> +#!/bin/sh
> +# description: Kprobe event auto/manual naming
> +
> +[ -f kprobe_events ] || exit_unsupported # this is configurable
> +
> +disable_events
> +echo > kprobe_events
> +
> +:;: "Add an event on function without name" ;:
> +
> +FUNC=`grep " [tT] .*vfs_read$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`
> +echo p $FUNC > kprobe_events
> +FUNC_NAME=`echo $FUNC | tr ".:" "_"`
> +test -d events/kprobes/p_${FUNC_NAME}_0 || exit_failure
> +
> +:;: "Add an event on function with new name" ;:
> +
> +echo p:event1 $FUNC > kprobe_events
> +test -d events/kprobes/event1 || exit_failure
> +
> +:;: "Add an event on function with new name and group" ;:
> +
> +echo p:kprobes2/event2 $FUNC > kprobe_events
> +test -d events/kprobes2/event2 || exit_failure
> +
> +:;: "Add an event on dot function without name" ;:
> +
> +FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "`

Since in some case we may not be able to find the function(e.g. build with old gcc or not optimized), we should check this is exist. I suggested to return UNRESOLVED for that case instead of FAIL, as below.

FUNC=`grep -m 10 " [tT] .*\.isra\..*$" /proc/kallsyms | tail -n 1 | cut -f 3 -d " "` || exit_unresolved

Thank you,

> +echo p $FUNC > kprobe_events
> +EVENT=`grep $FUNC kprobe_events | cut -f 1 -d " " | cut -f 2 -d:` || exit_failure
> +test -d events/$EVENT || exit_failure
> +echo > kprobe_events
> -- 
> 2.13.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
