Date: Mon, 20 Sep 1999 09:15:48 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Joseph Garcia <jpgarcia@execpc.com>
cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound module: interrupt (de)allocation panic
In-Reply-To: <37E47EC4.5A0D8BC1@execpc.com>
Message-ID: <Pine.LNX.4.10.9909200914340.2752-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 19 Sep 1999, Joseph Garcia wrote:
> I've caught a problem in interrupt deallocation of the dmasound module. 
> According to the top of the source file, you have done most of the work in this
> area, so i figured you would be most qualfied in providing insight in fixing
> this.  This came to my attention while attempting to improve the wallstreet

I worked on the Amiga part of the driver only.

> sleep code so that sound will wake up as well, in which modularity code would
> come in handy.  I am aware that Benjamin Herrenschmidt's and Paul Mackerras'
> attempts at resolving this sleep/sound issue haven't been successful.
> 
> Here are my notes on the issue:
> 
> In order to make the module, i had to force "machine compatibility" as a g3
> powerbook to prevent a linker error. (not to important.  i usually compile it in
> anyway)
> 
> upon installing and removing, a second install results in a interrupt
> initialization failure, however sound works.
> 
> Installing the module, removing it, sleeping it, and reinstalling it still
> yeilds same results as if no sleep at all (sound works, interrupt init fail)
> 
> if the system is slept with the sound installed or compiled in, afterwards, the
> system acts as if it works, though there is no output. (this is the original
> problem we have been having trouble with)
> 
> the module can be removed the second time, but the kernel panics upon a 3rd
> install.
> 
> the kernel also panics in a simple "strnlen" call (PC/System.map tracked) when
> cat-ting the /proc/interrupts when the module has been removed, even just once.
> 
> All this is with just the dmasound as a module, and not the soundcore (sc is
> compiled in). (this shouldn't matter, right?)
> 
> 
> Any insight on this would be greatly appreceated.
> 
> Thanks for your time.
> 
> -- 
> Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
> CS Undergraduate                      Student Employee - Systems Programmer
> University of Wisconsin - Madison                            UW Lidar Group
> 

Greetings,

						Geert

--
Geert Uytterhoeven ----------------- Sony Suprastructure Center Europe (SUPC-E)
Geert.Uytterhoeven@sonycom.com ------------------- Sint Stevens Woluwestraat 55
Phone +32-2-7248608 Fax +32-2-7262686 ---------------- B-1130 Brussels, Belgium


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
