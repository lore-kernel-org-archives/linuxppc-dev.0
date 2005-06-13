Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.194])
	by ozlabs.org (Postfix) with ESMTP id 7EF61679E8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Jun 2005 05:08:54 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so1501471wri
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Jun 2005 12:08:53 -0700 (PDT)
Message-ID: <528646bc050613120818806fad@mail.gmail.com>
Date: Mon, 13 Jun 2005 13:08:53 -0600
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
> > In the mean time, here's another option:  Leave
> > arch/ppc/syslib/mpc52xx_devices.c alone, but modify the table in the
> > board setup code to assign specific drivers to the PSC devices before
> > the table is parsed by the platform bus.  This has the added advantage
> > of eliminating the need for mpc52xx_match_psc_function() and it's
> > cousins.
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

I'm continuing to look at this problem and I'm trying to figure out
how pc_sys_assign_subfn() could be implemented.  One issue with this
approach is that the function needs to know what the 'base name' of
the device is.  With the current ppc_sys_platform_device scheme, there
is only the .name field in the platform_device structure.  The first
time ppc_sys_assign_subfn is called on a device it can simply allocate
a new string buffer and concatenate the original value of .name with a
seperator and the function name.

For example (pseudocode):
before:   .name =3D "mpc52xx-psc";  func=3D"uart";
newname=3Dkmalloc(strlen(.name) + 1 + strlen(func), GFP_KERNEL)
strcpy(newname, .name);
newname[strlen(.name)] =3D ':';
strcpy(newname+strlen(.name)+1, func);
.name =3D buff;  /* Note original value of .name is not freed; it was
statically allocated */
after:  .name =3D "mpc52xx-psc:uart"

If ppc_sys_platform_device is called a second time on the same device,
it needs to free the new buffer, otherwise we have a small memory
leak.  However, the function has no easy way to determine if it is
being called a second time.

I see a few of solutions here:

1. Wrap the 'platform_device' structure with a new structure that
includes a .basename field.  Default declarations of devices should
set .name to NULL and ppc_sys_assign_subfn() will always use .basename
as a prefix.  Any buffer pointed to by .name will always be freed
before assigning new value.

2. Make ppc_sys_assign_subfn() look for the seperator special
character (':' in example).  If the special character is there, make
the assumption that a subfn has already been assigned and the old
value should be freed.  However, this causes problems if the default
device tree wants to specify a default subfunction.

3. Never free the value of .name.  This assumes that once the subfn is
set it will never be changed during runtime and so the function will
only ever replace the original (statically allocated) value of .name.=20
I think this option should be avoided; I don't think that the
assumption is appropriate.  There may very well be boards that need to
change the function of a PSC without rebooting.

At the moment, I think option #1 is the cleanest, but it is a little invasi=
ve.

Thoughts?
g.
