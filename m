Message-ID: <37495F9D.5E8B980@fi.infn.it>
Date: Mon, 24 May 1999 16:18:05 +0200
From: Simone Piccardi <Simone.Piccardi@fi.infn.it>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>, linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME2431: how to use vme?
References: <Pine.HPP.3.96.990524121053.13293E-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Gabriel,
thanks for the help, I had already found the solution looking at the
code.
My universe.c now looks like:

        /* Set up an A32/D32 image with BLT for tests */
        SET_REG(0xd8000000 - universe.bus_delta, LSI_BS(2));
        SET_REG(0xdc000000 - universe.bus_delta, LSI_BD(2));
        SET_REG(universe.bus_delta, LSI_TO(2));
        SET_REG(UNIVERSE_SLAVE_EN | UNIVERSE_VAS_A32 | UNIVERSE_VDW_32 
                /*| UNIVERSE_BLT*/ ,
                LSI_CTL(2));

that is quite the same that you say me; and it work. I have just a
question, there is any drawback to set the region addresses directly
inside the BS and BD registers, or I have to put the different offset
like you did? Has I said I'm quite new to VME, and also if now I'm
beginning to understand some things, all these addresses stuffs are
still a little bit too complex for me.

I also had to modify the VME_attr declaration as:

        VME_attr memdesc = {
          base:  0xdaffe000, 
          limit: 0xdafff000, 
          flags: VME_AM_A32(32) | VME_USE_MAP 
        };       
and in this way mmap work (I can access the board after the mmap by some
*(mp)=0x5 or val[i]=*mp); I used this declaration (a page size) way
because using limit: 0xdaffe020 make mmap not working. I'll try your
values to see if everything is OK.

A second question is about the BLT flag, as I understand is used to
enable block tranfer. Now we don't need it because the board that we use
has only a readout address that take values stored inside internal FIFO;
this lead to about 700ns to read one word, but our hardware people are
thinking about to make a new board, putting everything inside a buffer,
so if I'll had to use this how I have to read? For what I undertand
block tranfer tranfer on read a whole block of data but how can I
specify the size? 

Just a last thing, I tried to compile the driver removing the 
#undef  UNIVERSE_DEBUG
line to use debugging info, but after I did this with make modules when
it try to compile the module I get:

universe.c:856: parse error before
`{'                                          
universe.c:856: `tmp' undeclared (first use in this
function)                   
universe.c:856: (Each undeclared identifier is reported only
once               
universe.c:856: for each function it appears
in.)                               
universe.c:856: parse error before
`,'                                          
universe.c: At top
level:                                                       
universe.c:856: parse error before
`,'                                          
universe.c:857: parse error before
`:'                                          
universe.c:857: warning: type defaults to `int' in declaration of
`tmp'         
universe.c:857: `tmp' used prior to
declaration                                 

and a lot of this (line number could be different from your original
code, because I put some debugging printk inside the code), I'm missing
some other declaration?

bye 
(and thanks for writing the driver!!!)
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
