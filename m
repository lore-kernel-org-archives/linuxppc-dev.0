Date: Mon, 24 May 1999 12:33:40 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Simone Piccardi <piccardi@fi.infn.it>
cc: David De Ridder <david.de.ridder@bitsmart.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME2431: how to use vme?
In-Reply-To: <373D670E.CC50AC8D@fi.infn.it>
Message-ID: <Pine.HPP.3.96.990524121053.13293E-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Sat, 15 May 1999, Simone Piccardi wrote:

	Hi Simone and David,

Back from holiday, it was fun :-)

> As first I'm currently using 2.2.6; I rebiuld my system using the new
> patches, and as I said it works, at least when I use the region that is
> used both in your vme.c and in testvme.c. 
> 
> I also read the universe documentation, but it was not useful. Our board
> use the normal 32 bit addressing, at a fixed (it is set by some jumper)
> address that is 0xDAFFE000, it is an "hand made" board, so it only check
> if this address is composed on the vme bus, and in this case it give the
> answer (I think it don't even control the AM lines, only the A ones); I
> tried to acces to this using this definition for memdesc:
> 
>         VME_attr memdesc = {
>           base: 
> 0xDaffe000,                                                    
>           limit:
> 0xDaffe020,

It should probably be 0xdaffe01f but does not matter.
                                                    
>           flags: VME_AM_A32(16) | VME_USE_MAP |   VME_USE_RMW
>         };
> but when I try to register such a region I get:
> 
> Failed VME_SET_ATTR: Device not configured 
> (just after the ioctl call with  VME_SET_ATTR).
> 
> I don't get the error if I remove the VME_USE_MAP and  VME_USE_RMW flag,
> but in this way I cannot use the mmap routine and I do not know how to
> access the board. As I said if I use the modified vme.c program I can
> access the bus, but it work only for A24 addressing.

That's because there is no slave image setup in the universe to access
this range of A32 space. Hopefully I shall find time to improve the
documentation and add an example: probably  in your /proc/bus/vme/regions
you have the following: 

Address space   Width and flags Range                   Device
 CR/CSR         D32,PRM         00000000-00ffffff       vme (Universe)
 A32 BLT        D32             c8000000-cbffffff       vme (Universe)
 A24 DATA       D32,PRM         00000000-00feffff       vme (Universe)
 A16            D32,PRM         00000000-0000ffff       vme (Universe)
 A24 DATA       D16,PRM         00000000-00feffff       vme (Universe)
 A16            D16,PRM         00000000-0000ffff       vme (Universe)
 A24 DATA  PRIV D32,PRM         00000000-00feffff       vme (Universe)
 A16       PRIV D32,PRM         00000000-0000ffff       vme (Universe)
 A24 DATA  PRIV D16,PRM         00000000-00feffff       vme (Universe)
 A16       PRIV D16,PRM         00000000-0000ffff       vme (Universe)

These are the areas that you may access with the CPU (actually there are
tricks to access more). What you have to do is to modify he initialization 
of the universe so that image 2 (the one which is set up by default to
access A32 BLT with D32 width) accesses your area at 0xdaffe000. 

This can be achieved by modifying the attributes and translation offset
registers for image 2 in the initialization section of the driver: 

        /* Set up an A32/D32 image with BLT for tests */
        SET_REG(0xc8000000 - universe.bus_delta, LSI_BS(2));
        SET_REG(0xcc000000 - universe.bus_delta, LSI_BD(2));
        SET_REG(universe.bus_delta, LSI_TO(2));
        SET_REG(UNIVERSE_SLAVE_EN | UNIVERSE_VAS_A32 | UNIVERSE_VDW_32 |
                UNIVERSE_BLT,
                LSI_CTL(2));

should be replaced with: 

        /* Set up an A32/D32 image with BLT for tests */
        SET_REG(0xc8000000 - universe.bus_delta, LSI_BS(2));
        SET_REG(0xcc000000 - universe.bus_delta, LSI_BD(2));
        SET_REG(universe.bus_delta + 0xd8000000 - 0xc8000000, LSI_TO(2));
        SET_REG(UNIVERSE_SLAVE_EN | UNIVERSE_VAS_A32 | UNIVERSE_VDW_32,
                LSI_CTL(2));


this will give you access to the 0xd8000000-0xdbffffff range in A32 with 
32 bit width. The reason you have to modify this is that it is
impossible to map the whole A32 VME address space through the PCI
bridge on a 32 bit processor (and that the Universe uses 32 address bits). 

A24 and A16 do not have such a limitation, even with all attributes.

This change should modify your /proc/bus/vme/regions to: 
Address space   Width and flags Range                   Device
 CR/CSR         D32,PRM         00000000-00ffffff       vme (Universe)
 A32 DATA       D32             d8000000-dbffffff       vme (Universe)
 ...

And yes, I know that the driver could use the ENV settings of PPCBug but
there are significant advantages to reprogramming the Universe at start. 
Especially if we decide to reprogram the Raven/Falcon/Hawk in CHRP mode
to enable larger addresing windows on VME which is one of my goals. 

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
