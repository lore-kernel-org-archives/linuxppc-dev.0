Message-ID: <39633DE8.EC3A6E1F@embeddededge.com>
Date: Wed, 05 Jul 2000 09:53:44 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: mark phillips <msss@ne.mediaone.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Problems with HardHat/NFS root filesystems
References: <39625545.370FE91F@ne.mediaone.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


mark phillips wrote:

> I've been working with HardHat Linux on an Embedded Planet CLLF...

> I have been able to run the mbxroot.min filesystem (both on NFS and as
> an initrd).


I'm surprised this even works.  Mixing tools and libraries is always
a challenge and seldom works.  The HHL tools and libraries are built
as a kit that works together.  The tools generate in-line floating point
and have startup functions ro glibc2.  The HHL tools, libraries and target
file system work together, and it is unlikely you will be able to mix
other pieces with any success.

The 'min' and 'full' file systems are old, glibc-1.99 version software.
The HHL tools will not build executables to work with this library.
It was a nicer library to use for embedded systems because it was smaller,
but it was simply obsolete and we couldn't maintain it.  You can strip
the libraries in the target file system to make them smaller, however
I think it removes symbols needed for linking (but programs run OK).
You can also download the glibc SRPM and remove functions you don't need,
then rebuild it with the HHL tools.


> In addition, I've noticed that if I run ldconfig on the mbxroot.min
> filesystem, it no longer boots.  Removing etc/ld.so.cache fixes the
> problem.

Don't run ldconfig......you don't need to do that, and as you have
experienced it does the wrong thing.

> ....trace ends with a bunch of queries to
> /opt/hardhat/devkit/ppc/8xx/target/opt.

You need a symbolic link in the target file system to resolve the
problem with abosulte path names of libraries in the dynamic loading.
In the /opt/hardhat/devkit/ppc/8xx/target directory on the server,
create a symbolic link opt/hardhat/devkit/ppc/8xx/powerpc-linux -> /.
This way, the target file system "sees" the same directory path that
was used when you cross compile on the host.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
