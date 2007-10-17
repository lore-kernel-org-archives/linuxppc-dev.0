Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail21-dub-R.bigfish.com (mail-dub.bigfish.com [213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 549EFDDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 02:22:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Merge dtc
Date: Wed, 17 Oct 2007 09:22:00 -0700
In-Reply-To: <fa686aa40710170615q3b69b13ch7a0038e9c6270729@mail.gmail.com>
References: <20071016050217.GA9052@localhost.localdomain><fa686aa40710160617o57564cb4r260a40cd66407852@mail.gmail.com><20071017052220.GA3801@localhost.localdomain>
	<fa686aa40710170615q3b69b13ch7a0038e9c6270729@mail.gmail.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Paul Mackerras" <paulus@samba.org>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>, <linuxppc-dev@ozlabs.org>
Message-Id: <20071017162227.8E7F3470071@mail21-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
> -----Original Message-----
> From:=20
> linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@ozlabs.or
> g=20
> [mailto:linuxppc-dev-bounces+stephen.neuendorffer=3Dxilinx.com@o
zlabs.org] On Behalf Of Grant Likely
> Sent: Wednesday, October 17, 2007 6:15 AM
> To: Grant Likely; Paul Mackerras; Josh Boyer; linuxppc-dev@ozlabs.org
> Subject: Re: Merge dtc
>=20
> On 10/16/07, David Gibson <dwg@au1.ibm.com> wrote:
> > On Tue, Oct 16, 2007 at 07:17:01AM -0600, Grant Likely wrote:
> > > On 10/15/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > This very large patch incorporates a copy of dtc into the kernel
> > > > source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> > > > longer an external dependency to build kernels with=20
> configurations
> > > > which need a dtb file.
> > >
> > > Powerpc is probably not going to be the only user of dtc.=20
>  Microblaze
> > > will be using it too.  Can it be put somewhere more common?
> >
> > Well, I guess we can move it to scripts/ when microblaze=20
> starts using
> > it.
> >
> > Also, tell me more about this microblaze, I'm certainly=20
> interested in
> > new users of dtc...
>=20
> It's a 'soft processor'.  Implemented in the fabric of an FPGA.  It's
> a ucLinux target.  Xilinx Virtex and Xilinx MicroBlaze targets share a
> lot of common devices.
>=20
> Cheers,
> g.

Basically, this partially works today.   Most of the device information
can come out of a flat device tree, with most of the kernel code copied
straight from arch/powerpc.  I'm still trying to sort out how some of
the architecture specific stuff can be extracted in a smart way.  For
instance, the microblaze has configurable cache sizes, and may or may
not be available.  Currently, this is #defined in the kernel, but I'd
like to get to the point where the same information is pulled out of a
device tree.  My main quandry at the moment is that I'm not wild about
self-modifying code and I'm not sure if the extra overhead of
implementing it with conditionals is significant.

In any event, my plan is to get this into a reasonable state and then
post it here for review.  The main reason why we went with flat device
trees for this was to get as much symmettry as possible between the soft
microblaze and the embedded ppc405 hard core in some FPGAs.

Steve
