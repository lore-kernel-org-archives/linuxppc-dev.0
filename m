Return-Path: <m.kozlowski@tuxland.pl>
Received: from tuxland.pl (xdsl-664.zgora.dialog.net.pl [81.168.226.152])
	by ozlabs.org (Postfix) with ESMTP id 9D04BDDE38
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 21:23:48 +1100 (EST)
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] ppc: cpm2_pic of_node_get cleanup
Date: Tue, 9 Jan 2007 11:24:03 +0100
References: <200701021236.20697.m.kozlowski@tuxland.pl>
	<17827.8109.461427.191194@cargo.ozlabs.ibm.com>
In-Reply-To: <17827.8109.461427.191194@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701091124.04949.m.kozlowski@tuxland.pl>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, 

> Mariusz Kozlowski writes:
> 
> > 	This patch removes redundant argument check for of_node_get().
> > 
> > Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> > 
> >  arch/powerpc/sysdev/cpm2_pic.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c
> > --- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c	2006-12-24 05:00:32.000000000 +0100
> > +++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c	2007-01-02 02:04:25.000000000 +0100
> > @@ -245,9 +245,7 @@ void cpm2_pic_init(struct device_node *n
> >  	cpm2_intctl->ic_scprrl = 0x05309770;
> >  
> >  	/* create a legacy host */
> > -	if (node)
> > -		cpm2_pic_node = of_node_get(node);
> > -
> > +	cpm2_pic_node = of_node_get(node);
> 
> This is actually a semantic change, in that cpm2_pic_node always gets
> assigned now, whereas previously it didn't if node == NULL.  Are you
> sure that is OK?  If so, you need to add something to the patch
> description explaining why it is OK.

It's ok to remove 'node' check because in real life cpm2_pic_init() never
gets called with node == NULL.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

 arch/powerpc/sysdev/cpm2_pic.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff -upr linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c
--- linux-2.6.20-rc2-mm1-a/arch/powerpc/sysdev/cpm2_pic.c	2006-12-24 05:00:32.000000000 +0100
+++ linux-2.6.20-rc2-mm1-b/arch/powerpc/sysdev/cpm2_pic.c	2007-01-02 02:04:25.000000000 +0100
@@ -245,9 +245,7 @@ void cpm2_pic_init(struct device_node *n
 	cpm2_intctl->ic_scprrl = 0x05309770;
 
 	/* create a legacy host */
-	if (node)
-		cpm2_pic_node = of_node_get(node);
-
+	cpm2_pic_node = of_node_get(node);
 	cpm2_pic_host = irq_alloc_host(IRQ_HOST_MAP_LINEAR, 64, &cpm2_pic_host_ops, 64);
 	if (cpm2_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");


-- 
Regards,

	Mariusz Kozlowski
