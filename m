Return-Path: <raj@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id C4E90DDE4A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jul 2007 03:06:31 +1000 (EST)
Message-ID: <46A0E6E7.3050309@semihalf.com>
Date: Fri, 20 Jul 2007 18:46:31 +0200
From: Rafal Jaworowski <raj@semihalf.com>
MIME-Version: 1.0
To: lokowich <lokowich@acdstar.com>
Subject: Re: SDRAM failures on MPC5200B
References: <46A0D76E.4030101@acdstar.com>
In-Reply-To: <46A0D76E.4030101@acdstar.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

lokowich wrote:
> We're working on bringing up a MPC5200B version of our original MPC5200 
> board using U-Boot 1.1.4 configured for Icecube/Lite5200B.  Other than 
> the CPU, the board is identical.  The bootloader crashes just after 
> relocation to RAM, often with a Program Check Exception, typically a 
> memory corruption issue.  I noticed failures at different stages after 
> relocation based on content, suggesting problems with upper SDRAM.  If I 
> force the initram to 1/2 the determined size (64MB instead of 128MB), 
> then everything works well through kernel load and initialization.  
> We've added termination resistors to improve AD signals, to no avail.  
> Memory tests work fine too.  Any help is appreciated.
> 

Assuming your RAM chips are fine, are you setting the SDelay register 
(MBAR + 0x0190)? If not, this can lead to a strange hangs similar to the 
described. For details please see the current U-Boot's initdram() for 
icecube, and AN3221.

Rafal
