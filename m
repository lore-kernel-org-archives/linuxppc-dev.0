Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0027.hostedemail.com
 [216.40.44.27])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvPHr4bQMzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 23:36:07 +1000 (AEST)
Date: Tue, 26 Apr 2016 09:36:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Michael
 Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] ftrace: Match dot symbols when searching functions
 on ppc64
Message-ID: <20160426093601.72b17896@gandalf.local.home>
In-Reply-To: <1461621374-14408-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1461621374-14408-1-git-send-email-bauerman@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 25 Apr 2016 18:56:14 -0300
Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:

> In the ppc64 big endian ABI, function symbols point to function
> descriptors. The symbols which point to the function entry points
> have a dot in front of the function name. Consequently, when the
> ftrace filter mechanism searches for the symbol corresponding to
> an entry point address, it gets the dot symbol.
> 
> As a result, ftrace filter users have to be aware of this ABI detail on
> ppc64 and prepend a dot to the function name when setting the filter.
> 
> The perf probe command insulates the user from this by ignoring the dot
> in front of the symbol name when matching function names to symbols,
> but the sysfs interface does not. This patch makes the ftrace filter
> mechanism do the same when searching symbols.
> 
> Fixes the following failure in ftracetest's kprobe_ftrace.tc:
> 
>   .../kprobe_ftrace.tc: line 9: echo: write error: Invalid argument
> 
> That failure is on this line of kprobe_ftrace.tc:
> 
>   echo _do_fork > set_ftrace_filter
> 
> This is because there's no _do_fork entry in the functions list:
> 
>   # cat available_filter_functions | grep _do_fork
>   ._do_fork
> 
> This change introduces no regressions on the perf and ftracetest
> testsuite results.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---

Acked-by: Steven Rostedt <rostedt@goodmis.org>

This can go through the ppc tree.

-- Steve
