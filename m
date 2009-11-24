Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E64EBB6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 09:46:55 +1100 (EST)
In-Reply-To: <fa686aa40911231219k3a52b9fdn66b8cffb735e5c2f@mail.gmail.com>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221502g2de254d2o4341d9abed0cdf41@mail.gmail.com>
	<4B0AE603.9050208@yahoo.es>
	<fa686aa40911231219k3a52b9fdn66b8cffb735e5c2f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <096E3BA2-9648-42FD-8BAC-3758454840F5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 02/19] powerpc: gamecube: device tree
Date: Tue, 24 Nov 2009 23:53:39 +0100
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> The soc node here tries to represent the big multi-function chip  
>> that integrates most of the devices of the video game consoles  
>> ("Flipper" on the Nintendo GameCube and "Hollywood" on the Wii).
>
> Right.  Much like many other SoCs.

It isn't a SoC, it's really just a memory bridge / I/O bridge
like e.g. MPC10x.

All the device addresses are fixed on the chip, there is no IMMR
or similar.

You can either group all devices under a "flipper" node, or just
put the devices directly in the root node, and have a separate
node for the generic control regs.  Both are a good description
of both the physical and logical structure, so it just comes down
to taste.

Good drivers can handle either structure btw, they should normally
only look at "compatible" to find their devices, so it doesn't
matter much anyway.


Segher
