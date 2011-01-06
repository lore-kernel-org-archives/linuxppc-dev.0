Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 14BB6B713F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Jan 2011 06:43:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RapidIO: question about rionet probe call
Date: Thu, 6 Jan 2011 11:43:17 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520172675B@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTi=ns4-bz1JBdzjX0tvqNuEDRiM6UpmzMu_Fr8cw@mail.gmail.com>
References: <AANLkTi=ns4-bz1JBdzjX0tvqNuEDRiM6UpmzMu_Fr8cw@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Thomas Taranowski" <tom@baringforge.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Did you change anything in RIO initialization sequence?
For multiple mport support I had to adjust rio_init_mports/rio_init
sequence.

Alex.

> -----Original Message-----
> From: =
linuxppc-dev-bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org
[mailto:linuxppc-dev-
> bounces+alexandre.bounine=3Didt.com@lists.ozlabs.org] On Behalf Of
Thomas Taranowski
> Sent: Thursday, January 06, 2011 3:27 AM
> To: linuxppc-dev@lists.ozlabs.org
> Subject: RapidIO: question about rionet probe call
>=20
> I'm doing some work to support multiple mport architectures, and have
> run into an issue where the rionet_probe() function isn't being
> called, so my rionet net device never get's created.  I've also
> verified that the rio_device_probe() isn't being called either.
>=20
> The low level rio bus driver initializes and probes correctly, and
> creates the required entries in sysfs.  Then, later, I see the
> rionet_init get called and return success, indicating it registered
> with the rapidio bus correctly, so everything looks good.
>=20
>=20
> I see the following output (extra debug prints added) , indicating the
> rionet driver is being added, but it never gets probed afterward.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ~~~ rio_register_driver ~~~
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~
> bus: 'rapidio': add driver rionet
> initializing klist
> init and added kobj, err=3D0
> driver_create_file err=3D0
> driver added attrs, err=3D0
> returning 0
> RIO: rionet_init rio_register_driver: rc=3D0
>=20
>=20
> Any ideas on why rionet isn't being probed?  Is rionet currently
working?
> I'm running a 2.6.36-rc8 baseline.
>=20
> Thanks,
> Thomas Taranowski
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
