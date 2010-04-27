Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.181])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99074B7D5B
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 23:58:38 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/4xx: Add optional "reset_type" property to
	control reboot via dts
Date: Tue, 27 Apr 2010 15:58:20 +0200
References: <1272289141-21053-1-git-send-email-sr@denx.de>
	<20100426182828.GA29593@zod.rchland.ibm.com>
In-Reply-To: <20100426182828.GA29593@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201004271558.20212.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Josh,

On Monday 26 April 2010 20:28:29 Josh Boyer wrote:
> On Mon, Apr 26, 2010 at 03:39:01PM +0200, Stefan Roese wrote:
> >By setting "reset_type" to one of the following values, the default
> >software reset mechanism may be overidden. Here the possible values of
> 
> >"reset_type":
> NEAT!  A 4xx patch!  I haven't gotten enough of these lately, so forgive my
> nit picking ;)

Sure. Comments welcome, as always.
 
> >  1 - PPC4xx core reset
> >  2 - PPC4xx chip reset
> >  3 - PPC4xx system reset (default)
> 
> We should probably put a brief description of this in the dts bindings
> under Documentation (or whereever we're storing them these days.  I saw
> something about a wiki?).

Right. I thought about this as well (too late). I'll include a short 
documentation in my next patch version.
 
> Also, while it's not a large issue, I wonder if there will be confusion on
> whether 'reset-type' is "the type of reset to use" or "the type of reset
> that was just done".  There are some products that actually care about the
> latter for various RAS issues.  I don't, however, have a great alternative
> property name that comes to mind though.

I'll stick with this name for now then.
 
> >This will be used by a new PPC440SPe board port, which needs a "chip
> >reset" instead of the default "system reset" to be asserted.
> 
> I'm curious why that is?

Hmmm. Frankly, I can't remember the background here. You might what to check 
this for yourself. Katmai has the same issue. And I just copied this reboot 
code from Katmai for this new 440SPe board.

BTW: Once this patch is finished/accepted, I'll cook up a short katmai patch 
to fix this reboot issue here too.
 
> >Signed-off-by: Stefan Roese <sr@denx.de>
> >Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
> >Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >---
> >
> > arch/powerpc/sysdev/ppc4xx_soc.c |   17 +++++++++++++++--
> > 1 files changed, 15 insertions(+), 2 deletions(-)
> >
> >diff --git a/arch/powerpc/sysdev/ppc4xx_soc.c
> >b/arch/powerpc/sysdev/ppc4xx_soc.c index 5c01435..fe54216 100644
> >--- a/arch/powerpc/sysdev/ppc4xx_soc.c
> >+++ b/arch/powerpc/sysdev/ppc4xx_soc.c
> >@@ -191,11 +191,24 @@ static int __init ppc4xx_l2c_probe(void)
> >
> > arch_initcall(ppc4xx_l2c_probe);
> > 
> > /*
> >
> >- * At present, this routine just applies a system reset.
> >+ * Apply a system reset. Alternatively a board specific value may be
> >+ * provided via the "reset-type" property in the cpu node.
> >
> >  */
> > 
> > void ppc4xx_reset_system(char *cmd)
> > {
> >
> >-	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_RST_SYSTEM);
> >+	struct device_node *np;
> >+	u32 reset_type = DBCR0_RST_SYSTEM;
> >+	const u32 *prop;
> >+
> >+	np = of_find_node_by_type(NULL, "cpu");
> >+	if (np) {
> >+		prop = of_get_property(np, "reset-type", NULL);
> >+		if (prop)
> >+			reset_type = prop[0] << 28;
> >+	}
> 
> While I don't think it's a big issue, I wonder if we should sanity check
> the resulting value here.  I could see someone being dumb and doing:
> 
> 	reset-type = "system";
> 
> or something like that.  If that is done, what would the resulting shift on
> it turn into?

Good idea. I'll add a check in the next version.

Thanks.

Cheers,
Stefan
