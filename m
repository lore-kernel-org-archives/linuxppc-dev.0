Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B8311A17AA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 10:04:16 +1100 (EST)
In-Reply-To: <1412678902-18672-13-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v3,12/16] cxl: Add base builtin support
Message-Id: <20141007230416.2040C14011E@ozlabs.org>
Date: Wed,  8 Oct 2014 10:04:15 +1100 (EST)
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, anton@samba.org,
 jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-07-10 at 10:48:18 UTC, Michael Neuling wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> This adds the base cxl support that needs to be build into the kernel to use
> cxl as a module. This is needed so that the cxl call backs from the core
> powerpc mm code always exist irrespective of if the cxl module is loaded or
> not. This is similar to how cell works with CONFIG_SPU_BASE.
> 
> This adds a cxl_slbia() call (similar to spu_flush_all_slbs()) which checks for
> the cxl module being loaded. If the modules is not loaded we return, otherwise
> we call into the cxl SLB invalidation code.
> 
> This also adds the cxl_ctx_in_use() function for use in the mm code to see if
> any cxl contexts are currently in use. This is used by the tlbie() to
> determine if it can do local TLB invalidations or not. This also adds get/put
> calls for the cxl driver module to refcount the active cxl contexts.

This last paragraph is no longer true.

cheers
