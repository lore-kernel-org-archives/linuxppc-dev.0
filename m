Message-ID: <3CF6C96E.BD1DAA3A@synergymicro.com>
Date: Thu, 30 May 2002 17:53:02 -0700
From: Bill Fincke <willy@synergymicro.com>
Reply-To: willy@synergymicro.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: GT64260 ethernet driver - long term stability?
References: <200205100459.XAA27925@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Has anyone exercised the gt64260_eth.c driver (from the MontaVista
BK tree) for any length of time?  I ported it and have been using
it successfully for several weeks, but find that it can't sustain
continuous file transfers for more than a few hours.

I'm running a loop with ftp putting/getting a 24-MB file to a remote
Linux system, and find that after a few hours, the "put" times out.
It happens on any of the 3 ports, and to/from several different
systems (G4 Mac or PC).  I run the test on the same system through
a I82559 chip and it runs all weekend.

The only clue I have it that the driver reports a flurry of RX CRC
errors when the timeout occurs.  After ftp quits, I can ping the
remote system, but the RX packets seem to be mismatched with the
TX (ping reports once a second, but instead of ~100 usec transit
time, it reports 1.000 sec, or 2.000 sec, or 3.000 sec, as if it's
getting RX packets that are 1, 2, 3 seconds old).

Anyone else seen anything like this?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
