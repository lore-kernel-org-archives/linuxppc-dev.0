Return-Path: <jbarnes@engr.sgi.com>
Received: from omx2.sgi.com (omx2-ext.sgi.com [192.48.171.19])
	by ozlabs.org (Postfix) with ESMTP id DA38167A73
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Mar 2005 17:29:15 +1100 (EST)
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 24 Mar 2005 08:54:45 -0800
References: <1111645464.5569.15.camel@gaston>
In-Reply-To: <1111645464.5569.15.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503240854.45741.jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ppc32/64: Map prefetchable PCI without guarded bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday, March 23, 2005 10:24 pm, Benjamin Herrenschmidt wrote:
> While experimenting with framebuffer access performances, we noticed a
> very significant improvement in write access to it when not setting
> the "guarded" bit on the MMU mappings. This bit basically says that
> reads and writes won't have side effects (it allows speculation). It
> appears that it also disables write combining.

Doesn't pgprot_writecombine imply non-guarded, so can't you use it instead?  
Either way, you'll probably want to fix fbmem.c as well and turn off 
_PAGE_GUARDED?

Maybe it's time for a more generic call to support this stuff, both for 
in-kernel mappings and ones that we export to userspace.

Jesse
