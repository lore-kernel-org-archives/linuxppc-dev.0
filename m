Return-Path: <hollisb@us.ibm.com>
Subject: Re: [RFC] consolidated libdt proposal
From: Hollis Blanchard <hollisb@us.ibm.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060808180408.GD6079@mag.az.mvista.com>
References: <20060719230544.GD3887@mag.az.mvista.com>
	<1154911082.27074.104.camel@diesel>
	<1154987921.24455.32.camel@basalt.austin.ibm.com>
	<20060808180408.GD6079@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 13:25:10 -0500
Message-Id: <1155061510.30116.197.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
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

On Tue, 2006-08-08 at 11:04 -0700, Mark A. Greer wrote:
> 
> Except for not being able to extend a property (see below),
> I think it does meet my needs (at least as I know them today).

Great.

> However, I was hoping to keep the interfaces in the bootwrapper
> similar to the ones used in the kernel.  To that end, I had a
> routine to find a device node and other routines to find and modify
> a property within that node.  I didn't notice a "finddevice" type of
> function to find a device node.  Would you have a problem adding one?

The way property modification works now is this:
	p = ft_get_prop(tree, "/xen/console/interrupts", &len);
	if ((NULL == p) || (len != foolen))
		return;
	*p = cpu_to_be32(foo);
(That does need to be hidden in a yet-to-be-written ft_set_prop().)

If necessary, it looks like it would be possible to modify ft_get_prop()
to return a pointer to the beginning of the node structure, but is it
really necessary? Do you have code that would be difficult to convert to
using
	ft_set_prop(tree, "/node/prop", buf, buflen);
?

> > One limitation of the attached code is that it doesn't support changing
> > the *size* of properties, though I don't think that would be too
> > difficult to add if needed.
> 
> If we're going to allow cmdline editing in the bootwrapper, we would
> need to extend the size of a property.  We've never really talked about
> cmdline editing in the powerpc branch but I assume that its a good
> thing(tm).  I know I would like to have it so, IMHO, I think we should
> add it (and therefore require extending a property).

I agree, and it shouldn't be too much work. I'll take a look later this
week, if nobody else has.

-- 
Hollis Blanchard
IBM Linux Technology Center
