Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.226])
 by lists.ozlabs.org (Postfix) with ESMTP id CB7381A0F01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 23:25:44 +1000 (AEST)
Date: Fri, 19 Jun 2015 09:26:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Torsten Duwe <duwe@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/4] ppc64 FTRACE_WITH_REGS implementation
Message-ID: <20150619092625.17e5c9a1@grimm.local.home>
In-Reply-To: <20150618162107.GB6546@lst.de>
References: <20150611095338.GA4492@lst.de> <20150618161727.GA6546@lst.de>
 <20150618162107.GB6546@lst.de>
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

On Thu, 18 Jun 2015 18:21:07 +0200
Torsten Duwe <duwe@lst.de> wrote:

> Implement FTRACE_WITH_REGS for powerpc64, on ELF ABI v2.
> Initial work started by Vojtech Pavlik, used with permission.
> 
>   * arch/powerpc/kernel/entry_64.S:
>     - enhance _mcount with a stub to test (ftrace_trace_function == &ftrace_stub)
>       as suggested in Documentation/trace/ftrace-design.txt
>       (for reference only, patched out at runtime)
>     - Implement an effective ftrace_caller that works from within the kernel
>       binary as well as from modules.
>   * arch/powerpc/kernel/ftrace.c:
>     - be prepared to deal with ppc64 ELV ABI v2, especially calls to _mcount
>       that result from gcc -mprofile-kernel
>   * arch/powerpc/kernel/module_64.c:
>     - do not save the TOC pointer on the trampoline when the destination
>       is ftrace_caller. This trampoline jump happens from a function prologue
>       before a new stack frame is set up, so bad things may happen otherwise...
>     - relax is_module_trampoline() to recognise the modified trampoline.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> --

FYI, the standard notation after the change log is '---' not '--'. That
way git will chop off this from the change log. When I did a git am -s
on this patch I had:

    Signed-off-by: Torsten Duwe <duwe@suse.de>
    --
     arch/powerpc/include/asm/ftrace.h |    5 +
     arch/powerpc/kernel/entry_64.S    |  112 +++++++++++++++++++++++++++++++-------
     arch/powerpc/kernel/ftrace.c      |   67 ++++++++++++++++++++--
     arch/powerpc/kernel/module_64.c   |   33 ++++++++++-
     4 files changed, 186 insertions(+), 31 deletions(-)
    --
    Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


>  arch/powerpc/include/asm/ftrace.h |    5 +
>  arch/powerpc/kernel/entry_64.S    |  112 +++++++++++++++++++++++++++++++-------
>  arch/powerpc/kernel/ftrace.c      |   67 ++++++++++++++++++++--
>  arch/powerpc/kernel/module_64.c   |   33 ++++++++++-
>  4 files changed, 186 insertions(+), 31 deletions(-)
> --
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> index e366187..6111191 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
