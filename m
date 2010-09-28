Return-Path: <yanok@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7CEFDB6F0D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 22:25:23 +1000 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de, vlad@emcraft.com
Subject: [RFC][PATCH 0/3] fixes and MPC8308 support for the mpc512x_dma driver
Date: Tue, 28 Sep 2010 14:24:53 +0200
Message-Id: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everybody,

I've found that mpc512x_dma doesn't work reliable in my tests (dmatest
module and NetPipe with CONFIG_NET_DMA enabled).
These patches fixes two issues I've found: inproper handling of
scatter/gather transfers and missing interrupts.
The third patch adds support for MPC8308 which has pretty much the same
DMA controller as MPC5121.

The first patch has an issue: I'm accessing IO space with direct memory
access not via accessor functions. I don't know how to use accessor
functions with bitfield structures.

Any comments would be appreciated.

With these patches applied my tests succeed both on MPC5121 and MPC8308.

Regards, Ilya.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>
