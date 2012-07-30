Return-Path: <B10812@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 682832C033E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2012 19:11:07 +1000 (EST)
From: Aggrwal Poonam-B10812 <B10812@freescale.com>
To: Greg KH <gregkh@linuxfoundation.org>, Singh Sandeep-B37400
 <B37400@freescale.com>
Subject: RE: [2/3][PATCH][v2] TDM Framework
Date: Mon, 30 Jul 2012 09:10:48 +0000
Message-ID: <ACB6D0C0104CFF42A45A5D82A0DD4F3D079C0B75@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1343397940-12975-1-git-send-email-sandeep@freescale.com>
 <20120727175939.GA23105@kroah.com>
In-Reply-To: <20120727175939.GA23105@kroah.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+poonam.aggrwal=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Gre=
g
> KH
> Sent: Friday, July 27, 2012 11:30 PM
> To: Singh Sandeep-B37400
> Cc: devel@driverdev.osuosl.org; linuxppc-dev@lists.ozlabs.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [2/3][PATCH][v2] TDM Framework
>=20
> On Fri, Jul 27, 2012 at 07:35:38PM +0530, sandeep@freescale.com wrote:
> > +/* Data structures required for sysfs */ static struct tdm_sysfs attr
> > +=3D {
> > +	.attr.name =3D "use_latest_data",
> > +	.attr.mode =3D 0664,
> > +	.cmd_type =3D TDM_LATEST_DATA,
> > +};
>=20
> What is this for?
This knob is to control the behavior of the TDM framework with respect to h=
andling the received TDM frames.
The framework layer receives the TDM frames from the TDM adapter driver, de=
-interleaves the data and sends to respective client modules.
In the case when the TDM client module has not consumed the data and emptie=
d the Buffer, this flag decides whether to discard the un-fetched data, or =
discard the latest received data.

>=20
> > +int tdm_sysfs_init(void)
> > +{
> > +	struct kobject *tdm_kobj;
> > +	int err =3D 1;
> > +	tdm_kobj =3D kzalloc(sizeof(*tdm_kobj), GFP_KERNEL);
> > +	if (tdm_kobj) {
> > +		kobject_init(tdm_kobj, &tdm_type);
> > +		if (kobject_add(tdm_kobj, NULL, "%s", "tdm")) {
> > +			pr_err("tdm: Sysfs creation failed\n");
> > +			kobject_put(tdm_kobj);
> > +			err =3D -EINVAL;
> > +			goto out;
> > +		}
> > +	} else {
> > +		pr_err("tdm: Unable to allocate tdm_kobj\n");
> > +		err =3D -ENOMEM;
> > +		goto out;
> > +	}
> > +
> > +out:
> > +	return err;
> > +}
>=20
> You just leaked memory, what are you trying to do here?
>=20
> And why are you using "raw" kobjects?  That's a sure sign that something
> is really wrong.
Will refer the documentation. Not very experienced on this stuff. Thanks fo=
r the comment.
>=20
> Your code doesn't look like it is tied into the driver model at all, why
> not?  What are you trying to do here?
This is a framework layer, not associated to a particular device. TDM adapt=
er drivers will register to this framework.
We got this comment in internal freescale review list also.
>=20
> Also, when creating new sysfs entries, like you are attempting to do here
> (unsuccessfully I might add), you must create Documentation/ABI/ files as
> well.
Ok.
>=20
> And, to top it all off, you do realize you are asking us to do code
> review in the middle of the merge window, when we are all busy doing
> other things?
Apologize for asking a review in the merge window time frame.
Are there any guidelines when to send something for a review? We will be ca=
reful next time.

Regards
Poonam
>=20
> greg k-h
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
