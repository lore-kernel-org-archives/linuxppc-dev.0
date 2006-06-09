Return-Path: <scott.coulter@cyclone.com>
Received: from CYBORG3.cyclone.com (unknown [69.37.28.78])
	by ozlabs.org (Postfix) with ESMTP id 33F2167C2C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 10 Jun 2006 05:32:50 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: help with inittab
Date: Fri, 9 Jun 2006 15:19:03 -0400
Message-ID: <43EB80E07C42E1408726E4905FB96B0466C6BF@CYBORG3.cyclone.com>
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

Does your serial output stop after "Freeing unused kernel memory..."

If it does, you may have an interrupt problem with the UART.  I had to
track down that very problem the other day.  As a test, even if my UART
interrupt was purposely misconfigured, I still saw all of the output up
to and including "Freeing unused kernel memory..."

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
From: linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+scott.coulter=3Dcyclone.com@ozlabs.org]=

On Behalf Of Chris Dumoulin
Sent: Friday, June 09, 2006 3:15 PM
To: Steve Iribarne (GMail)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: help with inittab

The init is from Busybox. Since I'm getting output from my serial port=20
during the kernel boot process, I think it's safe to say that my=20
/dev/ttyS0 is properly configured. Besides passing the kernel argument=20
console=3DttyS0,57600, is there anything else I need to do to properly=20
configure the console? I've looked through my kernel configuration to=20
make sure that any serial device or console related stuff was enabled=20
and configured.

I'm feeling pretty stumped.

- Chris

Steve Iribarne (GMail) wrote:

> On 6/9/06, Chris Dumoulin <cdumoulin@ics-ltd.com> wrote:
>
>> I've now determined that my kernel seems to stop in the following
line
>> of code, in the function init(void * unused), in init/main.c:
>> run_init_process("/sbin/init");
>
>
> Who's init are  you using??
>
> Are you using Busyboxes or sysinit from GNU?
>
>
>> I've determined that it stops at this call by stepping through the
code
>> with a BDI2000.
>>
>> My boot arguments are:
>> console=3DttyS0,57600n8 ip=3Doff root=3D/dev/ram0 rw
>>
>> My current inittab is:
>> ::sysinit:/etc/rc.sh
>> ::ctrlaltdel:/sbin/reboot
>> ::shutdown:/sbin/swapoff -a
>> ::shutdown:/bin/umount -a -r
>> ::restart:/sbin/init
>> ::respawn:/bin/sh
>>
>> I've tried adding an "echo" command to the /etc/rc.sh script that is
>> called, but I don't see any output. I've also trying changing the
>> ::sysinit line in inittab to point to some non-existent script, to
see
>> if I'll get some error message, but I still see nothing. Is it
possible
>> that /sbin/init is dying before it gets to the point of reading
inittab?
>> Any ideas?
>>
>> Regards,
>> Chris Dumoulin
>>
>>
>> Wolfgang Denk wrote:
>>
>> >In message <44888B92.40409@ics-ltd.com> you wrote:
>> >
>> >
>> >>I am using the linux kernel 2.6.15 and initrd ramdisk image from
ELDK
>> >>4.0. Currently, I seem to be able to boot without errors, but after

>> the
>> >>root filesystem is mounted, things just stop.
>> >>
>> >>
>> >
>> >And  what's  your  console  device?  Are  you  passing  any
console=3D
>> >arguments  on  the  command  line?  Is the corresponding device
entry
>> >present in the /dev/directory?
>> >
>> >Best regards,
>> >
>> >Wolfgang Denk
>> >
>> >
>> >
>>
>> --=20
>> *--Christopher Dumoulin--*
>> Software Team Leader
>>
>> <http://ics-ltd.com/>
>> <http://ics-ltd.com/>
>>
>> Interactive Circuits and Systems Ltd.
>> 5430 Canotek Road
>> Ottawa, ON
>> K1J 9G2
>> (613)749-9241
>> 1-800-267-9794 (USA only)
>>
>>
------------------------------------------------------------------------
>> This e-mail is private and confidential and is for the addressee
only.
>> If misdirected, please notify us by telephone and confirm that it has
>> been deleted from your system and any hard copies destroyed. You are
>> strictly prohibited from using, printing, distributing or
disseminating
>> it or any information contained in it save to the intended recipient.
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
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
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
