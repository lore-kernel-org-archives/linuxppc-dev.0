Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmb2p0GZbzDqpZ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 12:31:29 +1000 (AEST)
Subject: Re: [PATCH v1] Specific requirement of type casting for 64-bit
 architectures.
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, scottwood@freescale.com
References: <1468014242-13939-1-git-send-email-arvind.yadav.cs@gmail.com>
Cc: qiang.zhao@freescale.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <578061F6.4070307@roeck-us.net>
Date: Fri, 8 Jul 2016 19:31:18 -0700
MIME-Version: 1.0
In-Reply-To: <1468014242-13939-1-git-send-email-arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/2016 02:44 PM, Arvind Yadav wrote:

I would really suggest to read section 14 of Documentation/SubmittingPatches
and to follow the guidance it provides.

For the subject line: The subsystem/driver is still not listed,
and I am quite sure that this is not v1 of this patch.
It also does not describe the patch, much less concisely.

> -Return type of 'qe_muram_alloc' is 'unsigned long', That Was trying to
> assigned in ucc_fast_tx_virtual_fifo_base_offset and
> ucc_fast_rx_virtual_fifo_base_offset. It will work on 32-bit architectures
> But data can be loss on 64-bit architectures if 'qe_muram_alloc' will
> return greater then MAX value of 'unsigned int'.
>
Try to rephrase this to make it better readable.

> -Passing value in IS_ERR_VALUE() is wrong, as they pass an 'unsigned int'
> into a function, It will through this compilation warning.
>

What is wrong it that the return value from the allocator function is truncated
to 32 bit, and that the resulting value is then used as argument to IS_ERR_VALUE().

> "
>   include/linux/err.h:21:49: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>   #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= (unsigned long)-MAX_ERRNO)
>                                                   ^
>   include/linux/compiler.h:170:42: note: in definition of macro ‘unlikely’
>   # define unlikely(x) __builtin_expect(!!(x), 0)
> "
>
> -Most users of IS_ERR_VALUE() in the kernel are wrong, as they
> pass an 'unsigned int' into a function that takes an 'unsigned long'
> argument. This happens to work because the type is sign-extended
> on 64-bit architectures before it gets converted into an
> unsigned type.
>
While this may be true, the description of this patch should be about
this patch, not about the rest of the kernel.

> However, anything that passes an 'unsigned short' or 'unsigned int'
> argument into IS_ERR_VALUE() is guaranteed to be broken, as are
> 8-bit integers and types that are wider than 'unsigned long'.
>

What does that have to do with this patch ?

Again, the problem here is that a unsigned long is assigned to an u32, and that
the u32 is then used as parameter to IS_ERR_VALUE. This is wrong and needs to
be fixed. Describe what is wrong and needs to be fixed, not what can be wrong
elsewhere in the kernel.

> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

Here is where one would normally expect a change log.

>   drivers/soc/fsl/qe/ucc_fast.c | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
> index a768931..208b198 100644
> --- a/drivers/soc/fsl/qe/ucc_fast.c
> +++ b/drivers/soc/fsl/qe/ucc_fast.c
> @@ -141,6 +141,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
>   	struct ucc_fast __iomem *uf_regs;
>   	u32 gumr;
>   	int ret;
> +	unsigned long ret_muram;
>

Kind of an unfortunate variable name. A simple "offset" might be a better choice.

>   	if (!uf_info)
>   		return -EINVAL;
> @@ -265,28 +266,34 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
>   	gumr |= uf_info->mode;
>   	out_be32(&uf_regs->gumr, gumr);
>
> -	/* Allocate memory for Tx Virtual Fifo */
> -	uccf->ucc_fast_tx_virtual_fifo_base_offset =
> -	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
> -	if (IS_ERR_VALUE(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
> +	ret_muram =
> +		qe_muram_alloc(uf_info->utfs,
> +			UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);

While minor, this introduces a checkpatch CHECK message.

> +
This added empty line is an unnecessary whitespace change and does not add any value.

> +	if (IS_ERR_VALUE(ret_muram)) {
>   		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n",
>   			__func__);
>   		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
>   		ucc_fast_free(uccf);
>   		return -ENOMEM;
> +	} else {
> +		/* Allocate memory for Tx Virtual Fifo */

Why did you move the comment here ? The code below does not allocate anything.

> +		uccf->ucc_fast_tx_virtual_fifo_base_offset = (u32)ret_muram;
>   	}

checkpatch will rightfully tell you that else after return is generally not useful.
Also, the typecast is not necessary.

>
> -	/* Allocate memory for Rx Virtual Fifo */
> -	uccf->ucc_fast_rx_virtual_fifo_base_offset =
> +	ret_muram =
>   		qe_muram_alloc(uf_info->urfs +
>   			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
>   			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
> -	if (IS_ERR_VALUE(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
> +	if (IS_ERR_VALUE(ret_muram)) {
>   		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n",
>   			__func__);
>   		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
>   		ucc_fast_free(uccf);
>   		return -ENOMEM;
> +	} else {
> +		/* Allocate memory for Rx Virtual Fifo */
> +		uccf->ucc_fast_rx_virtual_fifo_base_offset = (u32)ret_muram;

Same comments as above.

>   	}
>
>   	/* Set Virtual Fifo registers */
>
