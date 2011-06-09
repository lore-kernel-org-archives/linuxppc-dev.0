Return-Path: <ericvh@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D4C1B6FAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 00:58:48 +1000 (EST)
Received: by bwz10 with SMTP id 10so1552773bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Jun 2011 07:58:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1307494057.2874.212.camel@pasglop>
References: <1307482573-25440-1-git-send-email-ericvh@gmail.com>
	<1307494057.2874.212.camel@pasglop>
Date: Thu, 9 Jun 2011 09:58:44 -0500
Message-ID: <BANLkTinD+1+QTUhKvQP-T_bZgbi1YS1jwQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC][V3] bluegene: use MMU feature flag to
	conditionalize L1 writethrough code
From: Eric Van Hensbergen <ericvh@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	bg-linux@lists.anl-external.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 7, 2011 at 7:47 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2011-06-07 at 16:36 -0500, Eric Van Hensbergen wrote:
>
>> open to alternatives. =A0jimix also suggested changing NEED_L1_WRITETHRO=
UGH
>> to DCBZ_BROKEN, which I'm open to if you think appropriate, or maybe
>> DCBZ_BROKEN_DAMNIT would be more apt.
>
> :-)
>
> I think NEED_L1_WRITETHROUGH isn't great since we are dealing with more
> than just that here. Let's call it 44x_SMP since afaik, all
> implementations, whether it's BG or other variants of the same hack
> (AMCC/APM has one too) need the same stuff here, no ?
>
> Let's not use more than one feature bit, it's not needed in practice, a
> better name is all we need. Might even call it MMU_FTR_BLUEGENE_44x_SMP
> if you want.
>

I've got it as MMU_FTR_44x_SMP now, just wanted to bounce off of Josh to
make sure he's okay with it since he owns the 44x stuff.  If he'd
rather, I'll change
it to MMU_FTR_BGP_44x_SMP.

>
> I'll add comments inline:
>
>> =A0#define PPC44x_MMUCR_TID =A0 =A0 0x000000ff
>> =A0#define PPC44x_MMUCR_STS =A0 =A0 0x00010000
>> +#define PPC44x_MMUCR_U2 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00200000
>
> Please document in a comment what is the effect of U2 on the BG/P ASIC
> caches.
>

Is a comment sufficient, or would you rather also have something along
the lines of
+#define PPC44x_MMUCR_U2 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00200000
+#define PPC44x_MMUCR_U2_SWOAE   PPC44x_MMUCR_U2 /* store without allocatio=
n */

or even...
+#define PPC44x_MMUCR_U2_BGP_SWOAE   PPC44x_MMUCR_U2 /* store without
allocation on BGP */

Seems like its getting a bit too verbose, maybe that's not a bad
thing.  As long as I don't have to type it
too many times :)

>
> BTW. Care to explain to me why you have U2 -both- in the arguments to
> tlbwe and in MMUCR ? That doesn't look right to me... which one is used
> where and when ?
>

My reading of the databook is that U2SWOAE is an enable bit that lets the U=
2
storage attribute control the behavior.

