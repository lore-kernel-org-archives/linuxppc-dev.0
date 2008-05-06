Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4479EDE030
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 06:11:13 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m46K8Eqp014785
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 16:08:15 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m46KB9MS218698
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 14:11:09 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m46KB9Dr028293
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 14:11:09 -0600
Received: from zod.rchland.ibm.com (wecm-9-67-192-35.wecm.ibm.com
	[9.67.192.35])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m46KB8aJ028260
	for <linuxppc-dev@ozlabs.org>; Tue, 6 May 2008 14:11:08 -0600
Date: Tue, 6 May 2008 15:09:55 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: arch/ppc is broken
Message-ID: <20080506150955.0fdcaa85@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Every arch/ppc defconfig I built today failed.  Someone broke it.
Those interested in fixing it might want to see why.  I suspect the

 ppc/powerpc: use kbuild.h instead of defining macros in asm-offsets.c

is responsible, but I have no evidence of that.

josh

/home/jwboyer/src/linux-2.6/arch/ppc/kernel/ppc_ksyms.c:152: error: '__flush_icache_range' undeclared here (not in a function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/ppc_ksyms.c:152: warning: type defaults to 'int' in declaration of '__flush_icache_range'
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/ppc_ksyms.c:153: error: 'flush_dcache_range' undeclared here (not in a function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/ppc_ksyms.c:153: warning: type defaults to 'int' in declaration of 'flush_dcache_range'
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/ppc_ksyms.c:154: error: 'flush_icache_user_range' undeclared here (not in a function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/ppc_ksyms.c:154: warning: type defaults to 'int' in declaration of 'flush_icache_user_range'
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/ppc_ksyms.c:155: error: 'flush_dcache_page' undeclared here (not in a function)
/home/jwboyer/src/linux-2.6/arch/ppc/kernel/ppc_ksyms.c:155: warning: type defaults to 'int' in declaration of 'flush_dcache_page'
make[2]: *** [arch/ppc/kernel/ppc_ksyms.o] Error 1
/home/jwboyer/src/linux-2.6/arch/powerpc/kernel/prom_init.c:130: error: expected specifier-qualifier-list before 'ihandle'
