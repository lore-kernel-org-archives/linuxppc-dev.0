In-Reply-To: <Pine.LNX.4.03.9901142334560.17386-100000@mercator.cs.kuleuven.ac.be>
Date: Mon, 18 Jan 1999 02:19:10 +0100
To: linuxppc-dev@lists.linuxppc.org,
        Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: MCLK=100 breaks PowerBook
Message-Id: <19990118021910.020182@smtp.calvacom.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The default mclk setting of 100MHz for the Rage LT-G breaks on my
PowerBook G3 Series (garbage on screen, accelerated X hangs). I added
mclk:83 to my command line and it works fine again (and, progress from
pre-4, I have no more snow in X when moving things around).

>atyfb: 3D RAGE LT PRO [0x4c47 rev 0x80] 4M SGRAM, 230 MHz PLL, 83 Mhz MCLK

the chip ID 0x4c47 should be set to 83 MHz by default, not 100.

Note that I made a typo the first time I tested and I used 88Mhz. it
works fine too.

MacOS ATI driver creates a strange property in the device tree. It's name
is "MCLK,XCLK" and the value is 00001a38 00001a38. Geert, those values
have any meaning to you ? If you tell me how to do, I could calc the MCLK
used by MacOS by peeking appropriate registers from MacsBug and we could
use this value for the kernel with this chipID.


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
