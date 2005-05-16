Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DA7F7679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 01:31:10 +1000 (EST)
In-Reply-To: <0.20050516_092837.tnt@patchsend.246tNt.com>
References: <0.20050516_092837.tnt@patchsend.246tNt.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <5fe12cfac05d60b8af016382594e50db@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 16 May 2005 10:30:56 -0500
To: "Sylvain Munaut" <tnt@246tNt.com>
Cc: Asier Llano Palacios <a.llano@usyscom.com>,
	ML linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] i2c: Race fix for i2c-mpc.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain,

Are you really still using the OCP side of the driver?  Do we need a=20
similar fix for the platform driver side?

- kumar

On May 16, 2005, at 1:24 AM, Sylvain Munaut wrote:

> i2c: Race fix for i2c-mpc.c
>
> The problem was that the clock speed and driver data is
>  initialized after the i2c adapter was added. This caused
>  the i2c bus to start working at a wrong speed. (Mostly
> noticable on the second bus on mpc5200)
>
> With this patch we've tried to keep the i2c adapter
>  working perfectly all the time it is included in the system.
>  Initialize before added, Remove garbage after deleleted.
>
>
>
>  Submitted-by: Asier Llano Palacios
>  Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> ---
>  --- linux-2.6/drivers/i2c/busses/i2c-mpc.c=A0=A0=A0=A0=A0 2005-05-16=20=

> 09:08:02.000000000 +0200
>  +++ linux-2.6/drivers/i2c/busses/i2c-mpc.c=A0=A0=A0=A0=A0 2005-05-16=20=

> 09:09:51.000000000 +0200
>  @@ -333,6 +333,9 @@
>  =A0=A0=A0=A0=A0=A0=A0 } else
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 i2c->irq =3D 0;
>  =A0
>  +=A0=A0=A0=A0=A0=A0 mpc_i2c_setclock(i2c);
> +=A0=A0=A0=A0=A0=A0 ocp_set_drvdata(ocp, i2c);
>  +
>  =A0=A0=A0=A0=A0=A0=A0 i2c->adap =3D mpc_ops;
>  =A0=A0=A0=A0=A0=A0=A0 i2c_set_adapdata(&i2c->adap, i2c);
>  =A0
>  @@ -341,8 +344,6 @@
>  =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 goto fail_add;
>  =A0=A0=A0=A0=A0=A0=A0 }
>  =A0
>  -=A0=A0=A0=A0=A0=A0 mpc_i2c_setclock(i2c);
> -=A0=A0=A0=A0=A0=A0 ocp_set_drvdata(ocp, i2c);
>  =A0=A0=A0=A0=A0=A0=A0 return result;
>  =A0
>  =A0=A0=A0=A0=A0=A0 fail_add:
>  @@ -358,8 +359,8 @@
>  =A0static void __devexit mpc_i2c_remove(struct ocp_device *ocp)
>  =A0{
>  =A0=A0=A0=A0=A0=A0=A0 struct mpc_i2c *i2c =3D ocp_get_drvdata(ocp);
> -=A0=A0=A0=A0=A0=A0 ocp_set_drvdata(ocp, NULL);
>  =A0=A0=A0=A0=A0=A0=A0 i2c_del_adapter(&i2c->adap);
>  +=A0=A0=A0=A0=A0=A0 ocp_set_drvdata(ocp, NULL);
>  =A0
>  =A0=A0=A0=A0=A0=A0=A0 if (ocp->def->irq !=3D OCP_IRQ_NA)
> =A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0=A0=A0=A0=A0 free_irq(i2c->irq, i2c);
>  _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
