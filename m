Return-Path: <michael@ellerman.id.au>
Date: Tue, 18 Jun 2013 14:54:51 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v3.10-rc6
Message-ID: <20130618045451.GB11417@concordia>
References: <alpine.DEB.2.00.1306172114580.17108@ayla.of.borg>
 <alpine.DEB.2.00.1306172115300.17174@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.1306172115300.17174@ayla.of.borg>
Cc: Linux/PPC Development <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 17, 2013 at 09:19:51PM +0200, Geert Uytterhoeven wrote:
> On Mon, 17 Jun 2013, Geert Uytterhoeven wrote:
> 
> powerpc-randconfig

>   + arch/powerpc/include/asm/mmu-hash64.h: error: control reaches end of non-void function [-Werror=return-type]:  => 180:1

This is running past a BUG(), which must mean we have CONFIG_BUG=n.
BUG() turning into nothing is a bug in the CONFIG_BUG=n implementation IMHO.
There was a discussion about this recently, I didn't see what the resolution
was.

>   + arch/powerpc/kvm/book3s_hv.c: error: 'vcpus_to_update[need_vpa_update]' may be used uninitialized in this function [-Werror=uninitialized]:  => 1187:22

This looks bogus to me:

  if (need_vpa_update) {
 	spin_unlock(&vc->lock);
 	for (i = 0; i < need_vpa_update; ++i) 
 		kvmppc_update_vpas(vcpus_to_update[i]);

I fail to see how that accesses vcpus_to_update[need_vpa_update].

>   + arch/powerpc/platforms/cell/beat_iommu.c: error: 'dma_base' may be used uninitialized in this function [-Werror=uninitialized]:  => 69:11
>   + arch/powerpc/platforms/cell/beat_iommu.c: error: 'dma_size' may be used uninitialized in this function [-Werror=uninitialized]:  => 68:2
>   + arch/powerpc/platforms/cell/beat_iommu.c: error: 'io_page_size' may be used uninitialized in this function [-Werror=uninitialized]:  => 68:54
>   + arch/powerpc/platforms/cell/beat_wrapper.h: error: 'io_space_id' may be used uninitialized in this function [-Werror=uninitialized]:  => 249:2
>   + arch/powerpc/platforms/cell/beat_wrapper.h: error: 'ioid' may be used uninitialized in this function [-Werror=uninitialized]:  => 249:2

The above are all false warnings AFAICS.

> We need more randconfig builds to divert attention from powerpc ;-)

Or we could just drop them, with all the false positives from -Wuninitialized
it's hard to spot any real problems.

cheers
