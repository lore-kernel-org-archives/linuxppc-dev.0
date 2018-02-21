Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x22f.google.com (mail-pf0-x22f.google.com
 [IPv6:2607:f8b0:400e:c00::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmbSZ1Gl5zDqgy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 22:52:13 +1100 (AEDT)
Received: by mail-pf0-x22f.google.com with SMTP id s24so552266pfm.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 03:52:13 -0800 (PST)
Date: Wed, 21 Feb 2018 21:51:55 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/9] powerpc/64s: kbuild set assembler machine type to
 POWER4
Message-ID: <20180221215155.18f37681@roar.ozlabs.ibm.com>
In-Reply-To: <201802211853.YUmKTVlL%fengguang.wu@intel.com>
References: <20180220190832.1872-4-npiggin@gmail.com>
 <201802211853.YUmKTVlL%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So this shouldn't be built on BookE because it generates the wrong code
for them. BookS CPUs are the only ones that set this FTR bit anyway.

Thanks,
Nick

On Wed, 21 Feb 2018 19:15:29 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Nicholas,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on powerpc/next]
> [also build test ERROR on v4.16-rc2 next-20180221]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Nicholas-Piggin/powerpc-cpu-feature-and-kernel-build-stuff/20180221-132025
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
> config: powerpc-ppc64e_defconfig (attached as .config)
> compiler: powerpc64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=powerpc 
> 
> All errors (new ones prefixed by >>):
> 
>    arch/powerpc/lib/copypage_power7.S: Assembler messages:
> >> arch/powerpc/lib/copypage_power7.S:46: Error: junk at end of line: `0b01000'
> >> arch/powerpc/lib/copypage_power7.S:47: Error: junk at end of line: `0b01010'  
>    arch/powerpc/lib/copypage_power7.S:49: Error: junk at end of line: `0b01000'
>    arch/powerpc/lib/copypage_power7.S:50: Error: junk at end of line: `0b01010'
>    arch/powerpc/lib/copypage_power7.S:52: Error: junk at end of line: `0b01010'
> 
> vim +46 arch/powerpc/lib/copypage_power7.S
> 
> fde69282 Anton Blanchard 2012-05-29  22  
> fde69282 Anton Blanchard 2012-05-29  23  _GLOBAL(copypage_power7)
> fde69282 Anton Blanchard 2012-05-29  24  	/*
> fde69282 Anton Blanchard 2012-05-29  25  	 * We prefetch both the source and destination using enhanced touch
> fde69282 Anton Blanchard 2012-05-29  26  	 * instructions. We use a stream ID of 0 for the load side and
> fde69282 Anton Blanchard 2012-05-29  27  	 * 1 for the store side. Since source and destination are page
> fde69282 Anton Blanchard 2012-05-29  28  	 * aligned we don't need to clear the bottom 7 bits of either
> fde69282 Anton Blanchard 2012-05-29  29  	 * address.
> fde69282 Anton Blanchard 2012-05-29  30  	 */
> 280a5ba2 Michael Neuling 2013-05-29  31  	ori	r9,r3,1		/* stream=1 => to */
> fde69282 Anton Blanchard 2012-05-29  32  
> fde69282 Anton Blanchard 2012-05-29  33  #ifdef CONFIG_PPC_64K_PAGES
> 280a5ba2 Michael Neuling 2013-05-29  34  	lis	r7,0x0E01	/* depth=7
> 280a5ba2 Michael Neuling 2013-05-29  35  				 * units/cachelines=512 */
> fde69282 Anton Blanchard 2012-05-29  36  #else
> fde69282 Anton Blanchard 2012-05-29  37  	lis	r7,0x0E00	/* depth=7 */
> 280a5ba2 Michael Neuling 2013-05-29  38  	ori	r7,r7,0x1000	/* units/cachelines=32 */
> fde69282 Anton Blanchard 2012-05-29  39  #endif
> fde69282 Anton Blanchard 2012-05-29  40  	ori	r10,r7,1	/* stream=1 */
> fde69282 Anton Blanchard 2012-05-29  41  
> fde69282 Anton Blanchard 2012-05-29  42  	lis	r8,0x8000	/* GO=1 */
> fde69282 Anton Blanchard 2012-05-29  43  	clrldi	r8,r8,32
> fde69282 Anton Blanchard 2012-05-29  44  
> 280a5ba2 Michael Neuling 2013-05-29  45  	/* setup read stream 0  */
> 8a583c0a Andreas Schwab  2017-08-05 @46  	dcbt	0,r4,0b01000  	/* addr from */
> 8a583c0a Andreas Schwab  2017-08-05 @47  	dcbt	0,r7,0b01010   /* length and depth from */
> 280a5ba2 Michael Neuling 2013-05-29  48  	/* setup write stream 1 */
> 8a583c0a Andreas Schwab  2017-08-05  49  	dcbtst	0,r9,0b01000   /* addr to */
> 8a583c0a Andreas Schwab  2017-08-05  50  	dcbtst	0,r10,0b01010  /* length and depth to */
> fde69282 Anton Blanchard 2012-05-29  51  	eieio
> 8a583c0a Andreas Schwab  2017-08-05  52  	dcbt	0,r8,0b01010	/* all streams GO */
> fde69282 Anton Blanchard 2012-05-29  53  
> 
> :::::: The code at line 46 was first introduced by commit
> :::::: 8a583c0a8d316d8ea52ea78491174ab1a3e9ef9d powerpc: Fix invalid use of register expressions
> 
> :::::: TO: Andreas Schwab <schwab@linux-m68k.org>
> :::::: CC: Michael Ellerman <mpe@ellerman.id.au>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
