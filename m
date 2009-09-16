Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E565B7B6F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 07:54:56 +1000 (EST)
Subject: Re: PPC PCI bus registers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
In-Reply-To: <4AB13550.1070506@embeddedarm.com>
References: <4A9F0377.1070606@embeddedarm.com>
	<1251972032.15089.30.camel@pasglop> <4AB13550.1070506@embeddedarm.com>
Content-Type: text/plain
Date: Thu, 17 Sep 2009 07:54:46 +1000
Message-Id: <1253138086.8375.290.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-09-16 at 11:58 -0700, Eddie Dawydiuk wrote:
> I'm not sure I understand. To clarify I have an FPGA connected via the
> PCI bus 
> which implements several peripherals, I've implemented device drivers
> for. 
> Currently I am calling ioremap() to get a virtual address
> corresponding to the 
> PCI devices. Then I use ___raw_writeN / ___raw_readN for
> reading/writing data 
> via the PCI bus to the FPGA registers. From looking at io.h I believe
> this 
> method is safe with regard to out of order execution.
> 
> "* ioremap is the standard one and provides non-cacheable guarded
> mappings
> *   and can be hooked by the platform via ppc_md "
> 
> Can you verify if my understanding is correct, or let me know if I
> need to add 
> memory barriers?
> 

Out of order execution != out of order storage. ioremap() will give you
guarded space which means it cannot be speculatively accessed for
example, and you do get -some- guarantees but not that your stores are
going to hit the device in order, nor that your loads are going to be
performed until the CPU actually use the result of the load, which can
be delayed beyond a store.

Cheers,
Ben.
