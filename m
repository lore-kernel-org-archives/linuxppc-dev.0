Date: Fri, 26 May 2000 13:27:01 -0400 (EDT)
From: "Mark S. Mathews" <mark@absoval.com>
To: Dan Malek <dan@netx4.com>
cc: Jim Lewis <jlewis@mvista.com>, Steve Rossi <srossi@ccrl.mot.com>,
        Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root fs on hdd
In-Reply-To: <392EA5A6.33044861@embeddededge.com>
Message-ID: <Pine.LNX.3.96.1000526130950.308A-100000@tristar.cc.absoval.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Our process is to:

1) cpio the /opt/hardhat/.../target tree (including the .../target/opt/...
subtree) to a temporary location
2) install our specific executables and scripts into the temporary
location  (from here we can test/debug our stuff via nfsroot)
3) cpio the pieces we want from the temporary location to a pre-image
staging area
4) strip everything in the staging area that's not stripped (except
modules)
5) test the staging area for size (we're currently using a max size of
6MB)
6) losetup, create, and mount a loopback fs
7) cpio from the staging area to the loopback
8) umount and un-losetup the loopback
9) gzip the loopback file
10) cp the loopback file to linux/arch/ppc/mbxboot/ramdisk.image.gz
11) do a make zImage.initrd
12) zsrec the resulting zImage
13) load into ram on the board
14) copy from ram to flash
15) reset the board and watch the fun begin  ;-)

Works great.  One tricky part is that some of this must be done as root.
I use sudo to make it a little easier.  Note step 1, we treat the
/opt/hardhat/.../target tree as a 'pristine', working root fs.  We always
copy the contents to somewhere else before making changes.

I may be restating the obvious, but someone might find it useful.

-Mark


On Fri, 26 May 2000, Dan Malek wrote:

>
> Jim Lewis wrote:
> >
> > You need to make the following soft link in your target :
> > opt/hardhat/devkit/ppc/8xx/powerpc-linux ----> /
>
>
> Oooo.  That's even better (I guess I have been making it too difficult :-).
>
>
> 	-- Dan
>
>


Mark S. Mathews

AbsoluteValue Systems      Web:    http://www.absoval.com
P.O. Box 941149            e-mail: mark@absoval.com
Maitland, FL 32794-1149    Phone:  407.644.8582
USA                        Fax:    407.539.1294


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
