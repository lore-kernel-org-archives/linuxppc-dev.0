Date: Wed, 27 Sep 2000 20:36:31 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: R Shapiro <rshapiro@bbn.com>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        daenzerm@student.ethz.ch, linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 + ati driver with rage II/rage pro
In-Reply-To: <14801.4812.235660.20792@esb.bbn.com>
Message-ID: <Pine.LNX.4.10.10009272022070.27656-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> MacOS display is /pci/ATY,mach64_3DU
> atyfb: 3D RAGE (GT) [0x4754 rev 0x9a] 2M SGRAM, 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK
> BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
> 7b23a040 86010182 004215b3 25010001     03000200      002806e3   02100503
> PLL ad d5 21 44 e8 13 80 b5 8e 9e 98 04 a6 1b 00 00
> Console: switching to colour frame buffer device 160x64
> fb0: ATY Mach64 frame buffer device on /pci/ATY,mach64_3DU
> atyfb: 3D RAGE PRO (BGA, PCI) [0x4749 rev 0x7c] 4M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
> BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
> 7b33a040 87010182 04651a77 75130c01     03000300      00280509   01f004f1
> PLL ad d5 21 64 e4 13 80 b5 8e 9e 98 01 a6 1b 00 00
> fb1: ATY Mach64 frame buffer device on /pci/ATY,XCLAIM3DPro
> atyfb: 3D RAGE PRO (BGA, PCI) [0x4749 rev 0x7c] 4M SGRAM, 14.31818 MHz XTAL, 230 MHz PLL, 100 Mhz MCLK
> BUS_CNTL DAC_CNTL MEM_CNTL EXT_MEM_CNTL CRTC_GEN_CNTL DSP_CONFIG DSP_ON_OFF
> 7b33a040 87010102 04651a77 75130c01     03000300      00280509   01f004f1
> PLL ad d5 21 64 e4 13 80 b5 8e 9e 98 01 a6 1b 00 00
> fb2: ATY Mach64 frame buffer device on /pci/ATY,XCLAIM3DPro

atyfb handles three displays just fine (could have guessed so, sorry Geert).

So here we have three fb devices in the kernel (you could check with
fbset that each is in fact accessible via /dev/fb[0-2]), and XFree unable
to cope. You specify the PCI bus ID but not the corresponding framebuffer
device node - I heard someone mention this was possible when I was
fighting the Lombard crashes, could anyone point out the syntax to use
there?

If we can't specify the fb node XFree will have to probe for it (Geert
mentioned an easy way to do that: open the device and compare
pScrn->memPhysBase or fPtr->fix.smem_start to the PCI base address).

BTW Geert: why is fPtr->fboff calculated from fix.smem_len not
fix.smem_start while pScrn->fbOffset is calculated from fix.smem_start?

void*
fbdevHWMapVidmem(ScrnInfoPtr pScrn)
{
        fbdevHWPtr fPtr = FBDEVHWPTR(pScrn);

        TRACE_ENTER("MapVidmem");
        if (NULL == fPtr->fbmem) {
                fPtr->fboff = fPtr->fix.smem_len & (PAGE_SIZE-1);
                fPtr->fbmem = mmap(NULL, fPtr->fix.smem_len, PROT_READ | PROT_W
	                           MAP_SHARED, fPtr->fd, 0);
                if (-1 == (int)fPtr->fbmem) {
	                perror("mmap fbmem");
	                fPtr->fbmem = NULL;
 	   	}
   	}
        pScrn->memPhysBase = (unsigned long)fPtr->fix.smem_start & (unsigned long)(PAGE_MASK);
        pScrn->fbOffset = (unsigned long)fPtr->fix.smem_start & (unsigned long) (~PAGE_MASK);
        return fPtr->fbmem;
}

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
