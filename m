Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 7AA97DDF76
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 16:26:33 +1100 (EST)
Date: Wed, 21 Jan 2009 21:26:34 -0800 (PST)
Message-Id: <20090121.212634.237965647.davem@davemloft.net>
To: linuxppc-dev@ozlabs.org
Subject: perf_counter vs. oprofile
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, I just noticed that right now if perf counter is enabled, the
oprofile module load will always fail because the powerpc perf counter
support unconditionally grabs the PMC hardware using
reserve_pmc_hardware() in an arch_initcall()

There really needs to be a way to segregate these multiple users of
the PMC device.  For example, if I'm not using the perf counter
APIs at all I should be able to use oprofile if I want to.

Anyways, just FYI...
