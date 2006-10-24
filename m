Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 96C5167B92
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Oct 2006 04:15:25 +1000 (EST)
In-Reply-To: <CAB1644F1C94A24BAC68B05D0F9774635CC446@VIECLEX01.frequentis.frq>
References: <CAB1644F1C94A24BAC68B05D0F9774635CC446@VIECLEX01.frequentis.frq>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <95309226-07A8-43E0-A03B-7D7E828D4429@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: MPC834x TSECs/Gianfar w/o MDIO accessible PHYs
Date: Tue, 24 Oct 2006 13:15:24 -0500
To: KRONSTORFER Horst <Horst.KRONSTORFER@frequentis.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Look at the driver in drivers/net/phy/fixed.c.  It probably needs  
some documentation, and Vitaly implied it needed a little tweaking,  
but it provides the basics of what you need (and what Dan  
mentioned).  Essentially, you need to fake the PHY.  However, if you  
wanted, you could also get smarter and write a new mdiobus driver,  
which handles configuring and using the switch.

I'm not quite sure why your approach isn't working, but I agree with  
Dan's suspicions that removing the PHY code doesn't just work.

One thing to check is the adjust_link() function.  You need to make  
sure that you have the carrier on, and that the MAC is set to MII  
mode, rather than GMII mode.

Andy

On Oct 24, 2006, at 04:16, KRONSTORFER Horst wrote:

> hi!
>
> in our design we use an mpc8343 with the 2 tsecs connected to a
> zarlink zl50411 eth switch in mii mode. the 2 ports of the switch
> are running in phy mode (reverse mii) w/o mdio. we're currently
> running kernel 2.6.17.13.
>
> i therefore 'simply' removed the mdio bus and phy support and tested
> with ping over tsec0. result: i can see arp requests which are some-
> what malformed (dest mac addr is not bcast, source ip addr is  
> incorrect,
> etc ...) btw: i used the same approach in u-boot and it works fine.
>
> i then checked the content of the sk_buff handed over to  
> gfar_start_xmit
> which is correct (mac addrs, ip addrs, ...)
>
> i'm currently out of ideas, any kind of help is appreciated!
>
> thanks
> -h
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
