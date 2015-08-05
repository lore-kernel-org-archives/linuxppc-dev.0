Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BECA21A1BF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 12:00:07 +1000 (AEST)
Message-ID: <1438740007.2304.4.camel@ellerman.id.au>
Subject: Re: powerpc: Add an inline function to update HID0
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,  mikey@neuling.org
Date: Wed, 05 Aug 2015 12:00:07 +1000
In-Reply-To: <55C0C6C8.3030403@linux.vnet.ibm.com>
References: <20150804100858.1F272140306@ozlabs.org>
 <55C0C6C8.3030403@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-04 at 19:36 +0530, Madhavan Srinivasan wrote:
> 
> On Tuesday 04 August 2015 03:38 PM, Michael Ellerman wrote:
> > On Tue, 2015-04-08 at 08:30:58 UTC, "Gautham R. Shenoy" wrote:
> >> Section 3.7 of Version 1.2 of the Power8 Processor User's Manual
> >> prescribes that updates to HID0 be preceded by a SYNC instruction and
> >> followed by an ISYNC instruction (Page 91).
> >>
> >> Create a function name update_hid0() which follows this recipe and
> >> invoke it from the static split core path.
> >>
> >> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> >> ---
> >>  arch/powerpc/include/asm/kvm_ppc.h       | 11 +++++++++++
> > Why is it in there? It's not KVM related per se.
> >
> > Where should it go? I think reg.h would be best, ideally near the definition
> > for HID0, though that's probably not possible because of ASSEMBLY requirements.
> > So at the bottom of reg.h ?
> 
> just to understand, Something like this will not do?
> 
> #define update_hid0(x)  __asm__ __volatile__(   "sync\n"\
>                                                 "mtspr " __stringify(SPRN_HID0)", %0\n"\
>                                                 "isync"::"r"(x));
> 

Yeah we could do that also.

The static inline is less ugly though.

cheers
