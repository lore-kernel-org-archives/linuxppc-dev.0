Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18031.29567.757635.864638@cargo.ozlabs.ibm.com>
Date: Wed, 13 Jun 2007 14:33:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: olof@lixom.net (Olof Johansson)
Subject: Re: [PATCH] powerpc: Don't use long for 32-bit temp variables in spin
	lock ops
In-Reply-To: <20070607170816.GA4273@lixom.net>
References: <20070607170816.GA4273@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson writes:

> The spinlock ops have long as their return type (as well as for some
> of the temporary types internally). All locks are 32-bit, so it makes
> no sense to do 64-bit ops on them.
> 
> For example, this is how my compiler built _spin_lock() for me:
> 
> c0000000004b2050:       li      r0,0
> c0000000004b2054:       stb     r0,460(r13)
> c0000000004b2058:       lwz     r0,8(r13)
> c0000000004b205c:       lwarx   r9,0,r3
> c0000000004b2060:       cmpwi   r9,0
> c0000000004b2064:       bne-    c0000000004b2078 <._spin_lock+0x28>
> c0000000004b2068:       stwcx.  r0,0,r3
> c0000000004b206c:       nop
> c0000000004b2070:       bne+    c0000000004b205c <._spin_lock+0xc>
> c0000000004b2074:       isync
> c0000000004b2078:       cmpdi   cr7,r9,0
> c0000000004b207c:       .long 0x4dfe0020
> c0000000004b2080:       mr      r1,r1
> c0000000004b2084:       lwz     r0,0(r3)
> c0000000004b2088:       cmpdi   cr7,r0,0
> c0000000004b208c:       bne+    cr7,c0000000004b2080 <._spin_lock+0x30>
> c0000000004b2090:       mr      r2,r2
> c0000000004b2094:       b       c0000000004b2058 <._spin_lock+0x8>
> 
> Note the cmpdi at ..78 when r9 was loaded with lwarx.

That's OK; the lwarx is defined to zero-extend the value to 64 bits.

Or are you implying that cmpdi is slower than cmpwi on some 64-bit
processors? :)

Paul.
