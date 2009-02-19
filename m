Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (unknown [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id E0126DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 00:23:44 +1100 (EST)
Message-ID: <499D5B99.3000404@mlbassoc.com>
Date: Thu, 19 Feb 2009 06:16:09 -0700
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: BUG: MAX_STACK_TRACE_ENTRIES too low!
References: <alpine.LRH.2.00.0902191334550.15109@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0902191334550.15109@vixen.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-15
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> When running 2.6.29-rc5+ on PS3 (ppc64), I got the following BUG once during
> bootup:
> 
> | Freeing unused kernel memory: 3436k freed
> | BUG: MAX_STACK_TRACE_ENTRIES too low!
> | turning off the locking correctness validator.
> | Call Trace:
> | [c000000006e1b640] [c00000000000f850] .show_stack+0x6c/0x16c (unreliable)
> | [c000000006e1b6f0] [c00000000007cf6c] .save_trace+0xe0/0x108
> | [c000000006e1b780] [c00000000007d058] .add_lock_to_list+0xc4/0x124
> | [c000000006e1b830] [c0000000000816d0] .__lock_acquire+0x13c4/0x17c8
> | [c000000006e1b930] [c000000000081b78] .lock_acquire+0xa4/0xec
> | [c000000006e1b9f0] [c0000000003be034] ._spin_lock+0x34/0x58
> | [c000000006e1ba80] [c0000000000d3e40] .kmem_cache_free+0x84/0x1a8
> | [c000000006e1bb30] [c0000000001f9abc] .idr_remove+0x214/0x248
> | [c000000006e1bbf0] [c00000000002867c] .destroy_context+0x34/0x64
> | [c000000006e1bc80] [c00000000005008c] .__mmdrop+0x4c/0x7c
> | [c000000006e1bd10] [c00000000004de90] .finish_task_switch+0xec/0x14c
> | [c000000006e1bdb0] [c00000000004e6fc] .schedule_tail+0x2c/0xa0
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> | [c000000006e1be30] [c000000000007738] .ret_from_fork+0x4/0xcc
> 
> (There are 65 call trace lines)
> 
> After that the system continued.

It looks like the stack trace code got stuck in a loop (the last
53 entries are identical) - increasing the limit won't change this,
it would just keep more entries.

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
