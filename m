Return-Path: <mgalassi@c-cor.com>
Received: from penguin.ncube.com (penguin.ncube.com [134.242.67.78])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 167D067BC3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Sep 2006 07:39:42 +1000 (EST)
Message-Id: <200609292139.k8TLdV10081103@penguin.ncube.com>
Subject: Re: Need help on PPC8343E bringup 
In-reply-to: <200609292133.k8TLXUUv072654@penguin.ncube.com> 
References: <198592450609291408w2dbf7e5ckf5e4cf7023d2000@mail.gmail.com>
	<200609292133.k8TLXUUv072654@penguin.ncube.com>
Date: Fri, 29 Sep 2006 14:39:31 -0700
From: Michael Galassi <mgalassi@c-cor.com>
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


>>Hello linux-ppc experts,
>>
>>I'm trying to use using wind river jtag probe to download uboot to our
>>switching box which is with PPC8343E/Intel 28F128J3D memory flash(16M).
>>Memory mapping is starting from 0xFF000000 to 0xFFFFFFFF which is 16M. The
>>JTAG software I'm using is visionclick8.
>>
>>The problem now is that I even couldn't erash flash, with following error
>>message:
>>
>>TF ERASE FFF00000..FFFFFFFF INTEL  28F128Jx ( 8192 x 16 )  1 Device
>>Erasing Flash(s) ... Failed
>>!ERROR! - [msg100000] Failed while erasing the device(s)
>>>BKM>
>>!HALT! - [msg90009] Target Stopped : CheckStop taken; PC = 0x00007404 [EVENT
>>Taken]
>>>BKM>
>>
>>Does anyone has experiece to bring up this CPU, and could shed some lights
>>on it? Thank you in advance.
>>
>>- Reeve
>
>Your flash part[s] are almost certainly write-protected, or part of them
>is.  Get the data-sheet for them and find what combination to write to
>them to un-protect them and try again.  For the parts I'm using (micron
>MT28F128J3) writing 0x00600060 followed by 0x00d000d0 to the part does
>the trick.
>
>-michael

I must be lonely, responding to my own email :-).

The other option you have is re-build u-boot to run from ram (presumably
at some lower address), then use u-boot itself to clear the write
protect bits on your flash.  U-boot's makefile has config targets for
ram & flash for some target boards which you may be able to take
advantage of.  My first solution is probably still quicker if you're not
trying to debug u-boot itself.

-michael
