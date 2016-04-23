Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qsQtT6QgFzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 18:40:49 +1000 (AEST)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 23 Apr 2016 13:30:18 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9B0952BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 13:29:55 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3N3TirV6095156
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 13:29:55 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3N3TJwM016947
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 13:29:20 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 55/68] powerpc/mm: VMALLOC abstraction
In-Reply-To: <1461307925.32306.46.camel@neuling.org>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-56-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461307925.32306.46.camel@neuling.org>
Date: Sat, 23 Apr 2016 08:59:01 +0530
Message-ID: <87h9etypdu.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> writes:

> Aneesh,
>
> I'm not sure why we need this patch.
>
> It seems to be moving the initialisation of some global variables into
> init functions from the definitions.  And renames some things.


because the value to which it is getting initialized is no more a
constant.

>
>> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
>> index 41503d7d53a1..3759df52bd67 100644
>> --- a/arch/powerpc/kernel/pci_64.c
>> +++ b/arch/powerpc/kernel/pci_64.c
>> @@ -38,7 +38,7 @@
>>   * ISA drivers use hard coded offsets.  If no ISA bus exists nothing
>>   * is mapped on the first 64K of IO space
>>   */
>> -unsigned long pci_io_base = ISA_IO_BASE;
>> +unsigned long pci_io_base;
>>  EXPORT_SYMBOL(pci_io_base);
>>  
>>  static int __init pcibios_init(void)
>> @@ -47,6 +47,7 @@ static int __init pcibios_init(void)
>>  
>>  	printk(KERN_INFO "PCI: Probing PCI hardware\n");
>>  
>> +	pci_io_base = ISA_IO_BASE;
>
> Did you mean to change this in this patch?  This seems to be a random
> change in pci code.
>

ISA_IO_BASE is not a constant now.

-aneesh
