Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-11.online-age.net (ext-nj2ut-11.online-age.net
	[64.14.54.241])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 2AD36DDEEB
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Feb 2009 23:22:02 +1100 (EST)
Received: from int-nj2ut-2.online-age.net (int-nj2ut-2.online-age.net
	[3.159.237.71])
	by ext-nj2ut-11.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n14CLwqL029980
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 07:21:58 -0500
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-2.online-age.net
	[3.159.237.71])
	by int-nj2ut-2.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n14CLvCC019847
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 07:21:58 -0500
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1233708479.16867.129.camel@pasglop>
References: <4982F311.4050507@gefanuc.com>
	<F764D461-8EFB-4B31-ABFC-ECBB7A3FBA01@kernel.crashing.org>
	<9B0CCADB-C891-42B2-BE94-0927B5715A00@kernel.crashing.org>
	<4986BEB9.3030606@gefanuc.com>
	<E00697F4-1313-49C2-9F8A-79FC9E511022@kernel.crashing.org>
	<498718B6.3030307@gefanuc.com>
	<D06DAB0F-1477-4CA6-A06D-0F7B62939C86@kernel.crashing.org>
	<49871D3E.80809@gefanuc.com> <1233607753.18767.103.camel@pasglop>
	<49883719.9030300@gefanuc.com>  <498867C0.2000607@gefanuc.com>
	<1233708479.16867.129.camel@pasglop>
Content-Type: text/plain
Date: Wed, 04 Feb 2009 12:22:02 +0000
Message-Id: <1233750122.23240.11.camel@ubuntu8041.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-02-04 at 11:47 +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2009-02-03 at 15:50 +0000, Martyn Welch wrote:
> > 
> > The primary CPU is spinning in smp_generic_give_timebase() waiting for
> > "!tbsync->ack". The secondary CPU has made it into
> > smp_generic_take_timebase() and has apparently (according to some
> > printk's I put in there) set "tbsync->ack=1". After that I don't get
> > any printk's, I guess that the one I have put in the "!
> > tbsync->handshake" while loop is making it to the print buffer, but
> > with both processors spinning it's not getting to the serial console.
> > 
> > At a guess, given that commit 64b3d0e8122b422e879b23d42f9e0e8efbbf9744
> > seems to be the point that it stopped working correctly, that "tbsync"
> > is now somehow becoming cached?
> > 
> Maybe we are missing the M bit in the mapping ?
> 
> Let's see... the kernel mapping is done via BATs on those guys (ie, e600
> is a hash table based processor right ? some kind of 74xx). The code
> that sets them up is in
> 
> arch/powerpc/mm/ppc_mmu_32.c
> 
> In mmu_mapin_ram() we call setbat() multiple times. The last argument is
> the "flags" which is set to _PAGE_RAM. That should contain
> _PAGE_COHERENT when CONFIG_SMP is set unless I screwed up. IE. _PAGE_RAM
> is _PAGE_KERNEL | _PAGE_HWEXEC. _PAGE_KERNEL is _PAGE_BASE plus things,
> and _PAGE_BASE should contains _PAGE_COHERENT if CONFIG_SMP or
> CONFIG_PPC_STD_MMU are set and they should both be in your case.
> 
> setbat() itself will clear _PAGE_COHERENT under some circumstances
> however. Either if the flags contain _PAGE_NO_CACHE, which should not be
> the case here, or if the CPU feature bit CPU_FTR_NEED_COHERENT is -not-
> set. I think that could be the cause of the problem.
> 
> CPU_FTR_NEED_COHERENT is set as part of CPU_FTR_COMMON if CONFIG_SMP
> is set (among other things). So it -should- be set for you. since
> CPU_FTR_COMMON should be OR'ed with all CPU table entries.
> 
> So I'm a bit at a loss here... unless something else went wrong.
> 
> Please let me know what you find out.
> 
> Cheers,
> Ben.

I think it is indeed something else. I added the patch below which
resulted in the following lines in the kernel messages:

Set BAT 2 for 0x10000000 from phys:0x0 at virt:0xc0000000
Page coherency set
Set BAT 3 for 0x10000000 from phys:0x10000000 at virt:0xd0000000
Page coherency set
...
tbsync structure allocated at 0xef818360 for 0x48
tbsync happens to live at 0xc0515110
running happens to live at 0xc0515114

This suggests to me that whilst *tbsync and running are located within
RAM mapped by the BATs, the memory allocated for the tbsync structure is
not and is mapped via page tables. I guess this structure is then only
mapped correctly for the first core.

Martyn

-- 

diff --git a/arch/powerpc/kernel/smp-tbsync.c b/arch/powerpc/kernel/smp-tbsync.c
index a5e5452..fdeda20 100644
--- a/arch/powerpc/kernel/smp-tbsync.c
+++ b/arch/powerpc/kernel/smp-tbsync.c
@@ -117,6 +117,10 @@ void __devinit smp_generic_give_timebase(void)
 
        /* if this fails then this kernel won't work anyway... */
        tbsync = kzalloc( sizeof(*tbsync), GFP_KERNEL );
+       printk("tbsync structure allocated at 0x%p for 0x%x\n", tbsync, 
+               sizeof(*tbsync));
+       printk("tbsync happens to live at 0x%p\n", &tbsync);
+       printk("running happens to live at 0x%p\n", &running);
        mb();
        running = 1;
 
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index fe65c40..2035cd6 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -123,6 +123,9 @@ void __init setbat(int index, unsigned long virt, phys_addr_
        int wimgxpp;
        struct ppc_bat *bat = BATS[index];
 
+       printk("Set BAT %d for 0x%x from phys:0x%lx at virt:0x%lx\n", index, 
+               size, phys, virt);
+
        if ((flags & _PAGE_NO_CACHE) ||
            (cpu_has_feature(CPU_FTR_NEED_COHERENT) == 0))
                flags &= ~_PAGE_COHERENT;
@@ -134,6 +137,11 @@ void __init setbat(int index, unsigned long virt, phys_addr
                wimgxpp = flags & (_PAGE_WRITETHRU | _PAGE_NO_CACHE
                                   | _PAGE_COHERENT | _PAGE_GUARDED);
                wimgxpp |= (flags & _PAGE_RW)? BPP_RW: BPP_RX;
+               if (wimgxpp & _PAGE_COHERENT) {
+                       printk("Page coherency set\n");
+               } else {
+                       printk("Page coherency cleared\n");
+               }
                bat[1].batu = virt | (bl << 2) | 2; /* Vs=1, Vp=0 */
                bat[1].batl = BAT_PHYS_ADDR(phys) | wimgxpp;
 #ifndef CONFIG_KGDB /* want user access for breakpoints */


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
