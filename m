Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D9A767B5F
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 06:40:03 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1GOKD2-0008HE-7c
	for linuxppc-dev@ozlabs.org; Fri, 15 Sep 2006 13:22:48 -0700
Message-ID: <6332580.post@talk.nabble.com>
Date: Fri, 15 Sep 2006 13:22:48 -0700 (PDT)
From: jbahr <jbahr@set-software-services.com>
To: linuxppc-dev@ozlabs.org
Subject: Discontiguous Memory
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We have a client building a PPC8548-based product who insists that we
allocate DRAM real address space in two large chunks at 0-2GB and 4-6GB in
the 36-bit address space.  It doesn't look like U-Boot's bd_info structure
allows for that, and it doesn't look like the Linux init routines (which
accesses the passed table) knows how to handle discontiguous memory either
(as opposed to X86 Linux, which can accept an E820 table). 

It looks like Linux cleans out the TLB's pretty quickly, so it wouldn't know
the VA-to-RA mapping.   

I've seen papers on some PPC Linuxes that handle large discontiguous real
DRAM memory spaces, but it doesn't look like the Linux in ELDK does.  Is
that correct? 

This is just the start of a headache between the architects and we poor
implementers.  It's not clear to us that, even with ATMU support, how normal
drivers are going to know how to create real addresses for buffers and such
to use when programming DMA controllers or external PCI devices. 

Are this really a problem or is there kernel provision for the PPC for
discontiguous real memory DRAM space?

Any comments would be VERY appreciated. 

Regards, 
J
-- 
View this message in context: http://www.nabble.com/Discontiguous-Memory-tf2279691.html#a6332580
Sent from the linuxppc-dev forum at Nabble.com.
