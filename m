Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B7E0FDDDFC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 13:46:10 +1100 (EST)
Subject: Re: Reorg of 32-bit dma code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <77A19FBD-7861-4D32-84BA-BDEEC39A4982@kernel.crashing.org>
References: <Pine.LNX.4.64.0802061802310.1616@monty.am.freescale.net>
	<1202347594.7079.107.camel@pasglop>
	<77A19FBD-7861-4D32-84BA-BDEEC39A4982@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 07 Feb 2008 13:45:44 +1100
Message-Id: <1202352344.7079.110.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-06 at 20:39 -0600, Kumar Gala wrote:
> > I'd prefer so yes.
> 
> Can you explain why?  Got no issue with doing this, but its good to  
> know hy.

Just in case ... let's not modify 64 bits behaviour especially to
something that will ultimately go away. I prefer failing if DMA ops are
not set rather than using a set of ops that will cause DMA to the wrong
place.
 
> Also, any ideas on how to handle setting dev->archdata for non-PCI  
> devices would be welcome.

This has to be done by whoever creates the struct device. Can be a bit
annoying with platform devices, I agree. One way to do it is to use the
bus notifiers mechanism, which allows you for example to have a default
for any platform device.

Ben.
