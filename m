Return-Path: <afleming@freescale.com>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D701494071@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D701494071@corpexc01.corp.networkrobots.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=WINDOWS-1252; delsp=yes; format=flowed
Message-Id: <35376E92-5F62-4CFD-8B50-3B687EC774B0@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Trying 10/HALF
Date: Tue, 22 Jan 2008 14:55:31 -0600
To: Siva Prasad <sprasad@bivio.net>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 9, 2008, at 13:35, Siva Prasad wrote:

> Hi,
>
>
>
> After booting, my MPC8641 based board keeps printing =93Trying 10/=20
> HALF=94 for ever. I am unable to use the Ethernet, even though there =20=

> are interrupts occuring. Based on /proc/interrupts, both tx and rx =20
> interrupt count is increasing, and zero count for enet_error =20
> interrupt.
>
>
>
> I think this is coming from drivers/net/phy/phy.c during =20
> autonegotiation. However, I am not sure how to take care of this. =20
> Appreciate some pointers.
>


Hm.  That's a bit strange.  What kind of PHY are you using?  The PHY =20
layer acts like that if auto-negotiation fails and it couldn't =20
establish a link using any other method.

Some things to double-check:

* Are your etsec interrupts correct in your dts.  Shouldn't be an =20
issue, but if you copied them from the wrong place, or used an out-of-=20=

date dts, the numbers could be wrong

* Are your PHY interrupts correct in your dts.  If the PHY interrupts =20=

are wrong, the PHY Lib might never discover that a link was established

Andy=
