Return-Path: <paulus@ozlabs.org>
Date: Wed, 13 Mar 2013 13:56:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V2 11/26] powerpc: Fix hpte_decode to use the correct
 decoding for page sizes
Message-ID: <20130313025614.GB21125@iris.ozlabs.ibm.com>
References: <1362550227-575-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1362550227-575-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1362550227-575-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 06, 2013 at 11:40:12AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> As per ISA doc, we encode base and actual page size in the LP bits of
> PTE. The number of bit used to encode the page sizes depend on actual
> page size.  ISA doc lists this as
> 
>    PTE LP     actual page size
> rrrr rrrz 	≥8KB
> rrrr rrzz	≥16KB
> rrrr rzzz 	≥32KB
> rrrr zzzz 	≥64KB
> rrrz zzzz 	≥128KB
> rrzz zzzz 	≥256KB
> rzzz zzzz	≥512KB
> zzzz zzzz 	≥1MB
> 
> ISA doc also says
> "The values of the “z” bits used to specify each size, along with all possible
> values of “r” bits in the LP field, must result in LP values distinct from
> other LP values for other sizes."
> 
> based on the above update hpte_decode to use the correct decoding for LP bits.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
[snip]
> +				shift = mmu_psize_defs[a_size].shift -
> +					mmu_psize_defs[MMU_PAGE_4K].shift;

"mmu_psize_defs[MMU_PAGE_4K].shift" seems like an overly complicated
way to write "LP_SHIFT" (or even "12").  After all, you did:

> +	unsigned int lp = (hpte->r >> LP_SHIFT) & ((1 << LP_BITS) - 1);

earlier.  If LP_SHIFT is good enough in that expression it's good
enough when calculating shift.

Apart from that minor nit,

Acked-by: Paul Mackerras <paulus@samba.org>
