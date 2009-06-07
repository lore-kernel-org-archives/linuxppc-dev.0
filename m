Return-Path: <subrata@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 27D1EB70B9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Jun 2009 00:37:02 +1000 (EST)
Subject: Re: [BUILD FAILURE 01/04] Next June 04:PPC64 randconfig
	[drivers/staging/comedi/drivers.o]
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: fmhess@users.sourceforge.net
In-Reply-To: <200906060936.22322.fmhess@speakeasy.net>
References: <20090605182625.24093.7808.sendpatchset@elm3a191.beaverton.ibm.com>
	<1244261806.31984.36.camel@pasglop> <20090606055103.GA9446@kroah.com>
	<200906060936.22322.fmhess@speakeasy.net>
Content-Type: text/plain
Date: Sun, 07 Jun 2009 20:06:45 +0530
Message-Id: <1244385405.5265.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: sachinp@linux.vnet.ibm.com, sfr@canb.auug.org.au, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, Linuxppc-dev@ozlabs.org,
	Ian Abbott <abbotti@mev.co.uk>, linux-next@vger.kernel.org,
	paulus@samba.org, Geert.Uytterhoeven@sonycom.com,
	geert@linux-m68k.org, David Miller <davem@davemloft.net>
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-06-06 at 09:36 -0400, Frank Mori Hess wrote:
> On Saturday 06 June 2009, Greg KH wrote:
> > Frank and Ian, any thoughts about the vmap call in the
> > comedi_buf_alloc() call?  Why is it using PAGE_KERNEL_NOCACHE, and what
> > is the prealloc_buf buffer used for?
> 
> It is a circular buffer used to hold data streaming either to or from a 
> board (for example when producing an analog output waveform).  Reads and 
> writes to the device files read/write to the circular buffer, plus a few 
> drivers do dma directly to/from it.  I personally don't have a problem 
> with requiring drivers to have their own dma buffers and making them copy 
> data between their private dma buffers and the main circular buffer.  I 
> guess the original design wanted to support zero-copy dma.

Great to hear that. How about a patch that solves my build problem on
PPC64(the problem seems to be existing for long) ? 

Regards--
Subrata

> 
