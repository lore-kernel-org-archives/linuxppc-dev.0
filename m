Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e24smtp04.br.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 453AF2C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2012 03:55:21 +1100 (EST)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Fri, 28 Dec 2012 14:55:14 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id A5A2B1DC0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 11:55:10 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qBSGskLm15532172
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 14:54:47 -0200
Received: from d24av04.br.ibm.com (loopback [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qBSEstPW010767
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2012 12:54:55 -0200
Date: Fri, 28 Dec 2012 14:55:04 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc/iommu: prevent false TCE leak message
Message-ID: <20121228165504.GC21831@oc0268524204.ibm.com>
References: <1356625686-8943-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <20121228052135.GB9975@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121228052135.GB9975@shangw.(null)>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 28, 2012 at 01:21:35PM +0800, Gavin Shan wrote:
> On Thu, Dec 27, 2012 at 02:28:06PM -0200, Thadeu Lima de Souza Cascardo wrote:
> >When a device DMA window includes the address 0, it's reserved in the
> >TCE bitmap to avoid returning that address to drivers.
> >
> >When the device is removed, the bitmap is checked for any mappings not
> >removed by the driver, indicating a possible DMA mapping leak. Since the
> >reserved address is not cleared, a message is printed, warning of such a
> >leak.
> >
> >Check for the reservation, and clear it before checking for any other
> >standing mappings.
> >
> >Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> >---
> > arch/powerpc/kernel/iommu.c |    5 +++++
> > 1 files changed, 5 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> >index 8226c6c..226e9e5 100644
> >--- a/arch/powerpc/kernel/iommu.c
> >+++ b/arch/powerpc/kernel/iommu.c
> >@@ -717,6 +717,11 @@ void iommu_free_table(struct iommu_table *tbl, const char *node_name)
> > 		return;
> > 	}
> >
> >+	/* In case we have reserved the first bit, we should not emit
> >+	 * the warning below. */
> 
> At least, the comment would look like:
> 
> 	/*
> 	 * xxxxxxx
> 	 */
> 

Sure. New code should always follow coding style.  :-)

How do you suggest merging with the comment below? I think it's closer
to the code it comments about, so I'd rather keep it where it is.

> >+	if (tbl->it_offset == 0)
> >+		clear_bit(0, tbl->it_map);
> >+
> > 	/* verify that table contains no entries */
> > 	/* it_size is in entries, and we're examining 64 at a time */
> 
> The comment would be merged as well? :-)
> 

I also considered replacing this code by this:

        /* verify that table contains no entries */
-       /* it_size is in entries, and we're examining 64 at a time */
-       for (i = 0; i < (tbl->it_size/64); i++) {
-               if (tbl->it_map[i] != 0) {
+       if (find_first_bit(tbl->it_map, tbl->it_size) < tbl->it_size)
                        printk(KERN_WARNING "%s: Unexpected TCEs for
%s\n",
                                __func__, node_name);
-                       break;
-               }
-       }
 
I'll resend the "unreserving" patch with the fixed comment styling, but
without merging comments. And I will send this other patch for comments.

Regards.
Thadeu Cascardo.

 
> > 	for (i = 0; i < (tbl->it_size/64); i++) {
> 
> Thanks,
> Gavin
