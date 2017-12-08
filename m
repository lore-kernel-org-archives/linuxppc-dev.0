Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytMRw5Ql7zDrvX
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 17:11:24 +1100 (AEDT)
Date: Fri, 8 Dec 2017 17:08:03 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Cc: David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC PATCH 0/2] KVM: PPC: Book3S HV: Transactional memory bug
 workarounds for POWER9
Message-ID: <20171208060803.relvzabipgl2lub6@rohan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This series adds emulation for some transactional memory instructions
that will be used on POWER9 DD2.2 processors as part of the
workarounds for hardware bugs.  The basic idea is that because the CPU
hardware cannot maintain a full checkpoint of the architected state
for all four threads, it needs to be able to escape from suspended
state at times.  (The CPU can escape from transactional state simply
by aborting the transaction and rolling back, but in suspended state
it can't roll back until the transaction is resumed.)  This is
implemented by having a "fake suspend" state where the MSR indicates
suspended state but there is no checkpoint.  This is differentiated
from real suspended state by a new bit in the PSSCR register.

In addition to these two patches, there will need to be another patch
which handles HMIs (hypervisor maintenance interrupts) which the
hardware will generate on threads that are in real suspend state at
the point where another thread that was in a stop instruction wants to
wake up.  The process of taking the HMI and exiting the guest to host
context will do a treclaim which will eliminate the checkpointed state
from the CPU hardware, so the only thing remaining will be to clear
the HMER bit that indicates the cause of the HMI.

The series is against v4.14.

Paul.
