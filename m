Message-ID: <3F73300F.2050605@mvista.com>
Date: Thu, 25 Sep 2003 11:12:31 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2nd time Annc: Marvell DB64360 platform support patches available
References: <200309180953.20633.waite@skycomputers.com> <3F72531C.6060000@mvista.com> <200309250924.06627.waite@skycomputers.com>
In-Reply-To: <200309250924.06627.waite@skycomputers.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brian Waite wrote:

>Mark,
>	Thanks for responding. I will start looking into all of this soon. I'll start
>feeding updated patches to the ftp site and ask if you could take a second
>look at them when I do.
>
Certainly.

>
>Thank You for your time
>Brian
>
>On Wednesday 24 September 2003 10:29 pm, Mark A. Greer wrote:
>
<snip>

>
>
>>d) It looks like drivers/char/mv64360_mpsc.c is pretty much a clone of
>>the gt64260_mpsc.c driver.  This too, should be updated with the latest
>>changes to the 64260 one to add KGDB support.  Also, you could consider
>>removing the 'MIRROR' stuff since that was necessary in the 64260 b/c of
>>errata.  Even better, it probably wouldn't be too hard to combine the
>>two drivers (obviously, you'd have to leave the MIRROR stuff in there
>>then).  Would you consider taking a look to evaluate the work?
>>
>>
>Are you sure you were looking at the patches I posted? I thought I removed all
>the MIRROR code. I'll take anouther look.
>
Hmm, you're right.  Somehow I got messed up.  Sorry about that.

>
>I will look at merging the 64260 and 64360 drivers.
>
>
>
>>e) Since you did such a good job with the 64360 enet driver, want to do
>>the same with the 64260 driver??  ;)  (I didn't really look at your
>>driver but I'm assuming that its fine since Jeff G. gave his blessing)
>>
>>
>That is definately do-able. I want to talk more with Jeff on the 64360 driver
>first. He said he had a few other cleanup things he would like to see but it
>was good enough to go in. I'd like to clean up those bits before I replicate
>them.
>
Makes sense.

>
>
>>3) In arch/ppc/boot/simple/misc-db64360.S you still have 64260 #ifdef's
>>4) Since AFAIK the 64360 doesn't have the errata about reading the MPSC,
>>et. al. regs, you can greatly simplify the driver to not use the SDMA
>>(in arch/ppc/boot/simple/mv64360_tty.c).  A polled, PIO driver is really
>>simple for the MPSC.  There was even a patch for this posted several
>>months ago (for the 64260).  Also, you still have 64260 references in
>>there.
>>
>>
>I will clean up the 260-isms. I will also put in the polled MPSC driver.
>
Depending on how easy it is to merge the 64260 & 64360 drivers, it may
be better to just combine them & still use the SDMA method.  But if you
do keep separte drivers, it would be better to have a 64360 one that
uses PIO directly on the chip's regs.

BTW, thanks for doing all this work.  It will be nice to have the 64360
up-to-date.

Mark


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
