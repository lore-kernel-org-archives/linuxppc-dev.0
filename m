Message-ID: <38107A55.179866F0@email.sps.mot.com>
Date: Fri, 22 Oct 1999 09:53:09 -0500
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: "@Jean-Jacques GERMOND" <jjg@sxb.bsf.alcatel.fr>
CC: linuxppc-embedded@lists.linuxppc.org, dmalek@jlc.net, wd@denx.de
Subject: Re: Status of MPC823FADS port
References: <199910221213.OAA11953tenor>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


@Jean-Jacques GERMOND wrote:
> 
> a) Which are the good chips?
> ----------------------------
> 
>  In an email dated Sep/03, Dan Malek states:
> 
>  --->  I don't recommend using any (F)ADS board with Linux/PPC.
> 
>  To add to the fun, I now understand that we also have to take into
>  consideration the mpc8xx revision number whatever the board is.
> 
>  I have linux 2.2.7 running bash and few basic utilities
>  on a "streamaster" board from Motorola with the following chip
>  references:
> 
>      XPC860SRZ P66 C1
>         2H96G
>      IMMR=A0000031
> 
>  Many thanks to the Linux community for that.
> 
>  Then I just spent two horrible months trying to port this 2.2.7 code
>  on several (F)ADS board(s) with  mpc823, mpc823e and other mpc860
>  variants without significant success due to many problems,
>  mostly in the MMU.

There are only really two functional differences in the MMU/caches
between the 860 and the MPC823.  The MPC823 has 8 TLBs, and 2k I/
1k D cache.  The MPC823E has 32 TLBs and 16k I/ 8k D cache.
The MPC860 has 32 TLBs and 4k I/ 4k D cache.  Other than that,
there are no core differences between the MPC823/MPC823e/MPC860
other than that listed in the errata.

>  Specifically the following chip does not seem to work:
> 
>      MPC823e Silicon Revision B.0
>        Mask Set 0J13D
>       IMMR=02202400

Revision B.0 silicon on the MPC823e is old.  In fact, it
was only an engineering mask.  Rev B.2 is the latest 
MPC823e silicon.

Not to say there isn't a problem.  What frequency are you trying
to run the MPC823e at?  It's bus? What is it spec'd for?
Does it work at a lower frequency but not a higher one?

>  Wolfgang Denk <wd@denx.de> was kind enough to check this IMMR value at:
>     http://www.mot.com/SPS/ADC/pps/subpgs/sse/823/index.html
>  and email me:
> 
>  --->  Ummm... are you still wondering why you have problems? I'm not.
>  --->  Your silicon is BROKEN, don't waste any more time on it.
>  --->  ....
>  --->  Make sure to run the latest revision (at least C.0) of silicon!
>  --->  ....

Contrary to popular belief, the MPC8xx parts do not all get revised
together.  Revision B of the MPC823 is much, much newer than say, 
revision B of the MPC821.  Revision B2 of the MPC823E is the latest
silicon.
 
>  I can find C.0 rev. nbr. of MPC860 chip but the MPC823e seems to be an
>  other issue.

It is.  They are both now owned by the same division, but weren't
originally, and so they have different versions.
 
> b) Which are the good boards?
> -----------------------------
> 
>  In the above mail, Dan states:
> 
>  --->  With high quality boards available from a variety of sources
>  --->  today, there is no need for the agony of using a (F)ADS board.

Dan was never very specific as to the exact problems he had.  I
don't know, for example, if he was using an old (F)ADS board that
had some problems, or just was unlucky and got a bad board.  What I 
can say is that our Windows CE team here has successfully ported
Windows CE to both the MPC821 and MPC823 with the (F)ADS boards,
including PCMCIA, Ethernet, LCD Controller, and the SCC and SMC.
Both the original ADS and the FADS.  In fact, we made some 100 
plastic-enclosed systems for them to use for their development.
Out of all the (F)ADS I have seen, I have only seen one case where
there was a questionable daughtercard.
 
>  May be the ppc linux community could maintain a list of such boards along
>  with processors rev. number and linux versions that are known to work?
>  I do not know how to get such a list started and maintained.
> 
>  Meanwhile, can anyone send me references of such "high quality boards"
>  specifically for the mpc823e on which Linux is known to run.
>  I am ready to order.  Please, use private mail, if you do not want
>  to post something that may look commercial.

I have heard good things about the Embedded Planet (formerly RPCg)
RPX series of boards.  I don't know if they have any MPC823e
based products as of yet.  (This does not serve as any sort of
endorsement of Embedded Planet by Motorola, etc etc yadda yadda.)

> c) The M_TWB issue
> ------------------
> 
>  There has been some discussion this year about the mpc8xx crashing
>  when we setup the M_TWB register.  the MPC860 user's
>  manual (9.8 Programming model) states that:
> 
>       "These (M_xxx) SPRs should be accessed when both instruction
>       and data address translation is disabled"

When doing a TLB reload, unless you specifically turn address
translation back on in your interrupt routine, address translation
is disabled.
 
>  In a private mail, Motorola told me that this restriction apply
>  to these SPRs setup as well (a dubious feature).

?
 
>  So, I wrote a small asm routine to sedtup these registers from
>  the mapped mode:
> 
>       -switch to unmapped mode
>       -setup M_TWB and optionally M_CASID
>       -return to the caller in mapped mode.
> 
>  I will post the source if asked too, but this mail is too long already.
> 
>  With this code, my MPC823(e) work much better (ie: they don't crash so fast).
>  The 2.2.7 switch is marginally slower but since I don't manage
>  yet to execve anything in init ....
> 
> d) Extracting the page number.
> -----------------------------
> 
>  In the file .../kernel/head.s, the following stmt. is used in several
>  locations:
> 
>         rlwinm. r20, r21,0,0,20 /* Extract page descriptor page address */
> 
>  This must be fine, but what about this other statement instead:
> 
>         rlwinm. r20, r21,0,0,19 /* Extract page descriptor page address */
> 
> 
> e) The 2.3.18 version
> ---------------------
> 
>  This version appears to be very promising and should solve many
>  of the above hw problems. It however does not run yet on any of
>  my machines because the ramdisk does not seem to work yet.
>  Please keep me posted.
> 
> Whatever the difficulties, it's great working with Linux.
> 
> Jean-Jacques Germond

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
