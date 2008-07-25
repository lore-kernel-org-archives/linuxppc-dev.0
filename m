Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 0CA25DE170
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jul 2008 21:22:18 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KMLNH-0004Re-2J
	for linuxppc-embedded@ozlabs.org; Fri, 25 Jul 2008 04:22:15 -0700
Message-ID: <18649823.post@talk.nabble.com>
Date: Fri, 25 Jul 2008 04:22:15 -0700 (PDT)
From: Mirek23 <miroslaw.dach@psi.ch>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Xilinx Linux 2.6 for XPS LL_TEMAC and LL_FIFO problem
In-Reply-To: <20080724132453.C8F1010F0077@mail56-dub.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <BAY115-W186EA84A950C17657AD8D9B20B0@phx.gbl>
	<EDAE140DF1B2FC42B5867C22CA0B333FA99D2F@XMBIL132.northgrum.com>
	<20080316214832.3F77A538046@mail141-sin.bigfish.com>
	<18628194.post@talk.nabble.com>
	<EDAE140DF1B2FC42B5867C22CA0B333FFA5D56@XMBIL132.northgrum.com>
	<20080724132453.C8F1010F0077@mail56-dub.bigfish.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi John and Mike,

Thank you for your reply. We have modified out FPGA design and now we have
LL_TEMAC with LL_DMA component connected instead of the LL_FIFO. Before
building linux kernel we have tried to build the u-boot (downloaded from the
xilinx-git tree).

It was relatively easy to build u-boot which has the ll_temac with ll_dma
support.

next we have tried to run u-boot on our ppc (virtex-4 FX12). All went fine
till the moment to establish the communication with the network.

I put some debug messages to the xilinx ll_dma and ll_temac drivers and we
have found that u-boot hangs 
during dma initialisation:

more specifically in the function calls :
       XLlDma_Initialize(XLlDma * InstancePtr, u32 BaseAddress) 
               XLlDma_Reset(XLlDma * InstancePtr) 
                         XLlDma_mBdRingSnapShotCurrBd(TxRingPtr);

Do you have any idea what could be wrong with dma initialization?

Best Regards

Mirek

 

-- 
View this message in context: http://www.nabble.com/Compile-time-error%2C-compiling-Xilinx-Linux-2.6-for-XPS-LLTEMAC-tp16065692p18649823.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
