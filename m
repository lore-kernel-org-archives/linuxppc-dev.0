Return-Path: <arnd@arndb.de>
Received: from mout-bounce.kundenserver.de (mout-bounce.kundenserver.de
	[212.227.17.2]) by ozlabs.org (Postfix) with ESMTP id DDAD2DDDE6
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 02:12:28 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH, v2] numactl: fix libnuma on big-endian 64-bit systems
Date: Fri, 5 Dec 2008 16:12:23 +0100
References: <200812041834.45931.arnd@arndb.de>
	<200812042149.06163.arnd@arndb.de>
	<200812042151.58676.arnd@arndb.de>
In-Reply-To: <200812042151.58676.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200812051612.23853.arnd@arndb.de>
Cc: Lee Schermerhorn <Lee.Schermerhorn@hp.com>,
	Mijo Safradin <safradin@de.ibm.com>, Cliff Wickman <cpw@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 04 December 2008, Arnd Bergmann wrote:
> The read-mask function assumes that it is running in 32-bit mode,
> by addressing the bitmask as a series of int values, instead of
> longs. This is broken as can easily be reproduced by running numademo
> on a bit-endian 64-bit system.
> 
> Changing the addressing to use 'long' values fixes the problem.

Unfortunately, this is still wrong, as it tries recreating a kernel
data structure that is represented as a series of 'int' values, just
in a different order.

What we really need is the reverse of bitmap_scnprintf from
linux/lib/bitmap.c. I don't have access to a little-endian NUMA
machine with more than 64 CPUs, so I really don't want to send
another embarrassingly wrong patch for this.

Can anyone else try to come up with a version that handles endianess
correctly and still works on x86-64?

	Arnd <><
