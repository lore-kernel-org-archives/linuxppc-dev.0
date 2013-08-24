Return-Path: <ydroneaud@quest-ce.net>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [IPv6:2a01:e0c:1:1599::11])
 by ozlabs.org (Postfix) with ESMTP id E823B2C009F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Aug 2013 06:21:04 +1000 (EST)
From: Yann Droneaud <ydroneaud@opteya.com>
To: Alexander Graf <agraf@suse.de>, Gleb Natapov <gleb@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/2] kvm: use anon_inode_getfd() with O_CLOEXEC flag
Date: Sat, 24 Aug 2013 22:14:06 +0200
Message-Id: <cover.1377372576.git.ydroneaud@opteya.com>
Cc: Yann Droneaud <ydroneaud@opteya.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Following a patchset asking to change calls to get_unused_flag() [1]
to use O_CLOEXEC, Alex Williamson [2][3] decided to change VFIO
to use the flag.

Since it's a related subsystem to KVM, using O_CLOEXEC for
file descriptors created by KVM might be applicable too.

I'm suggesting to change calls to anon_inode_getfd() to use O_CLOEXEC
as default flag.

This patchset should be reviewed to not break existing userspace program.

BTW, if it's not applicable, I would suggest that new ioctls be added to
KVM subsystem, those ioctls would have a "flag" field added to their arguments.
Such "flag" would let userspace choose the open flag to use.
See for example other APIs using anon_inode_getfd() such as fanotify,
inotify, signalfd and timerfd.

You might be interested to read:

- Secure File Descriptor Handling (Ulrich Drepper, 2008)
  http://udrepper.livejournal.com/20407.html

- Excuse me son, but your code is leaking !!! (Dan Walsh, March 2012) 
  http://danwalsh.livejournal.com/53603.html

Regards.

[1] http://lkml.kernel.org/r/cover.1376327678.git.ydroneaud@opteya.com
[2] http://lkml.kernel.org/r/1377186804.25163.17.camel@ul30vt.home
[3] http://lkml.kernel.org/r/20130822171744.1297.13711.stgit@bling.home

Yann Droneaud (2):
  kvm: use anon_inode_getfd() with O_CLOEXEC flag
  ppc: kvm: use anon_inode_getfd() with O_CLOEXEC flag

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 +-
 arch/powerpc/kvm/book3s_64_vio.c    | 2 +-
 arch/powerpc/kvm/book3s_hv.c        | 2 +-
 virt/kvm/kvm_main.c                 | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.8.3.1
