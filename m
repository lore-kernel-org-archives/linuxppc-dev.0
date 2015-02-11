Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1077E1A075A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Feb 2015 20:33:57 +1100 (AEDT)
Message-ID: <1423643596.5965.12.camel@kernel.crashing.org>
Subject: Re: [QUESTION,RFC] cacheable_memcpy() versus memcpy() ==> 8%
 improvment on FTP throughput
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Wed, 11 Feb 2015 19:33:16 +1100
In-Reply-To: <54DB0A6E.7020105@c-s.fr>
References: <54DB0A6E.7020105@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Anton Blanchard <anton@au1.ibm.com>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-11 at 08:53 +0100, leroy christophe wrote:
> In powerpc32 architecture there is a function called cacheable_memcpy() 
> which does same thing as memcpy() but using dcbz/dcbt instructions for 
> an optimised copy (just like __copy_tofrom_user())
> What seems strange is that it is almost nowhere used (only used in 
> drivers/net/ethernet/ibm/emac/core.c)
> 
> For a try I replaced all memcpy() in include/linux/skbuff.h and 
> net/core/skbuff.c by cacheable_memcpy() and I got around 8% improvement 
> on FTP throughput on MPC885.
> 
> What could be done to generalise the use of cacheable_memcpy() instead 
> of memcpy() whenever possible ?
> Indeed, in order to use cacheable_memcpy(), we need
> * The destination to be cacheable
> * The source and destination to not overlap on the same cachelines
> 
> Could we check, when calling memcpy(), whether the destination is 
> cacheable or not, and if yes redirect the call to cacheable_memcpy() ?
> How can we check that ?

Additionally we could have a P8 implementation that uses unaligned
vectors. Adding Anton to the CC list.

Cheers,
Ben.
