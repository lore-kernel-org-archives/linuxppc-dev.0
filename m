Message-ID: <3A229278.C774FB4@phx.mcd.mot.com>
Date: Mon, 27 Nov 2000 09:57:28 -0700
From: Tom Armistead <tarmiste@phx.mcd.mot.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC860-T / FEC transmits each packet 3 times?
References: <200011222214.eAMMEfO03659@denx.local.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

   I experienced the same behaviour when I had initialized the FEC to
use only 1 transmit BD (it was a simple application and I only needed 1
transmit buffer).  I modified the code to use 2 transmit BD's and the
problem went away.  If you are using only a single transmit BD, try
increasing it to 2.

Tom Armistead

Wolfgang Denk wrote:
>
> Hi,
>
> I'm struggeling with an Ethernet driver on the FEC of a MPC860-T.  To
> the   best   of  my  knowledge,  I'm  doing  everything  strictly  as
> documented, and as other drivers do it. However,  even  when  I  just
> want to send a single packet (no interrrupts, everything as simple as
> possible),  the package is sent 3 times to the wire; sometimes even 4
> times. I don't see any indication of this in  the  software,  just  3
> packets  on  the wire, usually 5...9 us apart (on a 100 Mbps net; the
> packets come after 300...320 us on a 10 Mbps net).
>
> Playing with half or full duplex mode didn't change anything. In case
> it matters: it's a LXT972LC PHY. Ummm.. and yes, I can  be  sure  the
> hardware is working OK. It does so in another OS...
>
> Any ideas what I am missing?
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
> Imagination is more important than knowledge.      -- Albert Einstein
>

--
Tom Armistead

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
