Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9C954B70F1
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 19:38:29 +1100 (EST)
Message-ID: <4CBC080A.7030005@windriver.com>
Date: Mon, 18 Oct 2010 16:40:42 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: CONFIG_FEC is not good for mpc8xx ethernet?
References: <AANLkTikNZ+LD-FZ_vK-R3Rfu7RzRSAL_zT4xbWgYL=8R@mail.gmail.com>
In-Reply-To: <AANLkTikNZ+LD-FZ_vK-R3Rfu7RzRSAL_zT4xbWgYL=8R@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Shawn Jin wrote:
> Hi,
> 
> My target is a mpc875 based board and has FEC ethernet. The phy is
> AM79C874. I have the following configuration for the network support.
> 
> CONFIG_PHYLIB=y
> CONFIG_NET_ETHERNET=y
> CONFIG_MII=y
> CONFIG_FS_ENET=y
> CONFIG_FS_ENET_HAS_FEC=y
> CONFIG_FS_ENET_MDIO_FEC=y
> 
> However I found that the phy support (AM79C874) is actually in
> drivers/net/fec.c which is compiled only when CONFIG_FEC=y. However

The phy driver should not be embedded into the NIC driver in theory.

I think you should include the phy driver, mdio-bitbang.c, which should be
support AMD79C874. But I'm not sure if it can work well based on your target and
maybe you have to fix/improve something.

Tiejun

> CONFIG_FEC is not on for mpc8xx targets, seen the dependency below.
> 
> config FEC
>         bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
>         depends on M523x || M527x || M5272 || M528x || M520x || M532x
> || MACH_MX27 || ARCH_MX35 || ARCH_MX25
>         help
>           Say Y here if you want to use the built-in 10/100 Fast ethernet
>           controller on some Motorola ColdFire and Freescale i.MX processors.
> 
> Does it mean that the phy driver for AM79C874 doesn't exist for MPC8xx
> and I'll have to write one for myself?
> 
> Thanks,
> -Shawn.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
