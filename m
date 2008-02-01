Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B105EDDEC9
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 04:31:12 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] Xilinx: hwicap driver
Date: Fri, 1 Feb 2008 09:31:06 -0800
In-Reply-To: <20080201055613.GY14201@localdomain>
References: <1201805233-15112-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1201827769-7439-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<20080201050228.7A6E117C0053@mail145-dub.bigfish.com>
	<20080201055613.GY14201@localdomain>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Nathan Lynch" <ntl@pobox.com>
Message-Id: <20080201173107.DD96C338057@mail112-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks,

I realized that on the way home..  That's what I get for trying to
finish something quickly before leaving.. :)

Steve

> -----Original Message-----
> From: Nathan Lynch [mailto:ntl@pobox.com]
> Sent: Thursday, January 31, 2008 9:56 PM
> To: Stephen Neuendorffer
> Cc: linuxppc-dev@ozlabs.org; grant.likely@secretlab.ca;
jacmet@sunsite.dk
> Subject: Re: [PATCH] [POWERPC] Xilinx: hwicap driver
>=20
> Stephen Neuendorffer wrote:
> >
> > +static ssize_t
> > +hwicap_read(struct file *file, char *buf, size_t count, loff_t
*ppos)
> > +{
> > +	struct hwicap_drvdata *drvdata =3D file->private_data;
> > +	ssize_t bytes_to_read =3D 0;
> > +	u32 *kbuf;
> > +	u32 words;
> > +	u32 bytes_remaining;
> > +	int status;
> > +
> > +        spin_lock(&hwicap_spinlock);
> > +	if (drvdata->is_accessing)
> > +		return -EBUSY;
>=20
> Need to unlock before returning (several places in this patch).
>=20
