Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 99E56DDE04
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Mar 2007 03:44:08 +1100 (EST)
In-Reply-To: <BE8D549F-71E4-43DE-B624-A8E4A50D094D@embeddedalley.com>
References: <45E46976.6060600@freescale.com>	<29c13109971547687159078eacdea008@kernel.crashing.org>	<45E592DC.9060700@freescale.com>	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>	<BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>	<45E5B604.904@freescale.com>
	<46F6BF70-2922-4E05-8DAB-6B0830B0AB47@embeddedalley.com>
	<45E5BD6B.1010509@freescale.com>
	<F2D0230C-CA22-4DEF-917E-6982FA0C6171@embeddedalley.com>
	<45E5C128.7020204@freescale.com> <45E5C333.2060100@zytor.com>
	<ED6BD6F0-827F-4ADC-9D66-F9C3DD7FC470@embeddedalley.com>
	<E919B903-0890-4725-81CF-005003A1A2F6@kernel.crashing.org>
	<45E5D627.6030707@zytor.com> <45E5D84A.5000502@freescale.com>
	<278AADB6-E175-4177-A728-5357E21697B7@kernel.crashing.org>
	<45E5DB49.8010205@freescale.com>
	<A6EED9FC-4CE4-4089-ACB8-A1C7A3C50FDD@embeddedalley.com>
	<a2fc3b0b25c4ad798b63b03763256a2f@kernel.crashing.org>
	<BE8D549F-71E4-43DE-B624-A8E4A50D094D@embeddedalley.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7a96cdcde345a4e75fb451cecd32501f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
Date: Thu, 1 Mar 2007 17:43:57 +0100
To: Dan Malek <dan@embeddedalley.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Torben.Mathiasen@hp.com,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>> - Cap the driver at 4 UARTs;
>
> Let's do this, but design the code to
> allow more by just changing a #define.
>
>> Just randomly using some extra minors that aren't
>> assigned to you isn't such a great idea.
>
> Maybe for a desktop or generic server where
> you don't know what's going to be configured,
> but it's not unusual to do so with custom
> embedded systems.

You can do whatever you want in your own stuff
but that's not how things work in the mainstream
Linux kernel.

> The small experimental
> or user allocations often don't cover what
> is needed, so we just grab some allocation
> from a device that isn't ever going to be
> used on the system.

Sure I've done that myself a few times, but this
just doesn't fly for in-kernel drivers; those have
their own ranges defined in devices.txt and don't
use random other minors.


Segher
