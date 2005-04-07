Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D548367B2C
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Apr 2005 09:59:49 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
In-Reply-To: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B1B@exnet.3il.fr>
References: <D4FDDD1349B5AC46B68FC26AD8AF42D6226B1B@exnet.3il.fr>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 08 Apr 2005 09:58:36 +1000
Message-Id: <1112918316.9518.338.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Interrupt disabling design
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-04-07 at 12:23 +0200, Garcia Jérémie wrote:
> Hi everybody, 
> I'm trying to emulate a VxWorks-designed application under a linux montavista environment.
> In this application I have critical portion of code which need the interrupts disabled as below:
> 
> -------------------------------------
>   lockKey = OSIntrLock();some 
>     .
>     . // my critical code  
>     .
>   bsos1IntrUnlock(lockKey);
> -------------------------------------
> As you can see we use an OS encapsulation layer which is used to call the OS routines:

On Linux, you can disable interrupts only on the current CPU. If your HW
is SMP, that cannot work, you need to complement the interrupt disabling
with a spinlock.

> ----------------------------
> int OSIntrLock(void)
> {
>   return (intLock());  // vxWorks routine
> }
> 
> void OSIntrUnlock(int lockKey)
> {
>   intUnlock(lockKey);  // vxWorks routine
> }
> ----------------------------
> 
> Furthermore, I'm running my "VxWorks emulator" in the user-space and I'm not allowed to modify files others than the OS encapsulation layer ones.
> So, how can I use the "cli() / sti()" functions from the user space as below:

You cannot. Never. Forget it. If you ever need to actually disable
interrupts, you have to be a kernel driver. Period. Wrong model.

> 
>  | USER-SPACE   |  --> | KERNEL-SPACE |  --> |    USER-SPACE    | --> | KERNEL-SPACE |  --> | USER-SPACE |
>  |              |      |              |      |                  |     |              |      |            |         
>  | OSIntrLock() |      |   cli()      |      | my critical code |     |    sti()     |      |   .....    |
>                                              |  OSIntrUnlock()  |    
> 
> Is it possible to do that? Cause If I do a "cli()" call, I disable interrupts --> so, will the "sti()" call work?
> If yes, it allows me to make my own system call to use them from the user space but I'm not really sure...
> 
> Tks a lot for your help 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>
