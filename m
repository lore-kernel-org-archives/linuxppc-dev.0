Return-Path: <mostrows@watson.ibm.com>
Received: from igw2.watson.ibm.com (igw2.watson.ibm.com [129.34.20.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 193AD679E2
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 06:41:12 +1000 (EST)
Received: from sp1n294en1.watson.ibm.com (sp1n294en1.watson.ibm.com
	[129.34.20.40])
	by igw2.watson.ibm.com (8.12.11.20060308/8.13.1/8.13.1-2005-04-25 igw)
	with ESMTP id k4TKfe1K014730
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:41:40 -0400
Received: from sp1n294en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with
	ESMTP id k4TKf8H287924
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:41:08 -0400
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n294en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with
	ESMTP id k4TKf73345784
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 16:41:07 -0400
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id
	k4TLYquq001607
	for <linuxppc-dev@ozlabs.org>; Mon, 29 May 2006 17:34:53 -0400
Subject: [RFC/PATCH 0/8] Overhaul of virt IRQ configuration. / Kill
	ppc64_interrupt_controller.
From: Michal Ostrowski <mostrows@watson.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 29 May 2006 16:41:02 -0400
Message-Id: <1148935262.25048.31.camel@brick>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following set of patches is aimed at killing the
ppc64_interrupt_controller global variable, and similarly that various
global variables used to tweak the parameters of virtual IRQ re-mapping.
Instead each platform can use a single function to configure IRQ
re-mapping in "init_early()".

Platforms can choose the default configuration (which is to
say identity mappings of IRQ vectors 0..511) or specify their own
configuration:  an offset (for ISA vectors), the range that is to be
identity mapped and the range of vectors that may be arbitrarily
re-mapper.

This allows us to remove the special-casing based on
ppc64_interrupt_controller in virt_irq_create_mapping(). 

Subsequently most uses of ppc64_interrupt_controller are on
configuration paths where we can typically obtain comparable information
by alternate means.

In the end, only pSeries-specific code must be aware of the choice of
PIC and it will check to see if an MPIC has been initialized (and if
not, assume XICS). (Thus no platforms beyond pSeries are affected.)

This code has been tested on pSeries LPAR, G5, and Maple.  I'll be
re-testing it on a Power3 with MPIC shortly once a system for testing
becomes available again.

-- 
Michal Ostrowski <mostrows@watson.ibm.com>
