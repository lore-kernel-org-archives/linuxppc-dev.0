Date: Fri, 22 Oct 1999 14:13:05 +0200 (MET DST)
Message-Id: <199910221213.OAA11953tenor>
From: "@Jean-Jacques GERMOND" <jjg@sxb.bsf.alcatel.fr>
To: linuxppc-embedded@lists.linuxppc.org
Cc: jjg@sxb.bsf.alcatel.fr, dmalek@jlc.net, wd@denx.de
Subject: Re: Status of MPC823FADS port
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



a) Which are the good chips?
----------------------------

 In an email dated Sep/03, Dan Malek states:
 
 --->  I don't recommend using any (F)ADS board with Linux/PPC.
 
 To add to the fun, I now understand that we also have to take into
 consideration the mpc8xx revision number whatever the board is.
 
 I have linux 2.2.7 running bash and few basic utilities
 on a "streamaster" board from Motorola with the following chip
 references:
 
     XPC860SRZ P66 C1
        2H96G
     IMMR=A0000031
 
 Many thanks to the Linux community for that.
 
 Then I just spent two horrible months trying to port this 2.2.7 code
 on several (F)ADS board(s) with  mpc823, mpc823e and other mpc860
 variants without significant success due to many problems,
 mostly in the MMU.
 
 Specifically the following chip does not seem to work:
 
     MPC823e Silicon Revision B.0
       Mask Set 0J13D
      IMMR=02202400
 
 Wolfgang Denk <wd@denx.de> was kind enough to check this IMMR value at:
    http://www.mot.com/SPS/ADC/pps/subpgs/sse/823/index.html
 and email me:
 
 --->  Ummm... are you still wondering why you have problems? I'm not.
 --->  Your silicon is BROKEN, don't waste any more time on it.
 --->  ....
 --->  Make sure to run the latest revision (at least C.0) of silicon!
 --->  ....
 
 I can find C.0 rev. nbr. of MPC860 chip but the MPC823e seems to be an
 other issue.

b) Which are the good boards?
-----------------------------

 In the above mail, Dan states:
 
 --->  With high quality boards available from a variety of sources
 --->  today, there is no need for the agony of using a (F)ADS board.
 
 May be the ppc linux community could maintain a list of such boards along
 with processors rev. number and linux versions that are known to work?
 I do not know how to get such a list started and maintained.
 
 Meanwhile, can anyone send me references of such "high quality boards"
 specifically for the mpc823e on which Linux is known to run.  
 I am ready to order.  Please, use private mail, if you do not want
 to post something that may look commercial.

c) The M_TWB issue
------------------
 
 There has been some discussion this year about the mpc8xx crashing
 when we setup the M_TWB register.  the MPC860 user's
 manual (9.8 Programming model) states that:
 
      "These (M_xxx) SPRs should be accessed when both instruction
      and data address translation is disabled"
 
 In a private mail, Motorola told me that this restriction apply
 to these SPRs setup as well (a dubious feature).
 
 So, I wrote a small asm routine to sedtup these registers from
 the mapped mode:

      -switch to unmapped mode
      -setup M_TWB and optionally M_CASID
      -return to the caller in mapped mode.
 
 I will post the source if asked too, but this mail is too long already.
 
 With this code, my MPC823(e) work much better (ie: they don't crash so fast).
 The 2.2.7 switch is marginally slower but since I don't manage
 yet to execve anything in init ....

d) Extracting the page number.
-----------------------------
 
 In the file .../kernel/head.s, the following stmt. is used in several
 locations:
 
 	rlwinm.	r20, r21,0,0,20	/* Extract page descriptor page address */
 
 This must be fine, but what about this other statement instead:
 
 	rlwinm.	r20, r21,0,0,19	/* Extract page descriptor page address */
 
 
e) The 2.3.18 version
---------------------

 This version appears to be very promising and should solve many
 of the above hw problems. It however does not run yet on any of
 my machines because the ramdisk does not seem to work yet.
 Please keep me posted.
 
Whatever the difficulties, it's great working with Linux.

Jean-Jacques Germond


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
