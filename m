Date: Thu, 20 Sep 2001 17:29:19 -0400
From: macdonldc@netscape.net (Craig MacDonald)
To: linuxppc-embedded@lists.linuxppc.org
Subject: PPCBoot and IMMR remapping for linux 2.4 on sbc8260 
Message-ID: <4E48AD2F.671BD424.031B03A1@netscape.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The immr_base value in PPCBoot on my sbc8260 is
0x0f000000. I have been reading here that the
best value for linux is 0xf0000000.

I don't have easy access to flash my PPCBoot
to a new immr_base value, but I want to run
linux. I have been trying to change the immr_base
in assembly, but it does not seem to work.

Can I setup linux correctly using this method.


   .set    IMMR_H,      0x0f01
   .set    IMMR_L,      0x01a8


   lis     r4,IMMR_H
   ori     r4,r4,0x0000
   lwz     r4,IMMR_L(r4)       // get the current value of the IMMR

   lis     r5,0xfff8
   ori     r5,r5,0xffff        // Zero out the ISB field
   and.    r4,r4,r5

   lis     r5,0x0004           // Change the IMMR reg to be at 0xf0000000
   or.     r5,r4,r5

   lis     r4,IMMR_H
   ori     r4,r4,0x0000
   stw     r5,IMMR_L(r4)       // modify the immr register


Best,
Craig MacDonald


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
