Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjrth1g91zDrbl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 20:46:36 +1100 (AEDT)
In-Reply-To: <20171110045507.30147-1-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: powerpc/64s/slice: Use addr limit when computing slice mask
Message-Id: <3yjrth0FF4z9s8J@ozlabs.org>
Date: Fri, 24 Nov 2017 20:46:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-11-10 at 04:55:07 UTC, "Aneesh Kumar K.V" wrote:
> While computing slice mask for the free area we need make sure we only search
> in the addr limit applicable for this mmap. We update the slb_addr_limit
> after we request for a mmap above 128TB. But the following mmap request
> with hint addr below 128TB should still limit its search to below 128TB. ie.
> we should not use slb_addr_limit to compute slice mask in this case. Instead,
> we should derive high addr limit based on the mmap hint addr value.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/7a06c66835f75fe2be4f154a93cc30

cheers
