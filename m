To: "=?utf-8?B?amVmZnk=?=" <leo_guo@jisung.cn>
Cc: "=?utf-8?B?bGludXhwcGMtZW1iZWRkZWRAbGlzdHMubGludXhwcGM=?=" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: =?utf-8?B?UmU6IFJlOiB3aGljaCBpcyB0aGUgYmVzdCByb290IEZpbGUgc3lzdGVtIGluIGVtYmVkIGxpbnV4IHN5c3RlbT8=?= 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Apr 2004 16:44:34 +0800."
             <20040422085859.C6134424CD@denx.de>
Date: Thu, 22 Apr 2004 11:39:50 +0200
Message-Id: <20040422093955.1D74BC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040422085859.C6134424CD@denx.de> you wrote:
>
> Because our board will be turned on and off frequently, so I think "high stability" is the important, and a R/W file system is prefer selection too!
> Another  performances such as speed of booting is not the focus!

How about speed when accessing (especially reading) files? What about
memory footprint?

> Now our system can runs ok, I use EXT2 FS as the root file system build in a 32M DOC2000, but it seems it's unstable!

You asked adbout a filesystem for flash before - this is NOT the same
as DOC or  even  CompacfFlash,  as  these  devices  use  an  internal
controller  which  may  perfom certain operations like wear levelling
etc. So what do you want  to  know  -  filesystems  for  plain  flash
memory, or for DOC?

The ext2 filesystem is extremley well tested and can be considered to
be very stable. Howebver, it was not designed to  be  used  like  you
attempt  to  do - i. e. just powering off the device. You must always
unmount an ext2 filesystem  (or  at  least  remount  it  read-only_)_
before shutting doen the system.

> In any time when the linux is starting, you turn off the power, maybe the root file system will crash!

Yes, this is the logical consequence of your mis-use.

> I have serval questions want to be confirmed:
> 1. Whether the DOC2000 is unstable?

NO. It is working perfectly fine in many applications.

> 2. Can I build a EXT2 FS in flash?

Yes, you can. Both in flash memory and on a DOC device. BUt you  have
to  be aware of the restrictions (i. e. ext2 requires to be unmounted
before shutdown, and it does not implement any wear  levelling  which
may be useful on writable flash filesystems).

> 3. How to avoid the file system crash in embed linux system?

Don't do things which  are  outside  of  the  specifications  of  the
software.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I like your game but we have to change the rules."

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
