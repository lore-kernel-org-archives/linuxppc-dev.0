Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D497DB7179
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 07:24:36 +1000 (EST)
Date: Thu, 2 Sep 2010 17:24:34 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@lists.ozlabs.org, "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: Re: Where to put board-specific drivers
Message-ID: <20100902172434.401195b2@lappy.seanm.ca>
In-Reply-To: <20100902211221.GD24861@ovro.caltech.edu>
References: <20100902200434.GC24861@ovro.caltech.edu>
	<320E0907-436B-42B8-9E85-EABF481FE04C@kernel.crashing.org>
	<20100902211221.GD24861@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Sep 2010 14:12:22 -0700
"Ira W. Snyder" <iws@ovro.caltech.edu> wrote:


> To give you three example drivers:
> 1) Data processing FPGA access driver
> 
> This driver provides a simple character device to userspace which
> exposes one function: mmap. With it, you can mmap the entire data
> processing FPGA memory window into your process. With this, I provide
> non-realtime FPGA control to userspace applications.
> 
> 2) Data processing FPGA capture driver
> 
> This driver provides a simple character device to userspace which
> supports one function: read. Internally, it maintains a list of
> buffers which hold capture data. When the FPGA's are processing data,
> they dump data at 64Hz (every 15.625ms). If the data is not copied
> off the chips before the next dump, data is lost.
> 
> DMA is required to move the data volume off the FPGAs fast enough to
> keep timing. Therefore this really does need to be in-kernel.

Could these drivers be merged?


Cheers,
   Sean
