Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D501BB70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 20:00:46 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43245DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 20:00:45 +1000 (EST)
Subject: Re: PPC PCI bus registers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eddie Dawydiuk <eddie@embeddedarm.com>
In-Reply-To: <4A9F0377.1070606@embeddedarm.com>
References: <4A9F0377.1070606@embeddedarm.com>
Content-Type: text/plain
Date: Thu, 03 Sep 2009 20:00:32 +1000
Message-Id: <1251972032.15089.30.camel@pasglop>
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

On Wed, 2009-09-02 at 16:44 -0700, Eddie Dawydiuk wrote:
> Hello,
> 
> I have a question regarding reading PCI bus registers from a user space 
> application running on a PPC SBC. Seeing as though the PCI bus is little endian 
> and PPC is big endian is it typical that one must perform a byte swap on all 16 
> and 32 bit register reads?
> 
> I've found this is true on a custom board I am working on(with an FPGA connected 
> via the PCI bus) and as a result I've added a byte swap command in busybox to 
> accommodate this feature...

Note that powerpc has efficient load/store reverse instructions that
perform the byteswap for you. We use them for IOs in the kernel for
example.

Also, if you're going to access a PCI device directly, beware of other
issues such as ordering. PPC is an out of order architecture, you need
to ensure you add the appropriate memory barriers if you want to ensure
you accesses are done in the order you write them in your program.

For "standard" stuff that doesn't involve DMA or locks, an eieio after
both MMIO loads and stores should do the trick.

If you need to order vs. DMA and/or locks, you may want to look at what
the kernel does in io.h

Cheers,
Ben.
