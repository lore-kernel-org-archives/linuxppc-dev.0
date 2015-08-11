Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F6CD1A0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:53:00 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 11 Aug 2015 10:52:58 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3FB223578055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:52:55 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7B0ql4w3604968
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:52:56 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7B0qLEu010881
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:52:22 +1000
Date: Tue, 11 Aug 2015 10:52:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru
Subject: Re: [PATCH v6 40/42] drivers/of: Return allocated memory chunk from
 of_fdt_unflatten_tree()
Message-ID: <20150811005202.GA20729@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-41-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C928D8.3040200@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C928D8.3040200@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 10, 2015 at 03:42:32PM -0700, Frank Rowand wrote:
>On 8/5/2015 9:11 PM, Gavin Shan wrote:

Frank, thanks for your comments. All of them will be included
in next revision.

Thanks,
Gavin

>> This changes of_fdt_unflatten_tree() so that it returns the allocated
>> memory chunk for unflattened device-tree, which can be released once
>> it's obsoleted.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/of/fdt.c       | 11 ++++++-----
>>  include/linux/of_fdt.h |  2 +-
>>  2 files changed, 7 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 074870a..8e1ba7e 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -408,7 +408,7 @@ static void *unflatten_dt_node(const void *blob,
>>   * @dt_alloc: An allocator that provides a virtual address to memory
>>   * for the resulting tree
>>   */
>> -static void __unflatten_device_tree(const void *blob,
>> +static void *__unflatten_device_tree(const void *blob,
>>  			     struct device_node *dad,
>>  			     struct device_node **mynodes,
>>  			     void * (*dt_alloc)(u64 size, u64 align))
>
>Please add a description of the return value to the documentation header.
>
>
>> @@ -421,7 +421,7 @@ static void __unflatten_device_tree(const void *blob,
>>  
>>  	if (!blob) {
>>  		pr_debug("No device tree pointer\n");
>> -		return;
>> +		return NULL;
>>  	}
>>  
>>  	pr_debug("Unflattening device tree:\n");
>> @@ -431,7 +431,7 @@ static void __unflatten_device_tree(const void *blob,
>>  
>>  	if (fdt_check_header(blob)) {
>>  		pr_err("Invalid device tree blob header\n");
>> -		return;
>> +		return NULL;
>>  	}
>>  
>>  	/* First pass, scan for size */
>> @@ -458,6 +458,7 @@ static void __unflatten_device_tree(const void *blob,
>>  			   be32_to_cpup(mem + size));
>>  
>>  	pr_debug(" <- unflatten_device_tree()\n");
>> +	return mem;
>>  }
>>  
>>  static void *kernel_tree_alloc(u64 size, u64 align)
>> @@ -473,11 +474,11 @@ static void *kernel_tree_alloc(u64 size, u64 align)
>>   * pointers of the nodes so the normal device-tree walking functions
>>   * can be used.
>>   */
>> -void of_fdt_unflatten_tree(const unsigned long *blob,
>> +void *of_fdt_unflatten_tree(const unsigned long *blob,
>
>Please add a description of the return value to the documentation header.
>
>
>>  			struct device_node *dad,
>>  			struct device_node **mynodes)
>>  {
>> -	__unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
>> +	return __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc);
>>  }
>>  EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>>  
>> diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
>> index 3644960..00db279 100644
>> --- a/include/linux/of_fdt.h
>> +++ b/include/linux/of_fdt.h
>> @@ -37,7 +37,7 @@ extern bool of_fdt_is_big_endian(const void *blob,
>>  				 unsigned long node);
>>  extern int of_fdt_match(const void *blob, unsigned long node,
>>  			const char *const *compat);
>> -extern void of_fdt_unflatten_tree(const unsigned long *blob,
>> +extern void *of_fdt_unflatten_tree(const unsigned long *blob,
>>  			       struct device_node *dad,
>>  			       struct device_node **mynodes);
>>  
>> 
>
