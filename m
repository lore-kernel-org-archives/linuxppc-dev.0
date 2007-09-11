Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 66C6CDDEF9
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 03:52:17 +1000 (EST)
In-Reply-To: <46E6CA63.1040703@freescale.com>
References: <20070828201618.GA24210@ld0162-tx32.am.freescale.net>
	<1E0D95DC-03E8-4BF0-9E22-69AECFA73FCF@kernel.crashing.org>
	<20070911135717.GD1932@ld0162-tx32.am.freescale.net>
	<3583FF3E-35E3-4B0A-A170-D69135E902F2@kernel.crashing.org>
	<46E6B98C.1070207@freescale.com>
	<B247D7AF-6AB9-4009-BFB8-0A365D3F0DF2@kernel.crashing.org>
	<46E6C145.2050006@freescale.com>
	<D3BBD38C-B050-4694-8B38-EF9C75DD2D8F@kernel.crashing.org>
	<46E6CA63.1040703@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2DD714D4-F20A-4F44-9E61-ECBCED65BCC7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: SOC registers/immr determination from device tree (was Re: [PATCH
	1/3] fsl_soc.c cleanup)
Date: Tue, 11 Sep 2007 12:54:58 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Yoder Stuart-B08248 <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 11, 2007, at 12:03 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Sep 11, 2007, at 11:24 AM, Scott Wood wrote:
>>> I propose we do it by defining the first (and ideally only, but  
>>> that's another argument) entry in ranges as the immr, and getting  
>>> rid of /soc/reg.
>> I disagree.
>
> I'm shocked. :-)

:)

>> I don't think we want to start overloading the meaning of  
>> something like 'ranges' in that way.
>
> As opposed to overloading the meaning of 'reg'?
>
> It's no different than how PCI ranges are treated -- we interpret,  
> in a bus-specific way, that certain ranges mean certain things.  In  
> the case of fsl immr/cssr buses, the first range would mean the  
> immr/cssr space.

In PCI its not order dependent.  Its just a PCI address.  If you want  
to propose a SOC address that encodes other information like the PCI  
address does feel free to.  However, order shouldn't be special.  Its  
too fragile.

>
>>>>> And why is 82xx-pq2 special?  Wouldn't you need this on 83xx,  
>>>>> 85xx, and 86xx as well?
>>>> The range will cover the whole immr space on 83xx/85xx/86xx.
>>> And why can't it do that on 82xx?
>> we can cover the whole range, thats fine.  We just need a different
>> mechanism to determine immr base.
>
> I'm unconvinced.
>
>>>> 82xx-pq2 is special in that its soc regs are in the middle of the
>>>>  immr address map.
>>> The /soc node is misnamed; it should really be /immr.  Why do we  
>>> need these particular registers to be in /soc/reg rather than a  
>>> subnode?
>> They could be in a sub node if there is a clear subnode for them  
>> to be in.
>
> Does anything actually use /soc/reg as anything other than an input to
> get_immrbase()?  If not, we can defer defining such nodes until  
> there's
> actually a need.

I think that's the only user for it.  Let's separate the issues.

> It'd probably be more efficient to discuss this in person; can you  
> stop
> by my cube sometime when you're around and not in a meeting?

I suggest you propose a solution to determine IMMR base w/o having  
using a specific entry in the range property and w/o introducing a  
new property.  I believe it can be done via either a new device type/ 
sub-node or regs in the soc node.  However, I don't believe you'll be  
able to come up with a solution that works for all the FSL platforms.

- k
