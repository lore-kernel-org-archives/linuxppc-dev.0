Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5BF6DDDF6A
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 08:33:15 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: DMA take 3
Date: Fri, 2 Mar 2007 13:29:42 -0800
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C069B03@MERCURY.inside.istor.com>
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

Thanks again Ed. This is a really good idea. It is entirely possible =
that some other complication in Linux is getting to me.
=20
So, with that in mind, I'm off to uboot for a while to see if I can =
convince myself the rest of the chips are setup correctly on the board.
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
