Subject: RE: No L2 Cache on PReP Machine
From: Adrian Cox <adrian@humboldt.co.uk>
To: "Hager, Johannes, HRD/AB" <johannes.hager@eads.com>
Cc: "PPC Linux Mailing List (E-Mail)" <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <2D9AB865A49FD511914700105A0EF679016C49C2@morse.smart.lfk.eads.net>
References: 
	 <2D9AB865A49FD511914700105A0EF679016C49C2@morse.smart.lfk.eads.net>
Content-Type: text/plain
Message-Id: <1092908669.10314.81.camel@localhost>
Mime-Version: 1.0
Date: Thu, 19 Aug 2004 10:44:29 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 2004-08-19 at 10:04, Hager, Johannes, HRD/AB wrote:
> I have a test program on VxWorks which takes about 110 ms for execution on
> the MVME3604 with enable L2 cache
> I ported this application to a RTAI module and did the test on linux and it
> took about 420ms
> So i disabled the L2 cache in VxWorks and did the test again and then it
> took with VxWorks about 417ms.
> After this and because of the content from /proc/cpuinfo I decided that the
> L2 cache is not used.

That's very convincing.

If you have the source of your VxWorks BSP it may be worth looking for
code where VxWorks enables the L2 cache. You'll need to add a MVME3604
specific patch to your kernel to turn the cache on. I've just looked at
prep_setup.c, and there are already lots of board specific L2 handling
routines, but none for MVME3604.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
