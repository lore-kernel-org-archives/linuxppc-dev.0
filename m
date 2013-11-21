Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 582362C009A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Nov 2013 11:08:33 +1100 (EST)
Date: Thu, 21 Nov 2013 00:08:19 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC PATCH powerpc] Fix a dma_mask issue of vio
Message-ID: <20131121000819.GU16735@n2100.arm.linux.org.uk>
References: <1384848697.2511.17.camel@ThinkPad-T5421>
 <1384910882.26969.57.camel@pasglop>
 <20131120232337.GT16735@n2100.arm.linux.org.uk>
 <1384992102.26969.120.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384992102.26969.120.camel@pasglop>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>,
 Li Zhong <zhong@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 21, 2013 at 11:01:42AM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2013-11-20 at 23:23 +0000, Russell King - ARM Linux wrote:
> > Li Zong's patch works around the issue of a failing dma_set_mask(),
> > but as I've already said elsewhere, the real fix is to get whatever
> > created the struct device to initialise the dev->dma_mask with a
> > bus default.
> > 
> > Using dma_coerce_xxx() merely makes the problem "go away" papering
> > over the issue - it's fine to do it this way, but someone should still
> > fix the broken code creating these devices...
> 
> Ok, they are created by the vio bus core, so it should be doing the
> job here of setting the dma_mask pointer to a proper value.
> 
> Li, can you take care of that ? Look at other bus types we have in
> there such as the macio bus etc...

Oh, hang on a moment, this is the "bus" code.

In which case, the question becomes: do vio devices ever need to have
a separate streaming DMA mask from a coherent DMA mask?  If not, then
something like the following is what's needed here, and I should've
never have used dma_set_mask_and_coherent().

dma_set_mask_and_coherent() (and the other dma_set_mask() functions)
are really supposed to be used by drivers only.

 arch/powerpc/kernel/vio.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index e7d0c88f621a..d771778f398e 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -1419,7 +1419,8 @@ struct vio_dev *vio_register_device_node(struct device_node *of_node)
 
 		/* needed to ensure proper operation of coherent allocations
 		 * later, in case driver doesn't set it explicitly */
-		dma_set_mask_and_coherent(&viodev->dev, DMA_BIT_MASK(64));
+		viodev->dev.coherent_dma_mask = DMA_BIT_MASK(64);
+		viodev->dev.dma_mask = &viodev->dev.coherent_dma_mask;
 	}
 
 	/* register with generic device framework */
