Return-Path: <rostedt@goodmis.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EE692B7B63
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Sep 2009 14:08:01 +1000 (EST)
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 6C158DDD0B
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Sep 2009 14:08:00 +1000 (EST)
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
Date: Sun, 13 Sep 2009 00:07:57 -0400
Message-Id: <1252814877.26049.93.camel@gandalf.stny.rr.com>
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

I'm looking at your back dump and this really bothers me. I did a
objdump -dr arch/powerpc/kernel/entry_64.o and this is what I have:

0000000000000968 <.mod_return_to_handler>:
 968:   f8 81 ff e0     std     r4,-32(r1)
 96c:   f8 61 ff e8     std     r3,-24(r1)
 970:   f8 41 ff f0     std     r2,-16(r1)
 974:   fb e1 ff f8     std     r31,-8(r1)
 978:   7c 3f 0b 78     mr      r31,r1
 97c:   f8 21 ff 91     stdu    r1,-112(r1)
 980:   3c 80 00 00     lis     r4,0
                        982: R_PPC64_ADDR16_HIGHEST     ftrace_return_to_handler
 984:   60 84 00 00     ori     r4,r4,0
                        986: R_PPC64_ADDR16_HIGHER      ftrace_return_to_handler
 988:   78 84 07 c6     rldicr  r4,r4,32,31
 98c:   64 84 00 00     oris    r4,r4,0
                        98e: R_PPC64_ADDR16_HI  ftrace_return_to_handler
 990:   60 84 00 00     ori     r4,r4,0
                        992: R_PPC64_ADDR16_LO  ftrace_return_to_handler
 994:   e8 44 00 08     ld      r2,8(r4)
 998:   48 00 00 01     bl      998 <.mod_return_to_handler+0x30>
                        998: R_PPC64_REL24      .ftrace_return_to_handler
 99c:   60 00 00 00     nop
 9a0:   7c 68 03 a6     mtlr    r3


The bug happened at mod_return_to_handler+0x2c which is 994 above. Your
reg dump shows r4 is 0, and worse yet, looking at the code:

4e800020 f881ffe0 f861ffe8 f841fff0 fbe1fff8 7c3f0b78 f821ff91 3c800000
60840000 788407c6 64840000 60840000 <e8440008> 48126375 60000000
7c6803a6

The 64840000 60840000 shows that the linker never resolved the address
to ftrace_return_to_handle??

Something is totally messed up here.

-- Steve
