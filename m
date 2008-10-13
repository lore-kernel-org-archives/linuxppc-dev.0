Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id C55B9DE0BA
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 01:50:29 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so383386yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 07:50:27 -0700 (PDT)
Date: Mon, 13 Oct 2008 10:49:04 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH V2 4/4] POWERPC: Merge 32 and 64-bit dma code
Message-ID: <20081013144904.GB18363@yoda.jdub.homelinux.org>
References: <1220900995-11928-5-git-send-email-becky.bruce@freescale.com>
	<1221251686-5567-1-git-send-email-becky.bruce@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1221251686-5567-1-git-send-email-becky.bruce@freescale.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 12, 2008 at 03:34:46PM -0500, Becky Bruce wrote:
>We essentially adopt the 64-bit dma code, with some changes to support
>32-bit systems, including HIGHMEM.  dma functions on 32-bit are now
>invoked via accessor functions which call the correct op for a device based
>on archdata dma_ops.  If there is no archdata dma_ops, this defaults
>to dma_direct_ops.
>
>In addition, the dma_map/unmap_page functions are added to dma_ops
>because we can't just fall back on map/unmap_single when HIGHMEM is
>enabled. In the case of dma_direct_*, we stop using map/unmap_single
>and just use the page version - this saves a lot of ugly
>ifdeffing.  We leave map/unmap_single in the dma_ops definition,
>though, because they are needed by the iommu code, which does not
>implement map/unmap_page.  Ideally, going forward, we will completely
>eliminate map/unmap_single and just have map/unmap_page, if it's
>workable for 64-bit.
>
>Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

While doing a buildall this morning, I notice chrp32_defconfig fails
to build with:

drivers/built-in.o: In function `hard_dma_setup':
floppy.c:(.text+0x6e40e): undefined reference to `isa_bridge_pcidev'
floppy.c:(.text+0x6e412): undefined reference to `isa_bridge_pcidev'
floppy.c:(.text+0x6e53e): undefined reference to `isa_bridge_pcidev'
floppy.c:(.text+0x6e546): undefined reference to `isa_bridge_pcidev'
floppy.c:(.text+0x6e54a): undefined reference to `isa_bridge_pcidev'
make[1]: *** [.tmp_vmlinux1] Error 1

(the hard_dma_setup thing is in arch/powerpc/include/asm/floppy.h).

I did a git bisect and it pointed at this commit as causing the build
to fail.  Why, I have no idea.

josh
