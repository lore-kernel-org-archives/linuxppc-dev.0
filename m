Return-Path: <paulus@ozlabs.org>
Date: Sat, 5 Jan 2013 11:55:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Carl E. Love" <cel@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/oprofile: Fix error in oprofile
 power7_marked_instr_event() function
Message-ID: <20130105005550.GH20724@iris.ozlabs.ibm.com>
References: <1354207323.5963.49.camel@oc5587145178.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1354207323.5963.49.camel@oc5587145178.ibm.com>
Cc: linuxppc-dev@ozlabs.org, bherren@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 29, 2012 at 08:42:03AM -0800, Carl E. Love wrote:
> powerpc/oprofile: Fix error in oprofile power7_marked_instr_event() function
> 
> The calculation for the left shift of the mask OPROFILE_PM_PMCSEL_MSK has an
> error.  The calculation is should be to shift left by (max_cntrs - cntr) times
> the width of the pmsel field width.  However, the #define OPROFILE_MAX_PMC_NUM
> was used instead of OPROFILE_PMSEL_FIELD_WIDTH.  This patch fixes the
> calculation.
> 
> Signed-off-by: Carl Love <cel@us.ibm.com>
> ---
>  arch/powerpc/oprofile/op_model_power4.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/oprofile/op_model_power4.c b/arch/powerpc/oprofile/op_model_power4.c
> index 315f949..f444b94 100644
> --- a/arch/powerpc/oprofile/op_model_power4.c
> +++ b/arch/powerpc/oprofile/op_model_power4.c
> @@ -52,7 +52,7 @@ static int power7_marked_instr_event(u64 mmcr1)
>  	for (pmc = 0; pmc < 4; pmc++) {
>  		psel = mmcr1 & (OPROFILE_PM_PMCSEL_MSK
>  				<< (OPROFILE_MAX_PMC_NUM - pmc)
> -				* OPROFILE_MAX_PMC_NUM);
> +				* OPROFILE_PMSEL_FIELD_WIDTH);
>  		psel = (psel >> ((OPROFILE_MAX_PMC_NUM - pmc)
>  				 * OPROFILE_PMSEL_FIELD_WIDTH)) & ~1ULL;

Apart from the fact that those two statements would be simpler and
better as:

		psel = mmcr1 >> ((OPROFILE_MAX_PMC_NUM - pmc)
  				 * OPROFILE_PMSEL_FIELD_WIDTH);
		psel &= OPROFILE_PM_PMCSEL_MSK & ~1ULL;

the change looks correct, so:

Acked-by: Paul Mackerras <paulus@samba.org>
