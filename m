Date: Tue, 21 Oct 2003 15:48:02 +0200
Message-ID: <3F710B1D000A0C08@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <1066742722.18957.36.camel@circle.hypercube>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: RE: Using in_8 and out_8 without module optimization
To: "Seb James" <seb@peak.uklinux.net>,
	linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Seb,

to get inline's expanded you need at least "-O" optimization.
To ensure that the asm-code is executed in sequence with your
C-code use:

  -fno-schedule-insns -fno-schedule-insns2

Hope that's what you are looking for.

Ciao, Wolfgang.


>-- Original Message --
>Subject: Using in_8 and out_8 without module optimization
>From: Seb James <seb@peak.uklinux.net>
>To: linuxppc-dev@lists.linuxppc.org
>Date: 21 Oct 2003 14:25:24 +0100
>
>
>
>Hello,
>
>I have a kernel module that I wish to insmod into a linux kernel running
>on a powerpc chip (mpc823).
>
>It uses an inline function declared and defined in asm-ppc/io.h: out_8.
>
>I #include io.h in my code, and call the function out_8. The code
>compiles fine. The module insmods fine as long as I called gcc with -O
>for some optimization when compiling.
>
>I need to run the module without optimization as I really need a section
>of the code to run exactly as I've coded it, but when I compile without
>the -O, insmod fails to insert the module, complaining:
>
>driver.o: unresolved symbol out_8
>
>Something to do with the fact that -O inlines quite a lot of the
>functions in my module, but I don't understand any further than this.
>Can anyone suggest a way I can use out_8 without optimizing my module?
>
>best regards,
>
>Seb James.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
