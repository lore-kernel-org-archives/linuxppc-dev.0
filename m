Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound4-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 19768DDFB0
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 05:59:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Xilinx: framebuffer: add compatibility for ml507 dvi core.
Date: Mon, 12 May 2008 12:59:03 -0700
In-reply-to: <fa686aa40805121246i68c42867k150c5f9e0082598f@mail.gmail.com>
References: <20080505175918.2AD03A58056@mail164-sin.bigfish.com>
	<fa686aa40805120724u17a380adnd0826044ae3ac369@mail.gmail.com>
	<20080512173130.0D747181804D@mail89-sin.bigfish.com>
	<fa686aa40805121130n53b14a8fye692e06616dc3bc7@mail.gmail.com>
	<20080512191025.67682630064@mail160-dub.bigfish.com>
	<fa686aa40805121246i68c42867k150c5f9e0082598f@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20080512195905.8DD2717B805C@mail2-dub.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, git-dev <git-dev@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: glikely@secretlab.ca [mailto:glikely@secretlab.ca] On Behalf Of
Grant Likely
> Sent: Monday, May 12, 2008 12:46 PM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org; git-dev
> Subject: Re: [PATCH] Xilinx: framebuffer: add compatibility for ml507
dvi core.
>=20
> On Mon, May 12, 2008 at 1:10 PM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >
> >  The best possibility that I see is glopping the compatibility
> >  information about what cores are compatible with which drivers and
> >  generating something.  This is moderately better than blindly
treating
> >  all cores with the same major version as interface compatible, but
still
> >  has the potential to blindly declare that core versions are
compatible
> >  when they are not really compatible.
>=20
> That's okay, the device tree conventions provide for that uncertainty.
>  If compatible includes both the *exact* version and the oldest known
> *compatible* version (the one the drivers know about) then we're in
> the situation where 99% of the time it just works.  For the 1% of the
> time when mistakes are made we still have the necessary information to
> write exceptions in the code to work around bad data.  This means code
> only needs to changes when mistakes are discovered, not for every IP
> core uprev.

My argument was that we should do this by truncating the major version,
which is also an established standard that cores *should* follow, but
you didn't like that. :)  It makes at least as much sense as expressing
the compatibility of the driver in the tree in terms of compatibility
with some other random driver.  In the case of the tft core in
particular, there *is* no other driver AFAIK.

> >  I *really* don't want to put this into the device tree generator on
a
> >  case-by-case basis, so unless there is something that can be
generated
> >  from whatever meta-information EDK has, I think we're going to have
to
> >  just have the explicit versions in the drivers for the time being.
>=20
> Can we post process the generated device tree with a table of known
> compatibility strings (or regexps) for adding the older compatible
> values?  I don't expect the list will be particularly long or hard to
> maintain and the code to do so should be trivial.

Ug, that's just pushing the problem around.
This seems as much like an argument for putting wildcards in the
compatible bindings in the kernel as anything...

Steve
