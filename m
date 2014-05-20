Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A7FAB1A0848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 16:36:23 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Tue, 20 May 2014 16:36:22 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 759642BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 16:36:17 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4K6a2GB10617112
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 16:36:02 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4K6aGtR009534
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 May 2014 16:36:17 +1000
Message-ID: <537AF7DF.1020209@linux.vnet.ibm.com>
Date: Tue, 20 May 2014 14:36:15 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc <linuxppc-dev@lists.ozlabs.org>
Subject: PowerPC Build error with patch: powerpc/ppc64: Allow allmodconfig
 to build (finally !)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

I face one build error in linux-next git tree, see below:
The platform is IBM P7.

[root@cena01 linux-next]# make -j60
   CHK     include/config/kernel.release
   CHK     include/generated/uapi/linux/version.h
   CHK     include/generated/utsrelease.h
   CALL    scripts/checksyscalls.sh
<stdin>:1232:2: warning: #warning syscall renameat2 not implemented [-Wcpp]
   CHK     include/generated/compile.h
   CALL    arch/powerpc/kernel/systbl_chk.sh
   CALL    arch/powerpc/kernel/prom_init_check.sh
   AS      arch/powerpc/kernel/head_64.o
arch/powerpc/kernel/exceptions-64s.S: Assembler messages:
arch/powerpc/kernel/exceptions-64s.S:269: Error: operand out of range 
(0x000000000000814c is not between 0xffffffffffff8000 and 
0x0000000000007ffc)
arch/powerpc/kernel/exceptions-64s.S:729: Error: operand out of range 
(0x000000000000814c is not between 0xffffffffffff8000 and 
0x0000000000007ffc)
make[1]: *** [arch/powerpc/kernel/head_64.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/powerpc/kernel] Error 2
make: *** Waiting for unfinished jobs....


Finally, I find out that it is the commit 
"0be9d8b61c0c1f3c8f86292c6e237ff26acd392d  powerpc/ppc64: Allow 
allmodconfig to build (finally !)" case this error.
