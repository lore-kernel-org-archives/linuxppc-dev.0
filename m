Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id E7952DDF6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 23:00:54 +1100 (EST)
Received: by ewy13 with SMTP id 13so759897ewy.9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Dec 2008 04:00:52 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
To: monstr@seznam.cz
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net> <493D2B22.4000601@seznam.cz>
	<493ED4B6.7010605@dlasys.net> <493F89F2.60702@seznam.cz>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 10 Dec 2008 13:00:08 +0100
In-Reply-To: <493F89F2.60702@seznam.cz> (Michal Simek's message of "Wed\,
	10 Dec 2008 10\:20\:50 +0100")
Message-ID: <87iqpsme9j.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dhlii@dlasys.net, linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "Michal" == Michal Simek <monstr@seznam.cz> writes:

Hi,

 Michal> You should try to swap mailbox and addr address.

 Michal> /* HPI registers */
 Michal> #define HPI_DATA	0
 Michal> #define HPI_MAILBOX	2
 Michal> #define HPI_ADDR	1
 Michal> #define HPI_STATUS	3

Why? Have you swapped your A0 / A1?

 Michal> Peter:

 Michal> What does it mean when I am getting TIMEOUT when kernel is
 Michal> trying to assign address to device?

 Michal> Here is the correspond log part. usb_control_msg 5 means
 Michal> address assigning. And there is timeout description. Star
 Michal> means interrupt occur.

 Michal> *usb_control_msg 5, -115
 Michal> hub_set_address 4 ffffff8d
 Michal> hub_set_address 8 ffffff8d
 Michal> +-------------retval ffffff8d ---------------+
 Michal> OK*... 0x14 ......*---c67x00_td_to_error---
 Michal> *timeout
 Michal> --------------------------------------1-----------
 Michal> *<6>c67x00 c67x00.0: ### TIMEOUT at 0x0500

I'm not quite following here - Is that the
wait_for_completion_timeout() in c67x00-sched.c?

USB questions are probably better asked on the
linux-usb@vger.kernel.org list.

 Michal> Don't you have your testing version for any kernel before
 Michal> 2.6.23? There were some change in usb subsystem.

There's some older patches at
http://peter.korsgaard.com/patches/linux, but why are you using such
an ancient kernel?

-- 
Bye, Peter Korsgaard
