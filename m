To: greyham@research.canon.com.au (Graham Stoney)
Cc: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Subject: Re: Bizarre initrd problem on CLLF860T
References: <20000417070226.92BE33C961@elph.research.canon.com.au>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 17 Apr 2000 10:23:56 +0200
In-Reply-To: greyham@research.canon.com.au's message of "Mon, 17 Apr 2000 17:02:26 +1000 (EST)"
Message-ID: <kfyvh1hp23n.fsf@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


greyham@research.canon.com.au (Graham Stoney) writes:

> Hi there,
>
> I'm wondering if anyone could please give me a pointer on the following
> problem I'm having: A couple of months ago when I last tried booting one of
> our CLLF860T boards with an initrd, it all worked fine -- no drama. Figuring
> that this hurdle was conquered, I haven't tried again until today, as we're
> happily NFS mounting the root filesystem for development.
>
> Today though, I can't for the life of me work out why the initrd stuff isn't
> working. The log messages tell me that it's trying to mount the root filesystem
> *twice*, and the second attempt fails with a panic. I've been banging my head
> against this all afternoon to no avail; any suggestions?
>
> I'm using Dan's 2.2.13-derived kernel; here are the boot messages:

[snip]

> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem)
> VFS: Cannot open root device 00:00
> Kernel panic: VFS: Unable to mount root fs on 00:00

Looks like the initrd is sucessfully mounted, then /linuxrc is either
executed quietly or fails to be executed. In either case the bootup
continues, and fails to mount the real root device because it is not
set to anything useful.

How is your bootup supposed to work? If you want to use the initrd
as the real root file system you should pass root=/dev/ram to
the kernel.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
