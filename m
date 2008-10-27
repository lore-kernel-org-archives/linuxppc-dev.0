Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 40FDADDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 00:44:08 +1100 (EST)
Message-Id: <8440180C-A3B1-4436-9CDF-C6BA9A01F8CD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1225002815.7654.487.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] genirq: Set initial default irq affinity to just CPU0
Date: Mon, 27 Oct 2008 08:43:11 -0500
References: <1224863858-7933-1-git-send-email-galak@kernel.crashing.org>
	<20081024.161813.193686281.davem@davemloft.net>
	<1224970389.7654.473.camel@pasglop>
	<20081025.210412.206011121.davem@davemloft.net>
	<1225002815.7654.487.camel@pasglop>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	torvalds@osdl.org, maxk@qualcomm.com, tglx@linutronix.de,
	David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 26, 2008, at 1:33 AM, Benjamin Herrenschmidt wrote:

> On Sat, 2008-10-25 at 21:04 -0700, David Miller wrote:
>> But back to my original wonder, since I've always tipped off of this
>> generic IRQ layer cpu mask, when was it ever defaulting to zero
>> and causing the behvaior your powerpc guys actually want? :-)
>
> Well, I'm not sure what Kumar wants. Most powerpc SMP setups actually
> want to spread interrupts to all CPUs, and those who can't tend to  
> just
> not implement set_affinity... So Kumar must have a special case of  
> MPIC
> usage here on FSL platforms.
>
> In any case, the platform limitations should be dealt with there or  
> the
> user could break it by manipulating affinity via /proc anyway.
>
> By yeah, I do expect default affinity to be all CPUs and in fact, I  
> even
> have an -OLD- comment in the code that says
>
> 	/* let the mpic know we want intrs. default affinitya is  
> 0xffffffff ...

While we have the comment the code appears not to really follow it.   
We appear to write 1 << hard_smp_processor_id().

- k
