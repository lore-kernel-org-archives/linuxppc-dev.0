Date: Wed, 25 Aug 1999 14:26:06 +1000
Message-Id: <199908250426.OAA00893@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: 
	<Pine.LNX.4.10.9908241456210.17842-100000@mercator.cs.kuleuven.ac.be>
	(message from Geert Uytterhoeven on Tue, 24 Aug 1999 14:56:45 +0200
	(CEST))
Subject: Re: BootX enhancement request
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9908241456210.17842-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

> Thus I can remove the nvram code from atyfb?

Well, what's there doesn't seem to be much use.  OTOH, we really do
need something to make it less likely that a newbie will be confronted
by a blank screen because they forgot to put "video=atyfb:vmode:17" in
their kernel command line.  Maybe it should look at the registers and
see if the chip is already running, and if so, just use whatever
timings the chip is currently set to (as long as they look sane).  Or
maybe there needs to be some intelligence somewhere that looks at the
`compatible' property on the device-tree root node and says "aha, an
iMac, default to 1024x768@75Hz".

I see that there properties called "ATY,DefaultMode" and
"ATY,DisplayMode" on the device-tree node for the ATI chip on my G3
desktop.  They both have the value 30 (0x1e).  I don't know what mode
30 is.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
