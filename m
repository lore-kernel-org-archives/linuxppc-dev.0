Return-Path: <dan.j.williams@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.237])
	by ozlabs.org (Postfix) with ESMTP id 8E1A4DDDF8
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Sep 2007 08:10:13 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so837748wxd
	for <linuxppc-dev@ozlabs.org>; Sun, 09 Sep 2007 15:10:12 -0700 (PDT)
Message-ID: <e9c3a7c20709091510i723ca2b8sb08b3b1f9d4e031a@mail.gmail.com>
Date: Sun, 9 Sep 2007 15:10:12 -0700
From: "Dan Williams" <dan.j.williams@intel.com>
Sender: dan.j.williams@gmail.com
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xx
	processors.
In-Reply-To: <46E46A3F.2050708@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20709091053u607e710ay1eb76c53312706ea@mail.gmail.com>
	<46E46A3F.2050708@freescale.com>
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

On 9/9/07, Timur Tabi <timur@freescale.com> wrote:
> Dan Williams wrote:
>
> > This routine implies that there is a piece of code somewhere that
> > wants to select which channels it can use.  A similar effect can be
> > achieved by registering a dma_client with the dmaengine interface
> > ('dma_async_client_register').  Then when the client code makes a call
> > to 'dma_async_client_chan_request' it receives a 'dma_event_callback'
> > for each channel in the system.  It will also be asynchronously
> > notified of channels entering and leaving the system.  The goal is to
> > share a common infrastructure for channel management.
>
> Are you familiar with the "flat device tree" used for PowerPC systems?  The
> "piece of code somewhere" is the device tree subsystem that parses the device
> tree, which is compiled from the .dts files in arch/powerpc/boot/dts.
>
> The FDT is how PowerPC systems specify hardware configuration.  In the case of
> 85xx, the FDT contains entries for each DMA device (typically 2), and the
> entries contain sub-entries for each DMA channel as well as the address of the
> register sets for each channel.
>
Ahh, ok then this code is replacing what would normally be handled by
the PCI bus enumeration code, or the platform device registrations for
iop-adma in arch/arm/mach-iop13xx.  Sorry for the noise with this
comment.

> --
> Timur Tabi
> Linux Kernel Developer @ Freescale
> -

Thanks,
Dan
