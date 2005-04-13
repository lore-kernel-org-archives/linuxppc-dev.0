Return-Path: <kylo@kylo.net>
Received: from cia.veriwave.com (mail.veriwave.com [198.107.59.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 45E5867A67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 05:29:28 +1000 (EST)
Message-ID: <425D6C03.1070805@kylo.net>
Date: Wed, 13 Apr 2005 11:59:15 -0700
From: Kylo Ginsberg <kylo@kylo.net>
MIME-Version: 1.0
To: Fahd Abidi <fabidi@ultsol.com>
References: <81C69D96BDD30640952C7A404004AA25018DB9@ultsol01.tewks.ultsol.local>
In-Reply-To: <81C69D96BDD30640952C7A404004AA25018DB9@ultsol01.tewks.ultsol.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: bdi2000 + mpc8560ads, very early breakpoints
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks; that was instructive.  I hadn't read up on the 85xx debug 
exceptions yet.

For posterity, my issue was that even though the code is running out of 
ddr at this stage, u-boot has left the IVPR pointed at flash.  So once 
head_e500.S invalidated the tlb entry for the flash region, the debug 
exception vector was inaccessible and a breakpoint sent the processor 
off the road.  As a workaround, I modified u-boot to re-point IVPR when 
it relocates itself into ddr.

Cheers,
Kylo

Fahd Abidi wrote:

>Try the suggestions pointed out in here:
>
>http://www.ultsol.com/faq-P308.htm
>
>This is based off suggestions from another customer. Let me know if this
>works for you or not.
>
>Fahd
>
>-----Original Message-----
>From: Kylo Ginsberg [mailto:kylo@veriwave.com] 
>Sent: Tuesday, April 12, 2005 3:21 PM
>To: linuxppc-embedded@ozlabs.org
>Subject: bdi2000 + mpc8560ads, very early breakpoints
>
>I'm running a bdi2000 (with mpc85xx-gdb f/w 1.03) with a mpc8560ads 
>target, and I'm trying to set breakpoints early on in linux startup (in 
>the head_e500.S code that sets up tlb's).   I'm setting the breakpoints 
>from within the bdi telnet interface.
>
>I can:
>--succesfully hit a breakpoint set up to any instruction <= the address 
>of the first 'tlbwe'.
>--single step (with the bdi "TI" command) past that 'tlbwe' as far as 
>I've cared to try
>
>I cannot:
>--hit a breakpoint once the first 'tlbwe' has executed.  If I attempt to
>
>do so, linux startup doesn't proceed, I lose further communication with 
>the target and the BDI claims "COP Freeze" and I have to reset the
>target.
>
>Btw, the 'tlbwe' in question marks invalid the first tlb1 entry setup by
>
>u-boot, which pointed at flash address space.  Code is running out of 
>ram at this point.
>
>I'm probably missing something very basic here.  Any ideas?
>
>Thanks,
>Kylo
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>  
>
