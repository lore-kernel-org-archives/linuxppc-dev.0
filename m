Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Sun, 5 Feb 2012 23:00:04 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v3 21/25] irqdomain/powerpc: Replace custom xlate
 functions with library functions
Message-ID: <20120206060004.GB21449@ponder.secretlab.ca>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <1327700179-17454-22-git-send-email-grant.likely@secretlab.ca>
 <24476.1328505761@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24476.1328505761@neuling.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Milton Miller <miltonm@bga.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 06, 2012 at 04:22:41PM +1100, Michael Neuling wrote:
> >  static const struct irq_domain_ops pmac_pic_host_ops = {
> >  	.match = pmac_pic_host_match,
> >  	.map = pmac_pic_host_map,
> > -	.xlate = pmac_pic_host_xlate,
> > +	.xlate = irq_domain_xlate_onecell;
> >  };
> >  
> 
> This causes a compile fail (in next-20120206):
>   arch/powerpc/platforms/powermac/pic.c:294: error: expected '}' before ';' token
> Trivial fix below:

fixed, thanks.

g.

> 
> 
> 
> irqdomain/powerpc: Fix compile error in powermac/pic.c
> 
> Error introduced in:
>   commit 72d6b477675374eafd206720d6c9146520df18ce
>   Author: Grant Likely <grant.likely@secretlab.ca>
>   irqdomain/powerpc: Replace custom xlate functions with library functions
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
> diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
> index 3af29d1..92afc38 100644
> --- a/arch/powerpc/platforms/powermac/pic.c
> +++ b/arch/powerpc/platforms/powermac/pic.c
> @@ -291,7 +291,7 @@ static int pmac_pic_host_map(struct irq_domain *h, unsigned int virq,
>  static const struct irq_domain_ops pmac_pic_host_ops = {
>  	.match = pmac_pic_host_match,
>  	.map = pmac_pic_host_map,
> -	.xlate = irq_domain_xlate_onecell;
> +	.xlate = irq_domain_xlate_onecell,
>  };
>  
>  static void __init pmac_pic_probe_oldstyle(void)
