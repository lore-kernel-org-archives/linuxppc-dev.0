Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 348CDDDEEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Jun 2007 23:44:19 +1000 (EST)
Message-ID: <46680D36.6000507@ru.mvista.com>
Date: Thu, 07 Jun 2007 17:50:46 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Simple driver for Xilinx SPI controler.
References: <fa686aa40706061200u1141fcc9k73b7cc80c07240d1@mail.gmail.com>	
	<20070606190640.B7028900053@mail104-cpk.bigfish.com>
	<fa686aa40706061255w2e589980tf89f3ba763bb9f54@mail.gmail.com>
In-Reply-To: <fa686aa40706061255w2e589980tf89f3ba763bb9f54@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	Wolfgang Reissnegger <wre@xilinx.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

IMHO the Kconfig stuff is off topic on spi-devel-general list, so I've removed
them from the distribution list. OK?

Grant Likely wrote:
> On 6/6/07, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com> wrote:
>> > Why still have XILINX_EDK?  I thought you meant replace
>> > XILINX_EDK with XILINX_DRIVERS.
>>
>> Yes, that's what I was suggesting.
>> But I think that Andrei still wants to use XILINX_EDK to pull in the
>> stuff in drivers/xilinx_common.

Correct,

>> # The Xilinx OS common code
>> obj-$(CONFIG_XILINX_EDK) += xbasic_types.o xpacket_fifo_l_v2_00_a.o \
>>                             xpacket_fifo_v2_00_a.o xversion.o \
>>                             xdma_channel.o xdma_channel_sg.o
>>

.. but not exactly this way.
See
http://source.mvista.com/git/gitweb.cgi?p=linux-xilinx-26.git;a=commitdiff;h=e5b35cc7fdef280b7dd7e592a57c6dd823c62ea1
http://source.mvista.com/git/gitweb.cgi?p=linux-xilinx-26.git;a=commitdiff;h=b03eb158a0c1b4a8dd32940df02431bdd5ffcef9

>> Which you wouldn't want if you were able to build a kernel completely
>> from 'non-edk' drivers.
> 
> Fair enough, but that's only an issue for vendor trees.  None of this
> code will be going into mainline.  Any of it that does get into good
> shape should probably go under drivers/misc, and have the drivers

At the moment I have this stuff in arch/ppc/syslib/xilinx.
drivers/misc seems a better place indeed.
Anyone objects I move arch/ppc/syslib/xilinx/* to drivers/misc/xilinx/* ?

> select only the pieces that are needed (with finer-grain CONFIG_
> items).

Yes, my current implementation is:


--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -229,6 +229,16 @@ config XILINX_VIRTEX_4_FX
config XILINX_VIRTEX
bool
+# The options selected by EDK based drivers. Not visible from [menu]config.
+config XILINX_EDK
+ bool
+config XILINX_IPIF_V123B
+ bool
+config XILINX_FIFO_V200A
+ bool
+config XILINX_DMA_V300A
+ bool
+
config STB03xxx

--- /dev/null
+++ b/arch/ppc/syslib/xilinx/Makefile
@@ -0,0 +1,10 @@
+#
+# Makefile for generic hardware blocks that could be incorporated into
+# various IP blocks: IPIF, FIFO, SGDMA.
+#
+
+obj-$(CONFIG_XILINX_EDK) += xbasic_types.o
+obj-$(CONFIG_XILINX_IPIF_V123B) += xipif_v1_23_b.o
+obj-$(CONFIG_XILINX_FIFO_V200A) += xpacket_fifo_v2_00_a.o \
+ xpacket_fifo_l_v2_00_a.o
+obj-$(CONFIG_XILINX_DMA_V300A) += xdmav3.o xdmav3_intr.o xdmav3_sg.o

--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2330,6 +2330,18 @@ config ATL1
To compile this driver as a module, choose M here. The module
will be called atl1.
+config XILINX_TEMAC
+ tristate "Xilinx 10/100/1000 Mbit TEMAC support"
+ depends on XILINX_VIRTEX
+ select PHYLIB
+ select XILINX_EDK
+# select XILINX_IPIF_V123B
+ select XILINX_FIFO_V200A
+ select XILINX_DMA_V300A
+ help
+ This driver supports Tri-Mode, 10/100/1000 Mbit EMAC IP
+ from Xilinx EDK.
+
endif # NETDEV_1000

Is it better?
(Except for CONFIG_XILINX_EDK which should be better renamed to CONFIG_XILINX_COMMON
or CONFIG_XILINX_COMMON_V100A as per the level 1 driver name in the EDK:
sw/XilinxProcessrIPLib/drivers/common_v1_00_a/src)

> A blanked CONFIG_XILINX_EDK for random stuff is not a good
> idea.

Agreed

Thanks,
Andrei

> Cheers,
> g.
> 
>>
>> Steve
>>
>>
>>
> 
> 
