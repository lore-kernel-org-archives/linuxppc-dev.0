Return-Path: <geert@linux-m68k.org>
Received: from wilson.telenet-ops.be (wilson.telenet-ops.be [195.130.132.42])
 by ozlabs.org (Postfix) with ESMTP id 9BE9D2C0182
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 05:20:39 +1000 (EST)
Received: from georges.telenet-ops.be (georges.telenet-ops.be [195.130.137.68])
 by wilson.telenet-ops.be (Postfix) with ESMTP id A63BF35F9D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 21:20:32 +0200 (CEST)
Date: Mon, 17 Jun 2013 21:19:51 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
Sender: geert@linux-m68k.org
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Build regressions/improvements in v3.10-rc6
In-Reply-To: <alpine.DEB.2.00.1306172114580.17108@ayla.of.borg>
Message-ID: <alpine.DEB.2.00.1306172115300.17174@ayla.of.borg>
References: <alpine.DEB.2.00.1306172114580.17108@ayla.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 17 Jun 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.10-rc6 to v3.10-rc5[3], the summaries are:
>   - build errors: +16/-36

  + arch/mn10300/include/asm/irqflags.h: error: implicit declaration of function 'raw_smp_processor_id' [-Werror=implicit-function-declaration]:  => 71:2
  + include/linux/smp.h: error: implicit declaration of function 'local_irq_restore' [-Werror=implicit-function-declaration]:  => 150:2
  + include/linux/smp.h: error: implicit declaration of function 'local_irq_save' [-Werror=implicit-function-declaration]:  => 148:2

am33_2.0/asb2303_defconfig and am33_2.0/asb2364_defconfig
Known, fix available

  + arch/powerpc/include/asm/mmu-hash64.h: error: control reaches end of non-void function [-Werror=return-type]:  => 180:1
  + arch/powerpc/kvm/book3s_hv.c: error: 'vcpus_to_update[need_vpa_update]' may be used uninitialized in this function [-Werror=uninitialized]:  => 1187:22
  + arch/powerpc/platforms/cell/beat_iommu.c: error: 'dma_base' may be used uninitialized in this function [-Werror=uninitialized]:  => 69:11
  + arch/powerpc/platforms/cell/beat_iommu.c: error: 'dma_size' may be used uninitialized in this function [-Werror=uninitialized]:  => 68:2
  + arch/powerpc/platforms/cell/beat_iommu.c: error: 'io_page_size' may be used uninitialized in this function [-Werror=uninitialized]:  => 68:54
  + arch/powerpc/platforms/cell/beat_wrapper.h: error: 'io_space_id' may be used uninitialized in this function [-Werror=uninitialized]:  => 249:2
  + arch/powerpc/platforms/cell/beat_wrapper.h: error: 'ioid' may be used uninitialized in this function [-Werror=uninitialized]:  => 249:2

powerpc-randconfig

We need more randconfig builds to divert attention from powerpc ;-)

> [1] http://kisskb.ellerman.id.au/kisskb/head/6325/ (86 out of 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6308/ (all 120 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
