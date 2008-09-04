Return-Path: <gunnar@genesi-usa.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id B8DE4475FA
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:01:23 +1000 (EST)
Received: by gxk14 with SMTP id 14so6327082gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 08:01:21 -0700 (PDT)
Message-ID: <b989d750809040801x50019cf9j9741219348c9b5f7@mail.gmail.com>
Date: Thu, 4 Sep 2008 17:01:21 +0200
From: "Gunnar Von Boehn" <gunnar@genesi-usa.com>
To: "David Jander" <david.jander@protonic.nl>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
In-Reply-To: <200809041459.27606.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200808251131.02071.david.jander@protonic.nl>
	<200809041405.16489.david.jander@protonic.nl>
	<20080904121926.GA12867@yoda.jdub.homelinux.org>
	<200809041459.27606.david.jander@protonic.nl>
Cc: munroesj@us.ibm.com, John Rigby <jrigby@freescale.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	prodyut hazarika <prodyuth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

Regarding your testcase.

I think we all agree with you that improving the performance for PPC
is a noble quest
and we should all try do improve the performance where possible.


Regarding the 5200B and 5221 CPUs.


As we all know the 5200B is a G2 PowerPC from Freescale.

The factor for the memory performance of the PPC are two items:
A) This CPU has ZERO 2nd level cache
B) This CPU can remember exactly one prefetched memory line.

This means the normal memcopy routines that prefetch several cache
lines ahead DO NOT WORK!
To get good/best performance you need to prefetch EXACTLY ONE cache line ahead.

Altering the Linux Kernel or glibc memcopy routines for the G2/PPC
core to work like this is actually very simple.
Altering the Linux Kernel or glibc memcopy routines to work like
described will increase performance by 100%



Regarding the 5121.
David, you did create a very special memcopy for the 5121e CPU.
Your test showed us that the normal glibc memcopy is about 10 times
slower than expected on the 5121.

I really wonder why this is the case.
I would have expected the 5121 to perform just like the 5200B.
What we saw is that switching from READ to WRITE and back is very
costly on 5121.

There seems to be a huge difference between the 5200 and its successor the 5121.
Is this performance difference caused by the CPU or by the board /memory?

Cheers
Gunnar
