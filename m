From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.0-test3
Date: Tue, 11 Jul 2000 10:45:27 +0200
Message-Id: <20000711084527.6747@192.168.1.10>
In-Reply-To: <Pine.HPX.4.10.10007110953000.9548-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10007110953000.9548-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>No 601 BATs are completely different, see the source code in the early
>init. The valid bits in not in the same (BATL or BATU), the size (limited
>to 8 Mb) and protection encoding are different (only one valid bit, not Vs
>and Vu, and WIMGxPP are coded as in the PTE). I think the G bit is
>ignored.
>
>Oh, and a last, but not least, point I forgot, the 601 only has the IBAT
>since the BAT arrays are unified.
>
>For the rest (i.e. nothing), 601 BAT are absolutely identical to
>other PPC BATs :-(

Well, I do handle them differently, but I can't test. Can you tell me
what you think of this code ?

/* Calc BAT values for mapping the display and store them
 * in disp_BATH and disp_BATL. Those values are then used
 * from head.S to map the display during identify_machine()
 * and MMU_Init()
 *
 * For now, the display is mapped in place (1:1). This should
 * be changed if the display physical address overlaps
 * KERNELBASE, which is fortunately not the case on any machine
 * I know of. This mapping is temporary and will disappear as
 * soon as the setup done by MMU_Init() is applied
 *
 * For now, we align the BAT and then map 8Mb on 601 and 16Mb
 * on other PPCs. This may cause trouble if the framebuffer
 * is really badly aligned, but I didn't encounter this case
 * yet.
 */
__init
static void
prepare_disp_BAT(void)
{
	unsigned long offset = reloc_offset();
	boot_infos_t* bi = PTRRELOC(RELOC(disp_bi));
	unsigned long addr = (unsigned long)bi->dispDeviceBase;

	if ((_get_PVR() >> 16) != 1) {
		/* 603, 604, G3, G4, ... */
		addr &= 0xFF000000UL;
		RELOC(disp_BATU) = addr | (BL_16M<<2) | 2;
		RELOC(disp_BATL) = addr | (_PAGE_NO_CACHE | _PAGE_GUARDED | BPP_RW);
	} else {
		/* 601 */
		addr &= 0xFF800000UL;
		RELOC(disp_BATU) = addr | (_PAGE_NO_CACHE | PP_RWXX) | 4;
		RELOC(disp_BATL) = addr | BL_8M | 0x40;
	}
	bi->logicalDisplayBase = bi->dispDeviceBase;
}

Then, in heqd.S, I do:

setup_disp_bat:
	/*
	 * setup the display bat prepared for us in prom.c
	 */
	mflr	r8
	bl	reloc_offset
	mtlr	r8
	lis	r8, disp_BATL@h
	ori	r8, r8, disp_BATL@l
	add	r8, r3, r8
	lwz	r8, 0(r8)
	lis	r11, disp_BATU@h
	ori	r11, r11, disp_BATU@l
	add	r11, r3, r11
	lwz	r11, 0(r11)
	mtspr	IBAT3L,r8
	mtspr	IBAT3U,r11
	mfspr	r9,PVR
	rlwinm	r9,r9,16,16,31		/* r9 = 1 for 601, 4 for 604 */
	cmpi	0,r9,1
	beq	1f
	mtspr	DBAT3L,r8
	mtspr	DBAT3U,r11
1:
	blr


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
