Subject: Re: very minor 405GP and 405GPr PCI difference
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF2774A711.2E120BD4-ON87256C5B.0047F3BA@boulder.ibm.com>
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Wed, 23 Oct 2002 09:10:12 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The MontVista Linux disables disable PMM1, which is correct.  It then
writes a 0 PMM0 enable bit,
which on the 405gp is OK because the enable bit is hardwired to a 1.  ON
the 405gpr, the bit is writeable and
this then disables PMM0.  The correct action is to write a 1 to the PMM0
enable bit on both the 405 and the 405gpr
and the problem is solved.


Chip

David Gibson <david@gibson.dropbear.id.au>@lists.linuxppc.org on 10/23/2002
12:08:50 AM

Sent by:    owner-linuxppc-embedded@lists.linuxppc.org


To:    Todd Poynor <tpoynor@mvista.com>
cc:    linuxppc-embedded@lists.linuxppc.org
Subject:    Re: very minor 405GP and 405GPr PCI difference




On Tue, Oct 22, 2002 at 02:55:47PM -0700, Todd Poynor wrote:
>
> David Gibson wrote (regarding Rainier PMM1 bios_fixup in MVL):
>
> >Well, it may be in a different place, but it looks like it has the
> >same problem.  It is still establishing a PCI window at PLB address
> >0x80000000, which is the same address used for the PMM0 window - or is
> >that also different in the MV kernel?
> >
> >I'd be trying to work out what that mapping's actually for, first.  I
> >still can't see how it can possibly work - if there are overlapping
> >PMM windows, what actually happens to accesses in that (PLB) range?
>
> Yes, it looks like MVL only sets up the one window using PMM1... we've
> started an effort to have the Rainier-knowedgeable folks get the code
> sync'ed up with the community and this should happen soon.

Hang on, so just to clarify - MVL sets up PMM1 with the code you
posted, but doesn't set up PMM0 anywhere?  From my reading of that
code, it sets up a window at the same address as the "standard"
(Walnut) mapping, except that it is only 128kB instead of 1GB.  Is
there a reason that Rainier must have such a small window?

--
David Gibson                  | For every complex problem there is a
david@gibson.dropbear.id.au   | solution which is simple, neat and
    | wrong.
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
