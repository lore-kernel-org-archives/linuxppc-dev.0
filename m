Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011700b515101599d8@[204.210.50.184]>
In-Reply-To: <l03130302b5145fe8d18f@[209.122.247.115]>
References: <38EE7EDE.612EB99F@denise.shiny.it>
 <l03130302b4fd80d3a908@[216.164.130.191]>
 <l03130304b50c8e1b783f@[216.164.131.253]>
Date: Sat, 8 Apr 2000 09:08:36 -0800
To: Giuliano Pochini <pochini@denise.shiny.it>,
        "DeRobertis" <derobert@erols.com>
From: Greg Noel <GregNoel@san.rr.com>
Subject: Re: stty crtscts < /dev/ttyS1
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 8:35 PM -0400 on 4/7/00, Giuliano Pochini wrote:

>I don't know why this happen exactly. It seems that the printer changes
>continuosly with very high frequency the state of CTS, which cause the
>serial driver to loop indefinitely.

At 12:05 AM -0400 4/8/00, DeRobertis replied:

>Ouch! Broken hardware... how can I document this is happening, so that
>I can demand an answer from Epson?

>From your messages, it's not clear to me that it's the printer.  It could
easily be the cable.  Try replacing the cable with one that only connects
the signals you're using and properly grounds all the other signals.

In a previous life, I had this sort of problem with a serial cable that let
RI (ring) float, so it acted like an antenna.  It picked up an another
signal in the cable that was running at 9600 baud (which was really fast at
the time).  It looked to the computer as if the phone was ringing 4800
times per second and each "ring" caused an interrupt so it could enable the
modem.  That was more than enough to drive it to its knees.

>Or maybe I should just hack the serial driver to ignore this. And WTF
>is the serial driver doing looking at CTS on a port with no data?!

If there are multiple ports, it may not be possible to disable a specific
interrupt for an individual port, so it always has to be enabled in case
any port needs it.  That was the case with the hardware I had.

Hope this helps,
-- Greg Noel, retired UNIX guru

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
