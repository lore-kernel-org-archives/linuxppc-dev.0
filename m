Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmJSD4MDgzDqm9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 01:34:04 +1000 (AEST)
Date: Fri, 8 Jul 2016 08:33:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: scottwood@freescale.com, qiang.zhao@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: Need proper type casting before assignment, Remove compilation
 Warning.
Message-ID: <20160708153348.GA21592@roeck-us.net>
References: <1467910871-6371-1-git-send-email-arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467910871-6371-1-git-send-email-arvind.yadav.cs@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 07, 2016 at 10:31:11PM +0530, Arvind Yadav wrote:
> -Return type of 'qe_muram_alloc' is 'unsigned long', That Was trying to
> assigned in ucc_fast_tx_virtual_fifo_base_offset and
> ucc_fast_rx_virtual_fifo_base_offset. These variable are 'unsigned int'.
> So before assginment need a proper type casting.

Are they ? In the upstream kernel, they seem to be "u32".

> 
> -Passing value in IS_ERR_VALUE() is wrong, as they pass an 'int'
> into a function that takes an 'unsigned long' argument.This happens
> to work because the type is sign-extended on 64-bit architectures
> before it gets converted into an unsigned type.
> 
Not really sure I understand if/how this applies to the patch in question.
I don't see an int passed to IS_ERR_VALUE(), I only see u32.

> -Passing an 'unsigned short' or 'unsigned int'argument into
> IS_ERR_VALUE() is guaranteed to be broken, as are 8-bit integers
> and types that are wider than 'unsigned long'.
> 
What does this have to do with this patch ?

> -Any user will get compilation warning for that do not pass an
> unsigned long' argument.
> 
Sure, but that doesn't mean that typecasting the parameter to unsigned long
does any good (other than hiding the real bug).

Your subject line still does not list the affected subsystem and/or driver.
Documentation/SubmittingPatches might give some hints about proper subject
lines, and looking at other patches applied to the same file(s) might help
as well.

Also, if you want someone to review your patches, it helps to Cc: that
someone.

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/soc/fsl/qe/ucc_fast.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
> index a768931..98eed25 100644
> --- a/drivers/soc/fsl/qe/ucc_fast.c
> +++ b/drivers/soc/fsl/qe/ucc_fast.c
> @@ -267,8 +267,10 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
>  
>  	/* Allocate memory for Tx Virtual Fifo */
>  	uccf->ucc_fast_tx_virtual_fifo_base_offset =
> -	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
> -	if (IS_ERR_VALUE(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
> +		(unsigned int)qe_muram_alloc(uf_info->utfs,

I don't see the point of this typecast.

> +				UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
> +	if (IS_ERR_VALUE(
> +		(unsigned long)uccf->ucc_fast_tx_virtual_fifo_base_offset)) {

If sizeof(u32) == sizeof(unsigned long), this patch does not have an effect.
If sizeof(u32) < sizeof(unsigned long), it does not change anything, and the
resulting code is as wrong as it was before.

>  		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n",
>  			__func__);
>  		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
> @@ -278,10 +280,11 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
>  
>  	/* Allocate memory for Rx Virtual Fifo */
>  	uccf->ucc_fast_rx_virtual_fifo_base_offset =
> -		qe_muram_alloc(uf_info->urfs +
> +		(unsigned int)qe_muram_alloc(uf_info->urfs +
>  			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
>  			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
> -	if (IS_ERR_VALUE(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
> +	if (IS_ERR_VALUE(
> +		(unsigned long)uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
>  		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n",
>  			__func__);
>  		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
