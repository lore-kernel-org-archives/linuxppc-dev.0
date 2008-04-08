Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08272DDDF9
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 00:28:24 +1000 (EST)
Message-Id: <8C415339-5DB0-42B3-A942-17296DE68267@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1207612292.10388.494.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
Date: Tue, 8 Apr 2008 09:28:12 -0500
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
	<18425.24938.332852.315571@cargo.ozlabs.ibm.com>
	<279F1861-9605-46FD-A917-DF5B95B8C4F6@kernel.crashing.org>
	<20080407162053.GB2688@loki.buserror.net>
	<1207612292.10388.494.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2008, at 6:51 PM, Benjamin Herrenschmidt wrote:
>
> On Mon, 2008-04-07 at 11:20 -0500, Scott Wood wrote:
>>
>> Another possible use is a BAT/TLB1 mapping for SoC registers (or
>> anything
>> else on the board which is frequently accessed), which can be reused
>> by
>> ioremap() to avoid wasting normal TLB entries, and to facilitate  
>> early
>> debugging.
>
> As far as the above is concerned, I'm not too fan of fixed virtual
> addresses. I'd rather dynamically assign it. But we can do it.

I'm in agreement with Ben here.  On Freescale parts that could mean  
using up to 16M of virtual address space while in reality we may only  
need a handful of 4k pages to cover SoC registers that we are truly  
accessing at runtime.

However I think there might be some utility to have an early ioremap  
mappings for debug.

- k
