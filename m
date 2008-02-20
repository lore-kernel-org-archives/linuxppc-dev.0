Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-102-tuesday.nerim.net [62.4.16.102])
	by ozlabs.org (Postfix) with ESMTP id 90B54DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 17:57:33 +1100 (EST)
Date: Wed, 20 Feb 2008 07:57:31 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Message-ID: <20080220075731.7675bbbb@hyperion.delvare>
In-Reply-To: <200802192355.17707.arnd@arndb.de>
References: <4784FED1.2040206@pikatech.com>
	<20080219092321.1fed233d@hyperion.delvare>
	<200802190959.41253.sr@denx.de> <200802192355.17707.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>, i2c@lm-sensors.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Arnd,

On Tue, 19 Feb 2008 23:55:16 +0100, Arnd Bergmann wrote:
> On Tuesday 19 February 2008, Stefan Roese wrote:
> > On Tuesday 19 February 2008, Jean Delvare wrote:
> > >
> > > With this Kconfig change, "make menuconfig" lets me select the
> > > i2c-ibm_iic driver on x86_64, but it fails to build horribly. I think
> > > that you want to restrict the build to PPC machines somehow, or at
> > > least make sure that either IBM_OCP or OF support is present.
> >=20
> > How about this:
> >=20
> > -=A0=A0=A0=A0=A0=A0=A0depends on IBM_OCP
> > +=A0=A0=A0=A0=A0=A0=A0depends on 4xx
>=20
> I think we should allow it to be built on other platforms as well,
> as long as they have of_platform_device support.
>=20
> The Axon south bridge used on IBMs QS21 blade probably has an ibm_iic,
> even though it's managed by the firmware and we probably don't want
> to use it at this time, someone could use the same chip in a new
> design and actually do that.
>=20
> In general, I also like to make it possible to enable drivers just
> for the benefit of compile testing, even for stuff that you can't
> find in any existing HW configuration, so as long as it builds on
> a platform, I think we shouldn't forbid it:

Fine with me as long as the default is set appropriately (i.e. default
to not building the driver on archs/platforms where it builds but is
known to be useless.)

>=20
> -       depends on IBM_OCP
> +       depends on IBM_OCP || PPC_MERGE

--=20
Jean Delvare
