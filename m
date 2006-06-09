Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (unknown [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 012B267C5F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Jun 2006 05:55:20 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: help with inittab
Date: Fri, 9 Jun 2006 15:53:39 -0400
Message-ID: <43EB80E07C42E1408726E4905FB96B0466C6C5@CYBORG3.cyclone.com>
From: "Scott Coulter" <scott.coulter@cyclone.com>
To: "Chris Dumoulin" <cdumoulin@ics-ltd.com>
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

Chris,

I was getting linux 2.6.15 running an MPC8560 board with an external
UART.  In my board specific code that was setting up the Programmable
Interrupt Controller (openpic), I had a problem with a loop index and
the external interrupts were not getting setup correctly, but the
internal interrupts were...

Once I fixed the loop, there was output from the init process...

What type of board are you running on?  Do you have the UART interrupt
configured correctly (interrupt level high or low, interrupt input
definition, etc.)?


Scott





___________________________________________________________________

  Scott N. Coulter
  Senior Software Engineer
 =20
  Cyclone Microsystems         =20
  370 James Street              Phone:  203.786.5536 ext. 118
  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
  U.S.A.                        Web:    http://www.cyclone.com
___________________________________________________________________

-----Original Message-----
From: Chris Dumoulin [mailto:cdumoulin@ics-ltd.com]=20
Sent: Friday, June 09, 2006 3:50 PM
To: Scott Coulter
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: help with inittab

Hi Scott,
That is where my output stops. What was the cause of your interrupt=20
problem? Were you able to fix it?

- Chris

Scott Coulter wrote:

>Chris,
>
>Does your serial output stop after "Freeing unused kernel memory..."
>
>If it does, you may have an interrupt problem with the UART.  I had to
>track down that very problem the other day.  As a test, even if my UART
>interrupt was purposely misconfigured, I still saw all of the output up
>to and including "Freeing unused kernel memory..."
>
>Scott
>
>
>
>
>___________________________________________________________________
>
>  Scott N. Coulter
>  Senior Software Engineer
> =20
>  Cyclone Microsystems         =20
>  370 James Street              Phone:  203.786.5536 ext. 118
>  New Haven, CT 06513-3051      Email:  scott.coulter@cyclone.com
>  U.S.A.                        Web:    http://www.cyclone.com
>___________________________________________________________________
>
>-----Original Message-----
>From: linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org
>[mailto:linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org=
]
>On Behalf Of Chris Dumoulin
>Sent: Friday, June 09, 2006 3:15 PM
>To: Steve Iribarne (GMail)
>Cc: linuxppc-embedded@ozlabs.org
>Subject: Re: help with inittab
>
>The init is from Busybox. Since I'm getting output from my serial port=20
>during the kernel boot process, I think it's safe to say that my=20
>/dev/ttyS0 is properly configured. Besides passing the kernel argument=20
>console=3DttyS0,57600, is there anything else I need to do to properly=20
>configure the console? I've looked through my kernel configuration to=20
>make sure that any serial device or console related stuff was enabled=20
>and configured.
>
>I'm feeling pretty stumped.
>
>- Chris
>
>Steve Iribarne (GMail) wrote:
>
> =20
>
>>On 6/9/06, Chris Dumoulin <cdumoulin@ics-ltd.com> wrote:
>>
>>   =20
>>
>>>I've now determined that my kernel seems to stop in the following
>>>     =20
>>>
>line
> =20
>
>>>of code, in the function init(void * unused), in init/main.c:
>>>run_init_process("/sbin/init");
>>>     =20
>>>
>>Who's init are  you using??
>>
>>Are you using Busyboxes or sysinit from GNU?
>>
>>
>>   =20
>>
>>>I've determined that it stops at this call by stepping through the
>>>     =20
>>>
>code
> =20
>
>>>with a BDI2000.
>>>
>>>My boot arguments are:
>>>console=3DttyS0,57600n8 ip=3Doff root=3D/dev/ram0 rw
>>>
>>>My current inittab is:
>>>::sysinit:/etc/rc.sh
>>>::ctrlaltdel:/sbin/reboot
>>>::shutdown:/sbin/swapoff -a
>>>::shutdown:/bin/umount -a -r
>>>::restart:/sbin/init
>>>::respawn:/bin/sh
>>>
>>>I've tried adding an "echo" command to the /etc/rc.sh script that is
>>>called, but I don't see any output. I've also trying changing the
>>>::sysinit line in inittab to point to some non-existent script, to
>>>     =20
>>>
>see
> =20
>
>>>if I'll get some error message, but I still see nothing. Is it
>>>     =20
>>>
>possible
> =20
>
>>>that /sbin/init is dying before it gets to the point of reading
>>>     =20
>>>
>inittab?
> =20
>
>>>Any ideas?
>>>
>>>Regards,
>>>Chris Dumoulin
>>>
>>>
>>>Wolfgang Denk wrote:
>>>
>>>     =20
>>>
>>>>In message <44888B92.40409@ics-ltd.com> you wrote:
>>>>
>>>>
>>>>       =20
>>>>
>>>>>I am using the linux kernel 2.6.15 and initrd ramdisk image from
>>>>>         =20
>>>>>
>ELDK
> =20
>
>>>>>4.0. Currently, I seem to be able to boot without errors, but after
>>>>>         =20
>>>>>
>
> =20
>
>>>the
>>>     =20
>>>
>>>>>root filesystem is mounted, things just stop.
>>>>>
>>>>>
>>>>>         =20
>>>>>
>>>>And  what's  your  console  device?  Are  you  passing  any
>>>>       =20
>>>>
>console=3D
> =20
>
>>>>arguments  on  the  command  line?  Is the corresponding device
>>>>       =20
>>>>
>entry
> =20
>
>>>>present in the /dev/directory?
>>>>
>>>>Best regards,
>>>>
>>>>Wolfgang Denk
>>>>
>>>>
>>>>
>>>>       =20
>>>>
>>>--=20
>>>*--Christopher Dumoulin--*
>>>Software Team Leader
>>>
>>><http://ics-ltd.com/>
>>><http://ics-ltd.com/>
>>>
>>>Interactive Circuits and Systems Ltd.
>>>5430 Canotek Road
>>>Ottawa, ON
>>>K1J 9G2
>>>(613)749-9241
>>>1-800-267-9794 (USA only)
>>>
>>>
>>>     =20
>>>
>-----------------------------------------------------------------------
-
> =20
>
>>>This e-mail is private and confidential and is for the addressee
>>>     =20
>>>
>only.
> =20
>
>>>If misdirected, please notify us by telephone and confirm that it has
>>>been deleted from your system and any hard copies destroyed. You are
>>>strictly prohibited from using, printing, distributing or
>>>     =20
>>>
>disseminating
> =20
>
>>>it or any information contained in it save to the intended recipient.
>>>_______________________________________________
>>>Linuxppc-embedded mailing list
>>>Linuxppc-embedded@ozlabs.org
>>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
>>>     =20
>>>
>
>
> =20
>


--=20
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
This e-mail is private and confidential and is for the addressee only.=20
If misdirected, please notify us by telephone and confirm that it has=20
been deleted from your system and any hard copies destroyed. You are=20
strictly prohibited from using, printing, distributing or disseminating=20
it or any information contained in it save to the intended recipient.
