From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910141421.QAA10144@opal.biophys.uni-duesseldorf.de>
Subject: Re: serial on lombard
In-Reply-To: <19991014150653.007845@mailhost.mipsys.com> from Benjamin Herrenschmidt at "Oct 14, 1999 03:06:53 pm"
To: bh40@calva.net (Benjamin Herrenschmidt)
Date: Thu, 14 Oct 1999 16:21:31 +0200 (CEST)
Cc: Chris.Ridd@messagingdirect.com, linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> 
> On Thu, Oct 14, 1999, Chris Ridd <Chris.Ridd@messagingdirect.com> wrote:
> 
> >> Note that this is the/a way to set CLOCAL -- open the device with
> O_NONBLOCK
> >> and then tcsetattr() or whatever.

My bad. I was confused by the alarm coming in after the open call apparently
returned. And I had forgotten the specific trick to set CLOCAL. 

> >The open on /dev/ttyS0 returns a valid fd, so it is succeeding. As BenH 
> >pointed out, the problem is the SIGALRM ringing which causes Minicom to 
> >erroneously think it couldn't open the device.

But it shouldn't timeout if the open hadn't blocked some way or other. 
 
> I just checked and yes, the driver doesn't check the O_NONBLOCK flag, it
> always block for 2.5s (since, I think, there's no DCD, it's a hackish

Nah, that's the 2.5 sec wait for powering up the modem, which is,
unfortunately, before the block_til_ready. We could forgo this wait period
on O_NONBLOCK (maybe mark the wait pending, and make the next operation wait
instead). 
Anyway: how come open returns successfully but minicom still gets the
timeout? 

	Michael

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
