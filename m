Return-Path: <paulus@ozlabs.org>
Date: Wed, 1 Aug 2012 15:29:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 12/13] arch/powerpc: Replace open coded CONTEXT_BITS
 value
Message-ID: <20120801052902.GF24014@drongo>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343647339-25576-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343647339-25576-13-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2012 at 04:52:18PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> To clarify the meaning for future readers, replace the open coded
> 19 with CONTEXT_BITS
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/mmu_context_hash64.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/mm/mmu_context_hash64.c b/arch/powerpc/mm/mmu_context_hash64.c
> index 40677aa..daa076c 100644
> --- a/arch/powerpc/mm/mmu_context_hash64.c
> +++ b/arch/powerpc/mm/mmu_context_hash64.c
> @@ -34,7 +34,7 @@ static DEFINE_IDA(mmu_context_ida);
>   * Each segment contains 2^28 bytes.  Each context maps 2^44 bytes,
>   * so we can support 2^19-1 contexts (19 == 35 + 28 - 44).
>   */
> -#define MAX_CONTEXT	((1UL << 19) - 1)
> +#define MAX_CONTEXT	((1UL << CONTEXT_BITS) - 1)

This is a good thing to do, but you should also update the comment.
Maybe you should put this patch before your number 10/13 and then
change the comment in the same patch where you add the 64TB support.

Paul.
