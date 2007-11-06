Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B87EDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 02:46:06 +1100 (EST)
Date: Tue, 6 Nov 2007 15:44:39 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: 2.6.24-rc1-git15 Kernel build fails on powerpc - Unrecognized
	opcode: `dssall'
Message-ID: <20071106154439.GK5080@shadowen.org>
References: <47304343.2010709@linux.vnet.ibm.com>
	<661de9470711060246s3040f68drf0a6310aeec4e1e8@mail.gmail.com>
	<1194346486.4066.13.camel@johannes.berg>
	<20071106.031001.189578769.davem@davemloft.net>
	<47304FE5.2010309@linux.vnet.ibm.com>
	<47306E9C.4090202@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47306E9C.4090202@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
	linuxppc-dev@ozlabs.org, johannes@sipsolutions.net,
	sam@ravnborg.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 06, 2007 at 07:09:40PM +0530, Balbir Singh wrote:
> Kamalesh Babulal wrote:
> > David Miller wrote:
> >> From: Johannes Berg <johannes@sipsolutions.net>
> >> Date: Tue, 06 Nov 2007 11:54:46 +0100
> >>
> >>>>>   CHK     include/linux/compile.h
> >>>>>   AS      arch/powerpc/kernel/swsusp_32.o
> >>>>> arch/powerpc/kernel/swsusp_32.S: Assembler messages:
> >>>>> arch/powerpc/kernel/swsusp_32.S:138: Error: Unrecognized opcode: `dssall'
> >>>>> make[1]: *** [arch/powerpc/kernel/swsusp_32.o] Error 1
> >>>>> make: *** [arch/powerpc/kernel] Error 2
> >>>>>
> >>>> Looks suspiciously like an altivec issue. Could you compile with make
> >>>> V=1 and/or do a git bisect and see what broke?
> >>> Looks more like a toolchain issue to me.
> >> Or, this is another instance of the "CFLAGS environment variable"
> >> problem.
> >>
> >> For a few days, the kbuild stuff would integrate any CFLAGS,
> >> AFLAGS, etc. settings you might have set in your environment.
> > 
> > Hi Balbir,
> > 
> > The Build error of kernel compilation with V=1
> > 
> > make -f scripts/Makefile.build obj=arch/powerpc/kernel
> > make -f scripts/Makefile.build obj=arch/powerpc/kernel/vdso32
> >   gcc -m32 -Wp,-MD,arch/powerpc/kernel/.swsusp_32.o.d  -nostdinc -isystem /usr/lib/gcc/ppc64-redhat-linux/4.1.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -Iarch/powerpc -D__ASSEMBLY__ -Iarch/powerpc -Wa,-m405 -gdwarf-2     -c -o arch/powerpc/kernel/swsusp_32.o arch/powerpc/kernel/swsusp_32.S
> > arch/powerpc/kernel/swsusp_32.S: Assembler messages:
> > arch/powerpc/kernel/swsusp_32.S:138: Error: Unrecognized opcode: `dssall'
> > make[1]: *** [arch/powerpc/kernel/swsusp_32.o] Error 1
> > make: *** [arch/powerpc/kernel] Error 2
> > 
> 
> I looked at your .config and now your  build. It looks like you select
> CONFIG_4xx (I see -Wa,-m405) and compile swsusp_32.S. The
> compiler/toolchain does not enable altivec instructions for CONFIG_4xx.
> If CONFIG_HIBERNATION is enabled as in your case, it compiles
> swsusp_32.S which assumes that ALTIVEC is enabled (see CPU_FTR_ALTIVEC).
> 
> You ideally need to have -Wa,-maltivec passed in your CFLAGS.

So that sounds like a Kconfig problem then?  That HIBERATION requires
ALITIVEC and yet does not depend on it or set it.

-apw
