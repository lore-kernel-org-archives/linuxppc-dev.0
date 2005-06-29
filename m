Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 79BE167B58
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2005 07:14:31 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	j5TLL2sJ006139
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 14:21:02 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id j5TLIL4d020172
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2005 16:18:22 -0500 (CDT)
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1120079668.1798.98.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Wed, 29 Jun 2005 16:14:28 -0500
Subject: set_phys_avail() futures question
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben (primarily),

I'd like to get your opinion on what the future of
arch/ppc/mm/init.c/set_phys_avail() looks like.
Currently, its job is to traverse the mem_pieces data
and remove a whole series of #ifdef'ed regions of
memory based on configuration options.  These regions
are the initrd, the RTAS data, and the AGP special page.

Do you see these regions as being explicitly listed in 
the proposed  "reserved memory blocks" area of the Flat
Dev Tree header structure?

If so, then they would follow the same conceptual flow
as the ppc64 reservations in the LMB.  They would then
be SetPagReserved() and removed from the do_init_bootmem()
regions of memory as well.

Thanks,
jdl
