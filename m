Return-Path: <John.Linn@xilinx.com>
Received: from IE1EHSOBE005.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 86574DDF07
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Jul 2008 23:25:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: Xilinx Linux 2.6 for XPS LL_TEMAC and LL_FIFO problem
Date: Thu, 24 Jul 2008 07:24:49 -0600
In-Reply-To: <EDAE140DF1B2FC42B5867C22CA0B333FFA5D56@XMBIL132.northgrum.com>
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl><EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com><20080316214832.3F77A538046@mail141-sin.bigfish.com><18628194.post@talk.nabble.com>
	<EDAE140DF1B2FC42B5867C22CA0B333FFA5D56@XMBIL132.northgrum.com>
From: John Linn <John.Linn@xilinx.com>
To: "Koss, Mike (Mission Systems)" <mike.koss@ngc.com>,
	"Mirek23" <miroslaw.dach@psi.ch>, <linuxppc-embedded@ozlabs.org>
Message-ID: <20080724132453.C8F1010F0077@mail56-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Mirek,

We are not currently testing the LL TEMAC driver with the LL FIFO. We
only test with the DMA configuration. I also realize this may not be
documented that well and we may need to work on that.

Our reasoning is that in the Virtex5 FXT devices the DMA is hard so that
it does not cost any more LUTs to use the DMA and most people want the
performance. =


Is there a specific reason you're wanting to use the LL FIFO rather than
DMA as this information might help us in the future?

We would welcome any patches to the driver if LL FIFO is a needed
feature.  Patches can be sent to git@xilinx.com.

Thanks,
John

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Koss, Mike
(Mission Systems)
> Sent: Thursday, July 24, 2008 6:56 AM
> To: Mirek23; linuxppc-embedded@ozlabs.org
> Subject: RE: Xilinx Linux 2.6 for XPS LL_TEMAC and LL_FIFO problem
> =

> Mirek,
> =

> I'm currently using the driver (CONFIG_XILINX_LLTEMAC) with the DMA
> portion with no problem, which is what you kind of eluded to. From
what
> I've seen, the drver source does support the FIFO portion. It just
> relies on having the proper definition for the TEMAC in either the DTS
> or the xparameters.
> =

> I'm currently using the 2.6.26-rc8 kernel (HEAD?) from git.xilinx.com
as
> well, and mine builds with no problem for arch/ppc. Yes, I still have
> not moved to arch/powerpc. I will be moving to the new arch in the
very
> near future. (My current test system is actually a mish-mash of 2.6.22
> w/ the driver from xilinx-2.6.26 tree).
> =

> Are you using arch/powerpc or arch/ppc? Are you generating your DTS
from
> your MHS file using the bsp generator for EDK on git.xilinx.com? Is
this
> for one of the reference boards (ML403, ML405, etc)? What is the
problem
> that you're having with the build of the kernel?
> =

> -- Mike
> =

> -----Original Message-----
> From: Mirek23 [mailto:miroslaw.dach@psi.ch]
> Sent: Thursday, July 24, 2008 5:20 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: Xilinx Linux 2.6 for XPS LL_TEMAC and LL_FIFO problem
> =

> =

> Dear All,
> =

> I have done a design using EDK 8.2 using Hard_Temac IP component. In
the
> EDK
> 9.2 there is a new idea to use ll_temac in conjunction with ll_fifo or
> ll_dma. So far I was using happily the linux kernel by Grant Likey.
> Unfortunately it does not deal with ll_temac. I have download the
kernel
> from git.xilinx.com.
> =

> I have tried to build the kernel 2.6.26  (by xilinx) but it seems to
be
> that it is not well prepared for ll_fifo.
> I have noticed that in drivers/xilinx_common there are files related
to
> ll_fifo but in the drivers/Makefile there is no rule to build ll_fifo.
> The same refers to the file arch/ppc/syslib/virtex_devices.c ->  there
> are no entries for LL_FIFO. I have the impression that one can use
only
> LL_DMA but not LL_FIFO.
> =

> Does anybody has modified the kernel to deal with LL_TEMAC together
with
> LL_FIFO?
> I will be grateful for any hint.
> =

> Best Regards
> =

> Mirek
> --
> View this message in context:
>
http://www.nabble.com/Compile-time-error%2C-compiling-Xilinx-Linux-2.6-f
> or-XPS-LLTEMAC-tp16065692p18628194.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> =

> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
