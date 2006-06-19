Return-Path: <linuxppc-dev@tonarchiv.ch>
Received: from hosting.substring.ch (hosting.substring.ch [80.242.134.171])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D05B267B24
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 00:33:16 +1000 (EST)
Received: from [192.168.168.101] (i577B0954.versanet.de [87.123.9.84])
	(authenticated bits=0)
	by hosting.substring.ch (8.13.5/8.13.5/SuSE Linux 0.6) with ESMTP id
	k5JEImlZ013060
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jun 2006 16:18:52 +0200
Subject: L3 cache on Apple dual processor (7450 r 2.1) question
From: Till Wimmer <linuxppc-dev@tonarchiv.ch>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 19 Jun 2006 16:17:04 +0200
Message-Id: <1150726624.4711.16.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

i tried to enable the L3 cache on my dual 800MHz processor board (taken
from Quicksilver). I'm running the 2.6.8-3-powerpc-smp kernel from
Debian.

I changed the code for in core99_init_caches() in
arch/ppc/platforms/pmac_smp.c because the cache wasn't enabled by
default:

        if (cpu == 0){
                _set_L3CR(0);
                _set_L3CR(0x9F424340);
                core99_l3_cache = _get_L3CR();
                printk("CPU0: L3CR is %lx\n", core99_l3_cache);
        } else {
                printk("CPU%d: L3CR was %lx\n", cpu, _get_L3CR());
                _set_L3CR(0);
                _set_L3CR(core99_l3_cache);
		printk("CPU%d: L3CR is %lx\n", cpu, _get_L3CR());
        }
Now my questions are:
Is there anything else to do for getting the L3 cache working?
How can i check if the L3 is enabled? E.g. is there a benchmark program
which accounts for cache settings?

Thanx
Till
