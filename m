Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD3E8B7D1E
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 11:03:02 +1000 (EST)
Subject: Re: PowerPC ftrace function trace optimisation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100429005117.GA4622@kryten>
References: <20100429005117.GA4622@kryten>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 29 Apr 2010 11:02:47 +1000
Message-ID: <1272502967.24542.137.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, imunsie@au1.ibm.com,
	rostedt@goodmis.org, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> The option Alan added reduces the footprint to 3 instructions which can
> be noped out completely. The rest of the function does not rely on the first
> three instructions. No stack spill is forced either:
> 
> # gcc -pg -mprofile-kernel

>From a quick test it appears that this only works with -m64, not -m32.
Alan is that correct ? Any chance you can fix that in future gcc
versions ?

Also should we implement support for both type of mcounts or just only
allow enabling of ftrace with gcc's that support this ?

Cheers,
Ben.

> 0000000000000000 <.foo>:
>    0:   7c 08 02 a6     mflr    r0
>    4:   f8 01 00 10     std     r0,16(r1)
>    8:   48 00 00 01     bl      8 <.foo+0x8>	<--- call to mcount
> 
>    c:   7c 08 02 a6     mflr    r0
>   10:   f8 01 00 10     std     r0,16(r1)
>   14:   f8 21 ff d1     stdu    r1,-48(r1)
>   18:   e9 22 00 00     ld      r9,0(r2)
>   1c:   e8 69 00 02     lwa     r3,0(r9)
>   20:   38 21 00 30     addi    r1,r1,48
>   24:   e8 01 00 10     ld      r0,16(r1)
>   28:   7c 08 03 a6     mtlr    r0
>   2c:   4e 80 00 20     blr
> 
> 
> This mean we could support ftrace function trace with very little overhead.
> 
> In fact if we are careful when switching to the new mcount ABI and don't
> rely on the store of r0, we could probably optimise this even further in a
> future gcc and remove the store completely. mcount would be 2 instructions:
> 
>    mflr    r0              
>    bl      8 <.foo+0x8>
> 
> Anton
