Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id A4BC0679F1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Jun 2005 02:06:34 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so703702wri
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 09:06:32 -0700 (PDT)
Message-ID: <528646bc050610090654d01bbe@mail.gmail.com>
Date: Fri, 10 Jun 2005 10:06:32 -0600
From: Grant Likely <glikely@gmail.com>
To: Sylvain Munaut <tnt@246tnt.com>
In-Reply-To: <42A99F1C.50104@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc05060907544d58da41@mail.gmail.com>
	<02ea73261175dc6bfb99047e73395fb1@freescale.com>
	<528646bc050609114857191ca7@mail.gmail.com>
	<42A99F1C.50104@246tNt.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC52xx: sysfs failure on adding new device driver
Reply-To: Grant Likely <glikely@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 6/10/05, Sylvain Munaut <tnt@246tnt.com> wrote:
> Hi Grant
>=20
> > +     /* Assign driver names to PSC devices */
> > +     ppc_sys_platform_devices[MPC52xx_PSC1].name =3D "mpc52xx-psc.uart=
";
> > +     ppc_sys_platform_devices[MPC52xx_PSC2].name =3D "mpc52xx-psc.uart=
";
> > +     ppc_sys_platform_devices[MPC52xx_PSC3].name =3D "mpc52xx-psc.spi"=
;
>=20
> Yes, I kinda like that. That maybe the cleanest way, just 1 line of code
> per device and when no subfn is assigned, nothing is loaded.
>=20
> I don't really like messing manually with the ppc_sys_platform
> "internals" outside of the ppc_sys code, but maybe creating a call like
>=20
> ppc_sys_assign_subfn(MPC52xx_PSC1,"uart");
>=20
>=20
> and place it in the ppc_sys code so that other platforms havin such
> "multi usage" device all have an uniform way of handling that. Galak ?
Hmm, yes...  I like this better.  I was also uncomfortable with
messing with the table directly.  A function like that can make sure
that the table is not modified after it is registered with the
platform bus; or if it is, make sure that a driver has not yet been
assigned and that sysfs is properly updated.  It would protect against
doing something stupid like:

ppc_sys_platform_devices[MPC52xx_MSCAN1].name =3D "mpc52xx-psc.uart";

g.
