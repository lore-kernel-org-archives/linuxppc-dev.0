From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Message-Id: <199910141741.TAA11374@opal.biophys.uni-duesseldorf.de>
Subject: Re: serial on lombard
In-Reply-To: <19991014181031.019116@mailhost.mipsys.com> from Benjamin Herrenschmidt at "Oct 14, 1999 06:10:31 pm"
To: bh40@calva.net (Benjamin Herrenschmidt)
Date: Thu, 14 Oct 1999 19:41:20 +0200 (CEST)
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> On Thu, Oct 14, 1999, Michael Schmitz
> <schmitz@opal.biophys.uni-duesseldorf.de> wrote:
> 
> >And I fixed it by modifying the serial port startup() code. Seems to work as
> >well - do we really need to wait that long for the modem to power up, or
> >will the modem just refuse to handshake while initializing?
> 
> What did you change in the startup() code ?

Pass !(filep->f_flags & O_NONBLOCK) as third argument 'do_wait' to startup,
and replace the if (delay) with if (delay && do_wait). 

> On the wallstreet, at least, (and possibly on the Lombard, if Paul could
> check that the FCR bits are actually the same), without this delay, the
> modem will not answer to AT commands. This causes almost all PPP dialers
> out there to fail with their default scripts. It's possible to work
> around this on some dialers (kppp has a tempo setting) but not all of
> them. That's the main reason why we added this code. (I think Paul added
> the clean sleep code, I originally throwed an horrible mdelay() which
> locked the entire kernel waiting for the modem).

That's possible; I have not tried a PPP dialer so far. Turns out that the
Gnome dialer is happy with this setup and initializes the modem fine as
before. The boneheaded thing still won't accept my ATX3 though. 
If the missing delay is a problem, we could push the delay to the subsequent 
write. But if mincom is the only program that is unhappy with the wait, it
sure is sufficient to fix minicom (and make the serial driver return
-ERESTARTSYS or similar if the wait was interrupted by a signal).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
