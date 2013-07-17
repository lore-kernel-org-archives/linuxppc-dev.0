Return-Path: <gsi@denx.de>
Date: Wed, 17 Jul 2013 12:42:34 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH RFC v2 2/5] dma: mpc512x: add support for peripheral
 transfers
Message-ID: <20130717104234.GJ7080@book.gsilab.sittig.org>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373803321-11628-1-git-send-email-gsi@denx.de>
 <1373803321-11628-3-git-send-email-gsi@denx.de>
 <51E5226D.9050100@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51E5226D.9050100@metafoo.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 devicetree-discuss@lists.ozlabs.org, Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 16, 2013 at 12:37 +0200, Lars-Peter Clausen wrote:
> 
> On 07/14/2013 02:01 PM, Gerhard Sittig wrote:
> > From: Alexander Popov <a13xp0p0v88@gmail.com>
> > 
> > introduce support for slave s/g transfer preparation and the associated
> > device control callback in the MPC512x DMA controller driver, which adds
> > support for data transfers between memory and peripheral I/O to the
> > previously supported mem-to-mem transfers
> > 
> > refuse to prepare chunked transfers (transfers with more than one part)
> > as long as proper support for scatter/gather is lacking
> > 
> > keep MPC8308 operational by always starting transfers from software,
> > this SoC appears to not have request lines for flow control when
> > peripherals are involved in transfers
> 
> I had a look at the current driver and it seems that any channel can be used
> for memcpy operation not only the MDDRC channel. Since the dmaengine API
> will just pick one of the currently free channels when performing a memcpy
> operation I think this patch breaks memcpy operations. You probably need to
> register two dma controllers, one for memcpy operations one for slave
> operations, that way you can ensure that only the MDDRC channel is used for
> memcpy operations.

OK, so the need for explicit start in software or external
request by the peripheral remains, but the condition for the
choice is different.  It might become a flag attached to the DMA
channel, that gets setup in the prep routines (memory and slave
access each use their own prep calls) and gets evaluated in
execute.  Something like "will access memory", or "will access
peripheral" (the latter may be preferrable since slave support is
the new feature).

This assumes that the non-MDDRC channels can get used for memory
transfers as well, which your description of the the former use
suggests, when slave support was absent.

Making the MDDRC channel preferrable for memcpy operations is
orthogonal to that.

> > 
> > [ introduction of slave s/g preparation and device control ]
> > Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
> > [ execute() start condition, mpc8308 compat, terminate all, s/g length check, reworded commit msg ]
> > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > ---
> [...]


> > +
> > +static int mpc_dma_device_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> > +				  unsigned long arg)
> > +{
> > +	struct mpc_dma_chan *mchan;
> > +	struct mpc_dma *mdma;
> > +	struct dma_slave_config *cfg;
> > +
> > +	mchan = dma_chan_to_mpc_dma_chan(chan);
> > +	switch (cmd) {
> > +	case DMA_TERMINATE_ALL:
> > +		/* disable channel requests */
> > +		mdma = dma_chan_to_mpc_dma(chan);
> > +		out_8(&mdma->regs->dmacerq, chan->chan_id);
> > +		list_splice_tail_init(&mchan->prepared, &mchan->free);
> > +		list_splice_tail_init(&mchan->queued, &mchan->free);
> > +		list_splice_tail_init(&mchan->active, &mchan->free);
> 
> This probably need locking.

Ah, yes.  It needs to grab the same lock as all the other list
manipulations in the driver's source.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
