Return-Path: <mmporter@cox.net>
Date: Thu, 20 Jan 2005 11:16:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Sachin P <sachinpc@gmail.com>
Message-ID: <20050120111627.A5631@cox.net>
References: <66164fbc0501190353485dc8e4@mail.gmail.com>
	<20050119141048.GA13254@lst.de> <20050119075603.B448@home.com>
	<66164fbc05012008302fe3e542@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <66164fbc05012008302fe3e542@mail.gmail.com>;
	from sachinpc@gmail.com on Thu, Jan 20, 2005 at 10:00:47PM +0530
Cc: Linuxppc-dev@ozlabs.org
Subject: Re: consistent_alloc() on PPC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 20, 2005 at 10:00:47PM +0530, Sachin P wrote:
> Hi,
> Thanks a lot to all of you for the help . 
> The following is a more clearer version of the problem I am facing :
> 
> 1.I am porting drivers from X86 (running Linux 2.4-20) to 
>   PPC platform running (Montevista Linux-2.4.20).
> 2.In  wrapper function for DMA allocation, I am using 
>   consistent_alloc() to allocate the memory. This function gives me
>   both the virtual-address as well as the dma-address.
>   I pass both these values to the upper-level drivers.
> 3. However , once the upper-level drivers are done with the memory
>    they call the wrapper function for free dma and pass only the dma
>    address and not the virtual-address. However consistent_free() 
>    accepts only virtual-address. 
>    Hence I need a way to convert the dma address to the
>    virtual-address.  

All you need to do is cache the virtual address and the dma/phys
address for later use when calling consistent_free(). converting
random DMA/phys to virtual is a bad idea since you are going to
find multiple mappings. Cache the results in your driver...it's
trivial.

-Matt
