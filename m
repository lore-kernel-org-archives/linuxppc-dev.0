Message-ID: <3CE949D5.AC5C5A9@ixiacom.com>
Date: Mon, 20 May 2002 12:09:09 -0700
From: Dan Kegel <dkegel@ixiacom.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: When did ppc405 support stabilize?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I'm trying to track down a khttpd problem.
khttpd was solid in Hard Hat Linux 2.0 on ppc405,
it's stable on the x86 (at least after my recent patch),
and it's (mostly) stable on the imac running plain old 2.4.18.
However, it seems to have serious problems on ppc405
with 2.4.17 and on from linuxppc_2_4_devel.

I'd like to try older linuxppc_2_4_devel kernels
until I find where the problem started.
I guess I'll have to work my way backwards, since I don't know
when ppc405 support stabilized in that tree.

How far back should I expect to be able to go?

BTW, here's the cheesy script I'm using to fetch old kernel versions;
I'm relying on the v2.4.xx tags.

#!/bin/sh

if [ -z $1 ]; then
        echo "Usage: `basename $0` <tag> e.g v2.4.18"
        exit 1
fi

bk clone -r$1 bk://ppc.bkserver.net/linuxppc_2_4_devel
linuxppc_2_4_devel-$1
cd linuxppc_2_4_devel-$1
find -type d -exec bk get {} \;
find -name SCCS -exec rm -rf {} \;
rm -rf RESYNC/
rm -rf PENDING/
rm -rf BitKeeper/
rm ChangeSet
cd ..
mv linuxppc_2_4_devel-$1 linux
tar zcvf linux-$1-ppc_2_4_devel.tar.gz linux

Thanks,
Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
