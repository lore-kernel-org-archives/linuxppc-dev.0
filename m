Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE005.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 7D3F2DE19B
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 02:44:24 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH] [V3] Xilinx : Framebuffer Driver: Add PLB support and
	cleanup DCR
Date: Wed, 15 Apr 2009 09:44:09 -0700
In-Reply-To: <fa686aa40904150903r584a3fd6wb75d4f9f606873dc@mail.gmail.com>
References: <20090414200834.D05446F8056@mail163-wa4.bigfish.com>
	<fa686aa40904150814p40813d25w9d04f7e88897a88@mail.gmail.com>
	<20090415155837.139A119C0056@mail32-dub.bigfish.com>
	<fa686aa40904150903r584a3fd6wb75d4f9f606873dc@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Message-ID: <20090415164417.E85B41600050@mail201-sin.bigfish.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel Garapati <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	John Linn <linnj@xilinx.com>, akonovalov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Grant Likely [mailto:grant.likely@secretlab.ca]
> Sent: Wednesday, April 15, 2009 9:03 AM
> To: Stephen Neuendorffer
> Cc: John Linn; jwboyer@linux.vnet.ibm.com; linux-fbdev-devel@lists.source=
forge.net; linuxppc-
> dev@ozlabs.org; akonovalov@ru.mvista.com; adaplas@gmail.com; Suneel Garap=
ati
> Subject: Re: [PATCH] [V3] Xilinx : Framebuffer Driver: Add PLB support an=
d cleanup DCR
> =

> On Wed, Apr 15, 2009 at 9:58 AM, Stephen Neuendorffer
> <stephen.neuendorffer@xilinx.com> wrote:
> >> > - =A0 =A0 =A0 rc =3D of_address_to_resource(op->node, 0, &res);
> >> > - =A0 =A0 =A0 if (rc) {
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "invalid address\n")=
;
> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> >> > + =A0 =A0 =A0 /*
> >> > + =A0 =A0 =A0 =A0* To check whether the core is connected directly t=
o DCR or PLB
> >> > + =A0 =A0 =A0 =A0* interface and initialize the tft_access according=
ly.
> >> > + =A0 =A0 =A0 =A0*/
> >> > + =A0 =A0 =A0 p =3D (u32 *)of_get_property(op->node, "xlnx,dcr-splb-=
slave-if", NULL);
> >>
> >> Hmmm. =A0This binding is undocumented. =A0It would be better to make t=
he
> >> decision on the presence/absence of the dcr-reg and/or reg properties.=

> >
> > For backward compatibility with the 'old' way, the device tree generato=
r for this core has both
> dcr-reg and reg properties (where the reg has been translated back throug=
h the bridge).
> =

> So, what is in the regs and dcr-regs properties when DCR is used?
> =

> How about when MMIO is used?
> =


Currently:
Core has DCR access, connected DCR bus:
	device tree contains dcr-reg property.
Core has DCR access, accessed through plb->dcr bridge:
	device tree contains dcr-reg property, AND for backward compatibility with=
 the =

	old driver, a reg property which contains the apparent registers on the bu=
s.
Core has PLB access: =

	device tree contains reg property only.

So, I guess it really doesn't matter... The only interesting case is the se=
cond one where (because the way the reg property is published), either meth=
od will work...  So, nevermind, the device tree question is completely inde=
pendent and I agree with your comment that there's probably not a need for =
a separate binding.

What I do think would be nice (at some point in the future maybe) is perhap=
s a bit of DCR_or_PLB abstraction for this core and the ll_temac driver to =
share which would avoid duplicating the code in each driver as to whether i=
t uses DCR or PLB access...

Steve


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
