Subject: Re: [PATCH] export m8xx_cpm_hostalloc
From: Andreas Oberritter <obi@saftware.de>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040723083856.A25212@home.com>
References: <1090590567.3939.20.camel@localhost.localdomain>
	 <20040723140231.GA21814@smtp.west.cox.net>
	 <6658EF7A-DCB6-11D8-BC2F-003065F9B7DC@embeddededge.com>
	 <20040723083856.A25212@home.com>
Content-Type: multipart/mixed; boundary="=-aC1Gd3i2/98zGh5DD4uO"
Message-Id: <1090674246.3023.1.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Sat, 24 Jul 2004 15:04:06 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-aC1Gd3i2/98zGh5DD4uO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Am Fr, den 23.07.2004 schrieb Matt Porter um 17:38:
> On Fri, Jul 23, 2004 at 10:41:36AM -0400, Dan Malek wrote:
> >
> > On Jul 23, 2004, at 10:02 AM, Tom Rini wrote:
> >
> > > Must the driver use hostalloc?  I didn't think that i2c was called so
> > > early that kmalloc/bootmem_alloc() (or so) couldn't be used.
> >
> >
> > Should use ...consistent_alloc()
>
> That doesn't exist in 2.6. Use dma_alloc_coherent().

Thanks, that works, but requires the attached patch. Please apply.

Regards,
Andreas

--=-aC1Gd3i2/98zGh5DD4uO
Content-Disposition: attachment; filename=dma.diff
Content-Type: text/x-patch; name=dma.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/24 14:59:23+02:00 obi@pegasos.saftware.de
#   export __dma_alloc_coherent and __dma_free_coherent (required for CONFIG_NOT_COHERENT_CACHE)
#
# arch/ppc/kernel/dma-mapping.c
#   2004/07/24 14:59:03+02:00 obi@pegasos.saftware.de +2 -1
#   export __dma_alloc_coherent and __dma_free_coherent (required for CONFIG_NOT_COHERENT_CACHE)
#
diff -Nru a/arch/ppc/kernel/dma-mapping.c b/arch/ppc/kernel/dma-mapping.c
--- a/arch/ppc/kernel/dma-mapping.c	2004-07-24 15:00:12 +02:00
+++ b/arch/ppc/kernel/dma-mapping.c	2004-07-24 15:00:12 +02:00
@@ -254,6 +254,7 @@
  no_page:
 	return NULL;
 }
+EXPORT_SYMBOL(__dma_alloc_coherent);

 /*
  * free a page as defined by the above mapping.
@@ -317,7 +318,7 @@
 	       __func__, vaddr);
 	dump_stack();
 }
-EXPORT_SYMBOL(dma_free_coherent);
+EXPORT_SYMBOL(__dma_free_coherent);

 /*
  * Initialise the consistent memory allocation.

--=-aC1Gd3i2/98zGh5DD4uO--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
