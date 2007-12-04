Return-Path: <SRS0+d99126679a6468e47a3e+1563+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 58BDEDDF56
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 00:28:55 +1100 (EST)
Subject: Re: [PATCH 2/2] [POWERPC] pasemi: Register i2c_board_info
From: David Woodhouse <dwmw2@infradead.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071130032923.GB25580@lixom.net>
References: <20071130032645.GA25580@lixom.net>
	<20071130032923.GB25580@lixom.net>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 13:28:46 +0000
Message-Id: <1196774926.13978.225.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-29 at 21:29 -0600, Olof Johansson wrote:
> +                               continue;
> +
> +                       info.addr = *addr;
> +
> +                       i2c_register_board_info(PCI_FUNC(pdev->devfn),
> &info,
> +                                               1);
> +               }
> +       }

+       /* Ensure that buses up to 2 are reserved */
+       i2c_register_board_info(2, NULL, 0);
+


> +       return 0;
> +}
> +device_initcall(pasemi_register_i2c_devices);
> +#endif


Otherwise when you make i2c-pasemi use i2c_add_numbered_adapter(), it
might fail to register the third bus -- because there were no devices
preregistered on it, so something else might have stolen that bus number
already.

You might want to add the patch to use i2c_add_numbered_adapter() to
your tree, btw.

-- 
dwmw2
