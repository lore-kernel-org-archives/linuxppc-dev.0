Return-Path: <mpe@ellerman.id.au>
Message-ID: <1393292822.13244.5.camel@concordia>
Subject: Re: [PATCH] powerpc/crashdump : fix page frame number check in
 copy_oldmem_page
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 12:47:02 +1100
In-Reply-To: <20140224163055.7263.86979.stgit@nimbus>
References: <20140224163055.7263.86979.stgit@nimbus>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-02-24 at 17:30 +0100, Laurent Dufour wrote:
> In copy_oldmem_page, the current check using max_pfn and min_low_pfn to
> decide if the page is backed or not, is not valid when the memory layout is
> not continuous.
> 
> This happens when running as a QEMU/KVM guest, where RTAS is mapped higher
> in the memory. In that case max_pfn points to the end of RTAS, and a hole
> between the end of the kdump kernel and RTAS is not backed by PTEs. As a
> consequence, the kdump kernel is crashing in copy_oldmem_page when accessing
> in a direct way the pages in that hole.
> 
> This fix relies on the memblock's service memblock_is_region_memory to
> check if the read page is part or not of the directly accessible memory.

Hi Laurent,

This looks good to me, assuming you've tested it on a PowerVM system as well as
under KVM.

cheers
