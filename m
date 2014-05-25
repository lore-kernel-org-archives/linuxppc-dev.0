Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [IPv6:2a03:3680:0:3::67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65B481A05C3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 May 2014 11:42:13 +1000 (EST)
Date: Sat, 24 May 2014 18:42:05 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: fs/hfsplus/xattr.c: comparison of distinct pointer types lacks a cast
Message-ID: <alpine.DEB.2.19.4.1405241829250.7552@trent.utfs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fsdevel@vger.kernel.org, geert@linux-m68k.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

while compiling 3.15-rc6 for powerpc (gcc-4.8.1 crosscompiling on x86_64), 
this happens:

---------------------------------------------------------------
  CC [M]  fs/hfsplus/xattr_user.o
  CC [M]  fs/hfsplus/xattr_security.o
  CC [M]  fs/hfsplus/xattr.o
  CC [M]  fs/hfsplus/xattr_trusted.o
In file included from 
/usr/local/src/linux-git/arch/powerpc/include/asm/div64.h:1:0,
                 from /usr/local/src/linux-git/include/linux/kernel.h:124,
                 from /usr/local/src/linux-git/include/asm-generic/bug.h:13,
                 from /usr/local/src/linux-git/arch/powerpc/include/asm/bug.h:127,
                 from /usr/local/src/linux-git/include/linux/bug.h:4,
                 from /usr/local/src/linux-git/include/linux/thread_info.h:11,
                 from /usr/local/src/linux-git/include/asm-generic/preempt.h:4,
                 from arch/powerpc/include/generated/asm/preempt.h:1,
                 from /usr/local/src/linux-git/include/linux/preempt.h:18,
                 from /usr/local/src/linux-git/include/linux/spinlock.h:50,
                 from /usr/local/src/linux-git/include/linux/wait.h:8,
                 from /usr/local/src/linux-git/include/linux/fs.h:6,
                 from /usr/local/src/linux-git/fs/hfsplus/hfsplus_fs.h:19,
                 from /usr/local/src/linux-git/fs/hfsplus/xattr.c:9:
/usr/local/src/linux-git/fs/hfsplus/xattr.c: In function 
'hfsplus_init_header_node':
/usr/local/src/linux-git/include/asm-generic/div64.h:43:28: warning: 
comparison of distinct pointer types lacks a cast [enabled by default]
  (void)(((typeof((n)) *)0) == ((uint64_t *)0)); \
                            ^
/usr/local/src/linux-git/fs/hfsplus/xattr.c:86:2: note: in expansion of 
macro 'do_div'
  do_div(tmp, node_size);
  ^
  LD [M]  fs/hfsplus/hfsplus.o
---------------------------------------------------------------

I don't fully understand the issue here, but xattr.c:86 reads:

           do_div(tmp, node_size);

Now, "git log -S do_div --source fs/hfsplus/xattr.c" brought up the 
following commit from Geert, introducing do_div() to xattr.c

  commit a99b7069aab8fc3fb4f26d15795dc280b52e38b1 HEAD
  Author: Geert Uytterhoeven <geert@linux-m68k.org>
  Date:   Thu Nov 14 14:32:18 2013 -0800
  hfsplus: Fix undefined __divdi3 in hfsplus_init_header_node()

Reverting this commit makes the warning above go away, but I doubt this 
would be the correct solution here :-)

Note: the warning has been reported[0] by Geert for v3.13-rc7 back in 
January 2014 already.

Thanks,
Christian.

[0] https://lkml.org/lkml/2014/1/6/107
-- 
BOFH excuse #133:

It's not plugged in.
