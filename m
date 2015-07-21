Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C64151A0877
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:24:01 +1000 (AEST)
Message-ID: <1437459841.30722.9.camel@ellerman.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Fix calculation for
 memory allocated for TCE table
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>,  Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Date: Tue, 21 Jul 2015 16:24:01 +1000
In-Reply-To: <1437389151-4042-1-git-send-email-aik@ozlabs.ru>
References: <1437389151-4042-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-20 at 20:45 +1000, Alexey Kardashevskiy wrote:
> The existing code stores the amount of memory allocated for a TCE table.
> At the moment it uses @offset which is a virtual offset in the TCE table
> which is only correct for a one level tables and it does not include
> memory allocated for intermediate levels. When multilevel TCE table is
> requested, WARN_ON in tce_iommu_create_table() prints a warning.
> 
> This adds an additional counter to pnv_pci_ioda2_table_do_alloc_pages()
> to count actually allocated memory.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> I was sure I sent it already but could not find it anywhere so reposting.
> Sorry if it is a duplicate.

Stable?

cheers
