From: "Jason Wohlgemuth" <jsw-embedded@mindspring.com>
To: "Graham Stoney" <greyham@research.canon.com.au>,
        "Marcus Sundberg" <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Cc: "LinuxPPC Embedded Mailing List" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Bizarre initrd problem on CLLF860T
Date: Mon, 17 Apr 2000 07:02:23 -0400
Message-ID: <NCBBKJKKGDLPHKDPAFFMEEBFCEAA.jsw-embedded@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20000417084215.B8A5B3C980@elph.research.canon.com.au>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham,

Hmmm... Here are some things I would try... it may be helpful to put a debug
line in fs/namei.c, the open_namei call,  and simply print the pathname,
maybe this will show you the file which is causing the problem.  When I get
to work, I look at the the root device 00:00 and see what is different on my
builds and get back to you with more information.

Jason

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Graham
Stoney
Sent: Monday, April 17, 2000 4:42 AM
To: Marcus Sundberg
Cc: Graham Stoney; LinuxPPC Embedded Mailing List
Subject: Re: Bizarre initrd problem on CLLF860T



Marcus Sundberg writes:
> > RAMDISK: Compressed image found at block 0
> > VFS: Mounted root (ext2 filesystem)
> > VFS: Cannot open root device 00:00
> > Kernel panic: VFS: Unable to mount root fs on 00:00
>
> Looks like the initrd is sucessfully mounted, then /linuxrc is either
> executed quietly or fails to be executed. In either case the bootup
> continues, and fails to mount the real root device because it is not
> set to anything useful.

Yes, but I'm confused as to why...

> How is your bootup supposed to work? If you want to use the initrd
> as the real root file system you should pass root=/dev/ram to
> the kernel.

I'm just trying to boot to a standalone shell; I have no /linuxrc in my
initrd,
and I do want to use the initrd as the real root file system. Also, I have:

    Boot arguments: root=/dev/ram

So it looks to me as though it _should_ work; but why is it trying to
remount
device 00:00?  The ramdisk is supposed to be 01:00.

Mucho confusedo,
Graham


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
