Date: Mon, 24 Jun 2002 10:00:55 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
Cc: Wolfgang Denk <wd@denx.de>, Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH and RFC] Remove request_8xxirq
Message-ID: <20020624170055.GB3489@opus.bloom.county>
References: <20020620214551.GI16052@opus.bloom.county> <20020620215844.E66F61030A@denx.denx.de> <20020620221016.GK16052@opus.bloom.county> <3D12F667.30902@bluewin.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D12F667.30902@bluewin.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 21, 2002 at 11:48:23AM +0200, Wolfgang Grandegger wrote:
> Hello,
>
> I jump into the discussion as well.
>
> On 06/21/2002 12:10 AM, Tom Rini wrote:
>
> >Well, I looked at it (after I sent but before your mail) and it wasn't a
> >patch but some cut'n paste bits.  And to possibly Dan's dismay I don't
> >always agree with his opinions now :)
> >
>
> I first wanted to present my ideas ... before I prepare and send a
> patch.

For future reference, unified diffs are the preferred way to present
ideas which you've already implemented. :)

> >Well, having never used RTAI (and by looking at the 'patch' at
> >http://lists.linuxppc.org/linuxppc-embedded/200110/txt00002.txt) I don't
> >get it..
>
> RTAI and RTLinux actually use the "irq_desc[].handler" functions to
> handle the interrupts and with the previous cpm_* functions it was
> non-trivial to access CPM interrupts within RTAI because they are
> handled in a separate interface.

Ah, which is why you just expanded things the way you did..  Which works
for that context but still leaves the larger problem of request_irq()
panic()'ing on unknown interrupt numbers.

[snip]
> I understand DAN's argument, that the usage of an offset can be quite
> messy especially during driver development but I cannot see a simple
> way around it without breaking the (PC) "request_irq" function.

Well maybe Dan will get encouraged enough to try and properly fix
request_irq() and break some of the legacy PC drivers in 2.5 again. :)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
