Return-Path: <jk@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC3171A0889
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 00:04:02 +1000 (AEST)
Message-ID: <55705AD1.30105@ozlabs.org>
Date: Thu, 04 Jun 2015 22:04:01 +0800
From: Jeremy Kerr <jk@ozlabs.org>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [3/3,v3] powerpc/powernv: Add opal-prd channel
References: <20150604113116.61400140273@ozlabs.org>
In-Reply-To: <20150604113116.61400140273@ozlabs.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> Sorry, I put this in but then hit the build break, I was going to fix it up but
> would rather you did and tested it, so we may as well do another review :)

whee!

>> @@ -0,0 +1,58 @@
>> +/*
>> + * OPAL Runtime Diagnostics interface driver
>> + * Supported on POWERNV platform
>> + *
>> + * (C) Copyright IBM 2015
> 
> Usual syntax is: "Copyright IBM Corporation 2015"

OK, fixed.

>> + *
>> + * Author: Vaidyanathan Srinivasan <svaidy at linux.vnet.ibm.com>
>> + * Author: Jeremy Kerr <jk@ozlabs.org>
> 
> I'd rather you dropped these, they'll just bit rot, but if you insist I don't
> care that much.

Yep, I'd rather remove them too.

>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2, or (at your option)
>> + * any later version.
> 
> As pointed out by Daniel, we should probably be using the "version 2" only
> language on new files.

Fixed.

>> +	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
>> +						 size, vma->vm_page_prot)
>> +				| _PAGE_SPECIAL;
> 
> This doesn't build with CONFIG_STRICT_MM_TYPECHECKS=y:
> 
>   arch/powerpc/platforms/powernv/opal-prd.c:131:5: error: invalid operands to binary | (have â€˜pgprot_tâ€™ and â€˜intâ€™)
>   | _PAGE_SPECIAL;

OK, new patch coming with the proper pgprot macros.

>> +	switch(cmd) {
>               ^
> 	      space please

Fixed.


>> +		pr_devel("ioctl SCOM_READ: chip %llx addr %016llx "
>> +				"data %016llx rc %lld\n",
> 
> Don't split the string please.

OK, but this makes our lines >80 chars. Assuming that'll be okay.

>> +struct file_operations opal_prd_fops = {
> 
> This can be static const I think.

Indeed it can! Updated.

>> +static struct miscdevice opal_prd_dev = {
>> +        .minor		= MISC_DYNAMIC_MINOR,
>> +        .name		= "opal-prd",
>> +        .fops		= &opal_prd_fops,
> 
> White space is messed up here, should be leading tabs.

[tabs-spaces-both.png]

Thanks for the review, new patch coming soon.

Cheers,


Jeremy
