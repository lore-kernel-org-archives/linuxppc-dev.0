Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ED38E67A01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Mar 2006 03:40:56 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FMSra-0003Hn-1F
	for linuxppc-embedded@ozlabs.org; Thu, 23 Mar 2006 17:40:42 +0100
Received: from mail.toimi.com ([208.45.127.50])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 23 Mar 2006 17:40:42 +0100
Received: from dave by mail.toimi.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Thu, 23 Mar 2006 17:40:42 +0100
To: linuxppc-embedded@ozlabs.org
From: David Updegraff <dave@cray.com>
Subject: Re: swizzling pci irqs
Date: Thu, 23 Mar 2006 10:40:19 -0600
Message-ID: <dvuj1k$318$1@sea.gmane.org>
References: <dvsds7$ta0$1@sea.gmane.org>
	<E895715F-A853-4A27-8076-90A1973273E2@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <E895715F-A853-4A27-8076-90A1973273E2@kernel.crashing.org>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Mar 22, 2006, at 2:59 PM, David Updegraff wrote:
> 
> 
>>Hi.
>>
>>If there were a noswizzle option to the kernel command line that
>>resulted in pci scan simply trusting that the bootrom/u-boot had  
>>already
>>correctly assigned the PCI irqs....  every tom,dick,harry, and
>>yours-truly wouldn't have to make a new platform to define the
>>swizzle-o-the-day.  Or have I already missed this argument?
> 
> 
> Sure, I do this now.  Just don't build pci_auto into your pci support  
> and don't explicitly rescan in your pci setup.  The 83xx pci code  
> under arch/powerpc should effective do this.
> 
> - kumar

Hmm; I must be missing something...  cuz to me it looks like pci_32.c
will allways call pcibios_init, which will will scan the bus, which will
swizzle irqs if the platform has non-null swizzle and map_irq function
pointers defined..  Perhaps a setting I've missed somewhere re.
'pci_auto', which I thought was a 'ppc' thing, not a 'powerpc' thing..??

-dbu.
