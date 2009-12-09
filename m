Return-Path: <to-fleischer@t-online.de>
Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
	by ozlabs.org (Postfix) with ESMTP id C3BA9B6EFE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 10 Dec 2009 06:14:21 +1100 (EST)
Resent-Message-ID: <200912092013.54352.to-fleischer@t-online.de>
From: Torsten Fleischer <to-fleischer@t-online.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: spi_mpc8xxx.c: chip select polarity problem
Date: Wed, 9 Dec 2009 20:13:30 +0100
References: <200911161742.46663.to-fleischer@t-online.de>
	<200912091649.19380.to-fleischer@t-online.de>
	<fa686aa40912090946m12fe293cg2efb043cb7a7f573@mail.gmail.com>
In-Reply-To: <fa686aa40912090946m12fe293cg2efb043cb7a7f573@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200912092013.30831.to-fleischer@t-online.de>
Cc: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Dec 9, 2009 at 18:46:51 Grant Likely wrote:
[...]
> > +               ret = of_get_spi_cs_active_state(np, i, &astate);
> > +               if (ret) {
> > +                       dev_err(dev, "can't get cs active state of device
> > " +                               "#%d: %d\n", i, ret);
> > +                       goto err_loop;
> > +               }
> 
> This is a bit heavy handed in that it expects the device tree to be
> fully populated with all SPI devices which isn't always a given.  For
> example a board that has some unpopulated SPI devices could have some
> gaps in the GPIO CS layout.  If a node can't be found, then just
> ignore it silently and move on to the next.  I'd do something like
> this:
> 
> +               astate = of_get_spi_cs_active_state(np, i);

What should be returned if the node can't be found, 'true' or 'false? 

Maybe its better to do the following:

+               ret = of_get_spi_cs_active_state(np, i, &astate);
+               if (ret) {
+                       /* Device node not found */
+                       continue;
+               }

>                ret = gpio_direction_output(pinfo->gpios[i],
> -                                           pinfo->alow_flags[i]);
> +                                           pinfo->alow_flags[i] ^ !astate);
> 
> BTW, why the xor?  The usage is non-obvious enough that I'd like to
> see a comment describing the use case.
 
If I understand it right, the alow_flags describe the wiring. If set to 0 the 
wiring is non-inverted, if set to 1 its inverted respectively. To take this 
into account the active state has to be xor'd with the appropriate alow_flag.
 
