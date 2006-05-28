Return-Path: <g.liakhovetski@gmx.de>
Date: Mon, 29 May 2006 00:34:08 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Linuxppc-dev@ozlabs.org
Subject: Re: TI_LOCAL_FLAGS definition wrong?
In-Reply-To: <Pine.LNX.4.60.0605212033480.11693@poirot.grange>
Message-ID: <Pine.LNX.4.60.0605290029020.4491@poirot.grange>
References: <Pine.LNX.4.60.0605212033480.11693@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 21 May 2006, Guennadi Liakhovetski wrote:

> Is this define in arch/ppc/kernel/asm-offsets.c (as of 2.6.17-rc3):
> 
> 	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, flags));
> 
> correct? Or should it be local_flags? Or is it already fixed in later 
> versions?

I think, putting LOCAL_FLAGS on flags as above causes oopses on strace as 
below. local_flags fixes it. It's on 2.6.17-rc3. Will double-check on rc5 
tomorrow, but looks like it hasn't changed.

Thanks
Guennadi
---
Guennadi Liakhovetski

Oops: kernel access of bad area, sig: 11 [#1]
NIP: C020DE40 LR: C020DE2C CTR: 00000000
REGS: c5821d80 TRAP: 0300   Not tainted  (2.6.17-rc3-kuroboxHG)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22000082  XER: 00000000
DAR: 0000000C, DSISR: 20000000
TASK = c7d307d0[1791] 'buttond' THREAD: c5820000
GPR00: 00000000 C5821E30 C7D307D0 00000000 C000B720 00000000 00001154 00000000 
GPR08: 005FB283 C02C6240 22020488 00001032 0000ED12 100424C0 10010000 7FF6FC70 
GPR16: 10040000 10040000 100C9BC8 C02D0000 C02C0000 C02C6240 C5820000 C7D308D8 
GPR24: 000086E2 C02C6240 00000075 000000B6 C02B1060 C02B1C60 00000000 00800000 
NIP [C020DE40] schedule+0x318/0x62c
LR [C020DE2C] schedule+0x304/0x62c
Call Trace:
[C5821E30] [C020DE2C] schedule+0x304/0x62c (unreliable)
[C5821E70] [C00235E0] ptrace_stop+0x98/0xf4
[C5821E80] [C00236AC] ptrace_notify+0x70/0x90
[C5821F20] [C0008D74] do_syscall_trace+0x28/0x68
[C5821F30] [C0008DF0] do_syscall_trace_enter+0x3c/0x4c
[C5821F40] [C0004344] syscall_dotrace+0x5c/0xc8
Instruction dump:
4bdf54c9 801e007c 2f800000 419e0280 7fc3f378 7fe4fb78 4bdfd8d1 7c7e1b78 
38000000 39346240 80690028 90090028 <83fe000c> 7c0000a6 60008000 7c000124 



Oops: kernel access of bad area, sig: 11 [#1]
NIP: C020DE38 LR: C020DE2C CTR: 00000000
REGS: c62fdd90 TRAP: 0300   Not tainted  (2.6.17-rc3-kuroboxHG)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22000082  XER: 00000000
DAR: 10046268, DSISR: 20000000
TASK = c7c4b770[1764] 'dump' THREAD: c62fc000
GPR00: 00000000 C62FDE40 C7C4B770 00000000 C000B720 00000000 000010E6 00000000 
GPR08: 00000000 10046240 22020488 00001032 0000B39D 100424C0 10010000 7FCB5C70 
GPR16: 10040000 10040000 100C9148 00000000 10040000 300269E8 00000000 00000000 
GPR24: 30013890 7FBF0AA0 30026EC8 30026D34 00000215 00000005 00000000 00000000 
NIP [C020DE38] schedule+0x310/0x62c
LR [C020DE2C] schedule+0x304/0x62c
Call Trace:
[C62FDE40] [C020DE2C] schedule+0x304/0x62c (unreliable)
[C62FDE80] [C00235E0] ptrace_stop+0x98/0xf4
[C62FDE90] [C00236AC] ptrace_notify+0x70/0x90
[C62FDF30] [C0008D74] do_syscall_trace+0x28/0x68
[C62FDF40] [C00044CC] syscall_exit_work+0x11c/0x120
Instruction dump:
419e00d4 809d0024 4bdf54c9 801e007c 2f800000 419e0280 7fc3f378 7fe4fb78 
4bdfd8d1 7c7e1b78 38000000 39346240 <80690028> 90090028 83fe000c 7c0000a6 
Oops: kernel access of bad area, sig: 11 [#2]
NIP: C020DE40 LR: C020DE2C CTR: 00000000
REGS: c62fdd80 TRAP: 0300   Not tainted  (2.6.17-rc3-kuroboxHG)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22000082  XER: 00000000
DAR: 0000000C, DSISR: 20000000
TASK = c7c4b770[1766] 'dump' THREAD: c62fc000
GPR00: 00000000 C62FDE30 C7C4B770 00000000 C000B720 00000000 00001082 00000000 
GPR08: 0059BDF5 C02C6240 22020488 00001032 0000B488 100424C0 10010000 7FA17C70 
GPR16: 10040000 10040000 100C9608 C02D0000 C02C0000 C02C6240 C62FC000 C7C4B878 
GPR24: 00008594 C02C6240 00000076 00000068 C78A93A0 C6E743A0 00000000 00800000 
NIP [C020DE40] schedule+0x318/0x62c
LR [C020DE2C] schedule+0x304/0x62c
Call Trace:
[C62FDE30] [C020DE2C] schedule+0x304/0x62c (unreliable)
[C62FDE70] [C00235E0] ptrace_stop+0x98/0xf4
[C62FDE80] [C00236AC] ptrace_notify+0x70/0x90
[C62FDF20] [C0008D74] do_syscall_trace+0x28/0x68
[C62FDF30] [C0008DF0] do_syscall_trace_enter+0x3c/0x4c
[C62FDF40] [C0004344] syscall_dotrace+0x5c/0xc8
Instruction dump:
4bdf54c9 801e007c 2f800000 419e0280 7fc3f378 7fe4fb78 4bdfd8d1 7c7e1b78 
38000000 39346240 80690028 90090028 <83fe000c> 7c0000a6 60008000 7c000124 
