MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: atm8260-1.0.1 
Date: Tue, 16 Sep 2003 15:37:07 +0200
Message-ID: <742AC4678EF8464697DDDFE3B40F6ECD37DA5F@srv-mailrnd.azisa.co.za>
From: "Nishen Brijraj" <Nishen.Brijraj@za.flextronics.com>
To: "w.n. jacobs" <willy.jacobs@nl.thalesgroup.com>
Cc: <shagitgy@techst02.technion.ac.il>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Willy.

Thanks for the prompt reply.

>Nishen Brijraj writes:
>> Hello all.
>>
>> I am using the mpc8260ads board running the 2.4.4 kernel and the phy
is
>> also the pm5350.

>You also need to set the kernel configuation variable:
>CONFIG_ATM_VADS=y

Did that, and also what's below. One difference however, is that there
is no risctimer.c file to create an object file, only the risctimer.h
which is included in some files. I also added the suni.o object to the
list of objects below (the suni.c and suni.h files are included in the
dir). Is that correct?

>and extend the Makefile with vads_phy.o:
>obj-$(CONFIG_UTOPIA)	+= mpc8260sar.o mpc8260sar_detect.o intpool.o
>mpool.o \
>			   risctimer.o mm.o cpmtimer.o utopia.o debug.o
\
>			   mpc8260iop.o vads_phy.o


 >> In reference to the message below, why can't you use the code as a
 >> loadable module?  I have tried it this way, and it does eventually
 >> compile and insert, although it doesn't do much else at the moment.

>Allocation and de-allocation of buffer descriptors and other buffers in
>dual-port memory might give problems.

 >> I have also tried to compile the code into the kernel, but that is
 >> proving to be more difficult than just doing what you stated below.
 >> There are a whole lot of undefined reference errors.

>Such as? I compiled it without problems (but without vads_phy.o).

I was getting reference errors referring to 'debug_print' but they were
originating from the unrelated uart.c file.

I did eventually get it to compile by not using that function and fixing
some other errors on my part.

At the moment, on boot up of the kernel, it says that:

utopia (itf 0): no signal

after a couple of read and write to the suni.

Still trying to debug this, but thanks for the help so far. I woiuld
appreciate any further advice on your part.

--
brij


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
