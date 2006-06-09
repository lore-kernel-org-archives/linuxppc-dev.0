Return-Path: <cdumoulin@ics-ltd.com>
Received: from mx6-6.spamtrap.magma.ca (mx6-6.spamtrap.magma.ca
	[209.217.78.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7E9A367A2E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Jun 2006 02:14:53 +1000 (EST)
Message-ID: <44899E7C.7080903@ics-ltd.com>
Date: Fri, 09 Jun 2006 12:14:52 -0400
From: Chris Dumoulin <cdumoulin@ics-ltd.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: help with inittab
References: <20060608214239.A71EE35265D@atlas.denx.de>
In-Reply-To: <20060608214239.A71EE35265D@atlas.denx.de>
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

I've now determined that my kernel seems to stop in the following line 
of code, in the function init(void * unused), in init/main.c:
run_init_process("/sbin/init");
I've determined that it stops at this call by stepping through the code 
with a BDI2000.

My boot arguments are:
console=ttyS0,57600n8 ip=off root=/dev/ram0 rw

My current inittab is:
::sysinit:/etc/rc.sh
::ctrlaltdel:/sbin/reboot
::shutdown:/sbin/swapoff -a
::shutdown:/bin/umount -a -r
::restart:/sbin/init
::respawn:/bin/sh

I've tried adding an "echo" command to the /etc/rc.sh script that is 
called, but I don't see any output. I've also trying changing the 
::sysinit line in inittab to point to some non-existent script, to see 
if I'll get some error message, but I still see nothing. Is it possible 
that /sbin/init is dying before it gets to the point of reading inittab?
Any ideas?

Regards,
Chris Dumoulin


Wolfgang Denk wrote:

>In message <44888B92.40409@ics-ltd.com> you wrote:
>  
>
>>I am using the linux kernel 2.6.15 and initrd ramdisk image from ELDK 
>>4.0. Currently, I seem to be able to boot without errors, but after the 
>>root filesystem is mounted, things just stop.
>>    
>>
>
>And  what's  your  console  device?  Are  you  passing  any  console=
>arguments  on  the  command  line?  Is the corresponding device entry
>present in the /dev/directory?
>
>Best regards,
>
>Wolfgang Denk
>
>  
>

-- 
*--Christopher Dumoulin--*
Software Team Leader

<http://ics-ltd.com/>
<http://ics-ltd.com/>

Interactive Circuits and Systems Ltd.
5430 Canotek Road
Ottawa, ON
K1J 9G2
(613)749-9241
1-800-267-9794 (USA only)

------------------------------------------------------------------------
This e-mail is private and confidential and is for the addressee only. 
If misdirected, please notify us by telephone and confirm that it has 
been deleted from your system and any hard copies destroyed. You are 
strictly prohibited from using, printing, distributing or disseminating 
it or any information contained in it save to the intended recipient.
