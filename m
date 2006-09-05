Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 01E8967B75
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 01:06:09 +1000 (EST)
Date: Tue, 5 Sep 2006 19:06:08 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: OT: Re: [U-Boot-Users] Status of OF in TQM8540 and linux-2.6.17.11
Message-ID: <20060905190608.082331bc@vitb.ru.mvista.com>
In-Reply-To: <44FD7B96.80405@anagramm.de>
References: <20060905121957.CF13F353A15@atlas.denx.de>
	<44FD7B96.80405@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: u-boot-users@lists.sourceforge.net, ppcembed,
	Mailing List <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 05 Sep 2006 15:28:54 +0200
Clemens Koller <clemens.koller@anagramm.de> wrote:

> Hello, Wolfgang!
> 
> -> moving from u-boot-users to linuxppc-embedded
> 
> Wolfgang Denk wrote:
> > In message <44FD5BD4.9090406@anagramm.de> you wrote:
> > 
> >>Now I try to boot a current linux kernel - the vanilla 2.6.17.11
> >>with the default tqm8540 config but it doesn't show any sign of life
> > 
> > Please use the kernel from our repo instead; see
> > http://www.denx.de/cgi-bin/gitweb.cgi?p=linux-2.6-denx.git
> 
> Okay, the compilation after a make TQM8540_defconfig fails:
> 
> clemens@ecam:~/git/linux-2.6-denx$ make uImage
>   CHK     include/linux/version.h
>   CHK     include/linux/utsrelease.h
>   SYMLINK include/asm -> include/asm-ppc
>   CHK     include/linux/compile.h
>   CC      arch/ppc/syslib/mpc85xx_devices.o
> In file included from arch/ppc/syslib/mpc85xx_devices.c:23:
> include/asm/cpm2.h:1193:1: warning: "FCC2_MEM_OFFSET" redefined
> include/asm/cpm2.h:1192:1: warning: this is the location of the previous definition
> arch/ppc/syslib/mpc85xx_devices.c:99: error: `F1_RXCLK' undeclared here (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:99: error: `F1_TXCLK' undeclared here (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:99: error: initializer element is not constant
> arch/ppc/syslib/mpc85xx_devices.c:99: error: (near initialization for `mpc85xx_fcc1_pdata.clk_route')
> arch/ppc/syslib/mpc85xx_devices.c:100: error: initializer element is not constant
> arch/ppc/syslib/mpc85xx_devices.c:100: error: (near initialization for `mpc85xx_fcc1_pdata.clk_trx')
> arch/ppc/syslib/mpc85xx_devices.c:117: error: `F2_RXCLK' undeclared here (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:117: error: `F2_TXCLK' undeclared here (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:117: error: initializer element is not constant
> arch/ppc/syslib/mpc85xx_devices.c:117: error: (near initialization for `mpc85xx_fcc2_pdata.clk_route')
> arch/ppc/syslib/mpc85xx_devices.c:118: error: initializer element is not constant
> arch/ppc/syslib/mpc85xx_devices.c:118: error: (near initialization for `mpc85xx_fcc2_pdata.clk_trx')
> arch/ppc/syslib/mpc85xx_devices.c:135: error: `F3_RXCLK' undeclared here (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:135: error: `F3_TXCLK' undeclared here (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:135: error: initializer element is not constant
> arch/ppc/syslib/mpc85xx_devices.c:135: error: (near initialization for `mpc85xx_fcc3_pdata.clk_route')
> arch/ppc/syslib/mpc85xx_devices.c:136: error: initializer element is not constant
> arch/ppc/syslib/mpc85xx_devices.c:136: error: (near initialization for `mpc85xx_fcc3_pdata.clk_trx')
> arch/ppc/syslib/mpc85xx_devices.c:138: error: `FCC3_MEM_OFFSET' undeclared here (not in a function)
> arch/ppc/syslib/mpc85xx_devices.c:138: error: initializer element is not constant
> arch/ppc/syslib/mpc85xx_devices.c:138: error: (near initialization for `mpc85xx_fcc3_pdata.mem_offset')
> make[1]: *** [arch/ppc/syslib/mpc85xx_devices.o] Error 1
> make: *** [arch/ppc/syslib] Error 2
> 
> >>Are there any tips&tricks to consider regarding that point?
> > 
> > Yes, use a working kernel. Not all our patches have been accepted
> > upstream, and we have some lag with re-submissions.
> 
> According to TQC, the latest "working" kernel was a 2.6.15-git from your
> (denx) tree. I get the details from Mr. Becher@TQC and see how far I can get.
> 
> Okay, let's move over to linux-ppc-embedded. (xposting)

The upper defines need to reside in the board-specific code for tqm as well as for other boards
utilizing such scheme (see platforms/85xx/mpc85xx_ads_common.h for instance).

Fix for FCC3_MEM_OFFSET was part of my patch series (as a typo fix), I'll submit it separately since 
it's a notable bugfix should be in the mainstream.

-- 
Sincerely, 
Vitaly
