Mime-Version: 1.0
Message-Id: <v04220805b566c4368f40@[206.6.156.5]>
In-Reply-To: 
 <Pine.LNX.4.05.10006090924480.2302-100000@callisto.of.borg>
References: 
 <Pine.LNX.4.05.10006090924480.2302-100000@callisto.of.borg>
Date: Fri, 9 Jun 2000 12:03:17 -0400
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: compiling new imsttfb?
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  > Is there any easy way to modify this properly? My intuition is
>  > telling me that this new imsttfb is so different it won't compile
>  > under any circumstances with the linux source I have, regardless of
>  > my question above. Is there a better version I can try?
>
>The new one uses PCI probing only, which is good. I suggest removing all
>references to imsttfb from drivers/video/offb.c.

OK, I did this (2 places) and now the new imsttfb.c compiles fine
into the kernel. However, using the video=imsttfb BootX argument
appears to do nothing. IOW, when starting X, the FBDev messages
indicate that there is no IMS acceleration available, and it runs
unaccelerated, as if I had checked "no video driver". A quick test of
the kernel with the old imsttfb compiled in and the identical BootX
args shows FBDev recognizing and starting acceleration, but with the
old results (unuseably fractured graphics).

I'm sorta in over my head here, but can still take directions well
:-) Any additional comments?


Stefan Jeglinski


(original message):

>  > I was browsing comp.os.linux.powerpc and saw mention of a new
>  > imsttfb.c that I nabbed off <http://fortyoz.org/~ror/linux/>.
>  >
>  > For grins I thought I'd try compiling this new imsttfb.c (dated
>  > 22-May) in with the 2.2.15 linux-pmac-stable (rsynced about 2 weeks
>  > ago).
>  >
>  > But, the new imsttfb.c is substantially different than the one
>  > included with the rsynced version. In particular, the entire
>  > imsttfb_of_init function is excised, and this causes the compile to
>  > fail:
>  >
>  > offb.o(.text.init+0x47c): undefined reference to `imsttfb_of_init'
>  > offb.o(.text.init+0x47c): relocation truncated to fit: R_PPC_REL24
>  > imsttfb_of_init
>  > make: *** [vmlinux] Error 1
>  >


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
