Date: Fri, 2 Jan 2004 11:40:14 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: "Kevin B.Hendricks" <kevin.hendricks@sympatico.ca>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	<debian-powerpc@lists.debian.org>, <linuxppc-dev@lists.linuxppc.org>,
	Andreas Schwab <schwab@suse.de>
Subject: Re: 2.6.0-ben3: Badness in redraw_screen
In-Reply-To: <397B64FE-3BA7-11D8-969D-0003938E434C@sympatico.ca>
Message-ID: <Pine.LNX.4.44.0401021136570.18422-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> In the first hunk of your patch you can possibly grab the semaphore and
> then do a return 1 with the semaphore held.
>
> If you really need to hold the semaphore to do a vc_allocate then you
> should remember to release that semaphore before doing the return 1

You're absolutely right. Thanks for spotting this.

> So something along the lines of ...
>
> acquire_console_sem();
> if (vc_allocate(SUSPEND_CONSOLE)) {
>     release_console_sme();
>     return 1;
> }
>
> would be better I think if you really do need to hold the console_sem()
> before calling vc_allocate.

Unfortunately, to avoid the warning we need to hold the semaphore before
calling vc_allocate, as this in turn will call the routines complaining
about the semaphore.

I don't think we can move the locking into vc_allocate; another function
might call this with the lock already held?

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
