Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3356567A3B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 16:39:15 +1000 (EST)
In-Reply-To: <1b2aacd80610242246n20075a33pcc76ab5be71fb87e@mail.gmail.com>
References: <1b2aacd80610242049j23917f61x1e277b4c6a581f9a@mail.gmail.com>
	<E2847437-6C75-4963-B9DB-BAC050015C88@kernel.crashing.org>
	<1b2aacd80610242246n20075a33pcc76ab5be71fb87e@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4BF669F6-7A28-4915-9DFF-0B00CC04E242@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8343: PCI resource allocation questions
Date: Wed, 25 Oct 2006 01:39:08 -0500
To: "Luong Ngo" <luong.ngo@gmail.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'm a bit confused here. If the host bridge is ignored/excluded,  
> then the region size in BARs will not be allocated corresponding  
> resource by the PCI subsystem, then how would other PCI devices in  
> the slots could be allocated in the BAR's range? If I understand  
> correctly, the PCI devices's resources are allocated based on the  
> bridge resource, which is assigned statically by PCI subsystem  
> using hose->mem_space and hose->io_space instead of reading it from  
> the BARs. Maybe you are saying in the case the CPU is in agent mode  
> and its PCI host bridge is functioning as a PCI-PCI bridge?

The problem is the host bridge shouldn't be included in BAR  
assignment since its the host bridge.  The problem is FSL devices  
show up when they scan themselves and the kernel then tries to  
allocate resources to them as if they were any other device.

you are correct, the pci subsystem is setup via the hose structure  
and not by trying to read BARs on the host controller itself.

- kumar
