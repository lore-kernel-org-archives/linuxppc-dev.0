Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BEFFEDDEFF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 07:36:21 +1000 (EST)
Message-Id: <F14C6B55-9B7E-4DEE-BB9C-6CF94365F8B4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080407162053.GB2688@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [RFC][PATCH] initial port of fixmap over from x86 for ppc32
Date: Mon, 7 Apr 2008 16:36:05 -0500
References: <Pine.LNX.4.64.0804030144460.15974@blarg.am.freescale.net>
	<18425.24938.332852.315571@cargo.ozlabs.ibm.com>
	<279F1861-9605-46FD-A917-DF5B95B8C4F6@kernel.crashing.org>
	<20080407162053.GB2688@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2008, at 11:20 AM, Scott Wood wrote:
> On Mon, Apr 07, 2008 at 08:09:57AM -0500, Kumar Gala wrote:
>> On Apr 6, 2008, at 6:48 PM, Paul Mackerras wrote:
>>> More generally, I think we need to take an overall look at what  
>>> things
>>> we are using fixed virtual addresses for, and why they need to be
>>> fixed.  If there are indeed several such things then we can  
>>> introduce
>>> the fixmap stuff.
>>
>> The list as I see it:
>> * kmap
>> * pci-e config for 4xx/83xx
>> * kexec/kdump (ben commented on this when Dale posted his patches for
>> ppc32 support)
>>
>> future:
>> * possible usage by HV
>>
>> since we already have three users and a possible fourth it seems  
>> like a
>> useful change.
>
> Another possible use is a BAT/TLB1 mapping for SoC registers (or  
> anything
> else on the board which is frequently accessed), which can be reused  
> by
> ioremap() to avoid wasting normal TLB entries, and to facilitate early
> debugging.

x86 has an early ioremap() that is implemented on top of their fixmap  
usage that we could also steal if desired :)

- k
