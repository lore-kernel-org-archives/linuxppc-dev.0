Subject: Re: [linux-usb-devel] [Patch] for UHCI driver (from kernel 2.6.6).
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Alan Cox <alan@www.pagan.org.uk>, Nicolas DET <nd@bplan-gmbh.de>,
	Linux-USB <linux-usb-devel@lists.sourceforge.net>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040618102044.GA32161@pegasos>
References: <40CDC05B.9020708@bplan-gmbh.de>
	 <1087241757.5996.3.camel@localhost.localdomain>
	 <20040617173454.GA5971@pegasos>  <20040618102044.GA32161@pegasos>
Content-Type: text/plain
Message-Id: <1087594287.8697.291.camel@gaston>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 16:31:28 -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> be still important, at least on G4 powerpc ? remove_list is the 5th
> software word here. Strange, because supposedly it works on x86 and
> other uhci using arches, and it works on the G3, but not on the G4.

I think it's more likely we are dealing with an ordering issue of
accesses to memory vs. mmio, those aren't order unless you use memory
barriers. Actually, it's worse, you need a full mb() to order them,
which is why lately, we made ppc64 writeX() do full sync's ... that sucks
but it's near to impossible to get an abstract IO API that would cover
our needs here and still make other archs happy it seems...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
