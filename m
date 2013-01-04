Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8D2BC2C008E
 for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2013 15:37:20 +1100 (EST)
Message-ID: <1357274227.2500.19.camel@pasglop>
Subject: Re: [PATCH] powerpc/oprofile: Fix error in oprofile
 power7_marked_instr_event() function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Carl E. Love" <cel@linux.vnet.ibm.com>
Date: Fri, 04 Jan 2013 15:37:07 +1100
In-Reply-To: <1354207323.5963.49.camel@oc5587145178.ibm.com>
References: <1354207323.5963.49.camel@oc5587145178.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@au1.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-11-29 at 08:42 -0800, Carl E. Love wrote:
> Ben:
> 
> Please review the following patch.  If it is acceptable, will you please
> commit it to the mainline tree.  Thanks.
> 
>               Carl Love
> 
> P.S.  Looks like I sent it to the wrong mailing list the first time to
> get it into the patch queue.

Also avoid my Notes address for patches please...

> --------------------------------------------------------------------------
> powerpc/oprofile: Fix error in oprofile power7_marked_instr_event() function
> 
> The calculation for the left shift of the mask OPROFILE_PM_PMCSEL_MSK has an
> error.  The calculation is should be to shift left by (max_cntrs - cntr) times
> the width of the pmsel field width.  However, the #define OPROFILE_MAX_PMC_NUM
> was used instead of OPROFILE_PMSEL_FIELD_WIDTH.  This patch fixes the
> calculation.

Paul, Anton, can of you ack this ?

Cheers,
Ben.

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
>  		unit = mmcr1 & (OPROFILE_PM_UNIT_MSK
