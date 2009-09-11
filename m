Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B1FB2B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 17:39:56 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F1DDDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 17:39:55 +1000 (EST)
Subject: Re: RMO ? (in the prom_init.c)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: HongWoo Lee <hongwoo7@gmail.com>
In-Reply-To: <4AA9EF51.1050506@gmail.com>
References: <4AA9EF51.1050506@gmail.com>
Content-Type: text/plain
Date: Fri, 11 Sep 2009 17:39:47 +1000
Message-Id: <1252654787.8566.106.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-09-11 at 15:33 +0900, HongWoo Lee wrote:
> Hi ~
> 
> Can anybody tell me what the RMO is ?? in the linux kernel. 
> (arch/powerpc/kernel/prom_init.c)
> Through googling and guessing, I found "Read Memory Only" and "Relaxed 
> Memory Order".
> But none of these are not properly understood in the context.

It's actually a bad name and should probably be "RMA" , aka Real Mode
Area.

This is a "feature" of the POWER architecture for servers, when running
under a hypervisor. Not all of memory can be accessed when the processor
is in "real mode" (MSR:IR and/or DR off).

The reason is obvious, since the OS doesn't have access to real memory
but virtualized logical addresses. And since all of the virtualization
normally goes through the MMU hash table, "real mode" accesses that
bypass the hash table are problematic to allow in an OS.

The "solution" used by those processors is to have a HW feature that
allows a chunk of physical memory to be made accessible to the partition
in "real" mode, which is called the RMA.

That means in practice that the kernel can only access that portion of
it's logical address space while in real mode, it needs to use
translations in the hash table to access the whole of it.

The value in prom_init.c is used to constrain some allocations to that
range for things that will be accessed while running in real mode (such
as RTAS), though it's also abused to constrain those allocations to a
subset of memory even without hypervisors to work around things like
firmware bugs etc...

Cheers,
Ben.
