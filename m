Return-Path: <jean.nicollerat@microdev.ch>
Received: from srv.brk07.com (srv.brk07.com [213.221.157.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25FDC67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 20:26:45 +1100 (EST)
From: "Jean Nicollerat MD" <jean.nicollerat@microdev.ch>
To: <wd@denx.de>
Date: Thu, 17 Mar 2005 10:27:07 +0100
Message-ID: <HMECJAKDCPLOGPDHNAHEAEKHCAAA.jean.nicollerat@microdev.ch>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20050317083415.4BCD5C1510@atlas.denx.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
Subject: RE: RTC with TQM823L 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for your answer.
I'm used to program on processor without OS. I want try linux to use linux
to have have LCD, ethernet, USB, ... , dirvers.
I have to read message that comme on the CAN bus every 2ms. Then I have to
show values on the LCD and transfers some message on the RS232.
I need a timer to the check the reception of the messages.
I seem it is difficult with linux. I will try with the RTAI.

regards
Jean Nicollerat

regards
-----Original Message-----
From: wd@denx.de [mailto:wd@denx.de]
Sent: Thursday, March 17, 2005 9:34 AM
To: Jean Nicollerat MD
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RTC with TQM823L


In message <HMECJAKDCPLOGPDHNAHECEKFCAAA.jean.nicollerat@microdev.ch> you
wrote:
>
> I need to have an interrup every 10ms in my application running in linux.

This is  an  oxymoron.  Interrups  are  processed  in  kernel  space,
applications  are running in userspace. You cannot process interrupts
in aplication code.

> I try to use the RTC modules but with the code :
>
> 	fd = open ("/dev/rtc", O_RDONLY);
>
> 	if (fd ==  -1) {
> 		perror("/dev/rtc");
> 	}
> 	/* Turn on update interrupts (one per second) */

You mentioned you wanted signals (not interrupts) every 10  millisec,
not every second -- what exactly is it that you want?

> 	retval = ioctl(fd, RTC_UIE_ON, 0);
...
>   ioctl : invalide argument # for then line :"retval = ioctl(fd,
RTC_UIE_ON,
> 0);"

Which means that the driver does not support this ioctl.

> Can somebody help ? why it is not working or a better way to get function
> called each 10ms

You can use setitimer. But be  warned.  Your  requirement  of  having
signals  every  10 milliseconds means that there is a serious problem
with your software design. You  are  doing  someting  really,  really
wrong.  To  me  it  sounds  as if you try to implement your own timer
based control loop in user space with an insane  smapp  period.  This
will  never  work  reliably (as there is no guarantee that your tasks
will be scheduled in time), and will waste a lot of CPU power.

Never take existing software  designs  from  other  operating  system
environments  and  put them without thinking into a Unix environment.
Often there are much better and more efficient approaches in Unix.


Just in case you really must stick with that 10  millisecond  raster:
in  this  case  you  will  probably have to use RTAI (especially on a
resource-limted CPU like the 823).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The trouble with our times is that the future is not what it used  to
be.                                                     - Paul Valery
