Message-ID: <3857103E.6608A366@ctam.com.au>
Date: Wed, 15 Dec 1999 14:51:27 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: Dan Malek <dan@netx4.com>
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc embedded boot problems.
References: <3856C0D7.4E1404C9@ctam.com.au> <385703C2.AA4298E7@netx4.com> <38570544.476D42C9@ctam.com.au> <385714D8.8AD74656@netx4.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Considering you are doing your own UPM, the Linux kernel will
> find lots of timing errors with it.  It enables the MMU and
> caches very early, so the bus timing will see something new
> for the first time.  I hope you are peforming the proper cache
> initialization sequence and setting all of the necessary
> processor registers in the boot rom.
>
> You can disable the caches in arch/ppc/kernel/head.S.  Try that.

I commented out (using #if0 and #endif) the bits of code that enable the
caches in arch/ppc/kernel/head.S and arch/ppc/mbxboot/head.S.  The kernel
now boots.  This indicates one or more of the following:
1) there is something I'm doing wrong which affects the cache setup.
2) Some of the code has moved in memory which makes it work.
3) I just got lucky this time.
I really hope it is number 1).

I now get the attached output.  Notice the "VFS: Mounted root (NFS
filesystem) readonly." message.  So the kernel things that the root
filesystem is mounted via NFS and it is ok with it.  But the shell never
runs.  The root filesystem is EXACTLY the same one I put into initrd and
that one seems to work.  So maybe the rootnfs stuff is not working properly
for me.  Is it the ethernet driver I ported to SCC4 ?  If it is, then how
can the root NFS filesystem be mounted.  Any clues ?

Thanks again,
Brendan Simon.


[lots of other stuff removed]
...
VFS: Mounted root (NFS filesystem) readonly.
BJS: INITRD: 1
BJS: freeing memory
Freeing unused kernel memory: 32k init
BJS: memory freed
BJS: kernel unlocked


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
