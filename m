Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e35.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA0FA2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2013 18:48:55 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sat, 14 Dec 2013 00:48:51 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 64A7C3E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2013 00:48:50 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBE7mnH66881636
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2013 08:48:50 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rBE7pqWM009815
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2013 00:51:53 -0700
Date: Fri, 13 Dec 2013 23:48:46 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: mingo@kernel.org
Subject: [GIT PULL locking/mb] Locking/memory-barrier commits
Message-ID: <20131214074846.GA23612@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, corbet@lwn.net,
 peterz@infradead.org, rusty@rustcorp.com.au, oleg@redhat.com,
 josh@joshtriplett.org, dhowells@redhat.com, paulus@samba.org,
 torvalds@linux-foundation.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Ingo,

This pull request contains additions to the memory-barrier documentation,
along with a downgrading of UNLOCK+LOCK to no longer be a full memory
barrier, and finally an smp_mb__after_unlock_lock() that allows upgrading
a particular LOCK to pair with a preceding UNLOCK to form a full memory
barrier, and application of smp_mb__after_unlock_lock() to RCU.

The first four documentation commits are ready for 3.14:

b145f8acfd82 (Add needed ACCESS_ONCE() calls to memory-barriers.txt)
6be08d626389 (Add long atomic examples to memory-barriers.txt)
c89bb78cfbe1 (Prohibit speculative writes)
b2ba08be67fc (Document ACCESS_ONCE())

The remaining commits might or might not be, but are at a point where
getting them into -tip is appropriate given other changes in this area,
e.g., Peter's smp_load_acquire() and smp_store_release().

These changes are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git locking/mb

for you to fetch changes up to 9f9df17e265b2c5aea11a95e3e69269d005ac0ae:

  powerpc: Full barrier for smp_mb__after_unlock_lock() (2013-12-13 09:05:13 -0800)

----------------------------------------------------------------
Paul E. McKenney (7):
      Documentation/memory-barriers.txt: Add needed ACCESS_ONCE() calls to memory-barriers.txt
      Documentation/memory-barriers.txt: Add long atomic examples to memory-barriers.txt
      Documentation/memory-barriers.txt: Document ACCESS_ONCE()
      locking: Add an smp_mb__after_unlock_lock() for UNLOCK+LOCK barrier
      Documentation/memory-barriers.txt: Downgrade UNLOCK+LOCK
      rcu: Apply smp_mb__after_unlock_lock() to preserve grace periods
      powerpc: Full barrier for smp_mb__after_unlock_lock()

Peter Zijlstra (1):
      Documentation/memory-barriers.txt: Prohibit speculative writes

 Documentation/memory-barriers.txt   | 733 ++++++++++++++++++++++++++++++------
 arch/powerpc/include/asm/spinlock.h |   2 +
 include/linux/spinlock.h            |  10 +
 kernel/rcu/tree.c                   |  18 +-
 kernel/rcu/tree_plugin.h            |  13 +
 5 files changed, 661 insertions(+), 115 deletions(-)
