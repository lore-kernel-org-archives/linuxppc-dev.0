Date: Fri, 8 Mar 2002 09:03:41 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Ruhland, Paul" <PRuhland@microwavedata.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Ethernet, kernel bug/weakness
Message-ID: <20020308090341.V6936@sunbeam.de.gnumonks.org>
References: <A60FFE6CA339C742BE11C311EA8BFF5401637E@mdsms2.inside.mdsroc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A60FFE6CA339C742BE11C311EA8BFF5401637E@mdsms2.inside.mdsroc.com>; from PRuhland@microwavedata.com on Thu, Mar 07, 2002 at 03:50:04PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 07, 2002 at 03:50:04PM -0500, Ruhland, Paul wrote:
> Effect:
> --
> Once the ethernet traffic goes above the critical point described above, all
> cpu cycles are spent servicing the ethernet traffic.

This is a common problem, also found with gigabit ethernet and large x86
boxes (or 100MBit and medium x86 boxes), as soon as you start shooting at them
with foll wire speed 20bytes IP packets.

It is well-known and about two years ago Jamal Hadi Selim and others were
solving the problem for a couple of example ethernet chips by using IRQ
mitigation.  This way the packets will get dropped on the network card
itself.

Seems like your driver isn't using this strategy for some strange reason.

Alternatively you can also try to detect high load within the driver and
switch to polling mode - this also has been implemented successfully in
some drivers, IIRC.

> Paul Ruhland

--
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
