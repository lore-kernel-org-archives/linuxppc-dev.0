Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DF93BDDF57
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 06:28:18 +1100 (EST)
Date: Tue, 4 Dec 2007 13:32:20 -0600
From: Olof Johansson <olof@lixom.net>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 2/2] [POWERPC] pasemi: Register i2c_board_info
Message-ID: <20071204193220.GC5758@lixom.net>
References: <20071130032645.GA25580@lixom.net>
	<20071130032923.GB25580@lixom.net>
	<1196774926.13978.225.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1196774926.13978.225.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 04, 2007 at 01:28:46PM +0000, David Woodhouse wrote:
> 
> On Thu, 2007-11-29 at 21:29 -0600, Olof Johansson wrote:
> > +                               continue;
> > +
> > +                       info.addr = *addr;
> > +
> > +                       i2c_register_board_info(PCI_FUNC(pdev->devfn),
> > &info,
> > +                                               1);
> > +               }
> > +       }
> 
> +       /* Ensure that buses up to 2 are reserved */
> +       i2c_register_board_info(2, NULL, 0);
> +
> 
> 
> > +       return 0;
> > +}
> > +device_initcall(pasemi_register_i2c_devices);
> > +#endif
> 
> 
> Otherwise when you make i2c-pasemi use i2c_add_numbered_adapter(), it
> might fail to register the third bus -- because there were no devices
> preregistered on it, so something else might have stolen that bus number
> already.

Good point, I'd missed that. Thanks!

> You might want to add the patch to use i2c_add_numbered_adapter() to
> your tree, btw.

Yep, I realized that after (re)asking Paul to pull though, and didn't
want to do a third request before he's done it. :)

If he doesn't pull in the next few days I might just keep adding new
patches as they come in though, and add it back.


-Olof
