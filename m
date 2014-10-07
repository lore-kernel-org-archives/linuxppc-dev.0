Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F7991A0287
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 20:28:23 +1100 (EST)
In-Reply-To: <20141003091250.28354.13766.stgit@bahia.local>
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2] powerpc/vphn: fix endian issue in NUMA device node code
Message-Id: <20141007092823.7994A1400BE@ozlabs.org>
Date: Tue,  7 Oct 2014 20:28:23 +1100 (EST)
Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-03-10 at 09:13:17 UTC, Greg Kurz wrote:
> The associativity domain numbers are obtained from the hypervisor through
> registers and written into memory by the guest: the packed array passed to
> vphn_unpack_associativity() is then native-endian, unlike what was assumed
> in the following commit:
> 
> This patch does two things:
> - extract values from the packed array with shifts, in order to be endian
>   neutral
> - convert the resulting values to be32 as expected
> 
> Suggested-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
> Reviewed-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Tested-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>


Hi Greg,

I'm a bit dense, it's after 8pm, but this seems like it's more complicated than
it needs to be?

We get six 64-bit registers back from the hypervisor, they're cpu endian
obviously, and each is defined to consist of four 2 byte fields.

So to unpack them, can't we just iterate over those six 64-bit values, which if
we load them as 64-bit values will be back in cpu endian?

cheers
