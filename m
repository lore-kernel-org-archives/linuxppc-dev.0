Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DD6BFDDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 01:24:12 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Laurent Lagrange <lagrange@fr.oleane.com>
In-Reply-To: <000501c86282$2a5ba9e0$a501a8c0@GEGE6600V>
Subject: Re: PCI configuration with multiple PCI controllers
References: <000501c86282$2a5ba9e0$a501a8c0@GEGE6600V>
Message-Id: <FBBAE39A-700D-4D15-B30D-94A317527BCA@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Date: Wed, 30 Jan 2008 08:24:05 -0600
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2008, at 8:20 AM, Laurent Lagrange wrote:

> Hello,
>
> I have a MPC8641 based board. I try to use the two PCIe controllers.  
> My
> firmware configures (physically) the PCI buses as follow:
>
> ------------------+
> MPC8641 PCIe 1	|	bus 1		+--------------+
> 			| --------------> | PCI device 0 |
> 	BUS 0		|			+--------------+
> - - - - - - - - - +
> MPC8641 PCIe 2	|	bus 3		+--------------+
> 			| --------------> | PCI device 1 |
> 	BUS 2		|			+--------------+
> ------------------+
>
> I launch the Linux image (2.6.23.9). During the Kernel PCI  
> configuration,
> buses behind the 2nd MPC8641 PCIe are skipped because its primary  
> bus don't
> start at bus number 0. The kernel reconfigure the primary bus number  
> of the
> MPC8641 PCIe 2 controller from 2 to 0.
>
> I can patch the kernel to work with my firmware but I don't know if  
> my PCI
> configuration is the good one.
>
> What is the common way to configure the PCI for Linux when a new  
> controller
> is found: start the bus number to 0 or to the last bus number + 1?

Linux now has the concept of PCI domains so each controller is a new  
domain and thus the first bus should be 0 in each domain.  (at least  
that's the "normal" way we handle things).

- k
