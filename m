Message-ID: <3B3A1328.6000602@mvista.com>
Date: Wed, 27 Jun 2001 10:08:56 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Michael Habermann <MHabermann@gmx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Segmentation fault while dynamic linking
References: <3B39524B.5090108@mvista.com> <32197.993642129@www29.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Michael Habermann wrote:

>>>>>My configuration: Kernel 2.4.4, glibc 2.2.2, bash 2.05, FADS, MPC855T
>>>>>
> ...
>
>>>binutils 2.11.2
>>>gcc 2.95.3
>>>glibc 2.2.2
>>>
>>>Everything unpatched and downloaded from ftp.gnu.org.
>>>
>>

>>From what I read in the mailing list, I would also say it looks like this
> problem.
>
> I've recompiled my toolchain now with plain gnu software and the following
> patches
> from ftp.mvista.com and glibc-src package:
> glibc22-27.patch               glibc22-getaddrinfo.dpatch
> glibc22-disable-static.dpatch  glibc22-nss-upgrade.dpatch
> glibc22-eo_EO.dpatch           glibcbug.dpatch
>
> But the problem is still there.
>
> I couldn't find 'the cacheline patch'. Is it the one mentioned here:
> http://lists.linuxppc.org/listarcs/linuxppc-embedded/200003/msg00073.html
>


There are two places cacheline size affects glibc.  The one above that
you already found and in the glibc ppc optimized memset or memcpy (don't
remember which one).  you can just delete the ppc specific memset and
configure will pull in the generic memset.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
