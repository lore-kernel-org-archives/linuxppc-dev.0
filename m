Return-Path: <arvind.yadav.cs@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmS3N65TLzDqpQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jul 2016 07:16:32 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id dx3so8713546pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 14:16:32 -0700 (PDT)
Subject: Re: Need proper type casting before assignment, Remove compilation
 Warning.
To: Guenter Roeck <linux@roeck-us.net>
References: <1467910871-6371-1-git-send-email-arvind.yadav.cs@gmail.com>
 <20160708153348.GA21592@roeck-us.net>
Cc: scottwood@freescale.com, qiang.zhao@freescale.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: arvind Yadav <arvind.yadav.cs@gmail.com>
Message-ID: <57801828.4090203@gmail.com>
Date: Sat, 9 Jul 2016 02:46:24 +0530
MIME-Version: 1.0
In-Reply-To: <20160708153348.GA21592@roeck-us.net>
Content-Type: multipart/alternative;
 boundary="------------010108040600090900080906"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010108040600090900080906
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit


As per you concern, I have submitted one more patch with some changes. 
Please review it.

Thanks,

On Friday 08 July 2016 09:03 PM, Guenter Roeck wrote:
> On Thu, Jul 07, 2016 at 10:31:11PM +0530, Arvind Yadav wrote:
>> -Return type of 'qe_muram_alloc' is 'unsigned long', That Was trying to
>> assigned in ucc_fast_tx_virtual_fifo_base_offset and
>> ucc_fast_rx_virtual_fifo_base_offset. These variable are 'unsigned int'.
>> So before assginment need a proper type casting.
> Are they ? In the upstream kernel, they seem to be "u32".
Yes, I have changed as per you suggestion.
>
>> -Passing value in IS_ERR_VALUE() is wrong, as they pass an 'int'
>> into a function that takes an 'unsigned long' argument.This happens
>> to work because the type is sign-extended on 64-bit architectures
>> before it gets converted into an unsigned type.
>>
> Not really sure I understand if/how this applies to the patch in question.
> I don't see an int passed to IS_ERR_VALUE(), I only see u32.
-Most users of IS_ERR_VALUE() in the kernel are wrong, as they
pass an 'unsigned int' into a function that takes an 'unsigned long'
argument. This happens to work because the type is sign-extended
on 64-bit architectures before it gets converted into an
unsigned type.

However, anything that passes an 'unsigned short' or 'unsigned int'
argument into IS_ERR_VALUE() is guaranteed to be broken, as are
8-bit integers and types that are wider than 'unsigned long'.
>> -Passing an 'unsigned short' or 'unsigned int'argument into
>> IS_ERR_VALUE() is guaranteed to be broken, as are 8-bit integers
>> and types that are wider than 'unsigned long'.
>>
> What does this have to do with this patch ?
Specific requirement of type casting for 64-bit architectures.

-Return type of 'qe_muram_alloc' is 'unsigned long', That Was trying to
assigned in ucc_fast_tx_virtual_fifo_base_offset and
ucc_fast_rx_virtual_fifo_base_offset. It will work on 32-bit architectures
But data can be loss on 64-bit architectures if 'qe_muram_alloc' will return
greater then MAX value of 'unsigned int'.


-Passing value in IS_ERR_VALUE() is wrong, as they pass an 'unsigned int'
into a function, It will through this compilation warning.
"
  include/linux/err.h:21:49: warning: cast to pointer from integer of 
different size [-Wint-to-pointer-cast]
  #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) >= 
(unsigned long)-MAX_ERRNO)
                                                  ^
  include/linux/compiler.h:170:42: note: in definition of macro ‘unlikely’
  # define unlikely(x) __builtin_expect(!!(x), 0)
