From: Nathan Sheeley <nsheeley@ibmoto.com>
Message-Id: <199906221621.LAA28496@shippy.ibmoto.com>
Subject: bug in head.S
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 22 Jun 1999 11:21:02 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



This is more or less the same message that I posted earlier, but no one 
replied.  Please at least tell me to go away ;^)

I was poking around in arch/ppc/kernel/head.S and I noticed this:

  oris  r18,r8,0x20000000@h
  oris  r21,r11,(KERNELBASE+0x20000000)@h
  mtspr DBAT2L,r18    /* N.B. 6xx (not 601) have valid */
  mtspr DBAT2U,r21    /* bit in upper BAT register */
  mtspr IBAT2L,r28
               ^^^^^^^^^^^^^^^^Wouldn't r18 make more sense here?
  mtspr IBAT2U,r21    

Has anyone tried to build/run a pmac SMP kernel with a recent (2.2.9)
version of Linux?  

    o I've got a 9500 with 2 604e/200MHz.
    o A UP kernel works fine.  
    o Compliling the same kernel with the SMP support box checked results in
      a kernel that doesn't boot on UP(a G3) or SMP(the 9500) machines. 
    o I also replaced the dual card with a single 133 MHz CPU, which also fails 
    to boot the SMP kernel.

Can I expect a SMP kernel to boot on a UP?  I thought so, although it might
be slower than a UP kernel on a UP.

The symptoms are that it gets to the point of "opening the display", which
activates the display (all white, I assume painted that way by OF), prints 
"copying OF device tree...done" and stops.  

Nathan Sheeley


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
