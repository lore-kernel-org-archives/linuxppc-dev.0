Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17645.18647.720814.903612@cargo.ozlabs.ibm.com>
Date: Thu, 24 Aug 2006 16:36:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: will_schmidt@vnet.ibm.com
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
In-Reply-To: <1156190965.9659.41.camel@farscape.rchland.ibm.com>
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
	<50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
	<200608192219.03178.arnd@arndb.de>
	<37280.84.105.60.119.1156030372.squirrel@gate.crashing.org>
	<1156190965.9659.41.camel@farscape.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de, segher@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Will Schmidt writes:

> I'm not Arnd :-) , but since I'm poking at it anyways,.. how about
> this? 

I just did a patch to fix the existing masks.  Could you do a new
version of this patch that doesn't include the unrelated mask fixes
please?  Also it would be really nice if you could figure out a way to
avoid doing the unnecessary 64-bit logical operations on 32-bit
machines - i.e. using an unsigned long for tmp, but then the constants
become problematic.  Maybe you need something like

#define LCONST(x)	((unsigned long)(x##ULL))

Thanks,
Paul.
