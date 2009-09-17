Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B8CFB7B7A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 18:43:25 +1000 (EST)
Subject: Re: FPGA access over PCI-E on MPC8536
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <C13B4529-4766-48C9-8004-A45B4A6EAE69@kernel.crashing.org>
References: <4AB1B84F.8080606@embedded-sol.com>
	<C13B4529-4766-48C9-8004-A45B4A6EAE69@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 17 Sep 2009 18:43:13 +1000
Message-Id: <1253176993.8375.345.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Felix Radensky <felix@embedded-sol.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > However when I attempt to access FPGA memory my mmapping it in  
> > userspace the read hangs. The same happens in kernel space. Does it  
> > happen because FPGA memory is marked as disabled, or because FPGA  
> > code is doing something wrong ?
> 
> Can you access the device in u-boot?  That would possible tell you if  
> the HW is functioning or not.
> 
> > Another question is what can cause PCI device memory be marked as
> > disabled.
> 
> Good question, no idea how lspci decided to print [disabled].  Take a  
> look at lspci source and see :)

Maybe the memory enable in the PCI command register isn't set ?

If you don't have a kernel driver that sets it (by calling
pci_enable_device) and u-boot doesn't set it then it's going
to be off and you'll get hangs or machine checks trying to
access the device...

Just an idea...

Cheers,
Ben.
