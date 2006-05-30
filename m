Return-Path: <will_schmidt@vnet.ibm.com>
Subject: [PATCH] fix of_parse_dma_window.      was: Re: [PATCH 1/2]
	powerpc: Add of_parse_dma_window()
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>, jk@ozlabs.org
In-Reply-To: <20060518231306.GG8220@pb15.lixom.net>
References: <1147933251.463191.267166640873.qpush@pokey>
	<20060518171159.GD8220@pb15.lixom.net>
	<06890505-B9A0-42B9-A713-A035FBCBDD1B@kernel.crashing.org>
	<20060518231306.GG8220@pb15.lixom.net>
Content-Type: text/plain
Date: Tue, 30 May 2006 13:38:40 -0500
Message-Id: <1149014320.23168.11.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-18 at 18:13 -0500, Olof Johansson wrote:
> On Fri, May 19, 2006 at 01:11:51AM +0200, Segher Boessenkool wrote:
> > > Acked-by: Olof Johansson <olof@lixom.net>
> > >
> > > (I'm assuming you've booted it on POWER4 LPAR and JS20, I don't
> > > have access to either to make sure it doesn't break there. Main worry
> > > would be if it lacked ibm,#dma*-properties for some reason.)
> > 
> > The code seems to be resilient against that.  Haven't tested though.
> 
> Well, yes. I should have said: if it lacks the ibm,#dma- and the
> normal addr-cells properties aren't the same as we assumed before.

My js20 appears to lack the ibm,#dma- properties, and boot fails with a
"Kernel panic - not syncing: iommu_init_table: Can't allocate 0 bytes"
message.  

This adds a fallback to the "#address-cells" property in case the
"#ibm,dma-address-cells" property is missing.   Tested on js20 and
power5 lpar.  

Unless there is a more elegant solution... :-)

Signed-off-by: Will Schmidt <willschm@us.ibm.com>


diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 23bb060..45df420 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -561,6 +561,9 @@ void of_parse_dma_window(struct device_n
 	*busno = *(dma_window++);
 
 	prop = get_property(dn, "ibm,#dma-address-cells", NULL);
+	if (!prop)
+		prop = get_property(dn, "#address-cells", NULL);
+
 	cells = prop ? *(u32 *)prop : prom_n_addr_cells(dn);
 	*phys = of_read_addr(dma_window, cells);
 
