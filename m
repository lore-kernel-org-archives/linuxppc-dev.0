Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id D95D6DE13B
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 22:50:52 +1000 (EST)
Date: Mon, 7 Jul 2008 14:51:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: kbuild tree build failure
Message-ID: <20080707125138.GA16569@uranus.ravnborg.org>
References: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080707184038.aaeb8d40.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 07, 2008 at 06:40:38PM +1000, Stephen Rothwell wrote:
> Hi Sam,
> 
> Today's linux-next build (powerpc ppc64_defconfig) failed like this:
> 
> arch/powerpc/platforms/cell/spu_base.c: In function '__spu_trap_data_seg':
> arch/powerpc/platforms/cell/spu_base.c:194: error: duplicate case value
> arch/powerpc/platforms/cell/spu_base.c:177: error: previously used here
> 
> This means that USER_REGION_ID (line 177) is the same as KERNEL_REGION_ID
> (line 194).
> 
> From include/asm-powerpc/pgtable-ppc64.h:
> 
> #define REGION_SHIFT            60UL
> #define REGION_MASK             (0xfUL << REGION_SHIFT)
> #define REGION_ID(ea)           (((unsigned long)(ea)) >> REGION_SHIFT)
> 
> #define VMALLOC_REGION_ID       (REGION_ID(VMALLOC_START))
> #define KERNEL_REGION_ID        (REGION_ID(PAGE_OFFSET))
> #define VMEMMAP_REGION_ID       (0xfUL)
> #define USER_REGION_ID          (0UL)
> 
> From include/asm-powerpc/page.h:
> 
> #define PAGE_OFFSET     ASM_CONST(CONFIG_PAGE_OFFSET)
> 
> From .config:
> 
> CONFIG_PAGE_OFFSET=0xffffffff
> 
> Not good.
> 
> From arch/powerpc/Kconfig (ADVANCED_OPTIONS is not set):
> 
> config PAGE_OFFSET_BOOL
>         bool "Set custom page offset address"
>         depends on ADVANCED_OPTIONS
> 
> config PAGE_OFFSET
>         hex "Virtual address of memory base" if PAGE_OFFSET_BOOL
>         default "0xc0000000"
> 
> if PPC64
> config PAGE_OFFSET
>         hex
>         default "0xc000000000000000"
> endif
> 
> Reverting commit 9ba4ff5059e1a26698786373c8c71321c37ef7f9 ("kconfig:
> normalize int/hex values") seems to have fixed it.
> 
> From .config:
> 
> CONFIG_PAGE_OFFSET=0xc000000000000000

I see what is wrong - we use a int to hold the value above
and it does not fit.

Will fix tonight or tomorrow.

	Sam
