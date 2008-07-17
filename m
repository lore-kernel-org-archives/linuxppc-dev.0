Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id C3BA8DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 05:44:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 82xx performance
Date: Thu, 17 Jul 2008 21:43:56 +0200
References: <DCEAAC0833DD314AB0B58112AD99B93B04AE61BC@ismail.innsys.innovsys.com>
	<200807171747.28624.arnd@arndb.de>
	<DCEAAC0833DD314AB0B58112AD99B93B04B34D32@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B04B34D32@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807172143.57576.arnd@arndb.de>
Cc: Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 17 July 2008, Rune Torgersen wrote:
> Arnd Bergmann wrote:
> > Seeing more hits in handle_mm_fault suggests that you have
> > a higher page fault rate. A trivial reason for this might
> > be that the amount of memory was misdetected in the new
> > code (maybe broken device tree). What is the content of
> > /proc/meminfo after a fresh boot?
> Powerpc
> VmallocTotal:   474756 kB
> Ppc
> VmallocTotal:   245696 kB

This seems to be the only significant difference here, but
I don't see how it can make an impact on performance.

>         User time (seconds): 4339.11
>         User time (seconds): 4177.11

3.8% slowdown

>         System time (seconds): 319.41 
>         System time (seconds): 295.00

8.2% slowdown

>         Elapsed (wall clock) time (h:mm:ss or m:ss): 1:17:42
>         Elapsed (wall clock) time (h:mm:ss or m:ss): 1:14:35

4% slowdown

>         Minor (reclaiming a frame) page faults: 4213347
>         Minor (reclaiming a frame) page faults: 4203103

slightly more faults

>         Voluntary context switches: 53543
>         Voluntary context switches: 53812

This actually went down by 0.5%, both of these are well within
the expected 

>         Involuntary context switches: 90165
>         Involuntary context switches: 85856

4.8% more context switches, probably a side-effect of the longer
run-time.

So again, nothing conclusive. I'm running out of ideas.

	Arnd <><
