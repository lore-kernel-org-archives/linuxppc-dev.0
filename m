Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 87CE8DE011
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 04:54:17 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m1FHrtVC004867
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 04:53:55 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1FHsG7e3723402
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 04:54:16 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1FHsFLM012128
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 04:54:16 +1100
Message-ID: <47B5D1C3.40702@linux.vnet.ibm.com>
Date: Fri, 15 Feb 2008 23:24:11 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: bzolnier@gmail.com
Subject: [BUID_FAILURE] next-20080215 Build failure caused by ide: rework
	PowerMac media-bay support
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The linux-next-20080215 kernel build fails on the powerpc with
following error
 
  CC      arch/powerpc/platforms/powermac/setup.o
In file included from arch/powerpc/platforms/powermac/setup.c:66:
include/asm/mediabay.h:29: error: syntax error before 'ide_hwif_t'
include/asm/mediabay.h:29: warning: function declaration isn't a prototype
make[2]: *** [arch/powerpc/platforms/powermac/setup.o] Error 1
make[1]: *** [arch/powerpc/platforms/powermac] Error 2
make: *** [arch/powerpc/platforms] Error 2

This build failure is caused by the  ide: rework PowerMac media-bay support
patch.This problem was reported and solution suggested according to
http://lkml.org/lkml/2008/2/13/195 including the 

#include <linux/ide.h> after

#ifdef CONFIG_BLK_DEV_IDE_PMAC

helps in fixing the build failure.

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
