Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE9FADDEDE
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 01:46:30 +1100 (EST)
In-Reply-To: <20070130104630.GC14571@lst.de>
References: <Pine.LNX.4.64.0701300010550.32498@localhost.localdomain>
	<20070130104630.GC14571@lst.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8C811CD0-1FA8-43AA-8D91-0C28811D021D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: RFC: kprobes support for ppc32
Date: Tue, 30 Jan 2007 08:45:29 -0600
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	prasanna@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 30, 2007, at 4:46 AM, Christoph Hellwig wrote:

> On Tue, Jan 30, 2007 at 12:13:32AM -0600, Kumar Gala wrote:
>> +	depends on !BOOKE && KALLSYMS && EXPERIMENTAL && MODULES
>
> Just curious: what's the problem with BOOKE?

Book-e's debug handling/architecture is significantly different than  
most other PPCs.  I'll look at adding support for it in the future.

>> +#ifdef CONFIG_PPC64
>>   	regs->nip = (unsigned long)(((func_descr_t *)jp->entry)->entry);
>>   	regs->gpr[2] = (unsigned long)(((func_descr_t *)jp->entry)->toc);
>> +#else
>> +	regs->nip = (unsigned long)jp->entry;
>> +#endif
>
> This should probably be split int a macro.

Seems like a bit of a waste, for 6 lines of code.  I'm not exactly  
sure what you're envisioning here.

> also I think you should not define kprobe_lookup_name for the 32bit
> case as the generic version should be fine for ppc32

Ok, I'll look into that.

- k
