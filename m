Date: Mon, 11 Dec 2000 09:09:07 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Peter R. Wood" <pwood@gordon.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CUDA related crash in 2.4 ?
In-Reply-To: <Pine.LNX.4.30.0012110150010.745-100000@dyn-134-168.gordon.edu>
Message-ID: <Pine.LNX.4.10.10012110905090.23745-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> After it prints out the error message, it repeats the last character that
> I typed about 30 or 40 times, and then the hard freeze occurs.  I don't
> know if this is the same thing that happened the other three or four
> times, but I suspect it may be related.
>
> Any ideas as to why this might be causing my system to hang?

Perhaps because the CUDA interrupt handler keeps storing the same
character in the ADB reply buffer, without bounds checking? At least at
some time in the distant past, the CUDA code I used in writing the MacII
ADB driver suffered from such a problem. Look at the interrupt handler in
via-cuda.c to see whether it still allows overrunning the reply buffer.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
