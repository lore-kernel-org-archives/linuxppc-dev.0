Date: Tue, 25 May 1999 11:11:48 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Simone Piccardi <Simone.Piccardi@fi.infn.it>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME2431: how to use vme?
In-Reply-To: <37495F9D.5E8B980@fi.infn.it>
Message-ID: <Pine.HPP.3.96.990525101402.6041D-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Mon, 24 May 1999, Simone Piccardi wrote:

> 
> Hi Gabriel,
> thanks for the help, I had already found the solution looking at the
> code.
> My universe.c now looks like:
> 
>         /* Set up an A32/D32 image with BLT for tests */
>         SET_REG(0xd8000000 - universe.bus_delta, LSI_BS(2));
>         SET_REG(0xdc000000 - universe.bus_delta, LSI_BD(2));
>         SET_REG(universe.bus_delta, LSI_TO(2));
>         SET_REG(UNIVERSE_SLAVE_EN | UNIVERSE_VAS_A32 | UNIVERSE_VDW_32 
>                 /*| UNIVERSE_BLT*/ ,
>                 LSI_CTL(2));
> 
> that is quite the same that you say me; and it work. I have just a
> question, there is any drawback to set the region addresses directly
> inside the BS and BD registers, or I have to put the different offset
> like you did? Has I said I'm quite new to VME, and also if now I'm
> beginning to understand some things, all these addresses stuffs are
> still a little bit too complex for me.

In this case, the problem is not on the VME side, but on possible
conflicts in the PCI address space. A generic resource allocation layer
will hopefully appear in 2.3.x to clean up this whole mess.

Addressing VME from the processor is a complex thing and it depends
on whether you access it from kernel or user space and of the correctness
and limitations of ioremap(). 

To access VME physical address vpa, you have to generate vpa-TO(image) on
the PCI bus (TO is translation offset register of the Universe). On PreP
(default Raven/Falcon setting), you have to generate processor physical
address vpa-TO(image)+0xc0000000 but this offset is 0 on CHRP and Intel 
boards.

Then to generate this address from kernel space you had (it might have
changed in recent releases so I'll use a past tense) to manage to have
this address in the 0xc0000000-0xcfffffff range which is mapped by a BAT
making it appear in the 0xd0000000-0xdfffffff kernel virtual address range
(this was because ioremap implementation was seriously limited). 

On the other hand, to access it from user mode, it can appear at any
physical address between 0xc0000000 and 0xfcffffff (upper limit might
depend on the bridge chip) but you have to make sure that you don't
conflict with any already allocated PCI address when setting the BS and BD
registers.

The first consideration is basically the reason for which I had only
allocated 64 MB of A32 space. I wanted it to be accessible from kernel
space but I also have an S3 graphics board (PMC module) in my system;
simply sum up taking into account the 256Mb limit of mapped PCI
memory address space: 

- 64 Mb for S3
- 64 Mb for Universe special slave image (A16 and A24)
- 16 MB for VME CR/CSR space (through one Universe image)
- 64 Mb for A32 

that's already 208Mb, leaving 48Mb for all the other devices. It was
clearly impossible to raise it to the next power of 2. 

In other words, your solution will work if you never need to access your
device from the kernel. 
 
> 
> I also had to modify the VME_attr declaration as:
> 
>         VME_attr memdesc = {
>           base:  0xdaffe000, 
>           limit: 0xdafff000, 
>           flags: VME_AM_A32(32) | VME_USE_MAP 
>         };       
> and in this way mmap work (I can access the board after the mmap by some
> *(mp)=0x5 or val[i]=*mp); I used this declaration (a page size) way
> because using limit: 0xdaffe020 make mmap not working. I'll try your
> values to see if everything is OK.

True, mmap can only access pages which are wholly contained inside the 
address range you want to access. That's a security feature: actually only
the VME_SET_ATTR ioctl is privileged, so you can pass the file descriptor
and mmap it in a non privileged process to access the device. 

> A second question is about the BLT flag, as I understand is used to
> enable block tranfer. Now we don't need it because the board that we use
> has only a readout address that take values stored inside internal FIFO;
> this lead to about 700ns to read one word, but our hardware people are
> thinking about to make a new board, putting everything inside a buffer,
> so if I'll had to use this how I have to read? For what I undertand
> block tranfer tranfer on read a whole block of data but how can I
> specify the size? 

Block transfer is mostly interesting for DMA and burst writes. Actually on
VME block transfers are signaled by a different addres modifier (AM) code
on the bus. You don't tell the length: it is the number of data strobes
cycles while the address strobe is active which determines the length. The
universe will only perform block transfers exceptionally on reads: when
you perform a read which is wider than the programmed VME bus width
(reading 32 bit on VME_A32_BLT(16) for example). It will perform block
transfers on writes, especially if you enable write posting which will use
the internal FIFOs and your processor performs store gathering (PPC750 for
example). 

> 
> Just a last thing, I tried to compile the driver removing the 
> #undef  UNIVERSE_DEBUG
> line to use debugging info, but after I did this with make modules when
> it try to compile the module I get:
> 
> universe.c:856: parse error before
> `{'                                          
> universe.c:856: `tmp' undeclared (first use in this
> function)                   
> universe.c:856: (Each undeclared identifier is reported only
> once               
> universe.c:856: for each function it appears
> in.)                               
> universe.c:856: parse error before
> `,'                                          
> universe.c: At top
> level:                                                       
> universe.c:856: parse error before
> `,'                                          
> universe.c:857: parse error before
> `:'                                          
> universe.c:857: warning: type defaults to `int' in declaration of
> `tmp'         
> universe.c:857: `tmp' used prior to
> declaration                                 
> 
> and a lot of this (line number could be different from your original
> code, because I put some debugging printk inside the code), I'm missing
> some other declaration?

I've not enabled debugging for a long time, so some other changes might
have broken it. I'm going to have a look. 
[...]
Here it is, 2 missing parentheses (introduced hen I had to fight a name
clash): 
--- drivers/vme/universe.c.orig Tue May 25 12:51:12 1999
+++ drivers/vme/universe.c      Tue May 25 12:55:36 1999
@@ -138,7 +138,7 @@
 
 /* Defining this makes the initialization verbose, perhaps too verbose !
*/
 #define UNIVERSE_DEBUG
-#undef UNIVERSE_DEBUG
+//#undef UNIVERSE_DEBUG
 
 
 /* values for the state field in the private section */
@@ -471,9 +471,9 @@
  * to access in memory structures like the DMA descriptors. 
  */
 #if defined(__powerpc__) 
-#define __get_le32(addr) {u32 tmp; \
+#define __get_le32(addr) ({u32 tmp; \
                asm("lwbrx %0,0,%1" : "=r" (tmp): "r"(addr), "m"(*addr));\
-               tmp;}
+               tmp;})
 #define __put_le32(val, addr) \
        asm("stwbrx %2,0,%1": "=m"(*addr) : "r"(addr), "r"(val))
 

	Bye,
	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
