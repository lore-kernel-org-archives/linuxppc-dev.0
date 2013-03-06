Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id DAE482C03A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 21:26:05 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 32296-01 for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  6 Mar 2013 10:26:00 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Wed, 6 Mar 2013 10:24:12 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7179@saturn3.aculab.com>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01BE9D9D@039-SN1MPN1-002.039d.mgd.msft.net>
References: <CALRxmdBjb+TrqZ_XdNjH=oDcdYtVJ5=Q71dcCkKodpe7WCHDpA@mail.gmail.com>
 <1362440744.16575.6@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE952E@039-SN1MPN1-002.039d.mgd.msft.net>
 <1362509262.25308.0@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01BE9D9D@039-SN1MPN1-002.039d.mgd.msft.net>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Jia Hongtao-B38951" <B38951@freescale.com>,
 "Wood Scott-B07421" <B07421@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Stuart Yoder <b08248@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > Yes, that's (one reason) why you'd want to fill in a known value.  =
Note
> > the "for now". :-)
> >
> > -Scott
>=20
> I think there is no overwhelming reason to fill the destination =
register
> with 0xffffffff.
>=20
> There's a small chance that 0xffffffff is treated as regular data =
rather
> than an error sign.
>=20
> Also setting this register may influence the user space under certain
> circumstance.
>=20
> So I think just ignore the skipped instruction is an acceptable option =
for
> this fix.

The 'random' value is just as likely to affect the reader, but only
for some values - so you'll get almost impossible to repeat bugs.
If a fixed value (0 or ~0) has an adverse effect, at least it will
have the same every time.

Read errors are also likely to affect device drivers reading
status bits, since these are very likely 'write to clear' any
driver would have to be willing to process the 'dummy' value
in a manner that won't loop forever (especially in an ISR).

You don't need every access to be via a function that explicitly
(somehow) detects that the fault happened, but knowing that a
specific value might be caused by a dead PCIe bus, and being
able to find out whether that is true (to avoid looping forever)
is probably useful.

This is probably similar to what a driver needs to recover from
an external PCIe list being unplugged.

	David
