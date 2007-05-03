Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 78C54DDFEC
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 16:53:56 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Date: Thu, 3 May 2007 08:53:17 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000043.GK4046@mag.az.mvista.com>
	<20070502214416.GD27253@xyzzy.farnsworth.org>
In-Reply-To: <20070502214416.GD27253@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705030853.17749.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 02 May 2007, Dale Farnsworth wrote:
> +=A0=A0=A0=A0=A0=A0=A0static int called_count;
> +=A0=A0=A0=A0=A0=A0=A0int instance =3D called_count++;

I would think it's simpler to count the instances in the outer loop
when looking for the devices than having a static counter here.

> +       pdev =3D platform_device_register_simple(MV64XXX_I2C_CTLR_NAME,
> +                                              instance, r, 2);
> +       if (IS_ERR(pdev))
> +               return PTR_ERR(pdev);
> +
> +       err =3D platform_device_add_data(pdev, &pdata, sizeof(pdata));
> +       if (err) {
> +               platform_device_unregister(pdev);
> +               return err;

Doing the initialization in this order means that you have to add the
devices before the driver is loaded. I haven't checked if you do
the same thing in the oder places as well, but I think it would be
better to do it open coded like

	pdev =3D platform_device_alloc(MV64XXX_I2C_CTLR_NAME, instance);
	if (!pdev)
		return -ENOMEM;
	err =3D platform_device_add_resources(pdev, r, 2);
	if (err)
		goto error;
	err =3D platform_device_add_data(pdev, &pdata, sizeof(pdata));
	if (err)
		goto error;
	err =3D platform_device_add(pdev);
	if (err)
		goto error;
	return pdev;
error:
	platform_device_put(pdev);
	return ERR_PTR(err);


	Arnd <><
