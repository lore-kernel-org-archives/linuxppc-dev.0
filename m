Date: Tue, 6 Nov 2001 02:32:36 -0500 (EST)
From: <tahoward@ntrnet.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Kernel cannot allocate resource region
In-Reply-To: <20011104201640.24983@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0111060225210.686-100000@ranger>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I had been using the bk linuxppc_2_4 tree.  I tried the _devel tree, and
it worked both with and without adb_sync, so all seems well.  Thanks!

Tony

On Sun, 4 Nov 2001, Benjamin Herrenschmidt wrote:

>
> >That may be a timing difference hitting in some driver - in the m68k ADB
> >code, I had been using a local (stack) adb_request struct for some
> >asyncronous ADB request. Most of the time the async operation would
> >complete while that variable was still valid (the calling routine hadn't
> >returned yet). Someetimes it would only complete later ;-(
> >
> >The current ADB code should be free from such gross errors, but maybe
> >something else doesn't cope with async probing of devices? ADB probing
> >happens asynchronously these days (but then, BenH won't have used
> >non-static variables for that). And I'd expect the kernel to throw a
> >panic() for data or illegal instruction errors. Maybe some deadlock - what
> >other task is active during ADB probe?
>
> Well, it' s possible that I left or added such bugs ;)
>
> If you are using my rsync tree (or since recently the bk _devel tree),
> there's an "adb_sync" option you can add to your kernel command line
> to force ADB probe to be synchronous.
>
> Tell me if that helps.
>
> Ben.
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
