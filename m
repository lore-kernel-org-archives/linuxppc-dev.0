Return-Path: <j.borkhuis@dutchspace.nl>
Received: from kirk.dutchspace.nl (kirk.dutchspace.nl [193.200.147.14])
	by ozlabs.org (Postfix) with ESMTP id EC590DE88B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Apr 2008 00:57:45 +1000 (EST)
Message-ID: <4808AED4.7020507@dutchspace.nl>
Date: Fri, 18 Apr 2008 16:23:16 +0200
From: Johan Borkhuis <j.borkhuis@dutchspace.nl>
MIME-Version: 1.0
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
Subject: Re: pci issue - wrong detection of pci ressources
References: <48088F02.2060806@linux.vnet.ibm.com>
In-Reply-To: <48088F02.2060806@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Christian,

Christian Ehrhardt wrote:
> Hi,
> I tried to use a radeon r200 based graphic card on a sequoia ppc 
> (440epx) board. I wondered about the initialization of radeonfb that 
> failed with
>     __ioremap(): phys addr 0x0 is RAM lr c029cf80
>     radeonfb (0000:00:0a.0): cannot map MMIO
>     radeonfb: probe of 0000:00:0a.0 failed with error -5
>
> I trigger a check in ioremap, because the address it wants to remap is 
> 0x0 which can never work. The reason of that is that the pci ressource 
> of that graphic card is not properly detected.
>
> With some help I found two kernels - one that work and one that has 
> this issue.
> Unfortunately they are very different:
>   good => 2.6.24.2 from the linux-2.6-denx - built for arch=ppc
>   bad => we have 2.6.25-rc9 (used in our kvm ppc project atm) - build 
> for arch=powerpc
> I tried building the 2.6.25-rc9 with arch=ppc, but that one does not 
> boot so far. Because of that I can't surely tell you if it is only 
> that difference that breaks the pci detection.
> We need arch=powerpc for our kvm code anyway, so I hope there is 
> another solution than to switch to arch=ppc ;-)

I came across a similar problem, which (ultimately) was caused by a lack 
of memory reserved for PCI. I moved from 2.6.14(ppc) to 2.6.20(powerpc), 
and suddenly some cards stopped working: the BAR registers were not 
initialized, so it was not possible to access the cards.
Have a look at the boot-time messages, especially the early messages, as 
the PCI subsystem is started very early in the boot process. You could 
also try switching on PCI-debugging, and have a look at the debug 
messages, or add some extra debugging info to the pci-initialization code.

Kind regards,
    Johan
