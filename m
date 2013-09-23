Return-Path: <thierry.reding@gmail.com>
Received: from mail-bk0-x22d.google.com (mail-bk0-x22d.google.com
 [IPv6:2a00:1450:4008:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 901792C00FE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 18:37:31 +1000 (EST)
Received: by mail-bk0-f45.google.com with SMTP id mx11so1055012bkb.32
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 01:37:26 -0700 (PDT)
Date: Mon, 23 Sep 2013 10:36:06 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 07/10] of/irq: Propagate errors in
 of_irq_to_resource_table()
Message-ID: <20130923083605.GC11881@ulmo>
References: <1379510692-32435-1-git-send-email-treding@nvidia.com>
 <1379510692-32435-8-git-send-email-treding@nvidia.com>
 <CAL_JsqJ+4P26hRrJcrbBmwfNPDAS+1GhXj12B+UvqmZZGjqT0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
In-Reply-To: <CAL_JsqJ+4P26hRrJcrbBmwfNPDAS+1GhXj12B+UvqmZZGjqT0g@mail.gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Russell King <linux@arm.linux.org.uk>, linux-mips@linux-mips.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>, sparclinux@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 22, 2013 at 04:08:26PM -0500, Rob Herring wrote:
> On Wed, Sep 18, 2013 at 8:24 AM, Thierry Reding
> <thierry.reding@gmail.com> wrote:
> > Now that all helpers return precise error codes, this function can
> > propagate these errors to the caller properly.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Changes in v2:
> > - return 0 on success or a negative error code on failure
> > - convert callers to new calling convention
>=20
> [snip]
>=20
> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> > index e4f38c0..6d7f824 100644
> > --- a/drivers/of/irq.c
> > +++ b/drivers/of/irq.c
> > @@ -397,18 +397,20 @@ int of_irq_count(struct device_node *dev)
> >   * @res: array of resources to fill in
> >   * @nr_irqs: the number of IRQs (and upper bound for num of @res eleme=
nts)
>=20
> You are effectively changing this to require an exact match rather
> than an upper bound. That seems to be okay since that is what all the
> callers want, but the documentation should be updated.

Done.

> >   *
> > - * Returns the size of the filled in table (up to @nr_irqs).
> > + * Returns 0 on success or a negative error code on failure.
> >   */
> >  int of_irq_to_resource_table(struct device_node *dev, struct resource =
*res,
> >                 int nr_irqs)
> >  {
> > -       int i;
> > +       int i, ret;
> >
> > -       for (i =3D 0; i < nr_irqs; i++, res++)
> > -               if (!of_irq_to_resource(dev, i, res))
>=20
> The error handling here needs to be updated in the previous patch.

Yes, you're right.

Thanks,
Thierry

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSP/11AAoJEN0jrNd/PrOh9SkP/0eqpECG/DCrq/PRvyVz1O5b
HRQn8Z6vwNDHfFBuxndtGEyyp28LmnxqIsFkooksR+VP/ZPnvcL68Db8p7ta3r2l
9AK8X2uESqu8/zIsqYHM0bjNICoVmwlRfuEUKkMXbta5j2jVH+Z6cgBcf2rhd7Dm
GAXRuRdnvrRy43GwUS0WzGYWH/zeihR1lI/dzPjaW4AYmfb8PSB43+sHV+Cev5j+
mldi6zYZa9N+ozEEhD4yY7hhGr5epkLypKFN4ihms9NUuPdBs/vZN1MBc+01PlTd
Etmy0NfoZDc/0yV+cQczelQ4dweAWFt+7mqNVpPtYWSLY4TiVqMqhTjXHmV8A1lV
1TMvhzABTRuTqQt9AvKkeFuarNRqBMp5CKLlHYhYJ9ggiXlA8G3xUAUaNoNQqeVG
OmoMFLpHzfntFyv8k5+WSi5L/aukFh0UPaVk4/O68IK3tfh+cGOGptgszLV2k2Aw
nKn8xPq3K7ByyEF5F1wmzceSNCiFm8irFVhKWWAIk8HIBHAs5hw1nqPQsscmcIDT
63AHK92IqEQo+YwO63Z7S8PFgZ3JSl+1LpzpjjP9v68B+UI9jQiaJaQ4sD3CP4L5
cdF6MYLhPjxwsFY4LkZWRjFBopaI7+l8XMjkobiKed9cQKJyg2DuJAEu19nRMP8s
txsDsmA/HZfN7bgreMBW
=bK7L
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
