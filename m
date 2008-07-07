Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1E81DDED9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 16:23:28 +1000 (EST)
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20080707061811.19989154246@magilla.localdomain>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 16:23:20 +1000
Message-Id: <1215411800.8970.91.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-07-06 at 23:18 -0700, Roland McGrath wrote:
> 
> Using dsocaps gives you the best of both worlds.  You can freely choose
> new strings in the kernel without the ld.so code having to know about
> them (which is not true of AT_PLATFORM, but may be true of how you are
> thinking about "strings are nice").  You do have to map all the
> possibilities that a single kernel build can produce into distinct bits.
> But, there are 32 unallocated bits to start with.  Moreover, those bit
> assignments are not part of any permanent ABI like bits in AT_* values.
> They just have to match up between this kernel build and the ld.conf.d
> file installed along with it--kernel hackers and kernel packagers have
> to coordinate, not kernel hackers and userland hackers.

I'm not sure... if ld.conf.d isn't parse of the kernel source tree then
it -will- end in tears...

Ben.
