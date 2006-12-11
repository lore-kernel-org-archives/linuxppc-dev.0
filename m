Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc1-s26.bay0.hotmail.com (bay0-omc1-s26.bay0.hotmail.com
	[65.54.246.98]) by ozlabs.org (Postfix) with ESMTP id 38C8567CC0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Dec 2006 01:26:18 +1100 (EST)
Message-ID: <BAY110-F19503E49329593BA19BD5DB2D00@phx.gbl>
In-Reply-To: <457D3FFD.8000107@grandegger.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: wg@grandegger.com
Subject: Re: how to cross-compile netperf.
Date: Mon, 11 Dec 2006 14:26:16 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Dear Wolfgang,
By the Way, another problem now. If I transfer UDP packets from my PC to my 
board as "netperf -H 192.168.0.5 -t UDP_STREAM -l 30", a problem happens on 
my ML403 board and ppc 405 as:

BUG: soft lockup detected on CPU#0!
NIP: C015084C LR: C014D384 CTR: C015075C
REGS: c2d43a20 TRAP: 1001   Not tainted  (2.6.16-rc5-g51645017-dirty)
MSR: 00029030 <EE,ME,IR,DR>  CR: 24004028  XER: 20000000
TASK = c03c27b0[732] 'netserver' THREAD: c2d42000
GPR00: 00007F08 C2D43AD0 C03C27B0 C032F2D8 C032F000 C2D43BA0 00021030 
0000000A
GPR08: C3359000 03362DDF C0270000 C4000000 003C2978
NIP [C015084C] XTemac_IntrSgHandler+0xf0/0x27c
LR [C014D384] xtenet_interrupt+0x20/0x34
Call Trace:
[C2D43AD0] [C306A620] 0xc306a620 (unreliable)
[C2D43B00] [C014D384] xtenet_interrupt+0x20/0x34
[C2D43B10] [C003BB30] handle_IRQ_event+0x54/0xa8
[C2D43B40] [C003BC5C] __do_IRQ+0xd8/0x148
[C2D43B70] [C0007588] do_IRQ+0x48/0x78
[C2D43B90] [C000343C] ret_from_except+0x0/0x18
[C2D43C50] [C014E568] SgRecvHandlerBH+0x124/0x434
[C2D43C90] [C0022688] tasklet_action+0x8c/0xd0
[C2D43CB0] [C00222CC] __do_softirq+0x64/0xe0
[C2D43CD0] [C0007608] do_softirq+0x50/0x74
[C2D43CF0] [C00223E8] irq_exit+0x38/0x48
[C2D43D00] [C00075A4] do_IRQ+0x64/0x78
[C2D43D20] [C000343C] ret_from_except+0x0/0x18
[C2D43DE0] [C003E0DC] filemap_nopage+0x178/0x378
[C2D43E20] [C004C394] __handle_mm_fault+0x550/0x100c
[C2D43E80] [C000A0E8] do_page_fault+0x35c/0x578
[C2D43F40] [C0003238] handle_page_fault+0xc/0x80
Instruction dump:
73a00040 41a20028 813f0138 807f0130 39290001 913f0138 83ff012c 388001f9
7fe903a6 38a00001 4bffffd0 800b0028 <0c000000> 4c00012c 812b0020 0c090000

If I specify the time length shorter, e.g. -l 5, it will not happened. 

This never happens when using TCP.

Can anyone tell me what's the reason and how to solve this? thanks for your 
helping.

BR
Ming


>From: Wolfgang Grandegger <wg@grandegger.com>
>To: Ming Liu <eemingliu@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: how to cross-compile netperf.
>Date: Mon, 11 Dec 2006 12:24:45 +0100
>
>Ming Liu wrote:
> > Dear all,
> > Maybe my question is not proper for this maillist but I really see some
> > friends who are using netperf to measure the netowrk performance from
> > this maillist. So I ask for help here.
> > Could anyone please tell me how to cross-compile the Netperf which 
could
> > be run on my PowerPC 405 processor? I cannot find a detailed 
explanation
> > from the manual. After the downloading and untaring the package, I use
> > the command "./configure --host ppc CC=powerpc-405-linux-gnu-gcc".
> > However unfortunately it doesn't work and error " checking whether
> > setpgrp takes no argument... configure:error: cannot check setpgrp when
> > cross compiling" appears. My host system is X86_64 PC with linux OS and
> > my target system is PowerPC 405(Xilinx Virtex 4 FPGA) with linux
> > too(embedded Ml403 board from Xilinx company). In my condition, which
> > arguments shall I specify?
> > If anyone can help, I wll really appreciate a lot.
>
>$ echo "ac_cv_func_setpgrp_void=yes" > config.cache
>$ ./configure --host ppc CC=powerpc-405-linux-gnu-gcc --config-cache
>
>Wolfgang.

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn  
