Message-ID: <373D670E.CC50AC8D@fi.infn.it>
Date: Sat, 15 May 1999 14:22:38 +0200
From: Simone Piccardi <piccardi@fi.infn.it>
MIME-Version: 1.0
To: David De Ridder <david.de.ridder@bitsmart.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: MVME2431: how to use vme?
References: <Pine.SO4.4.05.9905111658130.18026-200000@hsins.uia.ac.be> <3.0.6.32.19990514115828.008a1330@sins.uia.ac.be>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi David,

I spent last 3 days playing with the board, using another custom board
used to control data acquisition (it also use some registers), but
without any success. 

As first I'm currently using 2.2.6; I rebiuld my system using the new
patches, and as I said it works, at least when I use the region that is
used both in your vme.c and in testvme.c. 

I also read the universe documentation, but it was not useful. Our board
use the normal 32 bit addressing, at a fixed (it is set by some jumper)
address that is 0xDAFFE000, it is an "hand made" board, so it only check
if this address is composed on the vme bus, and in this case it give the
answer (I think it don't even control the AM lines, only the A ones); I
tried to acces to this using this definition for memdesc:

        VME_attr memdesc = {
          base: 
0xDaffe000,                                                    
          limit:
0xDaffe020,                                                    
          flags: VME_AM_A32(16) | VME_USE_MAP |   VME_USE_RMW
        };
but when I try to register such a region I get:

Failed VME_SET_ATTR: Device not configured 
(just after the ioctl call with  VME_SET_ATTR).

I don't get the error if I remove the VME_USE_MAP and  VME_USE_RMW flag,
but in this way I cannot use the mmap routine and I do not know how to
access the board. As I said if I use the modified vme.c program I can
access the bus, but it work only for A24 addressing.

The problem was that we cannot access this custom board not even from
PPCBug, it simply do not allow access to such high address (at least
without playing with the ENV setting on VME slave images, yesterday some
collegues could do it, modifying that settings, but from what I
understand the driver must use its own settings).

As for you we don't need any interrupt or dma, just to read and write
some register in the board (it has a FIFO where it store data), wa have
only to clear it writing in a control word, look in another control word
to see if data are avalaible, and then read.

I think that still I'm not undertanding how to use the driver, and I
have the sensation that I'm doing absolutely stupid things because my
ignorance about the VME. The new manual that Gabriel put in the patch
has some info but probably there is some background I'm missing. for the
moment I'm looking in the code to try to understand how it work and what
options I have to use, but this is quite complex and I have no idea of
what to do. So if you have a working program, could you send it to me?
(at least I can see how it work from the user side!).

Ah, just another thing,as I already said I have a working system on the
board, but still I'm not capable to telnet on it. I always had that "All
network port in use" error. I try to use an X terminal (X in correctly
working, I can run also the emacs in the board looking the windows from
remote) but when I try to open an xterm it say me: "no available ptys".
I'm suspecting that the problem is that I don't have no virtual consoles
avalaible (I've only ttyS0 in inittab). 
Could you telnet in your board? There is some configuration file or some
inittab entry that I miss (I removed all the tty respawning because the
errors).

Thank you
-- 
Simone Piccardi
Microsoft is NOT the answer. Microsoft is the Question.
The answer is: "NO!"

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
