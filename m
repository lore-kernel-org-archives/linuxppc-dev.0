Return-Path: <tnt@246tNt.com>
Received: from outmx003.isp.belgacom.be (outmx003.isp.belgacom.be
	[195.238.2.100]) by ozlabs.org (Postfix) with ESMTP id 5A39167A65
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 07:56:19 +1100 (EST)
Received: from outmx003.isp.belgacom.be (localhost [127.0.0.1])
	by outmx003.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j1GKuESe023874
	for <linuxppc-embedded@ozlabs.org>; Wed, 16 Feb 2005 21:56:14 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4213B356.3060901@246tNt.com>
Date: Wed, 16 Feb 2005 21:55:50 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Matej Kupljen <matej.kupljen@ultra.si>,
	linuxppc-embedded@ozlabs.org
References: <1108547431.30212.37.camel@mbmatejdebian.ultra.si>
In-Reply-To: <1108547431.30212.37.camel@mbmatejdebian.ultra.si>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Subject: Re: bdi2000 debugging
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

>Something is overwriting memory in kernel space I guess.
>Now, I have the BDI 2000 and I am trying to debug this, but until
>now I was unsuccessful :-(
>
>When I debug the kernel, the BDI prints this out in the telnet
>interface:
>- Target MBAR is 0xF0000000
>- Target XLBA is 0x8000A366
>
>I know what MBAR is, but what the XLBA is?
>The problem is that while this value remains the same everything 
>is fine. But sometimes it is set to 0x00000000 and then I cannot
>use debugger anymore. I can make a few steps when this value 
>is set to 0x0, but the "stepping" is done in completely unrelated
>code. I first noticed this while stepping trough hc_found_ohci
>function when the return 0 is executed. When I disabled the USB
>support in my kernel I could use debugger to debug a kernel.
>But is still does not work all the time, because the XLBA still 
>gets set to 0!
>  
>
The good news : I can explain you BDI2000 problem :)
The bad news : AFAIK you can't fix it :(

There is a bug in the rev <= 1.2 of the silicon of MPC5200 : When there
is another XLB Master active (like USB or any bestcomm activity), the XLB
arbiter can get confused during debugging and you can resume nor
can you access memory or do anything ... you can just reboot.

It's VERY frustrating since the BDI2000 is then kind of useless for debug
in the cases when you need those activated ...


        Sylvain
