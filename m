Return-Path: <michael@ellerman.id.au>
Date: Wed, 7 Aug 2013 15:11:24 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: Fix undefined variable
Message-ID: <20130807051124.GA19998@concordia>
References: <1375842286-26521-1-git-send-email-qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375842286-26521-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 06, 2013 at 10:24:46PM -0400, Mike Qiu wrote:
> 'pe_no' hasn't been defined, it should be an typo error,
> it should be 'frozen_pe_no'.
> 
> Also '__func__' should be added to IODA_EEH_DBG(),
> 
> Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/eeh-ioda.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
> index 0cd1c4a..a49bee7 100644
> --- a/arch/powerpc/platforms/powernv/eeh-ioda.c
> +++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
> @@ -843,7 +843,8 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
>  		 * specific PHB.
>  		 */
>  		IODA_EEH_DBG("%s: Error (%d, %d, %d) on PHB#%x\n",
> -			err_type, severity, pe_no, hose->global_number);
> +			__func__, err_type, severity,
> +			frozen_pe_no, hose->global_number);

Why is it using a custom macro? If you use pr_devel() or similar you
avoid these bugs, because the argument list is always expanded.

cheers
