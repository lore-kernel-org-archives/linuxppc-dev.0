Message-ID: <37F0E59F.ACDBF6CE@chpc.utah.edu>
Date: Tue, 28 Sep 1999 09:58:23 -0600
From: Lou Langholtz <ldl@chpc.utah.edu>
MIME-Version: 1.0
To: mlan@cpu.lu
Cc: rrschulz@cris.com, Paul.Mackerras@cs.anu.edu.au,
        linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Inbound TCP Circuits over PPP Stall; MTUs and Kppp
References: <199909271957.VAA00313@piglet.cpu.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Another Data point...

I can't help but suspect that this is also related to the "FB.
overflow" messages and the complete-freezing-up of systems that people have
been experiencing and reporting as well. These problems all seems to occur
with use of the PPP system and get worse over time. Sometimes I've even
noticed that even after rebooting my PPC Linux box making a
TCP/IP connection to the same hosts I just hung on (via netscape most
often), I suddenly hang again. It's like the connection stayed open and when
my box tries to reconnect, at some point it starts getting packets again
from its old stream and the kernel locks up on that.

I've been trying to hack on the macserial.c code to fix the "FB.
overflow" problem to no avail so its making more and more sense that the
problem is actually elsewhere in the flow. This latest thread brings me
seriously back to suspecting the PPP and TCP/IP network layer code. Why it
tweaks only the PPC port though has me scratching.

I have a friend who's had the same setup as me but been lucky enough to use
an ISDN router instead of PPP from his box. He's never seen these problems.
Unfortuantely with my modem and my PPP connection I see these just all to
frequently. It seems to ussually go like this...

  1. First my IP connections over PPP get slower and slower. I have a
     28.8Kbaud modem and ussually connect at 21Kbaud and get about that in
     transfer rate. After a couple days of packets my transfer rates get
     worse and worse. I start seeing 38 byte per second transfers and then a
     few hours later the connection just seizes up all-together. I have a
     Cisco 2511 at the other end and suspect it has something to do with the
     problem. At least in encouraging it.
  2. Then I reconnect my modem via netcfg de-activating PPP and
     power-cycling my modem. For a while again I get reasonable transfer
     rates. But then the same thing happens again where the rate drops
     abysmally.
  3. Finally, after a few connection lock / PPP reconnect cycles, the next
     lock-up is my whole machine. Sometimes, after the reboot, connecting to
     the same places I hang my whole machine again right away. The longer
     I wait before connecting to those places however the less I've noticed
     that it locks right back up again. That leads me to believe that the
     lock up problem is going on at the TCP layer; not at the PPP layer. Of
     course if it didn't have anything to do with the PPP layer then people
     not using PPP would see this problem as well.

Well anyhows... I really hope someone more kernel capable than me can find
this helpful since it'll probably be more time effective for me just
throwing money at the problem with a router of some kind to replace the
PPP link.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
