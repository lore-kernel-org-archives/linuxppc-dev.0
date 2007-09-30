Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id B02CCDDE36
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 07:39:42 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/7] Celleb: Support for Power/Reset buttons
Date: Sun, 30 Sep 2007 23:22:51 +0200
References: <20070926.132556.1723232353.kouish@swc.toshiba.co.jp>
	<200709261355.50310.arnd@arndb.de>
	<Pine.LNX.4.60.0709302259510.10318@poirot.grange>
In-Reply-To: <Pine.LNX.4.60.0709302259510.10318@poirot.grange>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709302322.52076.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 30 September 2007, you wrote:
>=20
> > kernel_restart() seems appropriate for that.
>=20
> Now a comment to this one says:
>=20
> =A0*=A0=A0=A0=A0=A0=A0This is not safe to call in interrupt context.
>=20
> and AFAIU, this is called from an interrupt. Am I missing anything or=20
> would this be wrong to call kernel_restart() here?

It should be called through a workqueue, afaics, do avoid calling
a sleeping notifier from an interrupt.

> > > +static irqreturn_t beat_reset_event(int virq, void *arg)
> > > +{
> > > +=A0=A0=A0printk(KERN_DEBUG "Beat: reset button pressed\n");
> > > +=A0=A0=A0beat_pm_poweroff_flag =3D 0;
> > > +=A0=A0=A0if (kill_cad_pid(SIGINT, 1)) {
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Just in case killing init proces=
s failed */
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0beat_restart(NULL);
> > > +=A0=A0=A0}
> > > +=A0=A0=A0return IRQ_HANDLED;
> > > +}
> >=20
> > same here, except calling kernel_halt() in the end.
>=20
> kernel_halt() doesn't have a similar comment, but it does call the=20
> kernel_shutdown_prepare() too, so, seems like it should not be called fro=
m=20
> an interrupt either?

yes

> Now, another question, is it generally good to hard-wire "reset" and=20
> "power-off" buttons in the kernel? Isn't it better to just register them=
=20
> as input event sources and let userspace (power-management daemon) decide=
=20
> what to do with them? Like poweroff / reboot / suspend / hibernate / ...

Tough question. I can see arguments for either way, but I guess I'd tend
to handling it in the kernel, choosing simplicity over consistency.

	Arnd <><
