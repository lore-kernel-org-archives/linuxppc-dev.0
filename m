Return-Path: <sachinpc@gmail.com>
Message-ID: <66164fbc05012008302fe3e542@mail.gmail.com>
Date: Thu, 20 Jan 2005 22:00:47 +0530
From: Sachin P <sachinpc@gmail.com>
To: Linuxppc-dev@ozlabs.org
In-Reply-To: <20050119075603.B448@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <66164fbc0501190353485dc8e4@mail.gmail.com>
	<20050119141048.GA13254@lst.de> <20050119075603.B448@home.com>
Subject: Re: consistent_alloc() on PPC
Reply-To: Sachin P <sachinpc@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,
Thanks a lot to all of you for the help . 
The following is a more clearer version of the problem I am facing :

1.I am porting drivers from X86 (running Linux 2.4-20) to 
  PPC platform running (Montevista Linux-2.4.20).
2.In  wrapper function for DMA allocation, I am using 
  consistent_alloc() to allocate the memory. This function gives me
  both the virtual-address as well as the dma-address.
  I pass both these values to the upper-level drivers.
3. However , once the upper-level drivers are done with the memory
   they call the wrapper function for free dma and pass only the dma
   address and not the virtual-address. However consistent_free() 
   accepts only virtual-address. 
   Hence I need a way to convert the dma address to the
   virtual-address.  

Regards
sachin


On Wed, 19 Jan 2005 07:56:03 -0700, Matt Porter
<mporter@kernel.crashing.org> wrote:
> On Wed, Jan 19, 2005 at 03:10:48PM +0100, Christoph Hellwig wrote:
> > On Wed, Jan 19, 2005 at 05:23:17PM +0530, Sachin P wrote:
> > > Hi ,
> > > I am facing some problems porting my drivers to the PPC platform . Am
> > > currently using consistent_alloc() and consistent_free() to
> > > allocate/free (non-cached) DMA ble memory.
> > > Is there any function/patch/macro, equivalent to
> > > phy_to_virt()/virt_to_phy() for memory returned by consistent_alloc()?
> >
> > Don't ever use concistant_alloc directly.  Always use
> > dma_alloc_coherent() which will give you both virtual and bus address.
> 
> He's obviously not talking about 2.6 since he's mentioning
> consistent_alloc().  I removed those PPC-specific APIs when I
> updated our DMA API implementation in 2.6.
> 
> -Matt
>
