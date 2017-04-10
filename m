Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w253F4SWmzDqFG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:49:29 +1000 (AEST)
In-Reply-To: <20170407065311.8599-1-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: powerpc/mm: Remove reduntant initmem information from log
Message-Id: <3w253F3V0Jz9sNK@ozlabs.org>
Date: Tue, 11 Apr 2017 08:49:29 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-04-07 at 06:53:11 UTC, Anshuman Khandual wrote:
> Generic core VM already prints these information in the log
> buffer, hence there is no need for a second print. This just
> removes the second print from arch powerpc NUMA init path.
> 
> Before the patch:
> 
> $dmesg | grep "Initmem"
> 
> numa: Initmem setup node 0 [mem 0x00000000-0xffffffff]
> numa: Initmem setup node 1 [mem 0x100000000-0x1ffffffff]
> numa: Initmem setup node 2 [mem 0x200000000-0x2ffffffff]
> numa: Initmem setup node 3 [mem 0x300000000-0x3ffffffff]
> numa: Initmem setup node 4 [mem 0x400000000-0x4ffffffff]
> numa: Initmem setup node 5 [mem 0x500000000-0x5ffffffff]
> numa: Initmem setup node 6 [mem 0x600000000-0x6ffffffff]
> numa: Initmem setup node 7 [mem 0x700000000-0x7ffffffff]
> Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffffffff]
> Initmem setup node 1 [mem 0x0000000100000000-0x00000001ffffffff]
> Initmem setup node 2 [mem 0x0000000200000000-0x00000002ffffffff]
> Initmem setup node 3 [mem 0x0000000300000000-0x00000003ffffffff]
> Initmem setup node 4 [mem 0x0000000400000000-0x00000004ffffffff]
> Initmem setup node 5 [mem 0x0000000500000000-0x00000005ffffffff]
> Initmem setup node 6 [mem 0x0000000600000000-0x00000006ffffffff]
> Initmem setup node 7 [mem 0x0000000700000000-0x00000007ffffffff]
> 
> After the patch:
> 
> $dmesg | grep "Initmem"
> 
> Initmem setup node 0 [mem 0x0000000000000000-0x00000000ffffffff]
> Initmem setup node 1 [mem 0x0000000100000000-0x00000001ffffffff]
> Initmem setup node 2 [mem 0x0000000200000000-0x00000002ffffffff]
> Initmem setup node 3 [mem 0x0000000300000000-0x00000003ffffffff]
> Initmem setup node 4 [mem 0x0000000400000000-0x00000004ffffffff]
> Initmem setup node 5 [mem 0x0000000500000000-0x00000005ffffffff]
> Initmem setup node 6 [mem 0x0000000600000000-0x00000006ffffffff]
> Initmem setup node 7 [mem 0x0000000700000000-0x00000007ffffffff]
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ea6145557400b38faa6b3cee946ebc

cheers