>> @@ -814,7 +829,15 @@ skpinv: =A0addi =A0 =A0r4,r4,1 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Increment */
>> =A0 =A0 =A0 /* attrib fields */
>> =A0 =A0 =A0 /* Added guarded bit to protect against speculative loads/st=
ores */
>> =A0 =A0 =A0 li =A0 =A0 =A0r5,0
>> - =A0 =A0 ori =A0 =A0 r5,r5,(PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_=
SX | PPC44x_TLB_G)
>> +BEGIN_MMU_FTR_SECTION
>> + =A0 =A0 ori =A0 =A0 r5,r5,(PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_=
SX | \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 PPC44x_TLB_G | PPC44x_TLB_U2)
>> + =A0 =A0 oris =A0 =A0r5,r5,PPC44x_TLB_WL1@h
>> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_L1_WRITETHROUGH)
>> +BEGIN_MMU_FTR_SECTION
>> + =A0 =A0 ori =A0 =A0 r5,r5,(PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_=
SX | \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PPC44x_TLB_G)
>> +END_MMU_FTR_SECTION_IFCLR(MMU_FTR_NEED_L1_WRITETHROUGH)
>>
>> =A0 =A0 =A0 =A0 =A0li =A0 =A0 =A0r0,63 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* TLB slot 63 */
>
> This isn't going to work. This happens before the CPU feature bits are
> established.
>
> I see two ways out of that dilemna:
>
> =A0- One is you find a way to identify the BG case at runtime from that
> very early asm code. It's a bit tricky since we never added the MMU type
> information to the device-tree blob header (but we're adding it to ePAPR
> via a register iirc, so we could hijack that), or maybe via inspecting
> what the FW left behind in the TLB...
>

Well, if we are using the u-boot scenario, I can control how the
bootloader sets up the device tree and add markers that we can use to
let us do this.



>> diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32=
.S
>> index 998a100..b54e2e8 100644
>> --- a/arch/powerpc/kernel/misc_32.S
>> +++ b/arch/powerpc/kernel/misc_32.S
>> @@ -506,7 +506,27 @@ _GLOBAL(clear_pages)
>> =A0 =A0 =A0 li =A0 =A0 =A0r0,PAGE_SIZE/L1_CACHE_BYTES
>> =A0 =A0 =A0 slw =A0 =A0 r0,r0,r4
>> =A0 =A0 =A0 mtctr =A0 r0
>> -1: =A0 dcbz =A0 =A00,r3
>> + =A0 =A0 li =A0 =A0 =A0r4, 0
>> +1:
>> +BEGIN_MMU_FTR_SECTION
>> + =A0 =A0 /* assuming 32 byte cacheline */
>> + =A0 =A0 stw =A0 =A0 r4, 0(r3)
>> + =A0 =A0 stw =A0 =A0 r4, 4(r3)
>> + =A0 =A0 stw =A0 =A0 r4, 8(r3)
>> + =A0 =A0 stw =A0 =A0 r4, 12(r3)
>> + =A0 =A0 stw =A0 =A0 r4, 16(r3)
>> + =A0 =A0 stw =A0 =A0 r4, 20(r3)
>> + =A0 =A0 stw =A0 =A0 r4, 24(r3)
>> + =A0 =A0 stw =A0 =A0 r4, 28(r3)
>> +END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_L1_WRITETHROUGH)
>> +/*
>> + * would have used an ELSE_MMU_FTR_SECTION here but it
>> + * broke the code with Error: non-constant expression in ".if" statemen=
t
>> + *
>> + */
>> +BEGIN_MMU_FTR_SECTION
>> + =A0 =A0 dcbz =A0 =A00,r3
>> +END_MMU_FTR_SECTION_IFCLR(MMU_FTR_NEED_L1_WRITETHROUGH)
>> =A0 =A0 =A0 addi =A0 =A0r3,r3,L1_CACHE_BYTES
>> =A0 =A0 =A0 bdnz =A0 =A01b
>> =A0 =A0 =A0 blr
>> @@ -550,7 +570,9 @@ _GLOBAL(copy_page)
>> =A0 =A0 =A0 mtctr =A0 r0
>> =A01:
>> =A0 =A0 =A0 dcbt =A0 =A0r11,r4
>> +BEGIN_MMU_FTR_SECTION
>> =A0 =A0 =A0 dcbz =A0 =A0r5,r3
>> +END_MMU_FTR_SECTION_IFCLR(MMU_FTR_NEED_L1_WRITETHROUGH)
>> =A0 =A0 =A0 COPY_16_BYTES
>> =A0#if L1_CACHE_BYTES >=3D 32
>> =A0 =A0 =A0 COPY_16_BYTES
>
> Instead here I would just do a single feature section as the first
> instruction of clear_pages() that covers a branch out of line to an
> alternate implementation of the whole function.
>
> _GLOBAL(clear_pages)
> BEGIN_MMU_FTR_SECTION
> =A0 =A0 =A0 =A0b =A0 =A0 =A0 clear_pages_no_dcbz
> END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_L1_WRITETHROUGH)
> =A0 =A0 =A0 =A0.../...
>

