Return-Path: <bharata@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qprkx2gbrzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 13:55:21 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bharata@linux.vnet.ibm.com>;
 Tue, 19 Apr 2016 13:55:19 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 774B22CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 13:55:08 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3J3t0oV64487442
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 13:55:08 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3J3sZNI022192
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 13:54:35 +1000
Date: Tue, 19 Apr 2016 09:24:13 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, nfonteno@us.ibm.com, aik@au1.ibm.com,
 mdroth@linux.vnet.ibm.com, david@gibson.dropbear.id.au
Subject: Re: [RFC FIX PATCH v0] powerpc,numa: Fix memory_hotplug_max()
Message-ID: <20160419035413.GC14785@in.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <1459935883-29445-1-git-send-email-bharata@linux.vnet.ibm.com>
 <57074150.6070105@linux.vnet.ibm.com>
 <20160409101431.GA21158@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160409101431.GA21158@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 09, 2016 at 03:44:31PM +0530, Bharata B Rao wrote:
> On Fri, Apr 08, 2016 at 12:27:44AM -0500, Nathan Fontenot wrote:
> > On 04/06/2016 04:44 AM, Bharata B Rao wrote:
> > > memory_hotplug_max() uses hot_add_drconf_memory_max() to get maxmimum
> > > addressable memory by referring to ibm,dyanamic-memory property. There
> > > are three problems with the current approach:
> > > 
> > > 1 hot_add_drconf_memory_max() assumes that ibm,dynamic-memory includes
> > >   all the LMBs of the guest, but that is not true for PowerKVM which
> > >   populates only DR LMBs (LMBs that can be hotplugged/removed) in that
> > >   property.
> > > 2 hot_add_drconf_memory_max() multiplies lmb-size with lmb-count to arrive
> > >   at the max possible address. Since ibm,dynamic-memory doesn't include
> > >   RMA LMBs, the address thus obtained will be less than the actual max
> > >   address. For example, if max possible memory size is 32G, with lmb-size
> > >   of 256MB there can be 127 LMBs in ibm,dynamic-memory (1 LMB for RMA
> > >   which won't be present here).  hot_add_drconf_memory_max() would then
> > >   return the max addressable memory as 127 * 256MB = 31.75GB, the max
> > >   address should have been 32G which is what ibm,lrdr-capacity shows.
> > > 3 In PowerKVM, there can be a gap between the end of boot time RAM and
> > >   beginning of hotplug RAM area. So just multiplying lmb-count with
> > >   lmb-size will not provide the correct max possible address for PowerKVM.
> > > 
> > > This patch fixes 1 by using ibm,lrdr-capacity property to return the max
> > > addressable memory whenever the property is present. Then it fixes 2 & 3
> > > by fetching the address of the last LMB in ibm,dynamic-memory property.
> > > 
> > > NOTE: There are some unnecessary changes in the patch because of converting
> > > spaces to tabs w/o which checkpatch.pl complains.
> > > 
> > > Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> > > ---
> > >  arch/powerpc/mm/numa.c | 29 ++++++++++++++++++++++-------
> > >  1 file changed, 22 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> > > index 669a15e..57d5877 100644
> > > --- a/arch/powerpc/mm/numa.c
> > > +++ b/arch/powerpc/mm/numa.c
> > > @@ -1164,17 +1164,32 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
> > >  static u64 hot_add_drconf_memory_max(void)
> > >  {
> > >          struct device_node *memory = NULL;
> > > -        unsigned int drconf_cell_cnt = 0;
> > > -        u64 lmb_size = 0;
> > > +	struct device_node *dn = NULL;
> > > +	unsigned int drconf_cell_cnt = 0;
> > > +	u64 lmb_size = 0;
> > >  	const __be32 *dm = NULL;
> > > +	const __be64 *lrdr = NULL;
> > > +	struct of_drconf_cell drmem;
> > > +
> > > +	dn = of_find_node_by_path("/rtas");
> > > +	if (dn) {
> > > +		lrdr = of_get_property(dn, "ibm,lrdr-capacity", NULL);
> > > +		of_node_put(dn);
> > > +		if (lrdr)
> > > +			return be64_to_cpup(lrdr);
> > > +	}
> > >  
> > >          memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
> > >          if (memory) {
> > > -                drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
> > > -                lmb_size = of_get_lmb_size(memory);
> > > -                of_node_put(memory);
> > > -        }
> > > -        return lmb_size * drconf_cell_cnt;
> > > +		drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
> > > +		lmb_size = of_get_lmb_size(memory);
> > > +
> > > +		/* Advance to the last cell, each cell has 6 32 bit integers */
> > > +		dm += (drconf_cell_cnt - 1) * 6;
> > 
> > You could do this as follows to avoid hard-coding 6
> 
> Can't do that since dm is of type __be32 pointer.
> 
> > 		dm += (drconf_cell_cnt - 1) * sizeof(struct of_drconf_cell)
> > 
> > > +		read_drconf_cell(&drmem, &dm);
> > > +		of_node_put(memory);
> > > +	}
> > > +	return drmem.base_addr + lmb_size;
> > 
> > I assume it is a safe assumption that there will only be 1 RMA LMB?
> 
> No, I am not assuming RMA to have 1 LMB here. I fetch the last LMB and
> get the max possible address from it by adding the base address of the
> last LMB with the lmb_size.
> 
> > 
> > I do see that the PAPR defines a bit in the flags field for each LMB
> > in ibm,dynamic-memory as 'reserved'. Is this something you could use
> > to flag RMA LMBs and put them in the ibm,dynamic-memory property?
> > 
> > I'm just curious why these LMBs are not in this property.
> 
> Not sure about both the above observations.
> 
> Section B.6.6 of LoPAPR mentions "... called the RMA, that is represented
> by the first value of the reg property of this first /memory node. Additional
> storage regions may each be represented by their own /memory node that
> includes dynamic reconfiguration (DR) properties or by an entry in
> /ibm,dynamic-reconfiguration-memory nodes"
> 
> Section B.6.6.2 says "All memory which is not subject to dynamic
> reconfiguration (such as the RMA) is represented in /memory node(s).
> 
> Currently PowerKVM puts RMA region and boot time memory (which is
> currently non DR in case of PowerKVM) in to their own /memory nodes and
> puts only DR LMBs (hot pluggable) RAM into
> ibm,dynamic-reconfiguration-memory node.

Nathan - If the fix is correct and the behaviour is as per PAPR, could this
be pursued further ?

Regards,
Bharata.
