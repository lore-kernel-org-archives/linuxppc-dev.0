Message-ID: <3805DDFE.AEF8F5CE@fadata.bg>
Date: Thu, 14 Oct 1999 16:43:26 +0300
From: Momchil Velikov <velco@fadata.bg>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: Chris Ridd <Chris.Ridd@messagingdirect.com>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: serial on lombard
References: <19991014150653.007845@mailhost.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> 
> On Thu, Oct 14, 1999, Chris Ridd <Chris.Ridd@messagingdirect.com> wrote:
> 
> >> Note that this is the/a way to set CLOCAL -- open the device with
> O_NONBLOCK
> >> and then tcsetattr() or whatever.
> >
> >The open on /dev/ttyS0 returns a valid fd, so it is succeeding. As BenH
> >pointed out, the problem is the SIGALRM ringing which causes Minicom to
> >erroneously think it couldn't open the device.
> 
> I just checked and yes, the driver doesn't check the O_NONBLOCK flag, it

This is not necessarily wrong, if the driver's routine doesn't block,
there is no need to check O_NONBLOCK, no matter how slow the routine is.

> always block for 2.5s (since, I think, there's no DCD, it's a hackish
> workaround). Now, we could eventually check more closely, it's possible
> that there's actually a DTR on this internal modem. I heard from Apple
> sources that the wiring of this modem to the SCC was a little bit weird,
> it's possible that the DTR is indeed available either on the flow control
> input pin (but I don't think so) or on the GPio pin. In this case, we
> should check this instead of waiting for an arbitrary amount of time.
> 
> Note that this error should not happen with other serial ports, this
> tempo is only used with the powerbook's internal modem (triggered by the
> "cobalt" compatible propery in the device tree).

I guess, Chris is right. Minicom should use the alarm only as a mean to
cause open() to return -1 and EINTR. And it has to account for such
devices by setting larger timeout.

Regards,
-velco

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
