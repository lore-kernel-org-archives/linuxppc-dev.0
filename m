Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttTgY5ZNJzDqG0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 09:50:49 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v03MnAg7032683
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 Jan 2017 17:50:47 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27rd3xvkx9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jan 2017 17:50:46 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 4 Jan 2017 08:50:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1E9513578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 09:50:42 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v03MoiHj55967842
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 09:50:44 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v03MofUR019605
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jan 2017 09:50:41 +1100
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Christian Kujau <lists@nerdbynature.de>, Christophe Leroy
 <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 04 Jan 2017 09:50:41 +1100
In-Reply-To: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1483483841.15843.4.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-01-03 at 07:25 -0800, Christian Kujau wrote:
> Hi,
> 
> when compiling v4.10-rc2 with CONFIG_CC_STACKPROTECTOR_STRONG=y, the 
> linker fails with:

The way gcc implements the stack protector has some serious
incompatibilities with the way the Linux kernel uses r13, I wouldn't
even try until we sort that out...

Cheers,
Ben.
> 
> ================================
> + ld -EB -m elf32ppc -Bstatic --build-id -X -o .tmp_vmlinux1 -T 
> ./arch/powerpc/kernel/vmlinux.lds arch/powerpc/kernel/head_32.o 
> arch/powerpc/kernel/fpu.o arch/powerpc/kernel/vector.o 
> arch/powerpc/kernel/prom_init.o init/built-in.o --start-group 
> usr/built-in.o arch/powerpc/kernel/built-in.o arch/powerpc/mm/built-
> in.o 
> arch/powerpc/lib/built-in.o arch/powerpc/sysdev/built-in.o 
> arch/powerpc/platforms/built-in.o arch/powerpc/math-emu/built-in.o 
> arch/powerpc/crypto/built-in.o arch/powerpc/net/built-in.o 
> kernel/built-in.o certs/built-in.o mm/built-in.o fs/built-in.o 
> ipc/built-in.o security/built-in.o crypto/built-in.o block/built-
> in.o 
> lib/lib.a lib/built-in.o drivers/built-in.o sound/built-in.o 
> firmware/built-in.o net/built-in.o virt/built-in.o --end-group
> arch/powerpc/platforms/built-in.o: In function `bootx_printf':
> /usr/local/src/linux-
> git/arch/powerpc/platforms/powermac/bootx_init.c:88: undefined
> reference to `__stack_chk_fail_local'
> arch/powerpc/platforms/built-in.o: In function
> `bootx_add_display_props':
> /usr/local/src/linux-
> git/arch/powerpc/platforms/powermac/bootx_init.c:211: undefined
> reference to `__stack_chk_fail_local'
> arch/powerpc/platforms/built-in.o: In function 
> `bootx_scan_dt_build_struct':
> /usr/local/src/linux-
> git/arch/powerpc/platforms/powermac/bootx_init.c:350: undefined
> reference to `__stack_chk_fail_local'
> arch/powerpc/platforms/built-in.o: In function `bootx_init':
> /usr/local/src/linux-
> git/arch/powerpc/platforms/powermac/bootx_init.c:596: undefined
> reference to `__stack_chk_fail_local'
> /usr/bin/ld.bfd.real: .tmp_vmlinux1: hidden symbol
> `__stack_chk_fail_local' isn't defined
> /usr/bin/ld.bfd.real: final link failed: Bad value
> ================================
> 
> 
> $ ld --version | head -1
> GNU ld (GNU Binutils for Debian) 2.25
> 
> $ gcc --version | head -1
> gcc-4.9.real (Debian 4.9.2-10) 4.9.2
> 
> 
> I'm regularly compiling userspace programs with -fstack-protector
> w/o 
> problems. I suspect it's either
> 6533b7c16ee5712041b4e324100550e02a9a5dda 
> ("powerpc: Initial stack protector (-fstack-protector) support") or 
> 902e06eb86cd62753974c249bd1dedae2825b430 ("powerpc/32: Change the
> stack 
> protector canary value per task") or both but I haven't started the 
> bisection yet.
> 
> Any other ideas?
> 
> Thanks,
> Christian.
