Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.123]) by ozlabs.org (Postfix) with ESMTP id 891A9DE06E
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 14:38:18 +1100 (EST)
Date: Thu, 29 Jan 2009 22:38:16 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: Dynamic-ftrace not working in PlayStation3
In-Reply-To: <49827003.5050307@am.sony.com>
Message-ID: <alpine.DEB.1.10.0901292234520.6222@gandalf.stny.rr.com>
References: <a25370a30901260639u3ab97112qf6688667d39e6706@mail.gmail.com>
	<49827003.5050307@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Remis Lima Baima <remis.developer@googlemail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 29 Jan 2009, Geoff Levand wrote:

> > 
> > //*************************************************************************************************************************************
> > ip:d000000000045aec jumps to d000000000046340 r2: d000000000050c00
> > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> > ip:d0000000000458d0 jumps to d000000000046340 r2: d000000000050c00
> > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> > ip:d000000000045838 jumps to d000000000046340 r2: d000000000050c00
> > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> > ip:d0000000000456dc jumps to d000000000046340 r2: d000000000050c00
> > 3d82ffff 398c5740 ffff5740 toc: d000000000046360 c0000000 00007cac
> ...

So I take it that the above showed that the code worked for some?

> > ps3_system_bus_match:362: dev=11.0(lpm_01), drv=11.0(ps3-lpm): match
> > ps3_system_bus_match:362: dev=11.0(lpm_01), drv=11.0(ps3-lpm): match
> > ps3-lpm lpm_01:  <- ps3_lpm_probe:1245:
> > ip:d0000000003fe280 jumps to d0000000003ffad8 r2: d000000000422c70

Could you find out what that function is? Perhaps do a:

	printk("ip:%pF\n", ip);

As long as you have kallsyms on, that should point to the function that's 
the problem.

> > 3d82fffe 398cce68 fffece68 toc: d00000000040faf8 6c656400 5f5f6b73
> > addr does not match
> > ptr: 6c6564005f5f6b73

ptr is the same info as the last line above.

> > addr: c0000000004ff128
> > GET_ADDR(addr): c000000000007cac
> 
> I don't know so much about ftrace, but to get a better idea of the
> problem, could you try with the patch below?
> 
> Is ps3-lpm built as a loadable module, and if so, is it the first one
> that got loaded?
> 
> Also, try to either build with CONFIG_PS3_LPM=n, or delete ps3-lpm.ko
> so it does not get loaded to see what happens.
> 
> -Geoff
> 
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -23,7 +23,7 @@
>  #if 0

Heh, I would have just done:

- #if 0
+ #if 1

;-)


-- Steve

>  #define DEBUGP printk
>  #else
> -#define DEBUGP(fmt , ...)	do { } while (0)
> +#define DEBUGP printk
>  #endif
>  
>  static unsigned int ftrace_nop = PPC_NOP_INSTR;
> @@ -213,6 +213,8 @@ __ftrace_make_nop(struct module *mod,
>  
>  	ptr = ((unsigned long)jmp[0] << 32) + jmp[1];
>  
> +	printk("ptr %lx, addr %lx, GET_ADDR %lx\n", ptr, addr, GET_ADDR(addr));
> +
>  	/* This should match what was called */
>  	if (ptr != GET_ADDR(addr)) {
>  		printk(KERN_ERR "addr does not match %lx\n", ptr);
> 
> 
> 
> 
