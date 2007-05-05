Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03535DDED7
	for <linuxppc-dev@ozlabs.org>; Sat,  5 May 2007 10:41:48 +1000 (EST)
In-Reply-To: <20070504221309.GR6193@austin.ibm.com>
References: <20070502195712.GA16541@ld0162-tx32.am.freescale.net>
	<F1B250DD-A472-470F-B3D0-EBB2F042E454@kernel.crashing.org>
	<4638F0C4.2000406@freescale.com>
	<FA9554A4-5A7D-4E03-BE28-C4B6B80D9DB9@kernel.crashing.org>
	<4638F734.2040809@freescale.com>
	<20070504221309.GR6193@austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <319ad63a0d38335a6b0c221e8f3c26b0@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] gianfar: Add I/O barriers when touching buffer
	descriptor ownership.
Date: Sat, 5 May 2007 02:41:20 +0200
To: linas@austin.ibm.com (Linas Vepstas)
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Well, Segher doesn't want me to use iobarrier (because it's not I/O).
>> Andy doesn't want me to use wmb() (because it's sync).  I don't think
>> something like gfar_wmb() would be appropriate.  So the remaining
>> options are either eieio(),
>
> ? Just curious... the original intent of eieio was to order I/O,
> such as MMIO; it has no effect on memory that isn't marked
> cache-inhibited or write-trhough or guarded. Has this changed?

eieio orders all accesses to address space that is WIMG=1xxx
or WIMG=x1x1; separately, it orders stores to address space
that is WIMG=001x.

> I guess I haven't kept up with the times ... is eieio now
> being used to provide some other kind of barrier?

Nothing changed.

> Is eieio providing some sort of SMP synchronization side-effect?

It orders stores to "well-behaved" memory yes.

> Point being: if Segher doesn't let you "use iobarrier (because
> it's not I/O)", then I don't understand why eieio would work (since
> that's for io only).

iobarrier() is a kernel-level primitive, meant for ordering
I/O only, as its name indicates.  eieio is a CPU insn that
orders stores to main memory (amongst other things), not that
its name would tell you.


Segher
