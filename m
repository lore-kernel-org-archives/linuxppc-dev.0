Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 33C36DDF04
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 03:08:05 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for Xilinx
	uart16550.
Date: Fri, 21 Mar 2008 09:08:37 -0700
In-Reply-To: <82ce3dbb9ebdb1fa4fc7407ed3396411@kernel.crashing.org>
References: <12060242324116-git-send-email-john.linn@xilinx.com><20080320144402.3063517C005D@mail148-sin.bigfish.com><fa686aa40803201719i7bf02ba2qd259f1a36a24d943@mail.gmail.com><18403.32257.725539.470771@cargo.ozlabs.ibm.com>
	<82ce3dbb9ebdb1fa4fc7407ed3396411@kernel.crashing.org>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>
Message-Id: <20080321160802.7CED7196805C@mail103-sin.bigfish.com>
Cc: John Linn <linnj@xilinx.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I thought about this, and reconsidered it again after I finally figured
out how to get the Power.org website to relenquish the ePAPR spec, which
(FWIW) has reg-shift as an optional property of the ns16550 binding.

However, I'm not enamoured of it, since I doubt it's really good to be
doing ioremaps and memory management on unaligned blocks.  It seems more
logical to me to have the reg property define a range of aligned
addresses, and in this case, it happens that the driver never touches
some of those bytes.

In any event, the real point of the patch was to spark some discussion,
which we failed to get otherwise.. :)  I think any of these proposals
are workable...

Steve

> -----Original Message-----
> From: =
linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.org] On Behalf Of
Segher Boessenkool
> Sent: Friday, March 21, 2008 4:40 AM
> To: Paul Mackerras
> Cc: linuxppc-dev@ozlabs.org; John Linn
> Subject: Re: [PATCH 2/3] [POWERPC] Xilinx: of_serial support for
Xilinx uart16550.
>=20
> >> Personally, I'm not fond of this approach.  There is already some
> >> traction to using the reg-shift property to specify spacing, and I
> >> think it would be appropriate to also define a reg-offset property
to
> >> handle the +3 offset and then let the xilinx 16550 nodes use those.
> >
> > Why do we need a reg-offset property when we can just add the offset
> > to the appropriate word(s) in the reg property?
>=20
> Because if you do that, the "reg" property cannot describe the full
> register block (it misses the first few bytes).  Not a huge problem
> in practice, sure.
>=20
>=20
> Segher
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
