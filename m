Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5AEA3140087
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 20:35:47 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 11 Apr 2014 06:35:45 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7951538C8027
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 06:35:42 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3BAZgxZ63635706
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 10:35:42 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3BAZfqa001080
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2014 06:35:42 -0400
Subject: [PATCH 0/3] ppc:Set runlatch bits correctly for offline threads and
 vcpus
To: linuxppc-dev@ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 11 Apr 2014 16:01:39 +0530
Message-ID: <20140411103030.27683.2107.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
 srivatsa.bhat@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The runlatch bits with their value indicated by CTRL_RUNLATCH are set and
cleared in the SPRN_CTRL registers to indicate a busy and idle cpu
respectively. This is currently being done in the cpuidle path of the host.
But needs to be taken care of in hotplug and kvm scenarios. This patchset
is aimed at ensuring that the runlatch bits are consisten with the
utilization of a CPU under all circumstances.
---

Preeti U Murthy (3):
      ppc/powernv: Set the runlatch bits correctly for offline cpus
      ppc/kvm: Set the runlatch bit of a CPU just before starting guest
      ppc/kvm: Clear the runlatch bit of a vcpu before napping


 arch/powerpc/kvm/book3s_hv_rmhandlers.S |   18 +++++++++++++++++-
 arch/powerpc/platforms/powernv/smp.c    |    3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

-- 
