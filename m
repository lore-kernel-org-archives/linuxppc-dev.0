Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKKXy1x9lzDvsP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 23:04:02 +1100 (AEDT)
In-Reply-To: <1478669793-15074-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com, sjitindarsingh@gmail.com
Subject: Re: powerpc/mm: Correct process and partition table max size
Message-Id: <3tKKXy15wsz9t1d@ozlabs.org>
Date: Thu, 17 Nov 2016 23:04:01 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-09-11 at 05:36:33 UTC, Suraj Jitindar Singh wrote:
> Version 3.00 of the ISA states that the PATS (partition table size) field
> of the PTCR (partition table control register) and the PRTS (process table
> size) field of the partition table entry must both be less than or equal
> to 24. However the actual size of the partition and process tables is equal
> to 2 to the power of 12 plus the PATS and PRTS fields, respectively. This
> means that the max allowable size of each of these tables is 2^36 or 64GB
> for both.
> 
> Thus when checking the size shift for each we should be checking for values
> of greater than 36 instead of the current check for shifts larger than 24
> and 23.
> 
> Fixes: 2bfd65e45e877fb5704730244da67c748d28a1b8
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/555c16328ae6d75a90e234eac9b519

cheers
