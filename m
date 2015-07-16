Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id CB8901A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 16:02:09 +1000 (AEST)
Date: Thu, 16 Jul 2015 16:01:41 +1000 (AEST)
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
In-Reply-To: <alpine.LNX.2.00.1507151200510.2862@nippy.intranet>
Message-ID: <alpine.LNX.2.00.1507161530270.19651@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102531.505897278@telegraphics.com.au>
 <alpine.LNX.2.00.1507141725480.851@nippy.intranet>
 <1436874720.3948.252.camel@kernel.crashing.org>
 <alpine.LNX.2.00.1507151200510.2862@nippy.intranet>
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


On Wed, 15 Jul 2015, I wrote:

> On Tue, 14 Jul 2015, Benjamin Herrenschmidt wrote:
> 
> > Maybe we should have a dedicated accessor for "mac_xpram" ...
> 
> ... I can see how to implement XPRAM for matroxfb and imsttfb 

I'll have to retract that. The video mode and color mode settings used by 
the PowerMac framebuffer drivers don't exist in the PRAM portion of NVRAM.

Addresses 0x140F and 0x1410 are found in the partition reserved by Apple 
for "Name Registry properties", according to Designing PCI Cards and 
Drivers for Power Macintosh Computers. There is no equivalent on m68k 
Macs, AFAIK.

This is NVRAM partition 2 on my beige g3, which begins at 0x1400. I'm not 
sure that this is true on New World PowerMacs, and I suspect that the 
framebuffer drivers should be calling pmac_get_partition() to determine 
the offset of the beginning of the Name Registry partition.

The arch_nvram_ops methods don't deal with structures like partitions. 
They treat the entire 8 KiB as unstructured, because that's how /dev/nvram 
treats it.

-- 
