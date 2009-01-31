Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE001.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 91D58DE1D2
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 14:04:27 +1100 (EST)
Message-ID: <4983BFA2.9010703@am.sony.com>
Date: Fri, 30 Jan 2009 19:04:02 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Dynamic-ftrace not working in PlayStation3
References: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
	<49827003.5050307@am.sony.com>
	<alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Remis Lima Baima <remis.developer@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I did a bit of work on this today.

Steven Rostedt wrote:
>> > ip:d000000000045aec jumps to d000000000046340 r2: d000000000050c00
>> > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
>> > ip:d0000000000458d0 jumps to d000000000046340 r2: d000000000050c00
>> > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
>> > ip:d000000000045838 jumps to d000000000046340 r2: d000000000050c00
>> > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
>> > ip:d0000000000456dc jumps to d000000000046340 r2: d000000000050c00
>> > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
>> ...
> 
> So I take it that the above showed that the code worked for some?

In my trials it blows up on the first load_module() call, and for my
config that was usbcore:

ip:d000000000305298 jumps to d000000000306ad8 r2: d000000000329bb8 3d82fffe 398ccf20 fffecf20 toc: d000000000316af8 5f666f72 5f726573
ptr 5f666f725f726573, addr c0000000005d0e40, GET_ADDR c000000000007cac
<3>addr does not match 5f666f725f726573
<0>------------[ cut here ]------------
<3>Badness at /home/geoff/projects/cell/ps3-linux-dev/kernel/trace/ftrace.c:441
NIP: c0000000000b3038 LR: c0000000000b46bc CTR: 0000000000000000
REGS: c00000001d143780 TRAP: 0700   Not tainted  (2.6.29-rc3-02162-gec97e82-dirty)
MSR: 8000000000020032 <CE,IR,DR>  CR: 42222442  XER: 00000000
TASK = c000000006f64640[373] 'modprobe' THREAD: c00000001d140000 CPU: 1
<6>GPR00: 0000000000000001 c00000001d143a00 c000000000625988 ffffffffffffffea
<6>GPR04: d000000000305298 c0000000000628c0 0000000000000000 0000000000000002
<6>GPR08: 0000000000000000 c000000000c6ce80 0000000000020000 c000000006f64640
<6>GPR12: 0000000042222444 c000000000655500 d00000000031e9d0 c00000001d143c78
<6>GPR16: d00000000018cbe0 0000000000000549 d00000000018c208 d00000000031e998
<6>GPR20: d00000000031de00 d00000000031e980 00000001e48bc1f0 0000000000000001
<6>GPR24: c0000000005d0e40 c00000001d47b2b8 c000000000576270 d000000000305298
<6>GPR28: d000000000305298 c00000001d47b2e0 c0000000005c6960 c00000001d143a00
NIP [c0000000000b3038] .ftrace_bug+0x98/0x210
LR [c0000000000b46bc] .ftrace_convert_nops+0x23c/0x344
Call Trace:
[c00000001d143a00] [c0000000000628c0] .vprintk+0x394/0x42c (unreliable)
[c00000001d143aa0] [c0000000000b46bc] .ftrace_convert_nops+0x23c/0x344
[c00000001d143b70] [c0000000000b47fc] .ftrace_init_module+0x38/0x50
[c00000001d143bf0] [c0000000000a1c70] .load_module+0x12e0/0x189c
[c00000001d143d80] [c0000000000a23fc] .SyS_init_module+0x90/0x248
[c00000001d143e30] [c0000000000074dc] syscall_exit+0x0/0x40
Instruction dump:
41fe0010 e93e8010 38000001 9009002c e93e8000 e97e8008 e87e80b0 48000130
80090030 7c000034 5400d97e 78000020 <0b000000> 2fa00000 41fe0010 e93e8010
<6>ftrace failed to modify [<d000000000305298>] 0xd000000000305298
 actual: 48:00:18:41
<6>usbcore: registered new interface driver usbfs

 
This ptr of 5f666f725f726573 seems bogus.  I think this code is not
working correctly:

	offset = (unsigned)((unsigned short)jmp[0]) << 16 |
		(unsigned)((unsigned short)jmp[1]);

	tramp = mod->arch.toc + offset + 32;

	if (probe_kernel_read(jmp, (void *)tramp, 8)) {
		printk(KERN_ERR "Failed to read %lx\n", tramp);
		return -EFAULT;
	}

	ptr = ((unsigned long)jmp[0] << 32) + jmp[1];

addr and GET_ADDR(addr) seem OK, System.map shows both to be _mcount.
If I force it to continue with this:

	if (ptr != GET_ADDR(addr)) {
		printk(KERN_ERR "addr does not match %lx\n", ptr);
		//return -EINVAL;
	}

It loads a lot of modules, but eventually it fails with the
following, which seems to mean a bad tramp value.

ip:d0000000005f08cc jumps to d0000000005f1920 r2: d0000000006031c8 3d82ffff 398ce758 ffffe758 toc: d000000000601940<3>Failed to read d000000000601940
<0>------------[ cut here ]------------
<3>Badness at /home/geoff/projects/cell/ps3-linux-dev/kernel/trace/ftrace.c:436
NIP: c0000000000b3000 LR: c0000000000b46dc CTR: 0000000000000001
REGS: c00000001d5b7780 TRAP: 0700   Not tainted  (2.6.29-rc3-02162-gec97e82-dirty)
MSR: 8000000000020032 <CE,IR,DR>  CR: 22222442  XER: 20000000
TASK = c000000006fea7c0[712] 'modprobe' THREAD: c00000001d5b4000 CPU: 0
<6>GPR00: 0000000000000001 c00000001d5b7a00 c000000000625998 fffffffffffffff2
<6>GPR04: d0000000005f08cc c000000000062054 0000000000000000 0000000000000002
<6>GPR08: 0000000000000000 c000000000c6ce80 000000000001ffff c000000006fea7c0
<6>GPR12: 0000000022222444 c000000000655300 d0000000005f9fd0 c00000001d5b7c78
<6>GPR16: d000000000565c58 0000000000000215 d0000000005653e5 d0000000005f9f98
<6>GPR20: d0000000005f9860 d0000000005f9f80 00000002cfe82a50 0000000000000001
<6>GPR24: c0000000005d0e50 c00000001d21e6f0 c000000000576270 d0000000005f08cc
<6>GPR28: d0000000005f08cc c00000001d21e718 c0000000005c6960 c00000001d5b7a00
NIP [c0000000000b3000] .ftrace_bug+0x60/0x210
LR [c0000000000b46dc] .ftrace_convert_nops+0x25c/0x364
Call Trace:
[c00000001d5b7a00] [0000000000000004] 0x4 (unreliable)
[c00000001d5b7aa0] [c0000000000b46dc] .ftrace_convert_nops+0x25c/0x364
[c00000001d5b7b70] [c0000000000b481c] .ftrace_init_module+0x38/0x50
[c00000001d5b7bf0] [c0000000000a1c70] .load_module+0x12e0/0x189c
[c00000001d5b7d80] [c0000000000a23fc] .SyS_init_module+0x90/0x248
[c00000001d5b7e30] [c0000000000074dc] syscall_exit+0x0/0x40
Instruction dump:
419e001c 2f83ffff 419e010c 2f83ffea e93e8010 409e013c 48000040 e93e8010
8009002c 7c000034 5400d97e 78000020 <0b000000> 2fa00000 41fe0010 e93e8010
<6>ftrace faulted on modifying [<d0000000005f08cc>] 0xd0000000005f08cc

-Geoff
