Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM2RJ454RzF0Pw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 20:51:24 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org
Subject: [PATCH 0/6] KVM: PPC: Book3S HV: Changes for POWER9 v2.2 support
Date: Wed, 17 Jan 2018 20:51:09 +1100
Message-Id: <1516182675-25331-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The POWER9 "Nimbus" v2.2 (referred to as DD2.2) chip has some hardware
bugs fixed that were present in earlier versions, and contains new
workarounds for other hardware bugs.

POWER9 DD2.2 can run with some threads of a core in hashed page table
(HPT) MMU mode while other threads are in radix MMU mode.
Patches 2 and 3 of this series adjust the guest entry/exit code
so that we don't do the (expensive) inter-thread synchronization
introduced in commit c01015091a77 ("KVM: PPC: Book3S HV: Run HPT
guests on POWER9 radix hosts", 2017-10-19) when running a HPT
guest on a radix host, and we don't require the host to be in
SMT1 mode with indep_threads_mode=N.  This means that guests can be
run in the normal fashion without any special host configuration
regardless of whether they will want to use the HPT or radix MMU mode.

POWER9 DD2.2 contains features which are intended to allow
hypervisor software to work around deficiencies in the handling
of transactional memory suspended mode which are present in DD2.2 and
all previous versions.  This involves generating softpatch interrupts
and hypervisor maintenance interrupts on execution of certain
TM-related instructions, so that the hypervisor can store the
checkpointed CPU state in memory and emulate some of the TM state
transitions.  With this, we can allow guests to use transactional
memory facilities even if the host kernel does not allow host
userspace programs to use TM.  This makes it possible to migrate
guests from a POWER8 system to a POWER9.  Since KVM on POWER8 makes TM
available to guests, any guest on a POWER8 may be using TM, and
therefore to be able to migrate such a guest to POWER9 we have to be
able to provide TM facilities to it.

Patch 1 is a bug-fix, relevant on POWER9 systems, to make sure we
don't enter the guest without the XIVE context loaded.

Paul.
