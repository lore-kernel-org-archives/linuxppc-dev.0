Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A145E1A050C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 08:11:28 +1000 (AEST)
Date: Mon, 4 May 2015 17:10:55 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [v2,2/2] powerpc32: add support for csum_add()
Message-ID: <20150504221055.GA17056@gate.crashing.org>
References: <20150203113927.8604D1A5F14@localhost.localdomain>
 <20150325013023.GA7588@home.buserror.net> <553FD904.8000309@c-s.fr>
 <1430528414.16357.201.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430528414.16357.201.camel@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 01, 2015 at 08:00:14PM -0500, Scott Wood wrote:
> On Tue, 2015-04-28 at 21:01 +0200, christophe leroy wrote:
> > The generated code is most likely different on ppc64. I have no ppc64
> > compiler

For reference: yes you do.  Just add -m64.

> Ideal (short of a 64-bit __wsum) would probably be something like (untested):
> 
> 	add	r3,r3,r4
> 	srdi	r5,r3,32
> 	add	r3,r3,r5
> 	clrldi	r3,r3,32
> 
> Or in C code (which would let the compiler schedule it better):
> 
> static inline __wsum csum_add(__wsum csum, __wsum addend)
> {
>         u64 res = (__force u64)csum;
>         res += (__force u32)addend;
>         return (__force __wsum)((u32)res + (res >> 32));
> }

Older GCC make exactly your asm code for that, in 64-bit; newer GCC get
two adds (one as 32-bit, one as 64-bit, it does not see those are the
same, grrr); and GCC 5 makes the perfect  addc 3,4,3 ; addze 3,3  for
this in 32-bit mode.  You don't want to see what older GCC does with
32-bit though :-/


Segher
