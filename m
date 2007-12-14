Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D0071DE00A
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 15:51:30 +1100 (EST)
Date: Thu, 13 Dec 2007 22:51:26 -0600 (CST)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/6] xics.c and time.c optimizations
Message-Id: <mm-cpu-0@bga.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches against for-2.2.25 do some optimizations related
to the usage smp_processor_id().  

The xics one has been tested on SMP on 2.6.23, and still applies cleanly.

In time.c I started with the per_cpu to __get_cpu_var transformations
which affect ppc64 (the calls were added in 2.6.24), and from there
went looking for redundant global accesses from objdump -d --reloc.
I primarly looked at the pseries_defconfig and checked the results on
chrp32_defconfig.

Optimization results were checked on debian using

gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)

milton
