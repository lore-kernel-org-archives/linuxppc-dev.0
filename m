Return-Path: <glikely@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.202])
	by ozlabs.org (Postfix) with ESMTP id C2410679F6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 00:54:44 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id 57so259975wri
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 09 Jun 2005 07:54:42 -0700 (PDT)
Message-ID: <528646bc05060907544d58da41@mail.gmail.com>
Date: Thu, 9 Jun 2005 08:54:42 -0600
From: Grant Likely <glikely@gmail.com>
To: Sylvain Munaut <tnt@246tnt.com>
In-Reply-To: <42A827DC.8000803@246tNt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <528646bc05060816514c2d5860@mail.gmail.com>
	<42A827DC.8000803@246tNt.com>
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

On 6/9/05, Sylvain Munaut <tnt@246tnt.com> wrote:
>=20
> Grant Likely wrote:
> >>From what I can tell, I should be able to register more than one
> > driver for a particular device name (mpc52xx_psc).
>=20
> I always assumed that yes.
> But now looking more closely, I'm not sure what I based that assumption
> on ... And if not the case that's indeed a problem because that's what's
> used to support the different function supported by the PSCs.
I was assuming so too, and it seems that the device structure would
support it.  Who would know the answer to this?

>=20
> > Otherwise I would
> > need to change arch/ppc/syslib/mpc52xx_devices.c to have a different
> > name for each psc.
>=20
> No you shouldn't have to touch that. The
> mpc52xx_match_psc_function(idx, "spi") is there to know which driver
> should be used for what PSC and you're using it correctly so it _should_
> work.
I thought so, if I disable the mpc52xx_uart driver then my driver will
register correctly.  I agree that it is not desireable to touch
mpc52xx_devices.c
>=20
> > If I change the sysfs code to ignore the failure
> > to create a directory then the driver seems to register fine.
>=20
> A "better" quick-fix would be to change the platform_match
> (drivers/platform.c) to support "sub-fonctions". For example when using
> mpc52xx_psc.spi it only matches what's before the dot (if any) with the
> device name.
... so that a different directory will be created in sysfs for each
driver?  That's got possibilities.

>=20
> That changes the semantic of the driver names for the platform bus
> however, making the dot a "special" char.
Who needs to be asked about this?  Should I take this discussion over
the the LKML?

Thanks,
g.
