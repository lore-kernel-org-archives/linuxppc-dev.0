Date: Tue, 30 Jan 2001 22:28:25 +0100 (CET)
From: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
To: Daniel Eisenbud <eisenbud@cs.swarthmore.edu>
cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh SCSI bus locks hard on 7500 when burning a CD-R in dao mode
In-Reply-To: <20010129182034.A25828@allspice.cs.swarthmore.edu>
Message-ID: <Pine.LNX.4.10.10101302212490.27525-100000@zirkon.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >
> > Please report the precise message text.
>
> Here is what appears to be the relevant part of the log.  I have more of
> it, which I can send to anyone if they need more context.  Note that in
> the full log, there are _no_ _more_ messages from the mesh driver ever
> after the last one you see in this segment.  It just crawls into a
> corner and dies.
> Jan 29 10:42:50 cumulonimbus kernel: mesh: sending 1 msg bytes: c0
> Jan 29 10:42:50 cumulonimbus kernel: sg_read: dev=2, count=36
> Jan 29 10:42:50 cumulonimbus kernel: Open returning 1
> Jan 29 10:46:10 cumulonimbus kernel: Command timed out active=1 busy=1 failed=1
> Jan 29 10:46:11 cumulonimbus kernel: Error handler waking up
> Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Checking to see if we need to request sense
> Jan 29 10:46:11 cumulonimbus kernel: Command to ID 3 timedout

The command in question seems to time out (now does this message come from
the sg or midlevel timeout?).

> Jan 29 10:46:11 cumulonimbus kernel: Total of 0+1 commands on 1 devices require eh work
> Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Checking to see if we want to try abort
> Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Checking to see if we want to try BDR
> Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Try hard bus reset
> Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Try hard host reset
> Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Take device offline
> Jan 29 10:46:11 cumulonimbus kernel: Finishing command for device 3 6000000
> Jan 29 10:46:11 cumulonimbus kernel: scsi_unjam_host: Returning

The error handling code can't cope with the situation. Either because
abort support isn't implemented, or because something in the low level
driver went FUBAR.

> Jan 29 10:46:11 cumulonimbus kernel: Clearing timer for command c033c200
> Jan 29 10:46:11 cumulonimbus kernel: scsi_error.c: Waking up host to restart
> Jan 29 10:46:11 cumulonimbus kernel: Calling request function to restart things...
> Jan 29 10:46:11 cumulonimbus last message repeated 2 times

That 'restart things' doesn't seem to do anything either.

The big question: why does this particular command time out in the first
place? Does the target expect more data to be sent? Does the target just
crash and fails to release the bus? It seems to work on other host
adapters, doesn't it?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
