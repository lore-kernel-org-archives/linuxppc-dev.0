MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: Hardware interrupts routines
Date: Wed, 16 Jun 2004 15:28:21 +0100
Message-ID: <85E6ED5B5EC32F439702305CC417E12D9E2A80@email.3il.fr>
From: =?Windows-1252?Q?Garcia_J=E9r=E9mie?= <GARCIAJ@3il.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi everybody !
As you guess I need some help... Indeed I'm a newbie in Linux embedded development and I have to work on a linux ppc based board project.
In fact, I have to adapt an existing VxWorks application to a linux montavista hardhat application.
My problem is the following : I need to find a linux equivalent routine of the intConnect() VxWorks routine. You can see the man page of taht function below :

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
NAME

intConnect( ) - connect a C routine to a hardware interrupt
SYNOPSIS

STATUS intConnect
    (
    VOIDFUNCPTR * vector,   /* interrupt vector to attach to */
    VOIDFUNCPTR   routine,  /* routine to be called */
    int           parameter /* parameter to be passed to routine */
    )

DESCRIPTION

This routine connects a specified C routine to a specified interrupt vector. The address of routine is generally stored at vector so that routine is called with parameter when the interrupt occurs. The routine is invoked in supervisor mode at interrupt level. A proper C environment is established, the necessary registers saved, and the stack set up.

The routine can be any normal C code, except that it must not invoke certain operating system functions that may block or perform I/O operations.

This routine generally simply calls intHandlerCreate( ) and intVecSet( ). The address of the handler returned by intHandlerCreate( ) is what actually goes in the interrupt vector.

This routine takes an interrupt vector as a parameter, which is the byte offset into the vector table. Macros are provided to convert between interrupt vectors and interrupt numbers, see intArchLib.

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

The only hardware interrupts routine I found through my investigations is the request_irq(...). But the problem is that request_irq do not allow me to pass an argument to the handler... So is there a routine that allows it or is there a way to adapt the request_irq() to my case.
I thougt to declare a global variable to store my param but I use multitasking. So bad way...


Thanks a lot for helping the newbie that I am...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
