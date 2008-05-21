Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E4882DE898
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:53:22 +1000 (EST)
In-Reply-To: <1211385735.8297.204.camel@pasglop>
References: <20080521141056.GC8897@wotan.suse.de>
	<20080521141231.GD8897@wotan.suse.de>
	<1211383592.8297.195.camel@pasglop>
	<20080521153420.GG8897@wotan.suse.de>
	<1211384580.8297.199.camel@pasglop>
	<20080521154701.GH8897@wotan.suse.de>
	<1211385735.8297.204.camel@pasglop>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0a98ed7b32cb86872320b6a072e7df92@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 2/2] powerpc: optimise smp_wmb
Date: Wed, 21 May 2008 22:51:51 +0200
To: benh@kernel.crashing.org
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This is mostly useless then since lwsync is just a sync to a processor
> that doesn't know it (it's a sync with a reservd bit set) :-) Or it's
> just to make gas happy if you specify a processor type that doesn't 
> have
> lwsync ?

GAS doesn't care (I tried with -Wa,-m405).  Support for this insn
was added to binutils in august 2001; do we still support older
binutils than that?  If so, we should just do the ".long" trick in
a lwsync() inline function, like we do for similar cases.


Segher
