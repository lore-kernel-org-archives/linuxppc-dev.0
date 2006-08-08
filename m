Return-Path: <mgreer@mvista.com>
Date: Tue, 8 Aug 2006 11:51:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [RFC] consolidated libdt proposal
Message-ID: <20060808185131.GA9231@mag.az.mvista.com>
References: <20060719230544.GD3887@mag.az.mvista.com>
	<1154911082.27074.104.camel@diesel>
	<1154987921.24455.32.camel@basalt.austin.ibm.com>
	<20060808180408.GD6079@mag.az.mvista.com>
	<1155061510.30116.197.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1155061510.30116.197.camel@basalt.austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Pantelis Antoniou <pantelis@embeddedalley.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	"xen-ppc-devel@lists.xensource.com" <xen-ppc-devel@lists.xensource.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 08, 2006 at 01:25:10PM -0500, Hollis Blanchard wrote:
> On Tue, 2006-08-08 at 11:04 -0700, Mark A. Greer wrote:
> > 
> > Except for not being able to extend a property (see below),
> > I think it does meet my needs (at least as I know them today).
> 
> Great.
> 
> > However, I was hoping to keep the interfaces in the bootwrapper
> > similar to the ones used in the kernel.  To that end, I had a
> > routine to find a device node and other routines to find and modify
> > a property within that node.  I didn't notice a "finddevice" type of
> > function to find a device node.  Would you have a problem adding one?
> 
> The way property modification works now is this:
> 	p = ft_get_prop(tree, "/xen/console/interrupts", &len);
> 	if ((NULL == p) || (len != foolen))
> 		return;
> 	*p = cpu_to_be32(foo);
> (That does need to be hidden in a yet-to-be-written ft_set_prop().)
> 
> If necessary, it looks like it would be possible to modify ft_get_prop()
> to return a pointer to the beginning of the node structure, but is it
> really necessary?

No, its just a preference to have it look similar to kernel code.

> Do you have code that would be difficult to convert to
> using
> 	ft_set_prop(tree, "/node/prop", buf, buflen);
> ?

No.

> > > One limitation of the attached code is that it doesn't support changing
> > > the *size* of properties, though I don't think that would be too
> > > difficult to add if needed.
> > 
> > If we're going to allow cmdline editing in the bootwrapper, we would
> > need to extend the size of a property.  We've never really talked about
> > cmdline editing in the powerpc branch but I assume that its a good
> > thing(tm).  I know I would like to have it so, IMHO, I think we should
> > add it (and therefore require extending a property).
> 
> I agree, and it shouldn't be too much work. I'll take a look later this
> week, if nobody else has.

OK.

Mark
