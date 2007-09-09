Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E416CDDDE7
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Sep 2007 07:47:50 +1000 (EST)
Message-ID: <46E46A3F.2050708@freescale.com>
Date: Sun, 09 Sep 2007 16:48:47 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 5/5] Add DMA engine driver for Freescale
	MPC85xx	processors.
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20709091053u607e710ay1eb76c53312706ea@mail.gmail.com>
In-Reply-To: <e9c3a7c20709091053u607e710ay1eb76c53312706ea@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, shannon.nelson@intel.com, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Williams wrote:

> This routine implies that there is a piece of code somewhere that
> wants to select which channels it can use.  A similar effect can be
> achieved by registering a dma_client with the dmaengine interface
> ('dma_async_client_register').  Then when the client code makes a call
> to 'dma_async_client_chan_request' it receives a 'dma_event_callback'
> for each channel in the system.  It will also be asynchronously
> notified of channels entering and leaving the system.  The goal is to
> share a common infrastructure for channel management.

Are you familiar with the "flat device tree" used for PowerPC systems?  The 
"piece of code somewhere" is the device tree subsystem that parses the device 
tree, which is compiled from the .dts files in arch/powerpc/boot/dts.

The FDT is how PowerPC systems specify hardware configuration.  In the case of 
85xx, the FDT contains entries for each DMA device (typically 2), and the 
entries contain sub-entries for each DMA channel as well as the address of the 
register sets for each channel.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
