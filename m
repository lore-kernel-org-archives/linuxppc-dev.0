Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS5Bf6hvbzDvLb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:11:38 +1100 (AEDT)
In-Reply-To: <20161124093954.12051-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/mm: Fixup kernel read only mapping
Message-Id: <3tS5Bf5sX6z9vFb@ozlabs.org>
Date: Mon, 28 Nov 2016 23:11:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-11-24 at 09:39:54 UTC, "Aneesh Kumar K.V" wrote:
> With commit e58e87adc8bf9 ("powerpc/mm: Update _PAGE_KERNEL_RO") we started
> using the ppp value 0b110 to map kernel readonly. But that facility
> was only added as part of ISA 2.04. For earlier ISA version only supported ppp
> bit value for readonly mapping is 0b011. (This implies both user and kernel
> get mapped using the same ppp bit value for readonly mapping.).
> 
> Update the code such that for earlier architecture version we use ppp value
> 0b011 for readonly mapping. We don't differentiate between power5+ and power5
> here and apply the new ppp bits only from power6 (ISA 2.05). This keep the
> changes minimal.
> 
> This fixes issue with PS3 spu usage reported at
> https://lkml.kernel.org/r/rep.1421449714.geoff@infradead.org
> 
> Fixes: e58e87adc8bf9 ("powerpc/mm: Update _PAGE_KERNEL_RO")
> Tested-by: Geoff Levand <geoff@infradead.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/984d7a1ec67ce3a46324fa4bcb4c74

cheers