okay, jimi had suggested something similar:
clear_pages_fake:
	li	r4, 0
1:	fake_dcbz r4, r3, L1_CACHE_BYTES
	addi	r3,r3,L1_CACHE_BYTES
	bdnz	1b
	blr

_GLOBAL(clear_pages)
	li	r0,PAGE_SIZE/L1_CACHE_BYTES
	slw	r0,r0,r4
	mtctr	r0
BEGIN_MMU_FTR_SECTION
	b	clear_pages_fake
END_MMU_FTR_SECTION_IFSET(MMU_FTR_NEED_L1_WRITETHROUGH)


>> diff --git a/arch/powerpc/lib/copy_32.S b/arch/powerpc/lib/copy_32.S
>> index 55f19f9..2646838 100644
>> --- a/arch/powerpc/lib/copy_32.S
>> +++ b/arch/powerpc/lib/copy_32.S
>> @@ -12,6 +12,7 @@
>> =A0#include <asm/cache.h>
>> =A0#include <asm/errno.h>
>> =A0#include <asm/ppc_asm.h>
>> +#include <asm/mmu.h>
>
> This is a bit more nasty. At some point we'll have to butcher that code
> in order to deal with 440 and 476 that have different cache line sizes
> and which we still want in the same kernel binary. In the meantime
> I'd do like previously and just duplicate the whole lot with just a
> single branch out.
>
> Note that I fail to see how your cachable_memzero can be correct since
> you don't replace dcbz with anything. On the other hand, the only user
> of it in the entire tree is ... clearing the hash table in ppc_mmu_32.c
> which we don't use on 440.
>

Yeah, as I was going over the take2 version of the patch, I was
uncomfortable with this as well.  I guess the BG guys just never
tripped over it because it was never called.

> So why don't you just make a separate patch that just completely gets
> rid of cachable_memzero() and use a memset in ppc_mmu_32.c ? I don't
> think anybody will notice the difference....
>
> For cachable_memcpy and copy_tofrom_user, just removing the dcbz's will
> do for now, though I wonder whether we could just remove cachable_memcpy
> as well. The only user is the EMAC driver and I doubt anybody will be
> able to measure the difference. It will make everbody life easier in the
> long term to remove those.
>

Okay, will do.

>> =A0 =A0 =A0 :
>> =A0#ifdef CONFIG_PPC47x
>> =A0 =A0 =A0 : "r" (PPC47x_TLB2_S_RWX),
>> -#else
>> +#elseif CONFIG_BGP_L1_WRITETHROUGH
>> + =A0 =A0 : "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44x_=
TLB_WL1 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 | PPC44x_TLB_U2 | PPC44x_TLB_M),
>> +#else /* neither CONFIG_PPC47x or CONFIG_BGP_L1_WRITETHROUGH */
>> =A0 =A0 =A0 : "r" (PPC44x_TLB_SW | PPC44x_TLB_SR | PPC44x_TLB_SX | PPC44=
x_TLB_G),
>> -#endif
>> +#endif /* CONFIG_PPC47x */
>> =A0 =A0 =A0 =A0 "r" (phys),
>> =A0 =A0 =A0 =A0 "r" (virt | PPC44x_TLB_VALID | PPC44x_TLB_256M),
>> =A0 =A0 =A0 =A0 "r" (entry),
>
> Make this conditional at runtime.
>

Oops.  sorry, that one slipped through.  I'll try and turn around [V4]
later today.  Thanks for the feedback.

       -eric
