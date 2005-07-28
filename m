Return-Path: <bgoodman@empirix.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-2022-JP"
Date: Thu, 28 Jul 2005 13:22:26 -0400
Message-ID: <BD261180E6D35F4D9D32F3E44FD3D901011B00BA@EMPBEDEX.empirix.com>
From: "Goodman, Brad" <bgoodman@empirix.com>
To: <Linuxppc-embedded@ozlabs.org>
Subject: Linux 2.6.12.1 PowerPC 750FX Initialization Failures (Caching & MMU)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am running the 2.6.12.1 Kernel with a Force CPCI-695 board.

(This board has a PPC 750FX, with a Marvell Disco II (MV64360) - although it uses a 8250, instead of the Disco II UART.)

Anyway…

This thing is hanging like a buffalo on bootup - in early Kernel initialization:

I setup_common_caches it gets to here:

  mfspr r11,SPRN_HID0				← HID0 is 0x800200a4
  andi. r0,r11,HID0_DCE
  ori r11,r11,HID0_ICE|HID0_DCE
  ori r8,r11,HID0_ICFI
  bne 1f      /* don't invalidate the D-cache */
  ori r8,r8,HID0_DCI    /* unless it wasn't enabled */
1:  sync
  mtspr SPRN_HID0,r8    /* enable and invalidate caches */     ← r8 is now 0x8002cca4
  ### NEVER GETS HERE
  sync
  mtspr SPRN_HID0,r11   /* enable caches */  
  mr r3,r11

So it's hanging trying to enable and invalidate the caches.

So - trying to ditch that problem until later - I had it leave the caches off and continuing.

Now, it gets to the point where it tries to enable the MMU, and in the turn_on_mmu function it appears to go unresponsive right after the return-from-interrupt:

turn_on_mmu:
  mfmsr r0
  ori r0,r0,MSR_DR|MSR_IR
  mtspr SPRN_SRR1,r0
  lis r0,start_here@h
  ori r0,r0,start_here@l
  mtspr SPRN_SRR0,r0
  SYNC
  ## GETS HERE
  RFI       /* enables MMU */

I put a check in start_here - and it never reaches it. The BATs should all be set up per-normal initialization, and I verified that it was mapping Physical address 0 to Effective Address 0xc0000000 - but still no luck.

BTW - I am loading my znetboot image (zImage with no ELF header) at 0x800000 - so it's not relocating on startup (and verified that this was happening correctly.)

I don't know if the caching issue is related to the MMU issue - or they are two totally separate things.

Any ideas????

Brad Goodman
Empirix, Inc.
bgoodman -et- empirix -dut- com
