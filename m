Return-Path: <kamalesh@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3DD44DDD0D
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Nov 2007 22:29:38 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id lA6BT6KY003453
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 22:29:06 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id
	lA6BTAHs1769516
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 22:29:10 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA6BSjmS004860
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 22:28:46 +1100
Message-ID: <47304FE5.2010309@linux.vnet.ibm.com>
Date: Tue, 06 Nov 2007 16:58:37 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: balbir@linux.vnet.ibm.com
Subject: Re: 2.6.24-rc1-git15 Kernel build fails on powerpc - Unrecognized
	opcode: `dssall'
References: <47304343.2010709@linux.vnet.ibm.com>
	<661de9470711060246s3040f68drf0a6310aeec4e1e8@mail.gmail.com>
	<1194346486.4066.13.camel@johannes.berg>
	<20071106.031001.189578769.davem@davemloft.net>
In-Reply-To: <20071106.031001.189578769.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, sam@ravnborg.org,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> Date: Tue, 06 Nov 2007 11:54:46 +0100
> 
>>
>>>>   CHK     include/linux/compile.h
>>>>   AS      arch/powerpc/kernel/swsusp_32.o
>>>> arch/powerpc/kernel/swsusp_32.S: Assembler messages:
>>>> arch/powerpc/kernel/swsusp_32.S:138: Error: Unrecognized opcode: `dssall'
>>>> make[1]: *** [arch/powerpc/kernel/swsusp_32.o] Error 1
>>>> make: *** [arch/powerpc/kernel] Error 2
>>>>
>>> Looks suspiciously like an altivec issue. Could you compile with make
>>> V=1 and/or do a git bisect and see what broke?
>> Looks more like a toolchain issue to me.
> 
> Or, this is another instance of the "CFLAGS environment variable"
> problem.
> 
> For a few days, the kbuild stuff would integrate any CFLAGS,
> AFLAGS, etc. settings you might have set in your environment.

Hi Balbir,

The Build error of kernel compilation with V=1

make -f scripts/Makefile.build obj=arch/powerpc/kernel
make -f scripts/Makefile.build obj=arch/powerpc/kernel/vdso32
  gcc -m32 -Wp,-MD,arch/powerpc/kernel/.swsusp_32.o.d  -nostdinc -isystem /usr/lib/gcc/ppc64-redhat-linux/4.1.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Iarch/powerpc -D__ASSEMBLY__ -Iarch/powerpc -Wa,-m405 -gdwarf-2     -c -o arch/powerpc/kernel/swsusp_32.o arch/powerpc/kernel/swsusp_32.S
arch/powerpc/kernel/swsusp_32.S: Assembler messages:
arch/powerpc/kernel/swsusp_32.S:138: Error: Unrecognized opcode: `dssall'
make[1]: *** [arch/powerpc/kernel/swsusp_32.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
