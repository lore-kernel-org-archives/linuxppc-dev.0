MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Netconsole on 8260
Date: Fri, 2 Jul 2004 10:43:11 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DB1E@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As far as I could see, the only thing needed to support the netpoll API
was to add a poll function that would call the interrupt driver. I did
that. Console does not get dumped to ethertnet

According to wat gets printed, netconsole  init aborts when it does not
find a ethernet device.
This is way later thatn parameter initialization, but still before FCC's
are initialized (see kernel dump from original post), last line before I
cut out some text says:

netconsole: eth1 doesn't exist, aborting.


> -----Original Message-----
> From: Tom Rini [mailto:trini@kernel.crashing.org]
> > Anybody know how to delay the startup of the netconsole driver to
> > after FCC ethernets are up?
>
> AFAIK, the cpm2 enet drivers do not support the NETPOLL API,
> so netconsole will not work yet.  But the early initalization
> of netconsole is fine, that's just setting up the params.
> Once ethernet comes up, the console gets dumped out.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
