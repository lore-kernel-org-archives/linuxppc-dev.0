Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE35367A6C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 04:14:40 +1100 (EST)
In-Reply-To: <dvuj1k$318$1@sea.gmane.org>
References: <dvsds7$ta0$1@sea.gmane.org>
	<E895715F-A853-4A27-8076-90A1973273E2@kernel.crashing.org>
	<dvuj1k$318$1@sea.gmane.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <97C7473A-C585-41F9-BC48-D59F32FF2654@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: swizzling pci irqs
Date: Thu, 23 Mar 2006 11:15:32 -0600
To: David Updegraff <dave@cray.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 23, 2006, at 10:40 AM, David Updegraff wrote:

> Kumar Gala wrote:
>> On Mar 22, 2006, at 2:59 PM, David Updegraff wrote:
>>
>>
>>> Hi.
>>>
>>> If there were a noswizzle option to the kernel command line that
>>> resulted in pci scan simply trusting that the bootrom/u-boot had
>>> already
>>> correctly assigned the PCI irqs....  every tom,dick,harry, and
>>> yours-truly wouldn't have to make a new platform to define the
>>> swizzle-o-the-day.  Or have I already missed this argument?
>>
>>
>> Sure, I do this now.  Just don't build pci_auto into your pci support
>> and don't explicitly rescan in your pci setup.  The 83xx pci code
>> under arch/powerpc should effective do this.
>>
>> - kumar
>
> Hmm; I must be missing something...  cuz to me it looks like pci_32.c
> will allways call pcibios_init, which will will scan the bus, which  
> will
> swizzle irqs if the platform has non-null swizzle and map_irq function
> pointers defined..  Perhaps a setting I've missed somewhere re.
> 'pci_auto', which I thought was a 'ppc' thing, not a 'powerpc'  
> thing..??

Ahh, why do you have swizzle and map_irq functions?  I guess I forgot  
that part.  In my setup I have u-boot do all IRQ assignment (via PCI  
IRQ line register) as well as all BAR config.  I just leave swizzle  
and map_irq null.

- kumar
