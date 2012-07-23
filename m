Return-Path: <paulus@ozlabs.org>
Date: Mon, 23 Jul 2012 10:06:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 09/11] arch/powerpc: Use 50 bits of VSID in slbmte
Message-ID: <20120723000658.GH17790@bloggs.ozlabs.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341839621-28332-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2012 at 06:43:39PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> Increase the number of valid VSID bits in slbmte instruction.
> We will use the new bits when we increase valid VSID bits.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/slb_low.S |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> index c355af6..c1fc81c 100644
> --- a/arch/powerpc/mm/slb_low.S
> +++ b/arch/powerpc/mm/slb_low.S
> @@ -226,7 +226,7 @@ _GLOBAL(slb_allocate_user)
>   */
>  slb_finish_load:
>  	ASM_VSID_SCRAMBLE(r10,r9,256M)
> -	rldimi	r11,r10,SLB_VSID_SHIFT,16	/* combine VSID and flags */
> +	rldimi	r11,r10,SLB_VSID_SHIFT,2	/* combine VSID and flags */

You can't do that without either changing ASM_VSID_SCRAMBLE or masking
the VSID it generates to 36 bits, since the logic in ASM_VSID_SCRAMBLE
can leave non-zero bits in the high 28 bits of the result.  Similarly
for the 1T case.

Paul.
