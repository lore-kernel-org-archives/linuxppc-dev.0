To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 28 Jun 2004 06:19:36 EDT."
             <Pine.LNX.4.60.0406280615400.3259@localhost.localdomain>
Date: Mon, 28 Jun 2004 12:48:17 +0200
Message-Id: <20040628104822.6C3BFC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0406280615400.3259@localhost.localdomain> you wrote:
>
> it was more the response time from flash as opposed to RAM that was an
> issue for me.  that's why i was asking about having the root FS loaded
> from flash into RAM at boot time.  we'd probably be happy about
> sacrificing boot time response (copying all of the root FS into RAM)
> for better run time performance, although i don't know the differences
> in performance at the moment.

Where is your ramdisk image coming from? Being loaded from flash?

So what's the difference between loading the image as a whole  before
startup,  or  loading the files step by step when needed? If you need
everything in your ramdisk the  difference  in  time  is  very  small
(except  from  measurable changes in the start-up sequence, wher eyou
can have the first code running actually faster from  a  flash  based
filesystem);  if  you don't use all the stuff in your ramdisk all the
time than the flash based filesystem may be faster, too.

We got the fastest boot and run times using a  read-only  ext2  file-
system in a MTD partition.

And using an overlay mounto to a JFFS2 partition you can still update
the files. [Or, for  occasional  updates,  you  can  remount  rw  the
filesystem,  perform  the  updates,  and  remount  ro again - an ext2
filesystem on a flash partition is obviously not optimal, but if  you
just  need  to  change  2  files  every year or so it will still work
fine.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"An open mind has but one disadvantage: it collects dirt."
                                                    - a saying at RPI

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
