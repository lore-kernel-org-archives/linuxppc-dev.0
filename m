Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRQ0jt3zDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:50 +1000 (AEST)
In-Reply-To: <1463060055-24158-3-git-send-email-bharata@linux.vnet.ibm.com>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: nfont@linux.vnet.ibm.com, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 aik@au1.ibm.com, david@gibson.dropbear.id.au
Subject: Re: [FIX,v2,2/2] powerpc,numa: Fix memory_hotplug_max()
Message-Id: <3rYTRP6HB5z9sCp@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-12-05 at 13:34:15 UTC, Bharata B Rao wrote:
> memory_hotplug_max() uses hot_add_drconf_memory_max() to get maxmimum
> addressable memory by referring to ibm,dyanamic-memory property. There
> are three problems with the current approach:
> 
> 1 hot_add_drconf_memory_max() assumes that ibm,dynamic-memory includes
>   all the LMBs of the guest, but that is not true for PowerKVM which
>   populates only DR LMBs (LMBs that can be hotplugged/removed) in that
>   property.
> 2 hot_add_drconf_memory_max() multiplies lmb-size with lmb-count to arrive
>   at the max possible address. Since ibm,dynamic-memory doesn't include
>   RMA LMBs, the address thus obtained will be less than the actual max
>   address. For example, if max possible memory size is 32G, with lmb-size
>   of 256MB there can be 127 LMBs in ibm,dynamic-memory (1 LMB for RMA
>   which won't be present here).  hot_add_drconf_memory_max() would then
>   return the max addressable memory as 127 * 256MB = 31.75GB, the max
>   address should have been 32G which is what ibm,lrdr-capacity shows.
> 3 In PowerKVM, there can be a gap between the end of boot time RAM and
>   beginning of hotplug RAM area. So just multiplying lmb-count with
>   lmb-size will not provide the correct max possible address for PowerKVM.
> 
> This patch fixes 1 by using ibm,lrdr-capacity property to return the max
> addressable memory whenever the property is present. Then it fixes 2 & 3
> by fetching the address of the last LMB in ibm,dynamic-memory property.
> 
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45b64ee64970dee9392229302e

cheers
