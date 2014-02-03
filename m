Return-Path: <mpe@ellerman.id.au>
Message-ID: <1391396405.30409.6.camel@concordia>
Subject: Re: [git pull] Please pull powerpc.git next branch
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alistair Popple <alistair@popple.id.au>
Date: Mon, 03 Feb 2014 14:00:05 +1100
In-Reply-To: <4555187.D5eRSF5r8x@mexican>
References: <1390883744.3872.76.camel@pasglop>
 <20140128150309.GA7428@aepfle.de> <1390940395.8524.25.camel@pasglop>
 <4555187.D5eRSF5r8x@mexican>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Olaf Hering <olaf@aepfle.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-01-29 at 13:29 +1100, Alistair Popple wrote:
> Looks like I missed the dart iommu code when changing the iommu table
> initialisation. The patch below should fix it, would you mind testing
> it Ben? Thanks.

Any reason not to add the following to save ourselves in future?

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index d773dd4..6ab7b53 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -657,6 +657,8 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
        unsigned int i;
        struct iommu_pool *p;
 
+       BUG_ON(!tbl->it_page_shift);
+
        /* number of bytes needed for the bitmap */
        sz = BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
 

cheers
