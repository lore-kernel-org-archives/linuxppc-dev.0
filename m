Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4FDCFB6F56
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Sep 2009 05:42:49 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id B262EDDD01
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 05:42:47 +1000 (EST)
Subject: Re: [FTRACE] Enabling function_graph causes OOPS
From: Steven Rostedt <rostedt@goodmis.org>
To: Sachin Sant <sachinp@in.ibm.com>
In-Reply-To: <4AA74AE2.5090001@in.ibm.com>
References: <4A5C5D65.3030906@in.ibm.com>
	<alpine.DEB.2.00.0907141844540.32740@gandalf.stny.rr.com>
	<4A76BE81.4080707@in.ibm.com>
	<1252458303.20985.10.camel@gandalf.stny.rr.com>
	<4AA74AE2.5090001@in.ibm.com>
Content-Type: text/plain
Date: Wed, 09 Sep 2009 15:42:44 -0400
Message-Id: <1252525364.27001.32.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: rostedt@goodmis.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-09 at 11:57 +0530, Sachin Sant wrote:
> Steven Rostedt wrote:
> > I'm going through old email, and I found this. Do you still see this
> > error. I don't recall seeing it myself.
> >   
> I can still recreate this with 31-rc9. When i enable tracing
> with function_graph i notice the following oops. This happens
> only once. Later if i try to enable/disable tracing i don't
> get this oops message. This behavior is observed only with
> function_graph. Other tracers work fine.
> 
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=1024 NUMA pSeries
> Modules linked in: ipv6 fuse loop dm_mod sr_mod ehea ibmveth sg cdrom sd_mod crc_t10dif ibmvscsic scsi_transport_srp scsi_tgt scsi_mod
> NIP: c000000000008f30 LR: c000000000008f04 CTR: 80000000000f6d68
> REGS: c00000003e98f560 TRAP: 0300   Not tainted  (2.6.31-rc9)
> MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000422  XER: 00000020
> DAR: 0000000000000008, DSISR: 0000000040000000
> TASK = c00000003e953b20[2483] 'irqbalance' THREAD: c00000003e98c000 CPU: 1
> GPR00: c000000000008f04 c00000003e98f7e0 d00000000117ed38 0000000000000000
> GPR04: 0000000000000000 0000000066000000 00000000000010bf 0000000000000000
> GPR08: 0000000000000000 800000010021bb40 00000000000000ff 800000010021bb60
> GPR12: 0000000000000002 c000000001032800 0000000000000000 ffffffffeffdff68
> GPR16: 00000fffa39fd6a0 00000fffa39e6c38 c00000003ebe9c38 fffffffffffff000
> GPR20: c00000002a6cf980 c00000003e98fdf8 c00000003e98fba8 00000fffa1740000
> GPR24: fffffffffffff000 8001000003000000 ffe0000000000000 0000000000000009
> GPR28: c00000003db40000 0000000000020000 d00000000117da78 c00000003e98f850
> NIP [c000000000008f30] .mod_return_to_handler+0x2c/0x64
> LR [c000000000008f04] .mod_return_to_handler+0x0/0x64
> Call Trace:
> [c00000003e98f7e0] [c00000002a6cf980] 0xc00000002a6cf980 (unreliable)
> [c00000003e98f850] [c000000000008f04] .mod_return_to_handler+0x0/0x64
> [c00000003e98f900] [c000000000008f04] .mod_return_to_handler+0x0/0x64
> [c00000003e98f9a0] [c000000000008f04] .mod_return_to_handler+0x0/0x64

Ah, seems the bug happens to be in the module handling. Does the call
back always have .mod_return_to_handler?

This doesn't surprise me any. The module code is a bit harry, and
function graph does some crazy crap with it.

-- Steve

> [c00000003e98fa30] [c000000000008ed0] .return_to_handler+0x0/0x34 (.bad_page_fault+0xc8/0xe8)
> [c00000003e98fb30] [c000000000008ed0] .return_to_handler+0x0/0x34 (handle_page_fault+0x3c/0x5c)
> [c00000003e98fc20] [c000000000008ed0] .return_to_handler+0x0/0x34 (.ehea_h_query_ehea_port+0x74/0x9c [ehea])
> [c00000003e98fcd0] [c000000000008ed0] .return_to_handler+0x0/0x34 (.ehea_get_stats+0xa0/0x1d0 [ehea])
> [c00000003e98fd80] [c000000000008ed0] .return_to_handler+0x0/0x34 (.dev_get_stats+0x50/0xec)
> [c00000003e98fe30] [c000000000008ed0] .return_to_handler+0x0/0x34 (.dev_seq_show+0x5c/0x140)
> Instruction dump:
> 4e800020 f881ffe0 f861ffe8 f841fff0 fbe1fff8 7c3f0b78 f821ff91 3c800000
> 60840000 788407c6 64840000 60840000 <e8440008> 48126375 60000000 7c6803a6
> ---[ end trace bb43efc994aed790 ]---
> 
> function_graph traces are recorded and can be retrieved using
> /sys/kernel/debug/tracing/trace.
> 
> 1)   3.936 us    |                        }
> 1)               |                        .release_console_sem() {
> 1)   0.594 us    |                          ._spin_lock_irqsave();
> 1)   0.560 us    |                          ._call_console_drivers();
> 1)   0.580 us    |                          ._call_console_drivers();
> 1)   0.582 us    |                          ._spin_lock_irqsave();
> 1)               |                          .up() {
> 1)   0.592 us    |                            ._spin_lock_irqsave();
> 1)   0.556 us    |                            ._spin_unlock_irqrestore();
> 1)   2.842 us    |                          }
> 1)   0.588 us    |                          ._spin_unlock_irqrestore();
> 1)   9.750 us    |                        }
> 1) + 75.274 us   |                      }
> 1)               |                      .die() {
> 1)               |                        .oops_enter() {
> 
> Thanks
> -Sachin
> 
