Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5DC141009B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 03:23:17 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0QFwPJA028902
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 10:58:32 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id D6DEF4DE81FC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 11:14:51 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0QGI6c01085686
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 11:18:06 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p0QGI4GK016910
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 14:18:06 -0200
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/2] Workaround for PowerPC 476FP hardware bug
Date: Wed, 26 Jan 2011 10:17:57 -0600
Message-Id: <1296058679-21352-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These patches add a workaround to avoid a hang on the DD2 level of the
476FP core.  This hardware bug will be fixed in future products, but this
particular core will used in production.

Dave Kleikamp (2):
  powerpc/476: define specific cpu table entry DD2 core
  powerpc/476: Workaround for PLB6 hang

 arch/powerpc/include/asm/cputable.h |    3 ++-
 arch/powerpc/kernel/cputable.c      |   22 ++++++++++++++++++----
 arch/powerpc/mm/tlb_nohash_low.S    |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 5 deletions(-)

-- 
1.7.3.4
