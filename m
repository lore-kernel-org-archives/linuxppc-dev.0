Return-Path: <michael@ellerman.id.au>
Date: Tue, 1 Oct 2013 14:09:40 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: Does iommu_init_table need to use GFP_ATOMIC allocations?
Message-ID: <20131001040940.GA17966@concordia>
References: <20130919165035.GA20144@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130919165035.GA20144@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 19, 2013 at 09:50:35AM -0700, Nishanth Aravamudan wrote:
> Under heavy (DLPAR?) stress, we tripped this panic() in
> arch/powerpc/kernel/iommu.c::iommu_init_table():
> 
>         page = alloc_pages_node(nid, GFP_ATOMIC, get_order(sz));
>         if (!page)
>                 panic("iommu_init_table: Can't allocate %ld bytes\n",
> sz);
> 
> Before the panic() we got a page allocation failure for an order-2
> allocation. There appears to be memory free, but perhaps not in the
> ATOMIC context. I looked through all the call-sites of
> iommu_init_table() and didn't see any obvious reason to need an ATOMIC
> allocation. Most call-sites in fact have an explicit GFP_KERNEL
> allocation shortly before the call to iommu_init_table(), indicating we
> are not in an atomic context. There is some indirection for some paths,
> but I didn't see any locks indicating that GFP_KERNEL is inappropriate.
> Does anyone know if/why ATOMIC allocations are necessary here?

I can't see any reason for it.

It was GFP_ATOMIC in the initial ppc64 code submission, so there's no
explanation in the commit history for it.

cheers
