Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <48726B66.5080404@am.sony.com>
Date: Mon, 7 Jul 2008 12:15:50 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [patch 07/11] powerpc/dma: implement new
	dma_*map*_attrs()	interfaces
References: <20080704190535.316377278@arndb.de>	
	<20080704190806.430190454@arndb.de>
	<1215408473.8970.69.camel@pasglop>
In-Reply-To: <1215408473.8970.69.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Fri, 2008-07-04 at 21:05 +0200, arnd@arndb.de wrote:
>> plain text document attachment
>> (0007-powerpc-dma-implement-new-dma_-map-_attrs-interfa.patch)
>> Update powerpc to use the new dma_*map*_attrs() interfaces. In doing so
>> update struct dma_mapping_ops to accept a struct dma_attrs and propagate
>> these changes through to all users of the code (generic IOMMU and the
>> 64bit DMA code, and the iseries and ps3 platform code).
>> 
>> The old dma_*map_*() interfaces are reimplemented as calls to the
>> corresponding new interfaces.
> 
> Geoff, I think the PS3 bits in this patch are ok but I'd like
> you to double-check and send your ack if you think they are.


I tested on PS3 with ps3_defconfig, and it works OK.

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>


>> Signed-off-by: Mark Nelson <markn@au1.ibm.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/powerpc/Kconfig                    |    1 +
>>  arch/powerpc/kernel/dma_64.c            |   34 ++++++---
>>  arch/powerpc/kernel/ibmebus.c           |   12 ++-
>>  arch/powerpc/kernel/iommu.c             |   11 ++-
>>  arch/powerpc/platforms/iseries/iommu.c  |    4 +-
>>  arch/powerpc/platforms/ps3/system-bus.c |   17 +++--
>>  include/asm-powerpc/dma-mapping.h       |  116 +++++++++++++++++++++++--------
>>  include/asm-powerpc/iommu.h             |   12 ++-
>>  8 files changed, 144 insertions(+), 63 deletions(-)
