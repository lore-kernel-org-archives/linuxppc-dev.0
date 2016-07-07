Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rlkYT3TVdzDqyq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 03:06:37 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c74so2306058pfb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jul 2016 10:06:37 -0700 (PDT)
Subject: Re: Remove lots of IS_ERR_VALUE abuses and compilation warning.
To: Guenter Roeck <linux@roeck-us.net>
References: <1467905249-3990-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20160707155102.GA5107@roeck-us.net>
Cc: scottwood@freescale.com, qiang.zhao@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <577E8C17.6090800@gmail.com>
Date: Thu, 7 Jul 2016 22:36:31 +0530
MIME-Version: 1.0
In-Reply-To: <20160707155102.GA5107@roeck-us.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yes, You are right,
-Now Return type of 'qe_muram_alloc' is 'unsigned long', That Was trying 
to assigned in ucc_fast_tx_virtual_fifo_base_offset and 
ucc_fast_rx_virtual_fifo_base_offset. These variable are 'unsigned int'. 
So before assignment need a proper type casting.

-Passing value in IS_ERR_VALUE() is wrong. So this is also need a proper 
type casting before passing an argument.

I have done the changes and re-submitted anther patch, Please review It.

Thanks,
Arvind

On Thursday 07 July 2016 09:21 PM, Guenter Roeck wrote:
> On Thu, Jul 07, 2016 at 08:57:29PM +0530, Arvind Yadav wrote:
>> Passing value in IS_ERR_VALUE() is wrong, as they
>>      pass an 'int' into a function that takes an 'unsigned long'
>>      argument. This happens to work because the type is sign-extended
>>      on 64-bit architectures before it gets converted into an
>>      unsigned type.
>>
>>      Passing an 'unsigned short' or 'unsigned int'
>>      argument into IS_ERR_VALUE() is guaranteed to be broken, as are
>>      8-bit integers and types that are wider than 'unsigned long'.
>>
>>      Any user will get compilation warning for that do not pass an
>>      'unsigned long' argument.
>>
>>      Commit '287980e49f; - This change is alreday fixes lots of other
>>      worst abusers.
>>
> Couple of generic comments:
>
> - Your patch subject lines don't include the affected drivers/modules.
>    As such, most of them will be ignored because maintainers won't realize
>    that you are talking with them. Some may ask you to resubmit with proper
>    subject lines.
>    Commit 287980e49f is different; it addresses the problem in several
>    drivers in a single commit.
> - If you patch a single file, I think it would be better to adjust the
>    description accordingly. In this patch, the offending variable type is
>    u32. The patch description is therefore misleading; the code here simply does
>    not work.
> - When you resubmit a patch, you don't include a version, not a change log.
>    This means additional work for maintainers, who have to figure out which
>    patch to apply.
>
> Specific comment:
>
> The allocator in question returns -ENOMEM in an unsigned long. This is assigned
> to u32. A proper fix would be to assign the return value to an unsigned
> long and to use IS_ER_VALUE() to check if it reports an error, and to only
> assign it to ucc_fast_rx_virtual_fifo_base_offset if there was no error.
>
> Also, unless I am missing something - since ucc_fast_rx_virtual_fifo_base_offset
> is defined as u32, it is somewhat unlikely that it is ever < 0.
>
> Guenter
>
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/soc/fsl/qe/ucc_fast.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
>> index a768931..7cc783c 100644
>> --- a/drivers/soc/fsl/qe/ucc_fast.c
>> +++ b/drivers/soc/fsl/qe/ucc_fast.c
>> @@ -268,7 +268,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
>>   	/* Allocate memory for Tx Virtual Fifo */
>>   	uccf->ucc_fast_tx_virtual_fifo_base_offset =
>>   	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
>> -	if (IS_ERR_VALUE(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
>> +	if (uccf->ucc_fast_tx_virtual_fifo_base_offset < 0) {
>>   		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n",
>>   			__func__);
>>   		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
>> @@ -281,7 +281,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
>>   		qe_muram_alloc(uf_info->urfs +
>>   			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
>>   			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
>> -	if (IS_ERR_VALUE(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
>> +	if (uccf->ucc_fast_rx_virtual_fifo_base_offset < 0) {
>>   		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n",
>>   			__func__);
>>   		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
