Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vClL527HpzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 12:05:33 +1100 (AEDT)
In-Reply-To: <20170128154840.32468-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm/hash: Properly mask the ESID bits when building
 proto-VSID
Message-Id: <3vClL46b5vz9tk1@ozlabs.org>
Date: Wed,  1 Feb 2017 12:05:32 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-01-28 at 15:48:40 UTC, "Aneesh Kumar K.V" wrote:
> proto-vsid is built using both mmu context id and ESID. We should not have
> overlapping bits between those. That will result in us having vsid
> collision. With the current code we missed masking the top bits of effective
> address. This implies for kernel address we ended up using the top 4 bits
> as part of proto-vsid, which is wrong. For the kernel we should have the
> below mapping
> 
> 0xf000000000000000 -> 0x7ffff  (19 bits context + 6 bits ESID ).
> 
> Without the patch we endup with
> 0xf000000000000000 ->  0xf7ffff (0x7ffff | 0xf00000)
> 
> We didn't observe any issues till now possibly because we never end up
> using a context value which could map to the same  VSID as kernel.
> 
> Fixes: c60ac5693c4 ("powerpc: Update kernel VSID range")
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/79270e0a3fd124388a0407f9edbd6a

cheers
