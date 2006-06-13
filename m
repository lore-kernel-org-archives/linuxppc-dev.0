Return-Path: <Chetan.S.Anantharaman@motorola.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 1FF7D67B35
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 02:26:33 +1000 (EST)
Received: from il06exr01.mot.com (il06exr01.mot.com [129.188.137.131])
	by motgate8.mot.com (8.12.11/Motgate7) with ESMTP id k5DGQNqE007138
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Jun 2006 09:26:28 -0700 (MST)
Received: from de01exm68.ds.mot.com (de01exm68.am.mot.com [10.176.8.24])
	by il06exr01.mot.com (8.13.5/8.13.0) with ESMTP id k5DGQM6f021530
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Jun 2006 11:26:22 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Re: help with inittab
Date: Tue, 13 Jun 2006 12:26:22 -0400
Message-ID: <EDF27F298D4B03498AE0C249A941DFF803D70E@de01exm68.ds.mot.com>
In-Reply-To: <mailman.9.1150164003.18626.linuxppc-embedded@ozlabs.org>
From: "Anantharaman Chetan-W16155" <Chetan.S.Anantharaman@motorola.com>
To: <dhlii@dlasys.net>
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

I've tried what you've mentioned below, i.e removing the /sbin/init and
just having the /bin/sh in the init/main.c file and I don't get a
standalone shell. I am having a Linux 2.4 Kernel (Montavista 3.1)
running on a PPC405 in a Xilinx Virtex4 FX100 FPGA.

You mentioned it could be a hardware problem. Are there any errata which
could explain the h/w bug?=20


Thanks,
Chetan Anantharaman

----------------------------------------------------------------------

Message: 1
Date: Sun, 11 Jun 2006 22:02:02 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: help with inittab
Cc: Chris Dumoulin <cdumoulin@ics-ltd.com>,
	linuxppc-embedded@ozlabs.org
Message-ID: <448CCB1A.409@dlasys.net>
Content-Type: text/plain; charset=3DISO-8859-1

  =20
    For debugging or single user purposes you do not need to run init or
have an inittab.
    There have been several sugestions that there may be a hardware
problem - there are a number that are possible.

    I was stalled here for some time because my UartDriver was
accidentally using the physical IO address instead of the virtual one
    and I had created a temporary phys=3Dvirtual entry in the tbl that =
was
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
  =20




--=20
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.

"Any intelligent fool can make things bigger and more complex... It
takes a touch of genius - and a lot of courage to move in the opposite
direction."
Albert Einstein
