To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: loading the kernel and root FS separately from flash? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 28 Jun 2004 06:13:18 EDT."
             <Pine.LNX.4.60.0406280600140.3259@localhost.localdomain>
Date: Mon, 28 Jun 2004 12:41:54 +0200
Message-Id: <20040628104159.87EEDC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <Pine.LNX.4.60.0406280600140.3259@localhost.localdomain> you wrote:
>
> i suspect that leaving my root filesystem in flash would cause
> noticeable performance problems (even if i managed to structure it so

What makes you think so?

The startup behaviour may change: at the moment you  load  the  whole
root  filesystem  into  RAM before you can run anything at all - that
means it takes longer before the first  application  can  start.  But
then  everything  _is_  in  RAM, so anything else will start quickly,
too.

With a  flash  based  root  filesystem  only  the  things  (binaries,
libraries)  that  are  actually  needed  for the first user processes
(init etc.) will be loaded to RAM, so they may actually start  faster
than  from  a  RAM  disk.  But  anything  else  may  require  to load
additional libraries etc. so it may start slower than from a ramdisk.
On the other hand, some code or binaries (like error handling  stuff,
debug  tools  etc.) may not be loaded at all for normal operation, so
you will have more RAM free, which adds to speed, too.

> that it could be read-only).  how hard would it be to automatically
> have that root FS copied from JFFS2 to RAM and mounted from there?

This makes just no sense to me.

> can that be done as a kernel option i haven't seen?  or do i have to
> do that manually, involving something like "pivot_root"?  or is it
> worth the trouble?

I cannot see any advantages from such a setup.

If you want a RAM based root filesystem, use a ramdisk.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
At the source of every error which is blamed on the computer you will
find at least two human errors, including the error of blaming it  on
the computer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
