Message-ID: <392EA50C.281D52ED@embeddededge.com>
Date: Fri, 26 May 2000 12:23:40 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Steve Rossi <srossi@ccrl.mot.com>
CC: Embedded Linux PPC List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: root fs on hdd
References: <392E92E3.62847D28@ccrl.mot.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve Rossi wrote:

> I've copied the the /bin, /dev, /etc, /lib, /libexec, /sbin, and /share
> directories from the monta vista sdk to the root direectory of my ext2
> partition (/dev/sda2) using "cp -a" while the root partition was


Several problems here.  You can't "cp" the /dev directory.  Use 'tar'
or 'cpio'.

The MontaVista CDK is built to operate in the /opt/hardhat/..... directory
tree.  You have to preserve this directory structure to the target
file system as used by NFS because these paths are part of the
library search.  Copy the /opt/hardhat/...../target tree to your
system, then make symbolic links from /bin, /etc, /lib and so on into
the /opt/hardhat/..../target subdirectory.  All of this (and much more)
is described in the documentation if you care to read it.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
