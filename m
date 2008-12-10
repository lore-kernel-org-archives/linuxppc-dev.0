Return-Path: <monstr@seznam.cz>
Received: from smtp.seznam.cz (smtp.seznam.cz [77.75.72.43])
	by ozlabs.org (Postfix) with ESMTP id 4A45CDDF76
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Dec 2008 01:36:39 +1100 (EST)
Message-ID: <493FD3EC.3060305@seznam.cz>
Date: Wed, 10 Dec 2008 15:36:28 +0100
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net>
	<493D2B22.4000601@seznam.cz>	<493ED4B6.7010605@dlasys.net>
	<493F89F2.60702@seznam.cz> <87iqpsme9j.fsf@macbook.be.48ers.dk>
In-Reply-To: <87iqpsme9j.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: dhlii@dlasys.net, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: monstr@seznam.cz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

>>>>>> "Michal" == Michal Simek <monstr@seznam.cz> writes:
> 
> Hi,
> 
>  Michal> You should try to swap mailbox and addr address.
> 
>  Michal> /* HPI registers */
>  Michal> #define HPI_DATA	0
>  Michal> #define HPI_MAILBOX	2
>  Michal> #define HPI_ADDR	1
>  Michal> #define HPI_STATUS	3
> 
> Why? Have you swapped your A0 / A1?

I found that ml40x designs have different connection that ml505 usb design. This
is no problem for me. But I think that in David case is that problem.

We used 2.6.20 kernel because we have this kernel well tested.
I found where the problem was.

Thanks for your driver and help,
Michal


> 
>  Michal> Peter:
> 
>  Michal> What does it mean when I am getting TIMEOUT when kernel is
>  Michal> trying to assign address to device?
> 
>  Michal> Here is the correspond log part. usb_control_msg 5 means
>  Michal> address assigning. And there is timeout description. Star
>  Michal> means interrupt occur.
> 
>  Michal> *usb_control_msg 5, -115
>  Michal> hub_set_address 4 ffffff8d
>  Michal> hub_set_address 8 ffffff8d
>  Michal> +-------------retval ffffff8d ---------------+
>  Michal> OK*... 0x14 ......*---c67x00_td_to_error---
>  Michal> *timeout
>  Michal> --------------------------------------1-----------
>  Michal> *<6>c67x00 c67x00.0: ### TIMEOUT at 0x0500
> 
> I'm not quite following here - Is that the
> wait_for_completion_timeout() in c67x00-sched.c?



> 
> USB questions are probably better asked on the
> linux-usb@vger.kernel.org list.
> 
>  Michal> Don't you have your testing version for any kernel before
>  Michal> 2.6.23? There were some change in usb subsystem.
> 
> There's some older patches at
> http://peter.korsgaard.com/patches/linux, but why are you using such
> an ancient kernel?
> 
