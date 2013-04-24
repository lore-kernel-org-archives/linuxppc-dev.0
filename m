Return-Path: <Ian.Campbell@citrix.com>
Received: from SMTP.EU.CITRIX.COM (smtp.eu.citrix.com [46.33.159.39])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "Cisco Appliance Demo Certificate",
 Issuer "Cisco Appliance Demo Certificate" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FD152C011E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 21:02:16 +1000 (EST)
Message-ID: <1366800525.20256.266.camel@zakaz.uk.xensource.com>
Subject: [RFC] device-tree.git automatic sync from linux.git
From: Ian Campbell <Ian.Campbell@citrix.com>
To: <linux-kernel@vger.kernel.org>
Date: Wed, 24 Apr 2013 11:48:45 +0100
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linux-mips@linux-mips.org, linux-c6x-dev@linux-c6x.org,
 linux-xtensa@linux-xtensa.org, microblaze-uclinux@itee.uq.edu.au,
 x86@kernel.org, linux@lists.openrisc.net, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

First off apologies for the large CC list -- I think this catches the
arch list for all the arches with device tree source in the tree.

Various folks have expressed an interest in eventually splitting the
device tree bindings out of the Linux git repository into a separate
tree. This should help reduce the cross talk between the code and the
bindings and to make it difficult to accidentally "co-evolve" the
bindings and the code (i.e. break compatibility) etc. There are also
other projects (such as Xen) which would also like to use device-tree as
an OS agnostic description of the hardware.

I was talking to Grant about this at this Spring's LinaroConnect in Hong
Kong and as a first step he was interested in a device-tree.git
repository which is automatically kept insync with the main Linux tree.
Somehow I found myself volunteering to set up that tree.

An RFC repository can be found at:
        http://xenbits.xen.org/gitweb/?p=people/ianc/device-tree-rebasing.git

This is created using git filter-branch and retains the full history for
the device tree source files up to v3.9-rc8.

The master branch contains everything including the required build
infrastructure while upstream/master and upstream/dts contain the most
recently converted upstream master branch and the pristine converted
version respectively. Each upstream tag T is paired with a tag T-dts
which is the converted version of that tag.

Note that the tree will be potentially rebasing (hence the name) for the
time being while I'm still smoothing out the conversion process.

The paths to include in the conversion are described in
scripts/rewrite-paths.sed. The generic cases are:
        arch/ARCH/boot/dts/*.dts and *.dts? (for dtsi and dtsp etc)
	arch/ARCH/boot/*.dts and *.dts?
        arch/ARCH/include/dts/* (currently unused?)
which become src/ARCH/*.dts and *.dts? plus src/ARCH/include/*

There are also some special cases for some arches which don't follow
this pattern and for older versions of the kernel which were less
consistent. The paths were gleaned from git ls-tree + grep on every tag
in the tree, so if a file was added and moved between two rcs then the
original path may not be covered (so the move will look like it just
adds the files).

In principal this supports the new .dtsp files and includes the required
include paths in the conversion but none of them seem to be in mainline
yet, so we'll have to see!

The initial conversion took in excess of 40 hours (running out of a
ramdisk) so even if the result is stable in terms of commit ids etc a
fresh conversion every time isn't an option for a ~daily sync so I had
to create a slightly hacked around git-filter-branch (found in
scripts/git-filter-branch) to support incremental filtering, which I
intend to send to the git folks soon. 

Please let me know what you think.

Ian.

[0] real    2533m32.142s
    user    2393m35.039s
    sys     343m44.385s
