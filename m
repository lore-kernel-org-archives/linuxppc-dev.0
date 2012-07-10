Return-Path: <blofeldus@yahoo.com>
Received: from nm3.bullet.mail.bf1.yahoo.com (nm3.bullet.mail.bf1.yahoo.com
 [98.139.212.162]) by ozlabs.org (Postfix) with SMTP id 0F9552C01FA
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2012 04:55:32 +1000 (EST)
Message-ID: <1341946130.68629.YahooMailClassic@web161302.mail.bf1.yahoo.com>
Date: Tue, 10 Jul 2012 11:48:50 -0700 (PDT)
From: roger blofeld <blofeldus@yahoo.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
To: Gerhard Pircher <gerhard_pircher@gmx.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1341267617.2588.51.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--- On Mon, 7/2/12, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Subject: Re: [git pull] Please pull powerpc.git merge branch
> To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
> Cc: "linuxppc-dev list" <linuxppc-dev@ozlabs.org>
> Date: Monday, July 2, 2012, 3:20 PM
> On Mon, 2012-07-02 at 23:38 +0200,
> Gerhard Pircher wrote:
> > 
> > What about this fix:?
> > 
> > http://patchwork.ozlabs.org/patch/166346/
> > 
> > At least I can't see it in the log...
> 
> The module fix went in. The ftrace patch, well, it's
> untested and we
> don't even know if we have a problem with mcount yet, so no,
> I haven't
> merged it yet.
> 
> Cheers,
> Ben.
> 
> 

I have had a chance to test this patch. Before it is applied I get the following message when loading a module:

Not a trampoline
------------[ cut here ]------------
WARNING: at /src/git/linux-powerpc/kernel/trace/ftrace.c:1583
Modules linked in: gpio_w1_transport(O+)
NIP: c008129c LR: c0082138 CTR: c021d744
REGS: c532dd80 TRAP: 0700   Tainted: G           O  (3.4.3-00002-g23fc8c3)
MSR: 00029032 <EE,ME,IR,DR,RI>  CR: 22082282  XER: 20000000
TASK = c5256900[363] 'insmod' THREAD: c532c000
GPR00: 00000001 c532de30 c5256900 ffffffea c907b008 00000000 c046befc 20747261
GPR08: c046be40 c045c862 00008000 00000000 22082224 10019fdc 00000000 100f0000
GPR16: 100f5678 100dc70c 00000000 eac3ec00 00000000 c0011bb0 c046890c 00000000
GPR24: c907b008 c70d8f80 c0443d0c 00000000 c5338000 0000000c c907b008 c049a910
NIP [c008129c] ftrace_bug+0xc0/0x25c
LR [c0082138] ftrace_process_locs+0x47c/0x608
Call Trace:
[c532de30] [c008fe04] ftrace_now+0x38/0x78 (unreliable)
[c532de50] [c0082138] ftrace_process_locs+0x47c/0x608
[c532dea0] [c008232c] ftrace_module_notify+0x68/0x7c
[c532deb0] [c004cd80] notifier_call_chain+0x90/0xe0
[c532dee0] [c004d27c] __blocking_notifier_call_chain+0x68/0x94
[c532df10] [c004d2cc] blocking_notifier_call_chain+0x24/0x34
[c532df20] [c0073b38] sys_init_module+0xa0/0x1e0
[c532df40] [c0011254] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff5d694
    LR = 0x10000cd4
Instruction dump:
90090008 48294b71 3c60c03c 7fc4f378 7fc5f378 3863874c 48294b5d 48000188
3d20c046 3929c862 88090003 68000001 <0f000000> 2f800000 409e0148 3d20c001
---[ end trace aaa9b56024f9d2b9 ]---
ftrace failed to modify [<c907b008>] gpio_w1_reset_bus+0x8/0xc0 [gpio_w1_transport]
 actual: 48:00:04:99

and the trace file dump results in:

# tracer: nop
#
# WARNING: FUNCTION TRACING IS CORRUPTED
#          MAY BE MISSING FUNCTION EVENTS        
# entries-in-buffer/entries-written: 0/0   #P:1
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |


after the patch is applied I get no messages on module loading and ftrace no longer complains, and I can trace my module's functions.

So I can add

Tested-By: Roger Blofeld <blofeldus@yahoo.com>

-rb
