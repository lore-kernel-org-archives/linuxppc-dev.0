Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45AC2DDE37
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Jul 2007 23:23:06 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id l64DN2QL164018
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2007 13:23:02 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l64DN2Xt1691728
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2007 15:23:02 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l64DN1wu023484
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Jul 2007 15:23:02 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
To: "Akinobu Mita" <akinobu.mita@gmail.com>
Subject: Re: [PATCH 1/2] eHEA: Capability flag for DLPAR support
Date: Wed, 4 Jul 2007 14:58:11 +0200
References: <200707041209.37127.ossthema@de.ibm.com>
	<961aa3350707040553m12ff1bccw9421e714337c80d1@mail.gmail.com>
In-Reply-To: <961aa3350707040553m12ff1bccw9421e714337c80d1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707041458.12792.ossthema@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jeff Garzik <jeff@garzik.org>,
	Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

good catch.

Thanks

On Wednesday 04 July 2007 14:53, Akinobu Mita wrote:
> 2007/7/4, Jan-Bernd Themann <ossthema@de.ibm.com>:
> 
> > diff --git a/drivers/net/ehea/ehea_main.c b/drivers/net/ehea/ehea_main.c
> > index bdb5241..f8c0908 100644
> > --- a/drivers/net/ehea/ehea_main.c
> > +++ b/drivers/net/ehea/ehea_main.c
> > @@ -2923,6 +2923,15 @@ static int check_module_parm(void)
> >         return ret;
> >  }
> >
> > +static ssize_t ehea_show_capabilities(struct device_driver *drv,
> > +                                     char *buf)
> > +{
> > +       return sprintf(buf, "%d", EHEA_CAPABILITIES);
> > +}
> > +
> > +static DRIVER_ATTR(capabilities, S_IRUSR | S_IRGRP | S_IROTH,
> > +                  ehea_show_capabilities, NULL);
> > +
> >  int __init ehea_module_init(void)
> >  {
> >         int ret;
> > @@ -2937,12 +2946,20 @@ int __init ehea_module_init(void)
> >         if (ret)
> >                 ehea_error("failed registering eHEA device driver on ebus");
> >
> 
> You forgot to put:
>                 return ret;
> or
>                 goto out;
> 
> > +       ret = driver_create_file(&ehea_driver.driver, &driver_attr_capabilities);
> > +       if (ret) {
> > +               ehea_error("failed to register capabilities attribute, ret=%d", ret);
> > +               ibmebus_unregister_driver(&ehea_driver);
> > +               goto out;
> > +       }
> > +
> >  out:
> >         return ret;
> >  }
> >
> 
