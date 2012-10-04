Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F36DB2C03AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2012 05:09:37 +1000 (EST)
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH 3/5] rapidio: run discovery as an asynchronous process
Date: Thu, 4 Oct 2012 19:08:27 +0000
Message-ID: <8D983423E7EDF846BB3056827B8CC5D1499FC7D9@corpmail2.na.ads.idt.com>
References: <1349291923-22860-1-git-send-email-alexandre.bounine@idt.com>
 <1349291923-22860-4-git-send-email-alexandre.bounine@idt.com>
 <20121003152953.79aecece.akpm@linux-foundation.org>
In-Reply-To: <20121003152953.79aecece.akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, October 03, 2012 6:30 PM
Andrew Morton <akpm@linux-foundation.org> wrote:
>=20
> On Wed,  3 Oct 2012 15:18:41 -0400
> Alexandre Bounine <alexandre.bounine@idt.com> wrote:
>=20
> > ...
> >
> > +static void __devinit disc_work_handler(struct work_struct *_work)
> > +{
> > +	struct rio_disc_work *work =3D container_of(_work,
> > +						  struct rio_disc_work, work);
>=20
> There's a nice simple way to avoid such ugliness:
>=20
> --- a/drivers/rapidio/rio.c~rapidio-run-discovery-as-an-asynchronous-
> process-fix
> +++ a/drivers/rapidio/rio.c
> @@ -1269,9 +1269,9 @@ struct rio_disc_work {
>=20
>  static void __devinit disc_work_handler(struct work_struct *_work)
>  {
> -	struct rio_disc_work *work =3D container_of(_work,
> -						  struct rio_disc_work, work);
> +	struct rio_disc_work *work;
>=20
> +	work =3D container_of(_work, struct rio_disc_work, work);
>  	pr_debug("RIO: discovery work for mport %d %s\n",
>  		 work->mport->id, work->mport->name);
>  	rio_disc_mport(work->mport);
> _
>=20

Thank you for the fix. Will avoid that ugliness in the future.

> > +	pr_debug("RIO: discovery work for mport %d %s\n",
> > +		 work->mport->id, work->mport->name);
> > +	rio_disc_mport(work->mport);
> > +
> > +	kfree(work);
> > +}
> > +
> >  int __devinit rio_init_mports(void)
> >  {
> >  	struct rio_mport *port;
> > +	struct rio_disc_work *work;
> > +	int no_disc =3D 0;
> >
> >  	list_for_each_entry(port, &rio_mports, node) {
> >  		if (port->host_deviceid >=3D 0)
> >  			rio_enum_mport(port);
> > -		else
> > -			rio_disc_mport(port);
> > +		else if (!no_disc) {
> > +			if (!rio_wq) {
> > +				rio_wq =3D alloc_workqueue("riodisc", 0, 0);
> > +				if (!rio_wq) {
> > +					pr_err("RIO: unable allocate rio_wq\n");
> > +					no_disc =3D 1;
> > +					continue;
> > +				}
> > +			}
> > +
> > +			work =3D kzalloc(sizeof *work, GFP_KERNEL);
> > +			if (!work) {
> > +				pr_err("RIO: no memory for work struct\n");
> > +				no_disc =3D 1;
> > +				continue;
> > +			}
> > +
> > +			work->mport =3D port;
> > +			INIT_WORK(&work->work, disc_work_handler);
> > +			queue_work(rio_wq, &work->work);
> > +		}
> > +	}
>=20
> I'm having a lot of trouble with `no_disc'.  afacit what it does is to
> cease running async discovery for any remaining devices if the
> workqueue
> allocation failed (vaguely reasonable) or if the allocation of a single
> work item failed (incomprehensible).
>=20
> But if we don't run discovery, the subsystem is permanently busted for
> at least some devices, isn't it?

This is correct. We are considering ways to restart discovery
process later but it is not applicable now.

>=20
> And this code is basically untestable unless the programmer does
> deliberate fault injection, which makes it pretty much unmaintainable.
>=20
> So...  if I haven't totally misunderstood, I suggest a rethink is in
> order?
>

I will review and simplify. Probably, just try to allocate all required
resources ahead of port list scan. Simple and safe.
=20
> > +	if (rio_wq) {
> > +		pr_debug("RIO: flush discovery workqueue\n");
> > +		flush_workqueue(rio_wq);
> > +		pr_debug("RIO: flush discovery workqueue finished\n");
> > +		destroy_workqueue(rio_wq);
> >  	}
