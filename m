Date: Wed, 26 May 1999 17:22:35 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David De Ridder <david.de.ridder@bitsmart.com>
cc: Simone Piccardi <Simone.Piccardi@fi.infn.it>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME2431: how to use vme?
In-Reply-To: <Pine.SO4.4.05.9905261456310.2110-100000@hsins.uia.ac.be>
Message-ID: <Pine.HPP.3.96.990526165052.17425B-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 26 May 1999, David De Ridder wrote:

> Hi everyone,
> 
> we now have Gabriel's Universe driver working with a "LeCroy ADC1182"
> VME board, which is simply an ADC board with 8 channels. We generate
> the sample-pulses internally on the board, with the Universe driver.
> In short, there is no problem using this board to measure (different)
> charges (in parallel). Operation is in A24/D16 mode.
> 
> I just thought scientific-minded people might be interested in hearing
> real-world applications of the Universe driver (and Linux).

Indeed, note that myself and colleagues in Grenoble are going to use it
for real world data acquisition in astronomy. The driver is being written
and will use all capabilities provided by the Universe driver (except RMW
cycles): triggering DMA from a data ready interrupt, several other
interrupts for synchronization and (probably) immediate bottom halves
to handle non time critical operations when returing from interrupts
and limit interrupt latencies.

> 
> In the meantime, Simone wrote : 
> 
> > > A second question is about the BLT flag, as I understand is used to
> > > enable block tranfer. Now we don't need it because the board that we use
> > > has only a readout address that take values stored inside internal FIFO;
> > > this lead to about 700ns to read one word, but our hardware people are
> > > thinking about to make a new board, putting everything inside a buffer,
> > > so if I'll had to use this how I have to read? For what I undertand
> > > block tranfer tranfer on read a whole block of data but how can I
> > > specify the size? 
> > 
> > Block transfer is mostly interesting for DMA and burst writes. Actually on
> > VME block transfers are signaled by a different addres modifier (AM) code
> > on the bus. You don't tell the length: it is the number of data strobes
> > cycles while the address strobe is active which determines the length. The
> > universe will only perform block transfers exceptionally on reads: when
> > you perform a read which is wider than the programmed VME bus width
> > (reading 32 bit on VME_A32_BLT(16) for example). It will perform block
> > transfers on writes, especially if you enable write posting which will use
> > the internal FIFOs and your processor performs store gathering (PPC750 for
> > example). 
> 
>  We too would like to use block transfers. It does not work however.
>  ``Device not configured'' it seems. I just changed (in the VME_window
>  struct) VME_AM_A24(16) to VME_AM_A24_BLT(16).
>  Unfortunately, I'm no VME expert. So, are BLTs something a VME board
>  itself must support ? Or do I need to set another parameter ?

By defaut the SLSI is used for VME A24 and A16 transfers. If you don't
need the VME A32 image which is enabled by default with BLT mode as an
example in the driver, you can just reprogram slave image 2 to use 
VME_AM_A24_BLT. 

However, this is not very interesting in itself since reads done using
standard PIO accesses will only use block transfers if you perform 
a 32 bit reads and the burst will only be for 2 channels. Only DMA can
efficiently use BLT.

But you can nevertheless try it, replace:

        /* Set up an A32/D32 image with BLT for tests */
        SET_REG(0xc8000000 - universe.bus_delta, LSI_BS(2));
        SET_REG(0xcc000000 - universe.bus_delta, LSI_BD(2));
        SET_REG(universe.bus_delta, LSI_TO(2));
        SET_REG(UNIVERSE_SLAVE_EN | UNIVERSE_VAS_A32 | UNIVERSE_VDW_32 |
                UNIVERSE_BLT,
                LSI_CTL(2));
#endif /* UNIVERSE_IMAGE_SETUP */

with something like: 

        /* Set up an A24/D16 image with BLT for tests */
        SET_REG(0xc8000000 - universe.bus_delta, LSI_BS(2));
        SET_REG(0xc9000000 - universe.bus_delta, LSI_BD(2));
        SET_REG(universe.bus_delta - 0xc8000000, LSI_TO(2));
        SET_REG(UNIVERSE_SLAVE_EN | UNIVERSE_VAS_A24 | UNIVERSE_VDW_16 |
                UNIVERSE_BLT,
                LSI_CTL(2));
#endif /* UNIVERSE_IMAGE_SETUP */

and it should work (have a look at /proc/bus/vme/regions: the A32 BLT
region should be transformed into an A24 BLT one).   

Now I have a RFC: 

Right now I have allocated an experimental major number (60) with minor 0
for /dev/vme and other vme devices use the same major with a different
minor. I am not sure that this is the best solution (TM) since it can make
things quite confusing: with only 8 bit minors and the variety of VME
boards available (often home made for research purposes), no 2 systems
will have the same numbering and you have to keep the drivers in sync with
the contents of /dev entries (you can have either automatic module loading
or dynamic minor allocation, but I've been unable to find a way to get
both at the same time, so for now none has been implemented).  Furthermore
this may create a large number of entries in /dev which increases the risk
of name clashes.

So I was considering the following change: give /dev/vme a fixed minor
among the miscellaneous character devices (this should not be a problem)
and when you need the services of a specific driver, you would have
to open /dev/vme and then use an ioctl specifying the name of the
board specific drivber which would override the standard /dev/vme
behaviour. 

It would have the following advantages: 
- only one entry in /dev: /dev/vme with a well known major/minor
combination allocated forever in the linux kernel.
 
- no potential name clashes in /dev

- name based resolution is more robust than the system dependant minor
list (of course 2 people can still choose the same name, but they are
likely to be on 2 completely different systems). 

- automatic module loading seems fairly easy to implement in the ioctl
code (without any need to add aliases in /etc/conf.modules)
(for now this feature has not been implemented at all).

- all the preceding makes the vme patch much less intrusive into the linux
kernel, which was one of my primary goals.

The only small drawbacks I see is that it is slightly more complex to
program, and it will still delay further the release of the documentation.

Comments ? 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
