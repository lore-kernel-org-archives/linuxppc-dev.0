In-Reply-To: <4461.939904548@MessagingDirect.com>
Date: Thu, 14 Oct 1999 15:06:53 +0200
To: Chris Ridd <Chris.Ridd@messagingdirect.com>,
        linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: serial on lombard
Message-Id: <19991014150653.007845@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 14, 1999, Chris Ridd <Chris.Ridd@messagingdirect.com> wrote:

>> Note that this is the/a way to set CLOCAL -- open the device with
O_NONBLOCK
>> and then tcsetattr() or whatever.
>
>The open on /dev/ttyS0 returns a valid fd, so it is succeeding. As BenH 
>pointed out, the problem is the SIGALRM ringing which causes Minicom to 
>erroneously think it couldn't open the device.

I just checked and yes, the driver doesn't check the O_NONBLOCK flag, it
always block for 2.5s (since, I think, there's no DCD, it's a hackish
workaround). Now, we could eventually check more closely, it's possible
that there's actually a DTR on this internal modem. I heard from Apple
sources that the wiring of this modem to the SCC was a little bit weird,
it's possible that the DTR is indeed available either on the flow control
input pin (but I don't think so) or on the GPio pin. In this case, we
should check this instead of waiting for an arbitrary amount of time.

Note that this error should not happen with other serial ports, this
tempo is only used with the powerbook's internal modem (triggered by the
"cobalt" compatible propery in the device tree).

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
