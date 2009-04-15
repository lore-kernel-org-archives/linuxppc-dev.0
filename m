Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from IE1EHSOBE003.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id F0580DE1AC
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 02:14:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: RE: [PATCH] [V3] Xilinx : Framebuffer Driver: Add PLB support and
	cleanup DCR
Date: Wed, 15 Apr 2009 08:58:29 -0700
In-Reply-To: <fa686aa40904150814p40813d25w9d04f7e88897a88@mail.gmail.com>
References: <20090414200834.D05446F8056@mail163-wa4.bigfish.com>
	<fa686aa40904150814p40813d25w9d04f7e88897a88@mail.gmail.com>
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>, "John Linn" <linnj@xilinx.com>
Message-ID: <20090415155837.139A119C0056@mail32-dub.bigfish.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com,
	Suneel Garapati <suneelg@xilinx.com>, linuxppc-dev@ozlabs.org,
	akonovalov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > - =A0 =A0 =A0 rc =3D of_address_to_resource(op->node, 0, &res);
> > - =A0 =A0 =A0 if (rc) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&op->dev, "invalid address\n");
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* To check whether the core is connected directly to D=
CR or PLB
> > + =A0 =A0 =A0 =A0* interface and initialize the tft_access accordingly.=

> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 p =3D (u32 *)of_get_property(op->node, "xlnx,dcr-splb-sla=
ve-if", NULL);
> =

> Hmmm.  This binding is undocumented.  It would be better to make the
> decision on the presence/absence of the dcr-reg and/or reg properties.

For backward compatibility with the 'old' way, the device tree generator fo=
r this core has both dcr-reg and reg properties (where the reg has been tra=
nslated back through the bridge).   =


You're probably right that it should just be one or the other, but the devi=
ce tree generator change needs to be synchronized, and it will break backwa=
rd compatibility with the older driver.

Steve =


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
