Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id D59D11A2C01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 18:18:02 +1000 (AEST)
Date: Fri, 18 Sep 2015 18:17:30 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org
Subject: Re: [RFC v4 17/25] powerpc, fbdev: Use arch_nvram_ops methods instead
 of nvram_read_byte() and nvram_write_byte()
In-Reply-To: <alpine.LNX.2.00.1507161530270.19651@nippy.intranet>
Message-ID: <alpine.LNX.2.00.1509181635140.13887@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102531.505897278@telegraphics.com.au>
 <alpine.LNX.2.00.1507141725480.851@nippy.intranet>
 <1436874720.3948.252.camel@kernel.crashing.org>
 <alpine.LNX.2.00.1507151200510.2862@nippy.intranet>
 <alpine.LNX.2.00.1507161530270.19651@nippy.intranet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ben,

On Thu, 16 Jul 2015, I wrote:

> On Wed, 15 Jul 2015, I wrote:
> 
> > On Tue, 14 Jul 2015, Benjamin Herrenschmidt wrote:
> > 
> > > Maybe we should have a dedicated accessor for "mac_xpram" ...
> > 
> ...
> 
> The arch_nvram_ops methods don't deal with structures like partitions ...

Instead of the accessor you suggested, perhaps it would be better to add a 
method like arch_nvram_ops.get_partition, to replace the 
pmac_get_partition() exported function?

The call sites for pmac_get_partition() are in the implementation of the 
IOC_NVRAM_GET_OFFSET ioctl that's used with /dev/nvram, and in 
pmac_xpram_read(). pmac_xpram_write() has no caller and could be removed.

But this doesn't have much to do with linux-fbdev. I think the old 
NV_CMODE/NV_VMODE issues*, which this patch avoids, are irrelevant to the 
problem of nvram module re-use, which is the aim of this patch series.

But if those issues really are relevant then we should move the discussion 
to the revised patch, that is, [RFC v6 16/25] powerpc, fbdev: Use NV_CMODE 
and NV_VMODE only when CONFIG_PPC32 and CONFIG_PPC_PMAC and CONFIG_NVRAM.

(There was no response to any patch in RFC v6 from any PowerPC 
maintainers, which is why I've revived this thread.)

* https://lists.ozlabs.org/pipermail/linuxppc-dev/2001-November/012662.html

-- 
