Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from VA3EHSOBE005.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 08776474C1
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 14:12:56 +1100 (EST)
Message-ID: <49827003.5050307@am.sony.com>
Date: Thu, 29 Jan 2009 19:12:03 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Remis Lima Baima <remis.developer@googlemail.com>
Subject: Re: Dynamic-ftrace not working in PlayStation3
References: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
In-Reply-To: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, Steven Rostedt <rostedt@goodmis.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Remis Lima Baima wrote:
> Hi to all. I was tracing a bug in the snd_usb_audio driver
> (PlayStation 3, Kernel 2.6.29-rc2,
> git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git) and
> for that I tried to use the "dynamic ftrace" to get less debug output.
> But it did not work at all. Ftrace (without the "dynamic ftrace"
> support) works normally. So I traced the "dynamic ftrace" bug and I
> think that I found the bug location but I got stucked. Could anyone
> help, please? Below is the link with the debug output:
> 
> PS1: The problem seems to happen in the file
> "./git/linux-2.6/arch/powerpc/kernel/ftrace.c" around the line 217:
> "if (ptr != GET_ADDR(addr)) {". It returns true.
> PS2: I enabled the "DEBUGP" macro to get the debug output below and
> changed the line 218 to "printk(KERN_ERR "addr does not match \nptr:
> %lx \naddr: %lx \nGET_ADDR(addr): %lx \n", ptr, addr,
> GET_ADDR(addr));".
> 
> //*************************************************************************************************************************************
> ip:d000000000045aec jumps to d000000000046340 r2: d000000000050c00
> 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> ip:d0000000000458d0 jumps to d000000000046340 r2: d000000000050c00
> 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> ip:d000000000045838 jumps to d000000000046340 r2: d000000000050c00
> 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> ip:d0000000000456dc jumps to d000000000046340 r2: d000000000050c00
> 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
...
> ps3_system_bus_match:362: dev=11.0(lpm_01), drv=11.0(ps3-lpm): match
> ps3_system_bus_match:362: dev=11.0(lpm_01), drv=11.0(ps3-lpm): match
> ps3-lpm lpm_01:  <- ps3_lpm_probe:1245:
> ip:d0000000003fe280 jumps to d0000000003ffad8 r2: d000000000422c70
> 3d82fffe 398cce68 fffece68 toc: d00000000040faf8 6c656400 5f5f6b73
> addr does not match
> ptr: 6c6564005f5f6b73
> addr: c0000000004ff128
> GET_ADDR(addr): c000000000007cac

I don't know so much about ftrace, but to get a better idea of the
problem, could you try with the patch below?

Is ps3-lpm built as a loadable module, and if so, is it the first one
that got loaded?

Also, try to either build with CONFIG_PS3_LPM=n, or delete ps3-lpm.ko
so it does not get loaded to see what happens.

-Geoff

--- a/arch/powerpc/kernel/ftrace.c
+++ b/arch/powerpc/kernel/ftrace.c
@@ -23,7 +23,7 @@
 #if 0
 #define DEBUGP printk
 #else
-#define DEBUGP(fmt , ...)	do { } while (0)
+#define DEBUGP printk
 #endif
 
 static unsigned int ftrace_nop = PPC_NOP_INSTR;
@@ -213,6 +213,8 @@ __ftrace_make_nop(struct module *mod,
 
 	ptr = ((unsigned long)jmp[0] << 32) + jmp[1];
 
+	printk("ptr %lx, addr %lx, GET_ADDR %lx\n", ptr, addr, GET_ADDR(addr));
+
 	/* This should match what was called */
 	if (ptr != GET_ADDR(addr)) {
 		printk(KERN_ERR "addr does not match %lx\n", ptr);
