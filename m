Return-Path: <dale@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Mon, 14 May 2007 07:44:21 -0700
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 10/13] powerpc: check cache coherency of kernel vs firmware
Message-ID: <20070514144420.GA8458@xyzzy.farnsworth.org>
References: <20070512004605.GA2808@mag.az.mvista.com>
	<20070512005735.GJ3365@mag.az.mvista.com>
	<20070514004014.GF6517@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070514004014.GF6517@localhost.localdomain>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 14, 2007 at 12:40:14AM +0000, David Gibson wrote:
> On Fri, May 11, 2007 at 05:57:35PM -0700, Mark A. Greer wrote:
> > 
> > From: Dale Farnsworth <dale@farnsworth.org>
> > 
> > check_cache_coherency() verifies that the cache coherency setting of
> > the kernel (CONFIG_NOT_COHERENT_CACHE) matches that left by the firmware,
> > as indicated by coherency-off device tree property.
> 
> This looks really bogus.  If the firmware reports a coherency state,
> then presumably there's some hardware switch to turn coherency on or
> off.  In which case, can't the kernel just toggle that switch to
> whatever's appropriate for it?

Oh, if it were only a single hardware switch.  This is currently done
as part of about 500 lines of window register setting code that would
need to be moved/copied into the kernel from the firmware/bootwrapper.

It looks like the coherency part involves changing the same field in
a dozen device window registers, plus a different field in a register
for each PCI bus.  So that is doable, and preferable to just printing
an error and failing as the above referenced patch does.

I was very glad to see all of the window initialization code taken out
of the kernel and put into the bootwrapper, but I'm beginning to believe
that it needs to be put back in the kernel.

Mark, it's your code.  What do you think?

-Dale
