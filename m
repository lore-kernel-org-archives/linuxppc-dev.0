Date: Sat, 25 Mar 2000 00:27:45 +0100
To: "Henry A. Worth" <haworth@ncal.verio.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: OF compatible serial PCMCIA cards?
Message-Id: <20000325002745.023968@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Mar 24, 2000, Henry A. Worth <haworth@ncal.verio.com> wrote:

>Does anyone know of any PCMCIA serial I/O cards that
>would be compatible with OF for use as the OF and/or
>XMON/Linux consoles? This would be for the PB2000.
>
>I ran across a site a with links to PCMCIA cards with
>Mac support.  It had a link to www.socketcom.com, which
>a local store stocks, but the socketcom site did not
>have word-one about Mac support. Their serial cards are
>16550 based, any hope that OF would support it or at
>least enable the interface so XMON and the kernel
>could use the port at boot?

Well, I don't think you'll find what you search. I beleive OF can only
use the zilog SCCs in the Apple ASIC. Any other solution would require a
cardbus card with an OF ROM containing OF methods for the serial port.
And I'm not even sure OF can actually use the cardbus at all.

However, for xmon, you can probably use any PCMCIA serial card, configure
manually the TI bridge setup at boot (may be a bit nasty) and write xmon
support for this serial port (not too difficult).

Paul also hacked a way to tie two modem together with a cross-over cable
that works with the internal modem. I don't remember which command you
have to use on the remote modem but looks at what xmon does in
arch/ppc/xmon/start.c when the modem stuff is enabled.
>
>There's also a telnet package in OF, what's that about?
>Is it possible to telnet into OF?

Well, OF can do already bootp and tftp... maybe they have a full IP stack
with a telnet client/server ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
