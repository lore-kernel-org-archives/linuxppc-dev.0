Message-ID: <3C158758.5020608@mit.edu>
Date: Mon, 10 Dec 2001 23:11:04 -0500
From: Adam C Powell IV <hazelsct@mit.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Why require CONFIG_BOOTX_TEXT for so much of offb?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings,

Somewhere between 2.4.8 and 2.4.12, the benh kernel (used by Dan
Jacobowitz in Debian) wrapped much of offb_init() in
#ifdef CONFIG_BOOTX_TEXT

As a result of this, the Debian kernel images, which do not set
CONFIG_BOOTX_TEXT because of oldworld OF problems, cannot open video
using BootX (unless you specify e.g. video=atyfb...).

So here are my questions:

    * Is there a way around this?
    * Is the test for BootX at the start of offb_init() somehow
      insufficient, such that all of this code must be eliminated if
      non-BootX booting is to work?
    * Or is there in fact a hard dependency of that code on other stuff
      provided by CONFIG_BOOTX_TEXT?
    * Is there some way of separating the two, so a single kernel can
      work with BootX and with all versions of OpenFirmware?
    * What's the point of offb without this section of code?

Please CC me in replies, as I'm not subscribed to this list.

Thanks,
--

-Adam P.

GPG fingerprint: D54D 1AEE B11C CE9B A02B  C5DD 526F 01E8 564E E4B6

Welcome to the best software in the world today cafe!
<http://lyre.mit.edu/%7Epowell/The_Best_Stuff_In_The_World_Today_Cafe.ogg>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
