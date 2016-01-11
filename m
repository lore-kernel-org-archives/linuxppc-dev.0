Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 018E21A0AC6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 16:51:40 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org, benh@kernel.crashing.org, michael@ellerman.id.au,
 bharata@linux.vnet.ibm.com
Cc: thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 0/4] Prototype PAPR hash page table resizing (guest side)
Date: Mon, 11 Jan 2016 16:52:29 +1100
Message-Id: <1452491553-26153-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've discussed with Paul and Ben previously the possibility of
extending PAPR to allow changing the size of a running guest's hash
page table (HPT).  This would allow for much more flexible memory
hotplug, since the HPT wouldn't have to be sized in advance for the
maximum possible memory size of the guest.

This is a second draft / prototype implementation of the guest side of
this.

Obviously, for now it uses vendor specific hypercalls rather than
official PAPR ones (and likewise non-standard hypertas property and
CAS vector extensions).  I have a draft implementation of these in
qemu for TCG guests which I hope to post in the reasonably near
future.

The design assumes that the HPT change happens in two phases:

   1) The "prepare" phase may be slow but can run asynchronously while
         the guest runs normally

   2) The "commit" phase switches to a previously prepared HPT, and
         must be run with no concurrent updates to the HPT - in practice
	       that means stop_machine() for a Linux guest.

To go with that there are two (proposed) hcalls:

H_RESIZE_HPT_PREPARE:
    This starts (1) for a new HPT of a given size.  It will typically
        return H_LONG_DELAY_* and the guest must call it in a (sleeping)
	    loop until it completes.

    Calling PREPARE with a different size from one already in progress
        will cancel the in-progress preparation (freeing the potential HPT
	    if already allocated) and start a new one for the given size.

    As a special case calling PREPARE with shift == 0 will cancel any
        in-progress preparation and not start a new one, instead reverting
	    to the existing HPT.

H_RESIZE_HPT_COMMIT:
    Switches to an HPT of the given size.  It will fail if there isn't
        a fully prepared HPT of the given size ready to go.  No HPT updates
	    (H_ENTER etc.) may be run on *any* guest CPU while this is called.

    Once COMMIT returns H_SUCCESS, the guest will be operating on the
        new HPT.  On any other return it is still running on the old HPT.

    The hypervisor could cancel a prospective HPT for its own reasons
        - e.g. it could time out if the guest waits too long between
	    PREPARE and COMMIT, or it could "forget" about an in-progress
	        preparation due to live migration.  In that case COMMIT will fail,
		    which the guest should be prepared to handle.

Both hypercalls take a flags parameter for extensibility, but I
haven't defined any flags so far.

I have two possible implementations in mind for the host side, both of
which should work with the same guest interface:

A) During the prepare phase we just allocate and clear the HPT (and
   install VRMA HPTEs for KVM).  During the commit phase we translate
      all bolted entries from the old HPT to the new then continue.

   This approach is relatively simple to implement, but could lead to
      a substantial delay during the commit phase.  Initial rough
         measurements suggest it will be around ~200ms on a POWER8 for a 1G
	    HPT (128G guest).  Since typical live migration downtimes are
	       300-500ms, that's probably still good enough to be useful.

B) During the prepare phase H_ENTER etc. calls are mirrored to both
   the current HPT and the prospective HPT.  Existing HPTEs are
      migrated to the new HPT in the background.  The prepare phase
         completes once the old and new HPTs are in sync.  The commit phase
	    simply pivots to the new HPT.


Please comment on the proposed new PAPR interface and this
implementation.  Any information on what the next step would be in
proposing this as a formal PAPR update would be useful too.

Changes since v1:
  * Added a firmware feature bit for HPT resizing, initialized from
    the device tree
  * Added support for advertising HPT resizing support via
    ibm,client-architecture-support
  * Assorted minor revisions

David Gibson (4):
  pseries: Add hypercall wrappers for hash page table resizing
  pseries: Add support for hash table resizing
  pseries: debugfs hook to trigger a hash page table resize
  pseries: Advertise HPT resizing support via CAS

 arch/powerpc/include/asm/firmware.h       |   5 +-
 arch/powerpc/include/asm/hvcall.h         |   2 +
 arch/powerpc/include/asm/plpar_wrappers.h |  12 +++
 arch/powerpc/include/asm/prom.h           |   1 +
 arch/powerpc/kernel/prom_init.c           |   2 +-
 arch/powerpc/platforms/pseries/firmware.c |   1 +
 arch/powerpc/platforms/pseries/lpar.c     | 135 ++++++++++++++++++++++++++++++
 7 files changed, 155 insertions(+), 3 deletions(-)

-- 
2.5.0
