Return-Path: <arnd.bergmann@de.ibm.com>
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 06/13] powerpc: cell interrupt controller updates
Date: Fri, 24 Mar 2006 19:05:03 +0100
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<20060323203521.862355000@dyn-9-152-242-103.boeblingen.de.ibm.com>
	<32140afe2349e8f1726d188eb85c780c@bga.com>
In-Reply-To: <32140afe2349e8f1726d188eb85c780c@bga.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603241905.04356.arnd.bergmann@de.ibm.com>
Cc: stk@de.ibm.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, hpenner@de.ibm.com,
	Arnd Bergmann <abergman@de.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 24 March 2006 18:43, Milton Miller wrote:
> On Mar 22, 2006, at 5:00 PM, Arnd Bergmann wrote:
> >  static void spider_enable_irq(unsigned int irq)
> >  {
> > +     int nodeid = (irq / IIC_NODE_STRIDE) * 0x10;
> >       void __iomem *cfg = spider_get_irq_config(irq);
> >       irq = spider_get_nr(irq);
> >
> > -     out_be32(cfg, in_be32(cfg) | 0x3107000eu);
> > +     out_be32(cfg, in_be32(cfg) | 0x3107000eu | nodeid);
> >       out_be32(cfg + 4, in_be32(cfg + 4) | 0x00020000u | irq);
> >  }
> >
> 
> I just did a quick read of the code, but my first thought is what if 
> some other node id was previously set?  Perhaps you should mask off 
> some bits before or'ing in the node id?

Good point. The firmware always sets nodeid zero (or the same one that
we set), but I can't see any reason why we should take that for granted.

Thanks,

	Arnd <><
