Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 10:15:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 11/11] arch/powerpc: Add 64TB support
Message-ID: <20120723001539.GI17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341839621-28332-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2012 at 06:43:41PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Increase max addressable range to 64TB. This is not tested on
> real hardware yet.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu-hash64.h        |    8 ++++----
>  arch/powerpc/include/asm/pgtable-ppc64-4k.h  |    2 +-
>  arch/powerpc/include/asm/pgtable-ppc64-64k.h |    2 +-
>  arch/powerpc/include/asm/processor.h         |    4 ++--
>  arch/powerpc/include/asm/sparsemem.h         |    4 ++--
>  5 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
> index aa0d560..a227ba7 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -374,16 +374,16 @@ extern void slb_set_size(u16 size);
>   */
>  
>  #define VSID_MULTIPLIER_256M	ASM_CONST(200730139)	/* 28-bit prime */
> -#define VSID_BITS_256M		36
> +#define VSID_BITS_256M		38
>  #define VSID_MODULUS_256M	((1UL<<VSID_BITS_256M)-1)

With these settings, the multiplication in ASM_VSID_SCRAMBLE could
overflow, leading to incorrect results (which would cause occasional
corruption of user processes under heavy load).  You will need to
reduce the multiplier to be less than 2^26, and it will need to be
co-prime with 2^38 - 1.  (Probably, the same value as we use in the 1T
case would be OK.)

Paul.
