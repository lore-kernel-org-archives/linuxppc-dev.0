Return-Path: <fweimer@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yT7cl10KxzDrD1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Nov 2017 04:05:25 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org, linux-mm <linux-mm@kvack.org>
From: Florian Weimer <fweimer@redhat.com>
Subject: POWER: Unexpected fault when writing to brk-allocated memory
Message-ID: <f251fc3e-c657-ebe8-acc8-f55ab4caa667@redhat.com>
Date: Fri, 3 Nov 2017 18:05:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are seeing an issue on ppc64le and ppc64 (and perhaps on some arm 
variant, but I have not seen it on our own builders) where running 
localedef as part of the glibc build crashes with a segmentation fault.

Kernel version is 4.13.9 (Fedora 26 variant).

I have only seen this with an explicit loader invocation, like this:

while I18NPATH=. /lib64/ld64.so.1 /usr/bin/localedef 
--alias-file=../intl/locale.alias --no-archive -i locales/nl_AW -c -f 
charmaps/UTF-8 
--prefix=/builddir/build/BUILDROOT/glibc-2.26-16.fc27.ppc64 nl_AW ; do : 
; done

To be run in the localedata subdirectory of a glibc *source* tree, after 
a build.  You may have to create the 
/builddir/build/BUILDROOT/glibc-2.26-16.fc27.ppc64/usr/lib/locale 
directory.  I have only reproduced this inside a Fedora 27 chroot on a 
Fedora 26 host, but there it does not matter if you run the old (chroot) 
or newly built binary.

I filed this as a glibc bug for tracking:

   https://sourceware.org/bugzilla/show_bug.cgi?id=22390

There's an strace log and a coredump from the crash.

I think the data shows that the address in question should be writable.

The crossed 0x0000800000000000 binary is very suggestive.  I think that 
based on the operation of glibc's malloc, this write would be the first 
time this happens during the lifetime of the process.

Does that ring any bells?  Is there anything I can do to provide more 
data?  The host is an LPAR with a stock Fedora 26 kernel, so I can use 
any diagnostics tool which is provided by Fedora.

I can try to come up with a better reproducer, but that appears to be 
difficult.

Thanks,
Florian
