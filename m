Return-Path: <rusty@ozlabs.org>
From: Rusty Russell <rusty@rustcorp.com.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V3 2/2] powerpc/pseries: init fault_around_order for
 pseries
In-Reply-To: <1398675690-16186-3-git-send-email-maddy@linux.vnet.ibm.com>
References: <1398675690-16186-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1398675690-16186-3-git-send-email-maddy@linux.vnet.ibm.com>
Date: Tue, 29 Apr 2014 11:48:40 +0930
Message-ID: <877g686fpb.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Cc: riel@redhat.com, ak@linux.intel.com, peterz@infradead.org,
 dave.hansen@intel.com, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 paulus@samba.org, mgorman@suse.de, akpm@linux-foundation.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
> index 2db8cc6..c87e6b6 100644
> --- a/arch/powerpc/platforms/pseries/setup.c
> +++ b/arch/powerpc/platforms/pseries/setup.c
> @@ -74,6 +74,8 @@ int CMO_SecPSP = -1;
>  unsigned long CMO_PageSize = (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K);
>  EXPORT_SYMBOL(CMO_PageSize);
>  
> +extern unsigned int fault_around_order;
> +

It's considered bad form to do this.  Put the declaration in linux/mm.h.

Thanks,
Rusty.
PS.  But we're getting there! :)
