Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0101.outbound.protection.outlook.com [207.46.100.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD3B31A34C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 06:14:36 +1000 (AEST)
Message-ID: <1443125663.32298.32.camel@freescale.com>
Subject: Re: [PATCH v2 08/25] powerpc/8xx: Map IMMR area with 512k page at a
 fixed address
From: Scott Wood <scottwood@freescale.com>
To: David Laight <David.Laight@ACULAB.COM>
CC: 'Christophe Leroy' <christophe.leroy@c-s.fr>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Date: Thu, 24 Sep 2015 15:14:23 -0500
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBA15B8@AcuExch.aculab.com>
References: <cover.1442939410.git.christophe.leroy@c-s.fr>
 <bfa8400abd8b5174942616aae5876a55242f5468.1442939410.git.christophe.leroy@c-s.fr>
 <063D6719AE5E284EB5DD2968C1650D6D1CBA15B8@AcuExch.aculab.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-24 at 11:41 +0000, David Laight wrote:
> From: Christophe Leroy
> > Sent: 22 September 2015 17:51
> ...
> > Traditionaly, each driver manages one computer board which has its
> > own components with its own memory maps.
> > But on embedded chips like the MPC8xx, the SOC has all registers
> > located in the same IO area.
> > 
> > When looking at ioremaps done during startup, we see that
> > many drivers are re-mapping small parts of the IMMR for their own use
> > and all those small pieces gets their own 4k page, amplifying the
> > number of TLB misses: in our system we get 0xff000000 mapped 31 times
> > and 0xff003000 mapped 9 times.
> 
> Isn't this a more general problem?
> 
> If there are multiple remap requests for the same physical page
> shouldn't the kernel be just increasing a reference count somewhere
> and returning address in the same virtual page?
> This should probably happen regardless of the address.
> I presume it must be done for cacheable mappings.

Why would you assume that?

-Scott
