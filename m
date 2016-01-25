Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 700211A0C62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jan 2016 16:46:03 +1100 (AEDT)
In-Reply-To: <1453361708-19422-1-git-send-email-aik@ozlabs.ru>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [kernel] powerpc: Make vmalloc_to_phys() public
Message-Id: <20160125054603.5D55B140326@ozlabs.org>
Date: Mon, 25 Jan 2016 16:46:03 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-21-01 at 07:35:08 UTC, Alexey Kardashevskiy wrote:
> This makes vmalloc_to_phys() public as there will be another user
> (in-kernel VFIO acceleration) for it soon.
> 
> As a part of future little optimization, this changes the helper to call
> vmalloc_to_pfn() instead of vmalloc_to_page() as the size of the
> struct page may not be power-of-two aligned which will make gcc use
> multiply instructions instead of shifts.

You should also mention why you need to export it, presumably because whatever
new user you have in mind can be built as a module.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
