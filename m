From: Jeremy Rosen <Jeremy.Rosen@au.thalesgroup.com>
To: Murray.Jensen@csiro.au, linuxppc-embedded@lists.linuxppc.org
Message-Id: <scf74bf6.008@au.thalesgroup.com>
Date: Fri, 31 May 2002 10:09:53 +1000
Subject: Re: [PATCH] enhanced i2c driver for MPC8xx/MPC8260 CPM ...
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, I have just applied your patch, and would like to add a few
comments



I beleive you use the denx kernel, which is not 100% compatible with
the 2.4.4-devel one.
In particular, commproc.h is in asm/ in the devel kernel.
The patch did not apply properly, and I had to do some trivial editing
to make it work (note that my last pull from 2.4-devel is quite old)
you also need to include commproc.h in i2c-algo-cpm.h, because this is
where iic_t is defined

in arch/ppc/8xx_io/commproc.c you reference a cp variable that oesn't
exist, I changed it to cpmp, which is probably what you  meant

you include the same header twice in i2c-algo-cpm : asm/mpc8xx.h

once compiled, the driver didn't work. I have a very simple test
program using /dev/i2c/0 (set the client address, read two bytes, it
worked with the old driver),
and it hangs after printing

cpm_iic_read(abyte=0x91
(no closing brace, the 0x91 value is correct)
I inserted
   cpm_iic_print_params(cpm);
   return 0;

after the blocking printk, and this allowed the printk to finish
properly and returned the following info

i2c-algo-cpm.o: #0 addr=0x48 flags=0x1 len=2
cpm_iic_read(abyte=0x91)
i2c regs @ 0xff000860:
        mod 00 add fe brg 07 com 01 cer 00 cmr 00
iic params @ 0xff002400:
        rbase 0838 tbase 0828 rfcr 10 tfcr 10 mrblr 0080
        rstate 00000000 rdp 00000000 rbptr 0000 rbc 0000 rxtmp
00000000
        tstate 00000000 tdp 00000000 tbptr 0000 tbc 0000 txtmp
00000000
        res dfcff956 rpbase 0060 res2 2400
Using relocation patch!
i2c-algo-cpm.o: read 0
10,0

I am trying to find out what's going wrong, but any clue would be
welcome..


(FYI I have a 860T FADS board with a Maxim DS1775R digital thermometer
attached on the IIC bus)
I only tested access through /dev/i2c/0, no sensor drivers.

Thanks Jeremy

>>> Murray Jensen 05/28/02 03:43pm >>>
enhanced i2c driver for MPC8xx/MPC8260 CPM ...

- replace the 8xx i2c driver with a combined 8xx/8260 driver (or in
future
  anything else that has a CPM)
- also enhances the code so that the driver can be used as a loadable
  module
- fixes the i2c-rpx driver to use the combined algo driver, but it
  really should just be removed, since I'm sure that the generic
i2c-cpm
  driver would work on rpx (untested - I don't have an RPX)

Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3
9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3
9662 7853
Internet: Murray.Jensen@csiro.au

Hymod project: http://www.msa.cmst.csiro.au/projects/Hymod/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
