Return-Path: <ebiederm@xmission.com>
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FCtP55ljzF3JN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 05:37:00 +1000 (AEST)
From: ebiederm@xmission.com (Eric W. Biederman)
To: <linux-kernel@vger.kernel.org>
Cc: <linux-arch@vger.kernel.org> , linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Tue, 18 Sep 2018 19:41:09 +0200
Message-ID: <878t3yitze.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [REVIEW][PATCH 0/9] signal/powerpc: siginfo cleanups
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


This is the continuation of my work to sort out signaling of exceptions
with siginfo.  The old functions by passing siginfo resulted in many
cases of fields of siginfo that were not initialized and then passed to
userspace, and also resulted in callers getting confused and
initializing the wrong fields.  My remedy is to have specific functions
for sending each different kind of signal with siginfo.  Those functions
take the information needed to fill in siginfo and do the work
themselves.

This is my set of changes to update powerpc to use those functions.
Along with some refactoring so those functions can be cleanly used.

Folks please review and double check me.  I think I have kept these
changes simple and obviously correct but I am human and mess up
sometimes.

After these patches have had a chance to be reviewed I plan to merge
them by my siginfo tree.  If you would rather take them in the powerpc
tree let me know.   All of the prerequisites should have been merged
through Linus's tree several releases ago.

Eric W. Biederman (9):
      signal/powerpc: Use force_sig_mceerr as appropriate
      signal/powerpc: Remove pkey parameter from __bad_area
      signal/powerpc: Call _exception_pkey directly from bad_key_fault_exception
      signal/powerpc: Remove pkey parameter from __bad_area_nosemaphore
      signal/powerpc: Factor the common exception code into exception_common
      signal/powerpc: Call force_sig_fault from _exception
      signal/poewrpc: Specialize _exception_pkey for handling pkey exceptions
      signal/powerpc: Simplify _exception_pkey by using force_sig_pkuerr
      signal/powerpc: Use force_sig_fault where appropriate

 arch/powerpc/include/asm/bug.h            |  2 +-
 arch/powerpc/kernel/process.c             |  9 +----
 arch/powerpc/kernel/traps.c               | 27 ++++++++-------
 arch/powerpc/mm/fault.c                   | 55 +++++++++++++++++--------------
 arch/powerpc/platforms/cell/spu_base.c    |  4 +--
 arch/powerpc/platforms/cell/spufs/fault.c | 26 +++++----------
 6 files changed, 57 insertions(+), 66 deletions(-)

Eric
