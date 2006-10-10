Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 490B367BAB
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 06:49:53 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9AKnneP018783
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 16:49:49 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9AKnm5Z360648
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 14:49:48 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9AKnllY018032
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 14:49:48 -0600
Date: Tue, 10 Oct 2006 15:49:47 -0500
To: akpm@osdl.org
Subject: [PATCH 0/21]: powerpc/cell spidernet bugfixes, etc.
Message-ID: <20061010204946.GW4381@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: jeff@garzik.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Andrew, please apply/forward upstream.

The following set of 21 patches (!) are all aimed at the the 
spidernet ethernet device driver. The spidernet is an etherenet
controller built into the Toshiba southbridge for the PowerPC Cell
processor. (This is the only device in existance that with this
ethernet hardware in it).

These patches re-package/re-order/re-cleanup a previous
set of patches I've previously mailed. Thus, some have
been previously Acked-by lines, most do not. Most of
these patches are tiny, and handle problems that cropped
up during testing. Sorry about there being so many of them.

The first set of 12 patches fix a large variety of mostly 
minor bugs. 

The important patches are 13 through 17: these overcome a 
debilitating performance problem on transmit (6 megabits
per second !!) on transmit of patches 500 bytes or larger.
After applying these, I am able to get the following:

pkt sz   speed (100K buffs)       speed (4M buffs)
------   -----------------        ----------------
1500     700 Mbits/sec            951 Mbits/sec
1000     658 Mbits/sec            770
800      600                      648
500      500                      500
300      372                      372
60        70                       70

Above buf size refers to /proc/sys/net/core/wmem_default

----

I'm not planning on any further patches for a long while.
I tried to do som RX work, but gave up. RX performance could 
be improved.

FYI, Christoph Hellwig's node-aware patches seem to make no
difference at all any more.

I tried to base these on linux-2.6.19-rc1-mm1 but hit a 
kernel BUG in copy_fdtable at fs/file.c:138! 
(reported earlire today by Olof)

--linas
