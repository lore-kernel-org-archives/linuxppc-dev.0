Message-ID: <396D6EC3.CAF4201B@centurysys.co.jp>
Date: Thu, 13 Jul 2000 16:24:51 +0900
From: Tania Boak <tania@centurysys.co.jp>
MIME-Version: 1.0
To: massin@col.bsf.alcatel.fr
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: /dev/watchdog for onchip MPC860 watchdog?
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Raphael

I'm interested in the application you mentioned in your message:

http://lists.linuxppc.org/listarcs/linuxppc-embedded/199910/msg00028.html



> I'm using the watchdog timer on a custom board since several months.
> To
> prevent a CPU reset during the kernel is uncompressing, i prorammed it
> to generate a Non Maskable Interrupt instead of system reset. Those
> NMIs
> are handled by a special function in the Linux kernel. This function
> can reset the board, using a specific I/O, when too many NMIs occurred
> without any watchdog timer (SWSR) servicing.
>
> Today, i refresh the timer in my real time application that is
> launched
> immediately after the kernel init. This scheme must work for any board
> launching an appli/real time module after kernel init. For other
> configurations,
> Dan's idea seems perfect.

I'm trying to find a way to use the on chip watchdog to provide an
automatic reboot should the software on our custom board go to never
never land.  At the moment I don't need to provide the /dev/watchdog
interface, but I may in the future.  Dan's idea about not servicing the
SWSR while /dev/watchdog is open sounds good for that.  But for now, I
just need a way to keep the watchdog timer from expiring as long as
things are working "normally".  I like the idea of using an application
to write to the SWSR rather than doing it from the timer interrupt in
the kernel because I can envision cases where interrupts but not much
else may be working.

But I don't know how to guarantee that the application will be able to
service the watchdog in any given interval of time.  How do you
distinguish between the case where the system has stopped working and
the case where the system is busy but still functioning?

Any help you can give would be appreciated.  If anyone else has an
opinion as to the best place to service the watchdog in order to provide
protection from a hung system, I'd love to hear it.

Thanks


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