"
>> -Any user will get compilation warning for that do not pass an
>> unsigned long' argument.
>>
> Sure, but that doesn't mean that typecasting the parameter to unsigned long
> does any good (other than hiding the real bug).
>
> Your subject line still does not list the affected subsystem and/or driver.
> Documentation/SubmittingPatches might give some hints about proper subject
> lines, and looking at other patches applied to the same file(s) might help
> as well.
>
> Also, if you want someone to review your patches, it helps to Cc: that
> someone.
Thanks, For your suggestion.
>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> ---
>>   drivers/soc/fsl/qe/ucc_fast.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
>> index a768931..98eed25 100644
>> --- a/drivers/soc/fsl/qe/ucc_fast.c
>> +++ b/drivers/soc/fsl/qe/ucc_fast.c
>> @@ -267,8 +267,10 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
>>   
>>   	/* Allocate memory for Tx Virtual Fifo */
>>   	uccf->ucc_fast_tx_virtual_fifo_base_offset =
>> -	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
>> -	if (IS_ERR_VALUE(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
>> +		(unsigned int)qe_muram_alloc(uf_info->utfs,
> I don't see the point of this typecast.
>
>> +				UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
>> +	if (IS_ERR_VALUE(
>> +		(unsigned long)uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
> If sizeof(u32) == sizeof(unsigned long), this patch does not have an effect.
> If sizeof(u32) < sizeof(unsigned long), it does not change anything, and the
> resulting code is as wrong as it was before.
>
>>   		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n",
>>   			__func__);
>>   		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
>> @@ -278,10 +280,11 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
>>   
>>   	/* Allocate memory for Rx Virtual Fifo */
>>   	uccf->ucc_fast_rx_virtual_fifo_base_offset =
>> -		qe_muram_alloc(uf_info->urfs +
>> +		(unsigned int)qe_muram_alloc(uf_info->urfs +
>>   			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
>>   			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
>> -	if (IS_ERR_VALUE(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
>> +	if (IS_ERR_VALUE(
>> +		(unsigned long)uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
>>   		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n",
>>   			__func__);
>>   		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;


--------------010108040600090900080906
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    As per you concern, I have submitted one more patch with some
    changes. Please review it.<br>
    <br>
    Thanks,<br>
    <br>
    <div class="moz-cite-prefix">On Friday 08 July 2016 09:03 PM,
      Guenter Roeck wrote:<br>
    </div>
    <blockquote cite="mid:20160708153348.GA21592@roeck-us.net"
      type="cite">
      <pre wrap="">On Thu, Jul 07, 2016 at 10:31:11PM +0530, Arvind Yadav wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">-Return type of 'qe_muram_alloc' is 'unsigned long', That Was trying to
assigned in ucc_fast_tx_virtual_fifo_base_offset and
ucc_fast_rx_virtual_fifo_base_offset. These variable are 'unsigned int'.
So before assginment need a proper type casting.
</pre>
      </blockquote>
      <pre wrap="">
Are they ? In the upstream kernel, they seem to be "u32".</pre>
    </blockquote>
    <small>Yes, I have changed as per you suggestion.</small><br>
    <blockquote cite="mid:20160708153348.GA21592@roeck-us.net"
      type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap="">
-Passing value in IS_ERR_VALUE() is wrong, as they pass an 'int'
into a function that takes an 'unsigned long' argument.This happens
to work because the type is sign-extended on 64-bit architectures
before it gets converted into an unsigned type.

</pre>
      </blockquote>
      <pre wrap="">Not really sure I understand if/how this applies to the patch in question.
I don't see an int passed to IS_ERR_VALUE(), I only see u32.
</pre>
    </blockquote>
    <small>-Most users of IS_ERR_VALUE() in the kernel are wrong, as
      they<br>
      pass an 'unsigned int' into a function that takes an 'unsigned
      long'<br>
      argument. This happens to work because the type is sign-extended<br>
      on 64-bit architectures before it gets converted into an<br>
      unsigned type.<br>
          <br>
      However, anything that passes an 'unsigned short' or 'unsigned
      int'<br>
      argument into IS_ERR_VALUE() is guaranteed to be broken, as are<br>
      8-bit integers and types that are wider than 'unsigned long'.</small><br>
    <blockquote cite="mid:20160708153348.GA21592@roeck-us.net"
      type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">-Passing an 'unsigned short' or 'unsigned int'argument into
IS_ERR_VALUE() is guaranteed to be broken, as are 8-bit integers
and types that are wider than 'unsigned long'.

</pre>
      </blockquote>
      <pre wrap="">What does this have to do with this patch ?
</pre>
    </blockquote>
    <small>Specific requirement of type casting for 64-bit
      architectures.<br>
      <br>
      -Return type of 'qe_muram_alloc' is 'unsigned long', That Was
      trying to<br>
      assigned in ucc_fast_tx_virtual_fifo_base_offset and<br>
      ucc_fast_rx_virtual_fifo_base_offset. It will work on 32-bit
      architectures<br>
      But data can be loss on 64-bit architectures if 'qe_muram_alloc'
      will return<br>
      greater then MAX value of 'unsigned int'.<br>
      <br>
      <br>
      -Passing value in IS_ERR_VALUE() is wrong, as they pass an
      'unsigned int'<br>
      into a function, It will through this compilation warning.<br>
      "<br>
       include/linux/err.h:21:49: warning: cast to pointer from integer
      of different size [-Wint-to-pointer-cast]<br>
       #define IS_ERR_VALUE(x) unlikely((unsigned long)(void *)(x) &gt;=
      (unsigned long)-MAX_ERRNO)<br>
                                                       ^<br>
       include/linux/compiler.h:170:42: note: in definition of macro
      ‘unlikely’<br>
       # define unlikely(x) __builtin_expect(!!(x), 0)<br>
      "  <br>
    </small>
    <blockquote cite="mid:20160708153348.GA21592@roeck-us.net"
      type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">-Any user will get compilation warning for that do not pass an
unsigned long' argument.

</pre>
      </blockquote>
      <pre wrap="">Sure, but that doesn't mean that typecasting the parameter to unsigned long
does any good (other than hiding the real bug).

Your subject line still does not list the affected subsystem and/or driver.
Documentation/SubmittingPatches might give some hints about proper subject
lines, and looking at other patches applied to the same file(s) might help
as well.

Also, if you want someone to review your patches, it helps to Cc: that
someone.
</pre>
    </blockquote>
    <small>Thanks, For your suggestion.</small><br>
    <blockquote cite="mid:20160708153348.GA21592@roeck-us.net"
      type="cite">
      <pre wrap="">
</pre>
      <blockquote type="cite">
        <pre wrap="">Signed-off-by: Arvind Yadav <a class="moz-txt-link-rfc2396E" href="mailto:arvind.yadav.cs@gmail.com">&lt;arvind.yadav.cs@gmail.com&gt;</a>
---
 drivers/soc/fsl/qe/ucc_fast.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qe/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
index a768931..98eed25 100644
--- a/drivers/soc/fsl/qe/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -267,8 +267,10 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 
 	/* Allocate memory for Tx Virtual Fifo */
 	uccf-&gt;ucc_fast_tx_virtual_fifo_base_offset =
-	    qe_muram_alloc(uf_info-&gt;utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_ERR_VALUE(uccf-&gt;ucc_fast_tx_virtual_fifo_base_offset)) {
+		(unsigned int)qe_muram_alloc(uf_info-&gt;utfs,
</pre>
      </blockquote>
      <pre wrap="">
I don't see the point of this typecast.

</pre>
      <blockquote type="cite">
        <pre wrap="">+				UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
+	if (IS_ERR_VALUE(
+		(unsigned long)uccf-&gt;ucc_fast_tx_virtual_fifo_base_offset)) {
</pre>
      </blockquote>
      <pre wrap="">
If sizeof(u32) == sizeof(unsigned long), this patch does not have an effect.
If sizeof(u32) &lt; sizeof(unsigned long), it does not change anything, and the
resulting code is as wrong as it was before.</pre>
    </blockquote>
    <blockquote cite="mid:20160708153348.GA21592@roeck-us.net"
      type="cite">
      <pre wrap="">

</pre>
      <blockquote type="cite">
        <pre wrap=""> 		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO\n",
 			__func__);
 		uccf-&gt;ucc_fast_tx_virtual_fifo_base_offset = 0;
@@ -278,10 +280,11 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 
 	/* Allocate memory for Rx Virtual Fifo */
 	uccf-&gt;ucc_fast_rx_virtual_fifo_base_offset =
-		qe_muram_alloc(uf_info-&gt;urfs +
+		(unsigned int)qe_muram_alloc(uf_info-&gt;urfs +
 			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
 			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_ERR_VALUE(uccf-&gt;ucc_fast_rx_virtual_fifo_base_offset)) {
+	if (IS_ERR_VALUE(
+		(unsigned long)uccf-&gt;ucc_fast_rx_virtual_fifo_base_offset)) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO\n",
 			__func__);
 		uccf-&gt;ucc_fast_rx_virtual_fifo_base_offset = 0;
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------010108040600090900080906--
