Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Wed, 2 May 2007 19:57:18 -0700
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 10/13] powerpc: Add arch/powerpc mv64x60 PCI setup
Message-ID: <20070503025718.GC26019@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000107.GL4046@mag.az.mvista.com>
	<20070502214609.GE27253@xyzzy.farnsworth.org>
	<20070503121358.aabc2755.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070503121358.aabc2755.sfr@canb.auug.org.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 03, 2007 at 12:13:58PM +1000, Stephen Rothwell wrote:
> On Wed, 2 May 2007 14:46:09 -0700 "Dale Farnsworth" <dale@farnsworth.org> wrote:
> >
> > +DECLARE_MUTEX(mv64x60_hs_lock);
> 
> Does this need to be global (it is not declared in a header file)?

Nope.  Fixed.

> > +	np = of_find_compatible_node(NULL, NULL, "mv64x60");
> > +	if (!np)
> > +		return 0;
> > +
> > +	pdev = platform_device_register_simple("mv64x60", 0, NULL, 0);
> > +	if (IS_ERR(pdev))
> > +		return PTR_ERR(pdev);
> 
> This error leaks a reference count on np.

Good find.  Fixed.

Stephen, thanks for taking the time to review and comment.
I'll wait to see what other comments I get before reposting.

-Dale
