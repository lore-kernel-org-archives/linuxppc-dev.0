From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: <linuxppc-dev@lists.linuxppc.org>, <tahoward@ntrnet.net>
Subject: Re: Kernel cannot allocate resource region
Date: Sun, 4 Nov 2001 21:16:40 +0100
Message-Id: <20011104201640.24983@smtp.wanadoo.fr>
In-Reply-To: 
 <Pine.LNX.4.33.0111041506400.11898-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.33.0111041506400.11898-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>That may be a timing difference hitting in some driver - in the m68k ADB
>code, I had been using a local (stack) adb_request struct for some
>asyncronous ADB request. Most of the time the async operation would
>complete while that variable was still valid (the calling routine hadn't
>returned yet). Someetimes it would only complete later ;-(
>
>The current ADB code should be free from such gross errors, but maybe
>something else doesn't cope with async probing of devices? ADB probing
>happens asynchronously these days (but then, BenH won't have used
>non-static variables for that). And I'd expect the kernel to throw a
>panic() for data or illegal instruction errors. Maybe some deadlock - what
>other task is active during ADB probe?

Well, it' s possible that I left or added such bugs ;)

If you are using my rsync tree (or since recently the bk _devel tree),
there's an "adb_sync" option you can add to your kernel command line
to force ADB probe to be synchronous.

Tell me if that helps.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
