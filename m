Date: Sun, 4 Nov 2001 15:17:11 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: <tahoward@ntrnet.net>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel cannot allocate resource region
In-Reply-To: <Pine.LNX.4.33.0111022254260.895-100000@ranger>
Message-ID: <Pine.LNX.4.33.0111041506400.11898-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> I'm wondering if it's significant that the last message printed before the
> hang (it's not a panic, no reboot after 180 seconds) is "Macinto"?  When
> I boot without the G3 enabled, the full line is:
> Macintosh CUDA driver v0.5 for Unified ADB.

That may be a timing difference hitting in some driver - in the m68k ADB
code, I had been using a local (stack) adb_request struct for some
asyncronous ADB request. Most of the time the async operation would
complete while that variable was still valid (the calling routine hadn't
returned yet). Someetimes it would only complete later ;-(

The current ADB code should be free from such gross errors, but maybe
something else doesn't cope with async probing of devices? ADB probing
happens asynchronously these days (but then, BenH won't have used
non-static variables for that). And I'd expect the kernel to throw a
panic() for data or illegal instruction errors. Maybe some deadlock - what
other task is active during ADB probe?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
