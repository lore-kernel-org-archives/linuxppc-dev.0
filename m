Message-ID: <3896AEAE.B261AAAD@ctam.com.au>
Date: Tue, 01 Feb 2000 21:00:14 +1100
From: Brendan John Simon <Brendan.Simon@ctam.com.au>
Reply-To: Brendan.Simon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: mpc8xx-2.2.13 kernel hangs during boot.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



I am trying to get mpc8xx-2.2.13 booting.  As far as I can tell, it is
hanging just after the kernel is decompressed into RAM and tries to
execute.  I get the following console output

    loaded at:     FF801000 FF80C1F0
    Relocate to:   00100000 0010B1F0
    Board Data at: 001001C4 001001E0
    relocated to:  00200100 0020011C
    Boot args at:  00200000 00200200
    zimage at:     FF807000 FF8676C8
    avail ram:     00201000 01000000

    Linux/PPC load:
    Uncompressing Linux... done.
    Now booting the kernel

I'm a little concerned about the overlap of BootArgs and the relocated
BoardData.  Does this seem right or wrong to anyone ?

I had previously had similar problem when using embedded-2.2.5.  It was
hanging during the boot.  It was suggested to me that I disable the
caches.  I did that in arch/ppc/mbxboot/head.S and
arch/ppc/kernel/head.S and I never had a problem booting embedded-2.2.5
since.  It was suggested to me that the UPM was probably incorrect and
that's why it fails with the caches enabled.
I have disabled the caches in mpc8xx-2.2.13 but I still get the same
results.  I have tried with 4 different UPM settings for a 25MHz bus
with 60ns EDO DRAM.  I got the values from the ADS manual, SDS Single
Step debugger and a commercial operating system.  I even tried with the
burst inhibit flag set/cleared in the chip select option registers.

I'm not sure if it is my bootloader or kernel.  In the bootloader I
basically setup the clocks, ports, chip selects for flash and dram and
that's about it.  Is there anything else the kernel expects to be setup
?

I've run out of ideas now and need some advice.
What could be causing the kernel not to boot ?
How can I tell where it is failing ?  I don't think I can use printk as
the console is not setup yet.  Is this correct ?

Getting a little desperate now.
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
