Date: Tue, 11 Jul 2000 12:12:05 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4.0-test3
In-Reply-To: <20000711084527.6747@192.168.1.10>
Message-ID: <Pine.HPX.4.10.10007111104060.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Jul 2000, Benjamin Herrenschmidt wrote:

> >
> >No 601 BATs are completely different, see the source code in the early
> >init. The valid bits in not in the same (BATL or BATU), the size (limited
> >to 8 Mb) and protection encoding are different (only one valid bit, not Vs
> >and Vu, and WIMGxPP are coded as in the PTE). I think the G bit is
> >ignored.

Ok, I was wrong there is no G bit since the Ks bit takes its place, should
have checked first...

> Well, I do handle them differently, but I can't test. Can you tell me
> what you think of this code ?

See the comments below. Note that I've desperately been trying to update
my BK tree this morning but it does not work at all. I'm very patient and
accustomed to this task taking quite along time every day for 2 trees
(yesterday the update for 2.3 took 1 1/2 hour, for 600 kB compressed), but
today it seems unreachable for me...

>
> /* Calc BAT values for mapping the display and store them
>  * in disp_BATH and disp_BATL. Those values are then used
>  * from head.S to map the display during identify_machine()
>  * and MMU_Init()
>  *
>  * For now, the display is mapped in place (1:1). This should
>  * be changed if the display physical address overlaps
>  * KERNELBASE, which is fortunately not the case on any machine
>  * I know of. This mapping is temporary and will disappear as
>  * soon as the setup done by MMU_Init() is applied
>  *
>  * For now, we align the BAT and then map 8Mb on 601 and 16Mb
>  * on other PPCs. This may cause trouble if the framebuffer
>  * is really badly aligned, but I didn't encounter this case
>  * yet.
>  */
> __init
> static void
> prepare_disp_BAT(void)
> {
> 	unsigned long offset = reloc_offset();
> 	boot_infos_t* bi = PTRRELOC(RELOC(disp_bi));
> 	unsigned long addr = (unsigned long)bi->dispDeviceBase;
>
> 	if ((_get_PVR() >> 16) != 1) {
> 		/* 603, 604, G3, G4, ... */
> 		addr &= 0xFF000000UL;
> 		RELOC(disp_BATU) = addr | (BL_16M<<2) | 2;
> 		RELOC(disp_BATL) = addr | (_PAGE_NO_CACHE | _PAGE_GUARDED | BPP_RW);
> 	} else {
> 		/* 601 */
> 		addr &= 0xFF800000UL;
> 		RELOC(disp_BATU) = addr | (_PAGE_NO_CACHE | PP_RWXX) | 4;
> 		RELOC(disp_BATL) = addr | BL_8M | 0x40;
> 	}
> 	bi->logicalDisplayBase = bi->dispDeviceBase;
> }

That part looks OK...

>
> Then, in heqd.S, I do:
>
> setup_disp_bat:
> 	/*
> 	 * setup the display bat prepared for us in prom.c
> 	 */
> 	mflr	r8
> 	bl	reloc_offset
> 	mtlr	r8
> 	lis	r8, disp_BATL@h
> 	ori	r8, r8, disp_BATL@l
> 	add	r8, r3, r8
> 	lwz	r8, 0(r8)
> 	lis	r11, disp_BATU@h
> 	ori	r11, r11, disp_BATU@l
> 	add	r11, r3, r11
> 	lwz	r11, 0(r11)
+	isync
- 	mtspr	IBAT3L,r8

Now imagine here that IBAT3U is zero (I think the code is executing in
1:1 mapped mode here). You just have set IBATL on a 601 hence the valid
flag and you temporarily have a mapping that says:

(1st 8 Mb of virtual address space) -> video memory

what happens if the instruction fetcher decides to start loading a cache
line (executing from video memory) ? Might it also depending on firmware,
create a multiple BAT match (which is a definitive no-no) ?

That's a single instruction slot, yes, but it may hurt. Simply swapping
these instructions might solve the problem since you are not supposed to
access the display virtual address at this time, it will have a transient
mapping:

(video memory) -> first 8 Mb of physical memory

but it sounds harmless.

Oh and please add an isync before and after touching the BATS, this is
required by the architecture (as I've indicated with my hand made pseudo
unified diffs).

The fact that the valid bits are BATL on 601 and BATU on the other makes
all the BAT manipulation extremely delicate. Maybe it would be better for
robustness not to try to save a few instructions and have 2 completely
different code paths...


> 	mtspr	IBAT3U,r11
+ 	mtspr	IBAT3L,r8
> 	mfspr	r9,PVR
> 	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
> 	cmpi	0,r9,1
> 	beq	1f
> 	mtspr	DBAT3L,r8
> 	mtspr	DBAT3U,r11
> 1:
+	isync
> 	blr

Besides looking at load_bat macros, the comment does not quite exactly
reflect the code and might crash on 601:
/* 601 only have IBAT cr0.eq is set on 601 when using this macro */
It should be reordered, even if slightly bigger. I believe that, once upon
a time, there was a LOAD_601_BAT macro.
#define LOAD_BAT(n, offset, reg, RA, RB) \
        /* see the comment for clear_bats() -- Cort */ \
        li      RA,0;                   \
        mtspr   IBAT##n##U,RA;          \
        mtspr   DBAT##n##U,RA;          \   <-- Wrong, might crash 601 !
        lwz     RA,offset+0(reg);       \
        lwz     RB,offset+4(reg);       \
        mtspr   IBAT##n##U,RA;          \
        mtspr   IBAT##n##L,RB;          \
        beq     1f;                     \

This should be fixed but it seems to be there since so long...

I don't know whether one of the chunks of code that I suspect is the
source of the problem, but they might well be.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
