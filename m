Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CC511B6EDF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 03:11:21 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 6/9] RapidIO: Add switch-specific sysfs initialization
	callback
Date: Mon, 16 Aug 2010 10:10:54 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D5FFC@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C692E4C.4040300@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-7-git-send-email-alexandre.bounine@idt.com>
	<4C692E4C.4040300@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen wrote:
>=20
> Alexandre Bounine wrote:
> > -	if (!rdev->rswitch)
> > -		goto out;
> > -
>=20
> Is it safe? All devices have a switch?

Yes. Because end-points should not have the "routes" attribute at all
(corrected by this patch).

>=20
> > @@ -63,10 +59,11 @@ struct device_attribute rio_dev_attrs[] =3D {
> >  	__ATTR_RO(asm_did),
> >  	__ATTR_RO(asm_vid),
> >  	__ATTR_RO(asm_rev),
> > -	__ATTR_RO(routes),
> >  	__ATTR_NULL,
> >  };
> >
> > +static DEVICE_ATTR(routes, S_IRUGO, routes_show, NULL);
> > +
>=20
> This seems a separate change from the sw_sysfs? Why make it separate?

I assume that your question was "Why do not make it separate?"
Both changes are specific to switches, both address sysfs and both are
not big enough to justify
a separate patch.
I agree that make separate patches would give more clarity, so would do
better description.
Because there are changes that should be made to other patches in this
set, I will regenerate this patch with better description.

>=20
> >   */
> >  struct rio_switch {
> > @@ -256,6 +257,7 @@ struct rio_switch {
> >  			   u8 *sw_domain);
> >  	int (*em_init) (struct rio_dev *dev);
> >  	int (*em_handle) (struct rio_dev *dev, u8 swport);
> > +	int (*sw_sysfs) (struct rio_dev *dev, int create);
> >  	struct rio_dev *nextdev[0];
> >  };
>=20
> Why not make a sw_sysfs_create and sw_sysfs_remove? Is better for
> readability. Now you call 'sw_sysfs(dev, 0)' or 'sw_sysfs(dev, 1)';

I just do not want to have an extra member here. Not every switch will
require own sysfs attributes, but every switch will be presented by a
data structure. Based on its intended use I do not see any problem here.
