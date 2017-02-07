Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHQx30Jl3zDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Feb 2017 12:00:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: xmon memory dump does not handle LE
In-Reply-To: <4efc7afd-647c-106d-ca90-5f736514f5fc@linux.vnet.ibm.com>
References: <2a0e256f-4947-e94d-7f79-5451b3c90f9f@linux.vnet.ibm.com>
 <87a8a4avx3.fsf@concordia.ellerman.id.au>
 <d245dc28-5075-8631-4ff1-1039ad88ccd5@linux.vnet.ibm.com>
 <87vasra7lp.fsf@concordia.ellerman.id.au>
 <4efc7afd-647c-106d-ca90-5f736514f5fc@linux.vnet.ibm.com>
Date: Tue, 07 Feb 2017 12:00:06 +1100
Message-ID: <87r33ag6i1.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Douglas Miller <dougmill@linux.vnet.ibm.com> writes:

> Hi Michael,
>
> Yes, your patch seems a more complete solution. The idea of "d1", "d2", 
> "d4", and "d8" commands is more what I needed and makes more sense to 
> someone hitting xmon "cold". I'll work on getting your patch submitted.
>
>
> Question on these sorts of patches (PPC only), do we submit initially to 
> upstream, or here on this (PPC) mailing list?

Yeah send them here. Patches that are only touch powerpc should come
here, from where I merge them and then send them to Linus.

Anything that touches powerpc and some other code should at least be
CC'ed here.

If you're ever in doubt where to send a patch you can use:

  $ ./scripts/get_maintainer.pl --nogit-fallback --no-rolestats -f arch/powerpc/xmon/xmon.c
  Benjamin Herrenschmidt <benh@kernel.crashing.org>
  Paul Mackerras <paulus@samba.org>
  Michael Ellerman <mpe@ellerman.id.au>
  linuxppc-dev@lists.ozlabs.org
  linux-kernel@vger.kernel.org

> It would be nice to get this into the distros as soon as possible.

This isn't a bug fix so the distros won't pick it up automatically.
You'll have to ask them specifically to take a backport.


cheers
