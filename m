Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc13.comcast.net (unknown [63.240.77.83])
	by ozlabs.org (Postfix) with ESMTP id 6BFB367B23
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Jun 2006 12:02:20 +1000 (EST)
Message-ID: <448CCB1A.409@dlasys.net>
Date: Sun, 11 Jun 2006 22:02:02 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
Subject: Re: help with inittab
References: <43EB80E07C42E1408726E4905FB96B0466C6BF@CYBORG3.cyclone.com>
In-Reply-To: <43EB80E07C42E1408726E4905FB96B0466C6BF@CYBORG3.cyclone.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Dumoulin <cdumoulin@ics-ltd.com>, linuxppc-embedded@ozlabs.org
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

   
    For debugging or single user purposes you do not need to run init or
have an inittab.
    There have been several sugestions that there may be a hardware
problem - there are a number that are possible.

    I was stalled here for some time because my UartDriver was
accidentally using the physical IO address instead of the virtual one
    and I had created a temporary phys=virtual entry in the tbl that was
conveniently getting blow away just here.

    You can try to isolate your problem by changing your boot ramdisk
(inramfs or initrd)

    Eliminate or rename /init /sbin/init /linuxrc and any of the other
permutations that linux tries to execute in init/main.c they are all
listed very near where you stopped.
    make sure you have /bin/sh

    reboot on that ramdisk  if you have an "init" related problem then
you should get a standalone shell.
    If you have a hardware problem you will likely still stop at the
same place.
   




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
