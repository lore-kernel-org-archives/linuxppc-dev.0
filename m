Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3BDEDDDE06
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 00:39:54 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA6DdpiP015761
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 08:39:51 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA6DdpxH119334
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 08:39:51 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA6DdpuE030067
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Nov 2007 08:39:51 -0500
Message-ID: <47306E9C.4090202@linux.vnet.ibm.com>
Date: Tue, 06 Nov 2007 19:09:40 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc1-git15 Kernel build fails on powerpc - Unrecognized
	opcode: `dssall'
References: <47304343.2010709@linux.vnet.ibm.com>
	<661de9470711060246s3040f68drf0a6310aeec4e1e8@mail.gmail.com>
	<1194346486.4066.13.camel@johannes.berg>
	<20071106.031001.189578769.davem@davemloft.net>
	<47304FE5.2010309@linux.vnet.ibm.com>
In-Reply-To: <47304FE5.2010309@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, johannes@sipsolutions.net, sam@ravnborg.org,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal wrote:
> David Miller wrote:
>> From: Johannes Berg <johannes@sipsolutions.net>
>> Date: Tue, 06 Nov 2007 11:54:46 +0100
>>
>>>>>   CHK     include/linux/compile.h
>>>>>   AS      arch/powerpc/kernel/swsusp_32.o
>>>>> arch/powerpc/kernel/swsusp_32.S: Assembler messages:
>>>>> arch/powerpc/kernel/swsusp_32.S:138: Error: Unrecognized opcode: `dssall'
>>>>> make[1]: *** [arch/powerpc/kernel/swsusp_32.o] Error 1
>>>>> make: *** [arch/powerpc/kernel] Error 2
>>>>>
>>>> Looks suspiciously like an altivec issue. Could you compile with make
>>>> V=1 and/or do a git bisect and see what broke?
>>> Looks more like a toolchain issue to me.
>> Or, this is another instance of the "CFLAGS environment variable"
>> problem.
>>
>> For a few days, the kbuild stuff would integrate any CFLAGS,
>> AFLAGS, etc. settings you might have set in your environment.
> 
> Hi Balbir,
> 
> The Build error of kernel compilation with V=1
> 
> make -f scripts/Makefile.build obj=arch/powerpc/kernel
> make -f scripts/Makefile.build obj=arch/powerpc/kernel/vdso32
>   gcc -m32 -Wp,-MD,arch/powerpc/kernel/.swsusp_32.o.d  -nostdinc -isystem /usr/lib/gcc/ppc64-redhat-linux/4.1.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Iarch/powerpc -D__ASSEMBLY__ -Iarch/powerpc -Wa,-m405 -gdwarf-2     -c -o arch/powerpc/kernel/swsusp_32.o arch/powerpc/kernel/swsusp_32.S
> arch/powerpc/kernel/swsusp_32.S: Assembler messages:
> arch/powerpc/kernel/swsusp_32.S:138: Error: Unrecognized opcode: `dssall'
> make[1]: *** [arch/powerpc/kernel/swsusp_32.o] Error 1
> make: *** [arch/powerpc/kernel] Error 2
> 

I looked at your .config and now your  build. It looks like you select
CONFIG_4xx (I see -Wa,-m405) and compile swsusp_32.S. The
compiler/toolchain does not enable altivec instructions for CONFIG_4xx.
If CONFIG_HIBERNATION is enabled as in your case, it compiles
swsusp_32.S which assumes that ALTIVEC is enabled (see CPU_FTR_ALTIVEC).

You ideally need to have -Wa,-maltivec passed in your CFLAGS.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
