Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A615BDE114
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 19:29:51 +1100 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id n2C8Rt99023081
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 19:27:55 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2C8U7Xq393314
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 19:30:07 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2C8TnCA019354
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 19:29:49 +1100
Message-ID: <49B8C7FA.8090805@in.ibm.com>
Date: Thu, 12 Mar 2009 13:59:46 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Next 12 : arch/powerpc/sysdev/axonram build failure
References: <20090312171154.11c6ec31.sfr@canb.auug.org.au>
In-Reply-To: <20090312171154.11c6ec31.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Stephen,

Today's next randconfig build on powerpc fails with

  CC [M]  arch/powerpc/sysdev/axonram.o
arch/powerpc/sysdev/axonram.c:108: warning: ‘struct request_queue’ declared inside parameter list
arch/powerpc/sysdev/axonram.c:108: warning: its scope is only this definition or declaration, which is probably not what you want
arch/powerpc/sysdev/axonram.c: In function ‘axon_ram_make_request’:
arch/powerpc/sysdev/axonram.c:110: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:118: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:121: error: implicit declaration of function ‘bio_for_each_segment’
arch/powerpc/sysdev/axonram.c:121: error: expected ‘;’ before ‘{’ token
arch/powerpc/sysdev/axonram.c:112: warning: unused variable ‘user_mem’
arch/powerpc/sysdev/axonram.c: In function ‘axon_ram_direct_access’:
arch/powerpc/sysdev/axonram.c:150: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:155: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c: At top level:
arch/powerpc/sysdev/axonram.c:168: error: variable ‘axon_ram_devops’ has initializer but incomplete type
arch/powerpc/sysdev/axonram.c:169: error: unknown field ‘owner’ specified in initializer
arch/powerpc/sysdev/axonram.c:169: warning: excess elements in struct initializer
arch/powerpc/sysdev/axonram.c:169: warning: (near initialization for ‘axon_ram_devops’)
arch/powerpc/sysdev/axonram.c:170: error: unknown field ‘direct_access’ specified in initializer
arch/powerpc/sysdev/axonram.c:171: warning: excess elements in struct initializer
arch/powerpc/sysdev/axonram.c:171: warning: (near initialization for ‘axon_ram_devops’)
arch/powerpc/sysdev/axonram.c: In function ‘axon_ram_probe’:
arch/powerpc/sysdev/axonram.c:228: error: implicit declaration of function ‘alloc_disk’
arch/powerpc/sysdev/axonram.c:228: warning: assignment makes pointer from integer without a cast
arch/powerpc/sysdev/axonram.c:235: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:236: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:237: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:238: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:239: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:241: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:244: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:244: error: implicit declaration of function ‘blk_alloc_queue’
arch/powerpc/sysdev/axonram.c:245: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:251: error: implicit declaration of function ‘set_capacity’
arch/powerpc/sysdev/axonram.c:252: error: implicit declaration of function ‘blk_queue_make_request’
arch/powerpc/sysdev/axonram.c:252: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:253: error: implicit declaration of function ‘blk_queue_hardsect_size’
arch/powerpc/sysdev/axonram.c:253: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:254: error: implicit declaration of function ‘add_disk’
arch/powerpc/sysdev/axonram.c:264: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:279: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:288: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:289: error: implicit declaration of function ‘unregister_blkdev’
arch/powerpc/sysdev/axonram.c:289: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:290: error: dereferencing pointer to incomplete type
arch/powerpc/sysdev/axonram.c:291: error: implicit declaration of function ‘del_gendisk’
arch/powerpc/sysdev/axonram.c: In function ‘axon_ram_init’:
arch/powerpc/sysdev/axonram.c:345: error: implicit declaration of function ‘register_blkdev’
make[1]: *** [arch/powerpc/sysdev/axonram.o] Error 1
make: *** [arch/powerpc/sysdev] Error 2

CONFIG_BLOCK is not set.

Thanks
-Sachin


-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
