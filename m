Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 6A49DB7BC5
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2009 18:55:36 +1100 (EST)
Received: by gxk28 with SMTP id 28so1719937gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Nov 2009 23:55:35 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4AF1FD46.9050101@austin.ibm.com>
References: <4AF1FB29.50905@austin.ibm.com> <4AF1FD46.9050101@austin.ibm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 5 Nov 2009 00:55:15 -0700
Message-ID: <fa686aa40911042355l73c7511bod3b2f651e9c9a5a4@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] Merge dynamic OF code to of_dynamic.c
To: Nathan Fontenot <nfont@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nathan,

Thanks for the patches.  Comments below.

On Wed, Nov 4, 2009 at 3:16 PM, Nathan Fontenot <nfont@austin.ibm.com> wrot=
e:
> Creation of the OF dynamic device tree update code in drivers/of. =A0This
> merges the common device tree updating routines to add/remove nodes and
> properties from powerpc and microblaze. =A0All of the new code is conditi=
onal
> based on a new OF_DYNAMIC config option.

Rather than one patch to create all the moved functions, and then
subsequent patches to remove the duplicates from each arch, I've been
using the pattern of one patch for each function or couple of
functions to both remove from the old files and add to the new home.
Would you be able to do the same for your patches here?  The merging
is complicated enough without having to track changes to a function
between separate commits.  Moving one function at a time will also
make bisecting more friendly.

Also, have you checked what impact these changes have on SPARC?

> --- linux-next.orig/drivers/of/Makefile 2009-11-03 11:18:08.000000000 -06=
00
> +++ linux-next/drivers/of/Makefile =A0 =A0 =A02009-11-03 13:42:35.0000000=
00 -0600
> @@ -1,6 +1,7 @@
> obj-y =3D base.o
> -obj-$(CONFIG_OF_DEVICE) +=3D device.o platform.o
> -obj-$(CONFIG_OF_GPIO) =A0 +=3D gpio.o
> -obj-$(CONFIG_OF_I2C) =A0 +=3D of_i2c.o
> -obj-$(CONFIG_OF_SPI) =A0 +=3D of_spi.o
> -obj-$(CONFIG_OF_MDIO) =A0+=3D of_mdio.o
> +obj-$(CONFIG_OF_DEVICE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D device.o pla=
tform.o
> +obj-$(CONFIG_OF_GPIO) =A0 =A0 =A0 =A0 =A0+=3D gpio.o
> +obj-$(CONFIG_OF_I2C) =A0 =A0 =A0 =A0 =A0 +=3D of_i2c.o
> +obj-$(CONFIG_OF_SPI) =A0 =A0 =A0 =A0 =A0 +=3D of_spi.o
> +obj-$(CONFIG_OF_MDIO) =A0 =A0 =A0 =A0 =A0+=3D of_mdio.o
> +obj-$(CONFIG_OF_DYNAMIC) =A0 =A0 =A0 +=3D of_dynamic.o

Unrelated whitespace churn makes it hard to see what actually changed.

Thanks,
g.


--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
