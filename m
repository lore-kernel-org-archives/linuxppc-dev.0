Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdM2nC1zF0WL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:19 +1000 (AEST)
In-Reply-To: <20180809133642.16007-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/mm/hash: Remove unnecessary do { }while(0) loop
Message-Id: <41ptdL6hVDz9sCW@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:18 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-08-09 at 13:36:42 UTC, "Aneesh Kumar K.V" wrote:
> Avoid coverity false warnings like
> 
> *** CID 187347:  Control flow issues  (UNREACHABLE)
> /arch/powerpc/mm/hash_native_64.c: 819 in native_flush_hash_range()
> 813        slot += hidx & _PTEIDX_GROUP_IX;
> 814        hptep = htab_address + slot;
> 815        want_v = hpte_encode_avpn(vpn, psize, ssize);
> 816        hpte_v = hpte_get_old_v(hptep);
> 817
> 818        if (!HPTE_V_COMPARE(hpte_v, want_v) || !(hpte_v & HPTE_V_VALID))
> >>>     CID 187347:  Control flow issues  (UNREACHABLE)
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f405b510c93eeb7390d0e2c6ef8d12

cheers
