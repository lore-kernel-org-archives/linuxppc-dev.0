Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FBCD1A0671
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Jul 2015 05:09:49 +1000 (AEST)
Date: Fri, 3 Jul 2015 20:09:24 +0100
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 Toshi Kani <toshi.kani@hp.com>, Arnd Bergmann <arnd@arndb.de>,
 "Luis R. Rodriguez" <mcgrof@do-not-panic.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>,
 Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: RFC: default ioremap_*() variant defintions
Message-ID: <20150703190924.GZ7557@n2100.arm.linux.org.uk>
References: <20150703181709.GD7021@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150703181709.GD7021@wotan.suse.de>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 03, 2015 at 08:17:09PM +0200, Luis R. Rodriguez wrote:
> The 0-day build bot detected a build issue on a patch not upstream yet that
> makes a driver use iorempa_uc(), this call is now upstream but we have no
> drivers yet using it, the patch in question makes the atyfb framebuffer
> driver use it. The build issue was the lack of the ioremap_uc() call being
> implemented on some non-x86 architectures.

You have to be careful here.  We've been through this with ioremap_wt()
which is incorrect for ARM as things stand at the moment (I have patches
which adds documentation on this issue, and fixes ioremap_wt().)

The question is whether the allocated memory may have unaligned accesses
performed on it - either intentionally, or unintentionally (eg, by GCC
inlining memcpy().)

If the answer to that question is yes or possibly yes, neither ioremap()
nor ioremap_nocache() (which is, unfortunately, the same as ioremap() due
to various documentation telling people to use it for devices) can be used
for the mapping on ARM.

So we can't go around adding new ioremap() variants and hoping that
ioremap_nocache() is a safe default everywhere.  It isn't.

> I *thought* I had added boiler plate code to map
> the ioremap_uc() call to ioremap_nocache() for archs that do not already define
> their own iorempa_uc() call, but upon further investigation it seems that was
> not the case but found that this may be a bit different issue altogether.
> 
> The way include/asm-generic/io.h works for ioremap() calls and its variants is:
> 
> #ifndef CONFIG_MMU                                                              
> #ifndef ioremap                                                                 
> #define ioremap ioremap                                                         
> static inline void __iomem *ioremap(phys_addr_t offset, size_t size)            
> {                                                                               
>         return (void __iomem *)(unsigned long)offset;                           
> }                                                                               
> #endif 
> ...
> #define iounmap iounmap                                                         
>                                                                                 
> static inline void iounmap(void __iomem *addr)                                  
> {                                                                               
> }                                                                               
> #endif                                                                          
> #endif /* CONFIG_MMU */  

I see you've been bitten by the gnome-terminal cut'n'paste bug with all those
space characters above. ;)

> That's the gist of it, but the catch here is the ioremap_*() variants and where
> they are defined. The first variant is ioremap_nocache() and then all other
> variants by default map to this one. We've been stuffing the variant definitions
> within the #ifndef CONFIG_MMU and I don't think we should be as otherwise each
> and everyone's archs will have to add their own variant default map to the
> default ioremap_nocache() or whatever. That's exaclty what we have to day, and
> from what I gather the purpose of the variant boiler plate is lost. I think
> we should keep the ioremap() and ioreunmap() tucked under the CONFIG_MMU
> but not the variants. For instance to address the build issue for ioremap_uc()
> we either define ioremap_uc() for all archs or do something like this:

Surely, if architectures can support the different variants, then they
should implement them?

The only case where it makes sense to provide boilerplate for these is
when architectures don't support the mapping type - and then we need help
from architecture people to decide what is the appropriate mapping type
(and therefore which ioremap() variant) to be used as a fallback.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
