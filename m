Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFS0m4sfbzDvfv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 15:41:12 +1100 (AEDT)
Date: Fri, 11 Nov 2016 12:07:11 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Move hpte encode routine to platform
 specific files
Message-ID: <20161111010711.pvth4fayv4yne4yy@oak.ozlabs.ibm.com>
References: <20161110092423.20137-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161110092423.20137-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2016 at 02:54:23PM +0530, Aneesh Kumar K.V wrote:
> They differ between powernv and pseries. While we are at it copy
> a version for ps3 too. For now this is same as what we have for pSeries.
> 
> Fixes: 50de596de8be6 ("powerpc/mm/hash: Add support for Power9 Hash")

This seems like a lot of churn on top of a lot of churn.

I think we should use the old format almost everywhere, and just
convert at the last minute in functions such as native_hpte_insert(),
native_hpte_invalidate(), etc.

Paul.
