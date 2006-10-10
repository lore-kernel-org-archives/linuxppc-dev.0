Return-Path: <mgreer@mvista.com>
Date: Mon, 9 Oct 2006 23:09:45 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/4] powerpc: Next round of bootwrapper flat dt patches
Message-ID: <20061010060945.GA28311@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

This patch series is a respin of--and complete replacement for--the
bootwrapper reorg patches that I sent out a while back.  I also included
the flatdevtree.c file which is the latest version that Paul sent plus
changes that I've made.

The patches apply to powerpc.git commit id:

	ba00003aa83a61b615542dd66f5af8fb4a7cee1d

Paul, it would really help the rest of us if you would apply these patches
quickly.  There are several people waiting for this work but there are so
many versions of so many patches that no one knows what to use.  Plus, it
would get more people testing/debugging the flatdevtree code.

Summary of changes:
===================

more reorg patch
----------------
- This patch includes Paul's changes to zImage.lds.S which define
  _dtb_start & _dtb_end and a related patch for the wrapper script.
- I changed main.c:start() a little so that the call to ft_init() is
  done in platform_init().  I did this because of an interface change
  to ft_init which now require some platform knowledge.
- I added a realloc() call to dt_ops so it can be passed to ft_open.

flatdevtree patch
-----------------
- I did not debug all of the flatdevtree.c code.  I only debugged
  ft_find_device, ft_get_prop, ft_set_prop and their supporting routines.
- I added a phandle table (insided the cxt) to track phandles returned by
  ft_find_device().  Now the value returned by ft_find_device() is a phandle
  which is nothing more than an index into the phandle table.  The phandle
  table contains the address of the corresponding node.  When the flat dt
  is edited/moved, the node pointers in the phandle table are updated
  accordingly so no phandles kept by the caller become stale.
- I tested shrinking, and expanding an existing property but did not test
  adding a new property.
- I'm not sure of the usefulness of the genealogy stuff but I left it there
  in case Paul has plans for it.  I did not test ft_get_parent (the only user
  of genealogy).

simple_realloc patch
--------------------
- The flatdevtree code needs a realloc now so that is implemented in here.
- As the name implies, it is a simple allocator which uses a table to track
  what's been allocated.  simple_alloc_init() let's the caller set where
  the heap is, its size, the granularity of its allocations, and how many
  entries the table has.
- Once a slot in the table is used, its base & size are set.  This allows
  the code to be much simpler.

non-OF serial console patch
---------------------------
- I decided not to look for a /cpus/<some cpu>/64-bit property and instead
  get either 1 or 2 "32-bit things" from the uart's 'virtual-reg' property.
  If there is 1, its 32-bits; if its 2, its 64-bits.

Mark
