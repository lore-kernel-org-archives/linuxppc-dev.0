Date: Fri, 2 Jul 2004 08:51:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Netconsole on 8260
Message-ID: <20040702155157.GF15960@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B06DB1E@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B06DB1E@ismail.innsys.innovsys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jul 02, 2004 at 10:43:11AM -0500, Rune Torgersen wrote:

> As far as I could see, the only thing needed to support the netpoll API
> was to add a poll function that would call the interrupt driver. I did
> that. Console does not get dumped to ethertnet
>
> According to wat gets printed, netconsole  init aborts when it does not
> find a ethernet device.
> This is way later thatn parameter initialization, but still before FCC's
> are initialized (see kernel dump from original post), last line before I
> cut out some text says:

Ah yes, that's the other problem...  netconsole relies on link order to
be linked in after all other network drivers.  But since the cpm2 ones
are currently broken and live in arch/ppc, the link order is busted.

You can change netconsole from module_init to late_initcall(), but I
don't think you can convince upstream that this is the correct fix.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
