MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: atm8260-1.0.1 
Date: Tue, 16 Sep 2003 14:04:56 +0200
Message-ID: <742AC4678EF8464697DDDFE3B40F6ECD37DA5E@srv-mailrnd.azisa.co.za>
From: "Nishen Brijraj" <Nishen.Brijraj@za.flextronics.com>
To: "w.n. jacobs" <willy.jacobs@nl.thalesgroup.com>,
	<shagitgy@techst02.technion.ac.il>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all.

I am using the mpc8260ads board running the 2.4.4 kernel and the phy is
also the pm5350.

In reference to the message below, why can't you use the code as a
loadable module?  I have tried it this way, and it does eventually
compile and insert, although it doesn't do much else at the moment.

I have also tried to compile the code into the kernel, but that is
proving to be more difficult than just doing what you stated below.
There are a whole lot of undefined reference errors.

By the way, the module_init() is in the file mpc8260sar_detect.c.

Please let me know why you say that it must be compiled into kernel, and
also any other steps or defines that I may need.

You also don't make any mention of the suni/phy code below. How should
that be compiled in or included?

Thank you.


-----Original Message-----
From: w.n. jacobs [mailto:willy.jacobs@nl.thalesgroup.com]
Sent: 16 September 2003 08:23 AM
To: shagitgy@techst02.technion.ac.il
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: atm8260-1.0.1


shagitgy@techst02.technion.ac.il writes:
 >
 > Hi
 > I have an mpc8260 board and Linux running on it (I uses Lineo's BSP
with kernel
 > 2.4.1). I want to run the atm8260-1.0.1 on my board. My phy is s/uni
pm 5350-
 > rc.
 > My question is:
 > Can I use the package from:
https://sourceforge.net/projects/atm8260/ as is?

You can use it. Just unpack the files in arch/ppc/ppc/8260_io.

Add this line to the Makefile in that directory:

obj-$(CONFIG_UTOPIA)	+= mpc8260sar.o mpc8260sar_detect.o intpool.o
mpool.o \
			   risctimer.o mm.o cpmtimer.o utopia.o debug.o
mpc8260iop.o

and this line to Config.in (same directory):

bool 'CPM FCC ATM/UTOPIA' CONFIG_UTOPIA

For the kernel config file you need to enable at least these options:
CONFIG_ATM=y
CONFIG_UTOPIA=y

PS. Check the #defines in the unpacked files if they are correct for
your
situation.

 > How can I use it? should I compile it with the kernel, or can I
insert it as a
 > loadable module (I didnt find the module_init() call).

You can't use it as a loadable module, just compile it directly in the
kernel.
--
willy


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
