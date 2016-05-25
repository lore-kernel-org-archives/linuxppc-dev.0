Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rF1T95Gg7zDqT6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2016 15:45:17 +1000 (AEST)
Message-ID: <1464155117.8573.2.camel@ellerman.id.au>
Subject: Re: [v4] powerpc/pci: Assign fixed PHB number based on device-tree
 properties
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com,
 paulus@samba.org, imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com,
 bhelgaas@google.com, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 May 2016 15:45:17 +1000
In-Reply-To: <56F9255A.1040900@linux.vnet.ibm.com>
References: <3qWdQC0MVDz9s9Y@ozlabs.org> <56F9255A.1040900@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Guilherme,

Sorry for the very late reply, this got lost in my email filters.


On Mon, 2016-03-28 at 09:36 -0300, Guilherme G. Piccoli wrote:
> On 03/25/2016 06:33 AM, Michael Ellerman wrote:

> > > +static int get_phb_number(struct device_node *dn)
> > > +{
> > > +	const __be64 *prop64;
> > > +	const __be32 *regs;
> > > +	int phb_id = 0;
> > > +
> > > +	/* try fixed PHB numbering first, by checking archs and reading
> > > +	 * the respective device-tree property. */
> > > +	if (machine_is(pseries)) {
> > 
> > Firstly I don't see why this check needs to be conditional on pseries. Any
> > machine where the PHB has a 'reg' property should be able to use 'reg' for
> > numbering.
> 
> This is something I'm not sure for all the powerpc sub-architectures, 
> like Cell - that's the reason of the check. If you are sure about this, 
> I'll gladly remove this check =)

Please do.

I'll test on Cell & other platforms. If there are bugs we can fix them. Maybe
if we can't get it to work on eg. Cell then we need a machine_is() check, but
that should be the last resort.

> > > +		regs = of_get_property(dn, "reg", NULL);
> > > +		if (regs)
> > > +			return (int)(be32_to_cpu(regs[1]) & 0xFFFF);
> > 
> > This should use of_property_read_u32().

You missed this in v5 ^

> > And finally in either case above, where you get a number from the device tree,
> > you must check that it's not already allocated. Otherwise if you have a system
> > where some PHBs have a property but others don't, you may give out the same
> > number twice. Also you could have firmware give you the same number twice
> > (which would be a firmware bug, but those happen).
> > 
> > If the number is allocated you fall back to dynamic numbering.
> > 
> > If it's not allocated you must mark it as allocated in the bitmap.
> 
> Hmm..interesting. I thought in performing such check, but I wasn't able 
> to imagine a system in which we can have some PHBs indexed by 
> device-tree properties and others don't, seemed impossible to me. The 
> buggy fw case is an example, I can implement this modification if you 
> think it's valid.
> 
> But, notice that for consistency in implementation, I'll might need to 
> increase the MAX_PHBS value to 65536, otherwise we won't cover all the 
> possible wrong cases, since I'm performing an AND with 0xFFFF mask 
> (imagine if we can have a buggy fw exposing same value for two different 
> PHBs, and this value is higher than 8192). What do you think about this?

Yeah please increase the bitmap size to 65536. It will only take 8KB of memory,
which is negligible.

cheers
