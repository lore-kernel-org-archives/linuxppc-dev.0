Return-Path: <shawnxjin@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 5799FB70E2
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 19:13:32 +1100 (EST)
Received: by ewy24 with SMTP id 24so723665ewy.15
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Oct 2010 01:13:30 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 18 Oct 2010 01:13:30 -0700
Message-ID: <AANLkTikNZ+LD-FZ_vK-R3Rfu7RzRSAL_zT4xbWgYL=8R@mail.gmail.com>
Subject: CONFIG_FEC is not good for mpc8xx ethernet?
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcdev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

My target is a mpc875 based board and has FEC ethernet. The phy is
AM79C874. I have the following configuration for the network support.

CONFIG_PHYLIB=y
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_FS_ENET=y
CONFIG_FS_ENET_HAS_FEC=y
CONFIG_FS_ENET_MDIO_FEC=y

However I found that the phy support (AM79C874) is actually in
drivers/net/fec.c which is compiled only when CONFIG_FEC=y. However
CONFIG_FEC is not on for mpc8xx targets, seen the dependency below.

config FEC
        bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
        depends on M523x || M527x || M5272 || M528x || M520x || M532x
|| MACH_MX27 || ARCH_MX35 || ARCH_MX25
        help
          Say Y here if you want to use the built-in 10/100 Fast ethernet
          controller on some Motorola ColdFire and Freescale i.MX processors.

Does it mean that the phy driver for AM79C874 doesn't exist for MPC8xx
and I'll have to write one for myself?

Thanks,
-Shawn.
