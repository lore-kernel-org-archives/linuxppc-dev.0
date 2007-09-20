Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8BAAFDDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 22:33:15 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l8KCXAku010983
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 08:33:10 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8KCXARH385440
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 06:33:10 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8KCXA0c025538
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 06:33:10 -0600
Date: Thu, 20 Sep 2007 07:33:08 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Cleanups for physmap_of.c (v2)
Message-ID: <20070920073308.6b5deefd@weaponx.rchland.ibm.com>
In-Reply-To: <20070920012225.GG14404@localhost.localdomain>
References: <20070920012225.GG14404@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Woodhouse <dwmw2@redhat.com>, Vitaly Wool <vwool@ru.mvista.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 20 Sep 2007 11:22:25 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> This patch includes a whole batch of smallish cleanups for
> drivers/mtd/physmap_of.c.
> 
> 	- A bunch of uneeded #includes are removed
> 	- We switch to the modern linux/of.h etc. in place of
> asm/prom.h
> 	- Use some helper macros to avoid some ugly inline #ifdefs
> 	- A few lines of unreachable code are removed
> 	- A number of indentation / line-wrapping fixes
> 	- More consistent use of kernel idioms such as if (!p) instead
> of if (p == NULL)
> 	- Clarify some printk()s and other informative strings.
> 	- parse_obsolete_partitions() now returns 0 if no partition
> information is found, instead of returning -ENOENT which the caller
> had to handle specially.
> 	- (the big one) Despite the name, this driver really has
> nothing to do with drivers/mtd/physmap.c.  The fact that the flash
> chips must be physically direct mapped is a constrant, but doesn't
> really say anything about the actual purpose of this driver, which is
> to instantiate MTD devices based on information from the device tree.
> Therefore the physmap name is replaced everywhere within the file with
> "of_flash".  The file itself and the Kconfig option is not renamed for
> now (so that the diff is actually a diff).  That can come later.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Looks great this time.  Tested on Ebony and Walnut.  I've applied it to
my tree.

josh
