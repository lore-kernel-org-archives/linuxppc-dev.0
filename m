Subject: Re: Hardware interrupts routines
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: Garcia =?ISO-8859-1?Q?J=E9r=E9mie?= <GARCIAJ@3il.fr>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <85E6ED5B5EC32F439702305CC417E12D9E2A80@email.3il.fr>
References: <85E6ED5B5EC32F439702305CC417E12D9E2A80@email.3il.fr>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1087395891.19701.15.camel@linpc003.aimsys.nl>
Mime-Version: 1.0
Date: Wed, 16 Jun 2004 16:24:51 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Only when you are in kernel mode (i.e. in a driver/module)
it is possible to register for an interrupt, e.g. like
this:


	#include <asm/irq.h> /* e.g. SIU_INT_IRQ1 for 82xx */

	static void irq_handler(int irq, void *my_data,
				struct pt_regs *regs)
	{
		/* handle the irq */

	}

	init()
	{
		int irq_flags = 0;
		long my_data = 0x12345678;

		request_irq(SIU_INT_IRQ1, &irq_handler,
			    irq_flags, "my irq", (void*)my_data);

	}


When some user land C routine needs to be called when
your interrupt arrives, you need to make a driver
like above that wakes up your user mode program
in "irq_handler". This will not give you very
good interrupt latencies however.

Jaap-Jan

On Wed, 2004-06-16 at 16:28, Garcia Jérémie wrote:
> Hi everybody !
> As you guess I need some help... Indeed I'm a newbie in Linux embedded development and I have to work on a linux ppc based board project.
> In fact, I have to adapt an existing VxWorks application to a linux montavista hardhat application.
> My problem is the following : I need to find a linux equivalent routine of the intConnect() VxWorks routine. You can see the man page of taht function below :
>
> >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
> NAME
>
> intConnect( ) - connect a C routine to a hardware interrupt
> SYNOPSIS
>
> STATUS intConnect
>     (
>     VOIDFUNCPTR * vector,   /* interrupt vector to attach to */
>     VOIDFUNCPTR   routine,  /* routine to be called */
>     int           parameter /* parameter to be passed to routine */
>     )
>
> DESCRIPTION
>
> This routine connects a specified C routine to a specified interrupt vector. The address of routine is generally stored at vector so that routine is called with parameter when the interrupt occurs. The routine is invoked in supervisor mode at interrupt level. A proper C environment is established, the necessary registers saved, and the stack set up.
>
> The routine can be any normal C code, except that it must not invoke certain operating system functions that may block or perform I/O operations.
>
> This routine generally simply calls intHandlerCreate( ) and intVecSet( ). The address of the handler returned by intHandlerCreate( ) is what actually goes in the interrupt vector.
>
> This routine takes an interrupt vector as a parameter, which is the byte offset into the vector table. Macros are provided to convert between interrupt vectors and interrupt numbers, see intArchLib.
>
> <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
>
> The only hardware interrupts routine I found through my investigations is the request_irq(...). But the problem is that request_irq do not allow me to pass an argument to the handler... So is there a routine that allows it or is there a way to adapt the request_irq() to my case.
> I thougt to declare a global variable to store my param but I use multitasking. So bad way...
>
>
> Thanks a lot for helping the newbie that I am...
>
--
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
