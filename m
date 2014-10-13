Return-Path: <ydroneaud@opteya.com>
From: Yann Droneaud <ydroneaud@opteya.com>
To: Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 linux-ia64@vger.kernel.org, Jeremy Kerr <jk@ozlabs.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 cbe-oss-dev@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jiri Kosina <trivial@kernel.org>
Subject: [PATCHv9 0/5] Getting rid of get_unused_fd()
Date: Mon, 13 Oct 2014 21:30:57 +0200
Message-Id: <cover.1413223900.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Please find the 9th revision of my patchset to remove
get_unused_fd() macro.

In linux-next, tag next-20141013, they're currently:

- 33 calls to fd_install()
       with one call part of anon_inode_getfd()
- 27 calls to get_unused_fd_flags()
       with one call part of anon_inode_getfd()
       with another part of get_unused_fd() macro
- 13 calls to anon_inode_getfd()
-  8 calls to anon_inode_getfile()
       with one call part of anon_inode_getfd()
-  5 calls to get_unused_fd()

The following patchset replaces the 5 last calls to
get_unused_fd() by calls to get_unused_fd_flags(0)
and remove the macro so that it won't be used in
newer code.

For some detailed background information, please have
a look at my previous patchset's cover letter[1].

Changes from patchset v8[1]
- fanotify: enable close-on-exec on events' fd when requested in
    fanotify_init()
  DROPPED: applied upstream, commit 0b37e097a648.
- reduce the amount of explanation in cover letter

[1] http://lkml.kernel.org/r/cover.1411562410.git.ydroneaud@opteya.com

Yann Droneaud (5):
  ia64: trivial: replace get_unused_fd() by get_unused_fd_flags(0)
  ppc/cell: trivial: replace get_unused_fd() by get_unused_fd_flags(0)
  binfmt_misc: trivial: replace get_unused_fd() by
    get_unused_fd_flags(0)
  file: trivial: replace get_unused_fd() by get_unused_fd_flags(0)
  file: remove get_unused_fd() macro

 arch/ia64/kernel/perfmon.c                | 2 +-
 arch/powerpc/platforms/cell/spufs/inode.c | 4 ++--
 fs/binfmt_misc.c                          | 2 +-
 fs/file.c                                 | 2 +-
 include/linux/file.h                      | 1 -
 5 files changed, 5 insertions(+), 6 deletions(-)

-- 
1.9.3
