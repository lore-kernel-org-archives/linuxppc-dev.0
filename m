Return-Path: <chris.friesen@genband.com>
Received: from exprod7og113.obsmtp.com (exprod7og113.obsmtp.com [64.18.2.179])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C91802C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 15:54:32 +1100 (EST)
Message-ID: <515E58E6.9030802@genband.com>
Date: Thu, 04 Apr 2013 22:53:58 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: powerpc userspace address space layout information
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

I'm running with glibc 2.11 on a 2.6.34 kernel.  32-bit userspace on 64-bit kernel.

On a complicated process the memory map looks something like this:

<vdso, executable, heap, etc.>
5b2c000-f5b38000 r-xp 00000000 00:0f 3636                               /lib/libnss_files-2.11.1.so
<lots of libraries snipped>
f6026000-f6035000 ---p 00096000 00:0f 3628                               /lib/libkrb5.so.3.3
<lots of libraries snipped>
f7902000-f7905000 r-xp 00000000 00:0f 3607                               /lib/libdl-2.11.1.so
f7905000-f7914000 ---p 00003000 00:0f 3607                               /lib/libdl-2.11.1.so
f7914000-f7915000 r--p 00002000 00:0f 3607                               /lib/libdl-2.11.1.so
f7915000-f7916000 rw-p 00003000 00:0f 3607                               /lib/libdl-2.11.1.so
f7918000-f7919000 rw-p 00000000 00:00 0
f7919000-f791a000 r--p 0001a000 00:0f 3646                               /lib/libpthread-2.11.1.so
f791a000-f791b000 r--p 00001000 00:0f 2306001                            /path/to/binary
f791b000-f791c000 r--p 00001000 00:0f 2306001                            /path/to/binary
f791c000-f791d000 r--p 00001000 00:0f 2306001                            /path/to/binary
f791d000-f7923000 rw-p 00000000 00:00 0
f7923000-f7943000 r-xp 00000000 00:0f 13323                              /lib/ld-2.11.1.so
f7943000-f7944000 r--p 00020000 00:0f 13323                              /lib/ld-2.11.1.so
f7944000-f7945000 rw-p 00021000 00:0f 13323                              /lib/ld-2.11.1.so
f9000000-fac01000 rw-p 00000000 00:00 0
fac06000-fac07000 rw-s 00000000 00:04 327690                             /SYSV41050355 (deleted)
fad00000-fae00000 rw-s 00000000 00:04 98307                              /SYSVee113d3f (deleted)
fae00000-fb000000 rw-s 00000000 00:04 7503872                            /SYSVc5050355 (deleted)
fb000000-fb200000 rw-s 00000000 00:04 7536641                            /SYSV5c050355 (deleted)
fb200000-fb600000 rw-s 00000000 00:0d 30647                              /var/log/blah
ffa8e000-ffab0000 rwxp 00000000 00:00 0                                  [stack]


I have a few questions I'm hoping someone can help me with.

First, what determines where /lib/ld-2.11.1.so gets mapped? It seems like
it never goes above 0xf8000000 or so.

Second, what is the mapping at 0xf9000000-0xfac01000?  Is this just empty
space or is it reserved for something in particular?

Third, what's the most reliable way to ensure a block of addresses around
0xf6000000 don't get used for shared libraries?  (We want to preserve
those addresses for emulating hardware in a virtual machine.)  We have
this working on an older system but after upgrading to new software the
libraries now extend further down the address space.

Any help is greatly appreciated.

Chris


-- 

Chris Friesen
Software Designer

500 Palladium Drive, Suite 2100
Ottawa, Ontario K2N 1C2, Canada
www.genband.com
office:+1.343.883.2717
chris.friesen@genband.com
