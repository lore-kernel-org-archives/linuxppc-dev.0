Date: Tue, 31 Aug 1999 11:48:26 +1000
Message-Id: <199908310148.LAA14647@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: Geert.Uytterhoeven@cs.kuleuven.ac.be
CC: toe@unlserve.unl.edu, puetzk@iastate.edu, iweiny@falcon.csc.calpoly.edu,
        lambert@jeol.com, linuxppc-dev@lists.linuxppc.org
In-reply-to: 
	<Pine.LNX.4.10.9908301823010.27650-100000@mercator.cs.kuleuven.ac.be>
	(message from Geert Uytterhoeven on Mon, 30 Aug 1999 18:23:48 +0200
	(CEST))
Subject: Re: Communicator Crashes X II
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.10.9908301823010.27650-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be> wrote:

> Perhaps the kernel spends too much time in the interrupt handling section of
> the IDE driver? We saw similar things on m68k.

Or the SCSI code.  I recently converted the mesh and mac53c94 drivers
to use the `new-style' error handling (it didn't take as much hacking
as I had expected).  One result is that the command-done processing in
the scsi mid-layer gets done in a BH handler rather than in an
interrupt handler with interrupts disabled.  I noticed that I got far
fewer serial overruns with the new code during disk activity.

I don't see the FB. overflow messages, but then I don't run the serial
port at 115200, only at 57600.  Is it a common feature that people who
see the FB. overflow message are running the serial port at 115200 or
230400 baud?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
