Message-ID: <39C7C7EE.7B17A25B@mvista.com>
Date: Tue, 19 Sep 2000 16:09:18 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@fh-brandenburg.de>
CC: paulus@linuxcare.com.au, Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
References: <Pine.GSO.4.10.10009192020500.4878-100000@zeus.fh-brandenburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:

> I'm curious, what needs ioremap before the VM is ready?

The IMMR (internal memory map to almost everything in the chip)
has to be mapped to provide access to a variety of bits for
initialization.  On some boards, the board control/status register
has to be mapped and configured.

I hope people don't forget that this is done on other platforms
with BATs as well, it just isn't as obvious as the 4xx/8xx.

> Shouldn't it be possible, to add such stuff directly to the hash table
> and add the official mapping later?

In many cases (and certainly the 8xx) the mapping done early is assumed
to be the address used throughout the life of the system.  Using one
set of mapping early, and then something else later is quite confusing
when you have global pointers like immr, you have to update internal
processor registers when it changes, and internal devices that you
previously initialized use the old value.

> BTW the whole mm stuff really needs a big cleanup,

Heh...This quote has been in e-mail messages for years :-).

I don't think we need lots of changes, but it should continue to
evolve into something more efficient.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
