Message-Id: <200212071104.FAA32694@lists.linuxppc.org>
To: "Pagnotta, Chris" <chris.pagnotta@viasat.com>
Subject: Re: NFS root woes: No init found 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Dec 2002 17:36:27 PST."
             <0509218DDAD7D6118055006008F6D5F6A1E39A@postal.viasat.com>
Date: Sat, 07 Dec 2002 12:02:07 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0509218DDAD7D6118055006008F6D5F6A1E39A@postal.viasat.com> you wrote:
>
> I am having a problem with NFS mounting the root filesystem. It seems that
> init
> is not being executed. However, the problem may be with rootpath not being
> set.
> Should that parameter be set from the kernel command nfsroot=?

What are you talking about?

> Kernel command line: root=/dev/nfs nfsroot=/tftpboot/powerpc-rootfs
> ip=172.25.59
> .11:172.25.59.15::255.255.0.0:vib::off

Your rootpath _is_ set here: you're using "/tftpboot/powerpc-rootfs"
as root directory.

...
> Looking up port of RPC 100003/2 on 172.25.59.15
> Looking up port of RPC 100005/1 on 172.25.59.15
> VFS: Mounted root (nfs filesystem).

And the root filesystem was found and mounted.

> Mounted devfs on /dev
> Freeing unused kernel memory: 212k init
> Kernel panic: No init found.  Try passing init= option to kernel.

Are you sure you NEED devfs here? For now I recommend to disable this
option, as it adds just additional complexity. To anlyze what's going
on with your  NFS  root  filesystem,  run  a  network  sniffer  (like
ethereal) and check wich accesses work, and which are failing.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Imagination is more important than knowledge.      -- Albert Einstein

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
