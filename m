Date: Sat, 29 Dec 2001 11:56:12 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200112291956.fBTJuCD00235@dave.home>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: signals from interrupt
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>I am running MontaVista hardhat 2.4.2. linux kernel on a MPC8240 cpu with
>a pci bus,NVRAM device ,64M ram and 32M rom (flash).
>basically my application is running very well i have created all the threads
>i needed and all other initialization are almost done.
>the last problem i have regards interrupts.
>on my target i have a dual UART 16550 device, one of it's ports used by the
>kernel (kprintf,etc...) the other port i need to use for my own application.
>in order to use it i need to receive an interrupt (mean RX interrupt), now
>since there are no interrupts available out side of the kernel i thought of
>using signals.
>what i wanted to do is to get the interrupt with in the kernel and to send a
>signal to the application, the problem is that every method i tried to
>implement that did not succeed, can any body help me dealing with this
>issue.
>
>thanks in advance.
>
>Ofer Rashuk-Rosenthal.

I would think this whole problem is not in the kernel realm. Your user space
program should open /dev/ttyS0 or whatever, then just do reads/writes on it.
You can test if data is available for reading using select(). You can
fork() off a child process that does nothing but select() in the file
descriptor for the /dev/ttyS0, and send a signal to the main process to
notify it of the fact.

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
