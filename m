Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B6BBD1A003B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2014 02:31:44 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 7 Sep 2014 22:01:41 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A2E9A394004E
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Sep 2014 22:01:38 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s87GW3iU45154536
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Sep 2014 22:02:03 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s87GVbAE005750
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Sep 2014 22:01:38 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Subject: [PATCH 0/2 v5] powerpc/kvm: support to handle sw breakpoint
Date: Sun,  7 Sep 2014 22:01:31 +0530
Message-Id: <1410107494-25556-1-git-send-email-maddy@linux.vnet.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset adds ppc64 server side support for software breakpoint
and extends the use of illegal instruction as software
breakpoint across ppc platform.

Patch 1, adds kernel side support for software breakpoint.
Design is that, by using an illegal instruction, we trap to
hypervisor via Emulation Assistance interrupt, where we check
for the illegal instruction and accordingly we return to Host
or Guest. Patch also adds support for software breakpoint
in PR KVM.

Patch 2,extends the use of illegal instruction as software
breakpoint instruction across the ppc platform. Patch extends
booke program interrupt code to support software breakpoint.

Patch 2 is only compile tested. Will really help if
someone can try it out and let me know comments.

Changes v4->v5:
 Made changes to code comments and commit messages
 Added debugging active checks for illegal instr comparison
 Added debug instruction check in emulate code
 Extended SW breakpoint to booke

Changes v3->v4:
 Made changes to code comments and removed #define of zero opcode
 Added a new function to handle the debug instruction emulation in book3s_hv
 Rebased the code to latest upstream source.

Changes v2->v3:
 Changed the debug instructions. Using the all zero opcode in the instruction word
  as illegal instruction as mentioned in Power ISA instead of ABS
 Removed reg updated in emulation assist and added a call to
  kvmppc_emulate_instruction for reg update.

Changes v1->v2:

 Moved the debug instruction #def to kvm_book3s.h. This way PR_KVM can also share it.
 Added code to use KVM get one reg infrastructure to get debug opcode.
 Updated emulate.c to include emulation of debug instruction incase of PR_KVM.
 Made changes to commit message.

Madhavan Srinivasan (2):
  powerpc/kvm: support to handle sw breakpoint
  powerpc/kvm: common sw breakpoint instr across ppc

 arch/powerpc/include/asm/kvm_ppc.h |  6 ++++++
 arch/powerpc/kvm/book3s.c          |  3 ++-
 arch/powerpc/kvm/book3s_hv.c       | 41 ++++++++++++++++++++++++++++++++++----
 arch/powerpc/kvm/book3s_pr.c       |  3 +++
 arch/powerpc/kvm/booke.c           | 18 +++++++++++++++--
 arch/powerpc/kvm/emulate.c         | 18 +++++++++++++++++
 6 files changed, 82 insertions(+), 7 deletions(-)

-- 
1.7.11.4
