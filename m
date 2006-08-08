Return-Path: <mgreer@mvista.com>
Date: Tue, 8 Aug 2006 11:04:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [RFC] consolidated libdt proposal
Message-ID: <20060808180408.GD6079@mag.az.mvista.com>
References: <20060719230544.GD3887@mag.az.mvista.com>
	<1154911082.27074.104.camel@diesel>
	<1154987921.24455.32.camel@basalt.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1154987921.24455.32.camel@basalt.austin.ibm.com>
Cc: Pantelis Antoniou <pantelis@embeddedalley.com>,
	"xen-ppc-devel@lists.xensource.com" <xen-ppc-devel@lists.xensource.com>,
	linuxppc-dev@ozlabs.org, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Hollis,

On Mon, Aug 07, 2006 at 04:58:41PM -0500, Hollis Blanchard wrote:
> On Sun, 2006-08-06 at 19:38 -0500, Hollis Blanchard wrote:
> > 
> > Hmm, so we'll have at least three copies of this code: uboot, kernel,
> > and Xen. Would it make sense to put this stuff into a libdt.a?
> > Technically, dtc has a "libdt" already, but it's absurdly incomplete
> > (I don't even know why it's there), so we could just replace it. 
> 
> Mark, I had a look at the code Pantelis wrote for u-boot, and it was
> pretty easy to adapt to meet Xen's (userspace-based) needs. I've
> attached my version below (and see ft_setup() at the bottom of the
> file). Does it meet your requirements for the kernel bootwrapper?

[Disclaimer: I did a fairly quick scan of your patch so I may have
misread or missed something.]

Except for not being able to extend a property (see below),
I think it does meet my needs (at least as I know them today).

However, I was hoping to keep the interfaces in the bootwrapper
similar to the ones used in the kernel.  To that end, I had a
routine to find a device node and other routines to find and modify
a property within that node.  I didn't notice a "finddevice" type of
function to find a device node.  Would you have a problem adding one?

> One limitation of the attached code is that it doesn't support changing
> the *size* of properties, though I don't think that would be too
> difficult to add if needed.

If we're going to allow cmdline editing in the bootwrapper, we would
need to extend the size of a property.  We've never really talked about
cmdline editing in the powerpc branch but I assume that its a good
thing(tm).  I know I would like to have it so, IMHO, I think we should
add it (and therefore require extending a property).

Mark
