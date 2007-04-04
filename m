Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1175611539.2665.30.camel@shinybook.infradead.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<26babf7b7398794f08e7417377b3facc@kernel.crashing.org>
	<1175473220.3144.1.camel@concordia.ozlabs.ibm.com>
	<432af8a0f928491e7d376923829f40a0@kernel.crashing.org>
	<1175568133.16182.15.camel@concordia.ozlabs.ibm.com>
	<1175570169.30552.3.camel@shinybook.infradead.org>
	<1175611539.2665.30.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 11:26:35 +1000
Message-Id: <1175649996.30879.35.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, nhorman@redhat.com,
	cbe-oss-dev <cbe-oss-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 10:45 -0400, David Woodhouse wrote:
> On Mon, 2007-04-02 at 23:16 -0400, David Woodhouse wrote:
> > > > My question remains: shouldn't Linux get that
> > > > information from the device tree, instead?  The
> > > > bootwrapper or bootloader can put it there.
> > > 
> > > Yes it _should_, but it doesn't.
> > 
> > It _used_ to. The 2.6.16 kernel just used the memory listed in the
> > device tree. That's _why_ we need this hack -- because when we boot
> > from
> > 2.6.16 with the memory listed in the device tree, it ends up getting
> > registered twice by the new kernel. 
> 
> Why _did_ we make this change? It makes /sbin/kexec unhappy too, since
> it doesn't like the apparent lack of _any_ memory.
> 
> It's not as if anyone's going to be expanding the amount of memory in
> their PS3, so it really needs to be dynamically detected.
> 
> If we were to put the memory back in the device-tree, and start with a
> single region up to 0x07c00000 followed by another region with the rest
> of it, then we wouldn't need the rmo_top hack to /sbin/kexec either.

I think the right approach on the PS3 would be to have the RMO in
the /memory node... and _maybe_ the hotplugged memory in a separate
range in there, though that is less important.

Would it be possible to modify the 2.6.16 kernel to split the /memory
range in two (or is it already doing that ?). I have no problem relying
on an updated 2.6.16 when booting off an old distro.

As far as 2.6.2x is concerned, I think we should put the RMO at least
in /memory and that can easily be done by having the ps3 platform code
overwrite the /memory node content. The other approach would be to fix
it up from the zImage wrapper, but that would require booting off zImage
unless you are coming from a sane kernel.

Ben.
