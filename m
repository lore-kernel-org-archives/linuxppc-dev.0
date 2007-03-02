Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B8E5DDF33
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 10:43:00 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: DMA take 3
Date: Fri, 2 Mar 2007 15:42:57 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B08@MERCURY.inside.istor.com>
References: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A181@MERCURY.inside.istor.com>
	<B52955765C54604CB1A62A9967F22C7301EAE573@az33exm20.fsl.freescale.net>
	<9F3F0A752CAEBE4FA7E906CC2FBFF57C069B02@MERCURY.inside.istor.com>
	<B52955765C54604CB1A62A9967F22C7301EAE5F8@az33exm20.fsl.freescale.net>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Swarthout Edward L-SWARTHOU" <ed.swarthout@freescale.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Ed:
=20
Your uboot script works fine with the DMA engine. I can transfer a few =
bytes from 0xfff8_0000 to 0x1_0000 with no difficulty. However, I have =
not yet gotten to an understanding when DMA'ing through an address =
translation window, but at least I know how to make it work in local =
memory (LM) space.
=20
In our design, we have two outbound translation address windows setup =
and the BAR's in our ASIC are dual, meaning BAR0/BAR1 work together to =
form a 64bit address and BAR2/BAR3 work together to form a different =
64bit address. One is translated from 0x8400_0000 to 0x3_0000_0000 which =
we call RM (Register Memory) and the other is translated from =
0x8800_0000 to 0x1_0000_0000 which we call SM (System Memory).
=20
I have setup POWBAR1/POTAR1/POWAR1 for the 0x8400_0000 translation and =
POWBAR2/POTAR2/POWAR2 for the 0x8800_0000 translation. Using those =
translations, we can write & read single memory locations in both RM & =
SM space from LM space using these settings.
=20
Next is the burst mode of the PCI for which, I believe, the only =
recourse is to use the DMA engine. Here things get a bit trickier.
=20
I am DMA'ing to the window at 0x8800_0000 plus the destination offset =
within that window and the issue is that although LM->LM DMA is now =
working, LM->SM is not working.
=20
So, her are the questions:
=20
Is there any special consideration in trying to DMA from a 32bit PCI to =
a 64bit address using DAC (Dual Address Cycles) in the 8541?
=20
Are there any special considerations relating to using an outbound =
address translation window to do this?
=20
Where else might things be going awry?
=20
Charles

________________________________

From: Swarthout Edward L-SWARTHOU [mailto:ed.swarthout@freescale.com]
Sent: Fri 3/2/2007 1:27 PM
To: Charles Krinke; linuxppc-embedded@ozlabs.org
Subject: RE: DMA take 3



Maybe even a more basic question - are you setting the controller up
correctly for this mode (SRW=3D1 and CTM=3D1)?
One suggestion is to try it once by hand in u-boot to ensure the
hardware is working as expected before trying it in Linux.

-EdS

#simple u-boot Direct Mode dma example - Ed.Swarthout
setenv sad fff80000 #source
setenv dad 10000    #dest
setenv bc 10        #byte count
setenv b e0021      #ccsr

mw ${b}104 ffffffff #sr clear
mw ${b}110 50000    #satr SREADTTYPE=3D5 read snoop
mw ${b}114 $sad   #sar
mw ${b}118 50000    #datr write snoop
mw ${b}120 $bc    #bcr
mw ${b}100 0f03c404 #mr BWC=3Df, DAHTS=3D3, SAHTS=3D3, SRW=3D1 CTM
md $dad 5           #before
mw ${b}11c $dad     #set dar and go
md ${b}100 9        #show status
md $dad 5           #after

Or make a dma command and run it:

setenv dma 'mw ${b}104 ffffffff;mw ${b}110 50000;mw ${b}114 $sad;mw
${b}118 50000;mw ${b}120 $bc;mw ${b}100 0f03c404; mw ${b}11c $dad; md
${b}100 9'

setenv b e0021; setenv sad fff80000; setenv dad 10000; setenv bc 10
run dma

--- results ---

=3D> md $dad 5
md $dad
00010000: deadbeef deadbeef deadbeef deadbeef    ................
00010010: deadbeef    ....
=3D> run dma
run dma
e0021100: 0f03c405 00000000 00000000 00000000    ................
e0021110: 00050000 fff80010 00050000 00010010    ................
e0021120: 00000000    ....
=3D> md $dad 5
md $dad 5
00010000: 27051956 552d426f 6f742031 2e322e30    '..VU-Boot 1.2.0
00010010: deadbeef    ....
