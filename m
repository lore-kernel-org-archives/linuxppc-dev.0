Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE004.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id 2EADBDDFDB
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 04:43:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH] [V2] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Date: Thu, 3 Jul 2008 11:59:50 -0600
In-Reply-To: <20080703174229.GL2284@secretlab.ca>
References: <20080703164235.37739A006B@mail196-wa4.bigfish.com>
	<20080703132305.ZZRA012@mailhub.coreip.homeip.net>
	<20080703174229.GL2284@secretlab.ca>
From: John Linn <John.Linn@xilinx.com>
To: "Grant Likely" <grant.likely@secretlab.ca>,
	"Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Message-ID: <20080703175952.74E449C0051@mail178-wa4.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, Sadanand Mutyala <sadanan@xilinx.com>,
	linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In reviewing the data sheet for the device, I don't see any shared
information between the 2 channels of the device.

The mutex looks like it's not needed to me also.  =


I'll review with some others here to make sure I'm not overlooking
something. =


-- John

> -----Original Message-----
> From: Grant Likely [mailto:glikely@secretlab.ca] On Behalf Of Grant
Likely
> Sent: Thursday, July 03, 2008 11:42 AM
> To: Dmitry Torokhov
> Cc: John Linn; linuxppc-dev@ozlabs.org; linux-input@vger.kernel.org;
jwboyer@linux.vnet.ibm.com;
> jacmet@sunsite.dk; Sadanand Mutyala
> Subject: Re: [PATCH] [V2] powerpc: Xilinx: PS2: Added new XPS PS2
driver
> =

> On Thu, Jul 03, 2008 at 01:27:00PM -0400, Dmitry Torokhov wrote:
> > Hi John,
> >
> > On Thu, Jul 03, 2008 at 09:42:31AM -0700, John Linn wrote:
> > > +
> > > +	/* Initialize the PS/2 interface */
> > > +	mutex_lock(&drvdata->cfg_mutex);
> > > +	if (xps2_initialize(drvdata)) {
> > > +		mutex_unlock(&drvdata->cfg_mutex);
> > > +		dev_err(dev, "Could not initialize device\n");
> > > +		retval =3D -ENODEV;
> > > +		goto failed3;
> > > +	}
> > > +	mutex_unlock(&drvdata->cfg_mutex);
> >
> > The drvdata is allocated per-port and so both (there are 2 PS/2
ports,
> > right?) ports get their own copy of cfg_mutex. Since you are trying
to
> > serialze access to resource shared by both ports it will not work.
> > The original driver-global mutex was appropriate (the only thing I
> > objected there was use of a counting semaphore instead of a mutex).
> =

> John, correct me if I'm wrong, but I don't think there are any shared
> resources being accessed here and I believe the mutex is entirely
> unnecessary.
> =

> Cheers,
> g.


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
