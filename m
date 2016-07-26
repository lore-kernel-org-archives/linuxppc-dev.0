Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz0LZ3s84zDqZv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 11:06:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powernv/pci: Add PHB register dump debugfs handle
In-Reply-To: <5796522D.9040601@linux.vnet.ibm.com>
References: <20160722052336.3340-1-ruscur@russell.cc>
 <20160722063655.GA28438@gwshan> <5796522D.9040601@linux.vnet.ibm.com>
Date: Tue, 26 Jul 2016 11:06:11 +1000
Message-ID: <87y44pryws.fsf@concordia.ellerman.id.au>
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

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:

> On 07/21/2016 11:36 PM, Gavin Shan wrote:
>> On Fri, Jul 22, 2016 at 03:23:36PM +1000, Russell Currey wrote:
>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> index 891fc4a..ada2f3c 100644
>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> @@ -3018,6 +3018,38 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
>>> 	}
>>> }
>>>
>>> +#ifdef CONFIG_DEBUG_FS
>>> +static ssize_t pnv_pci_debug_write(struct file *filp,
>>> +				   const char __user *user_buf,
>>> +				   size_t count, loff_t *ppos)
>>> +{
>>> +	struct pci_controller *hose = filp->private_data;
>>> +	struct pnv_phb *phb;
>>> +	int ret = 0;
>> 
>> Needn't initialize @ret in advance. The code might be simpler, but it's
>> only a personal preference:
>
> I believe its actually preferred that it not be initialized in advance
> so that the tooling can warn you about conditional code paths where you
> may have forgotten to set a value.

Yeah that's right, it's preferable not to initialise it.

It helps for complex if/else/switch cases, where you might accidentally
have a path where you return without giving ret the right value.

The other case is when someone modifies your code. For example if you
have:

	int ret;

        if (foo)
                ret = do_foo();
        else
                ret = 1;

        return ret;

And then you add a case to the if:

        if (foo)
                ret = do_foo();
        else if (bar)
        	do_bar();
        else
                ret = 1;

The compiler will warn you that in the bar case you forget to initialise
ret. Whereas if you initialised ret at the start then the compiler can't
help you.

There are times when it's cleaner to initialise the value at the start,
eg. if you have many error cases and only one success case. But that
should be a deliberate choice.

cheers
