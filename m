Return-Path: <joserz@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVpRP0NN4zDqyy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 12:18:24 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0U1DhBq130957
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 20:18:22 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fte23sm4v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 20:18:22 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <joserz@linux.vnet.ibm.com>;
 Mon, 29 Jan 2018 18:18:21 -0700
From: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, paulus@ozlabs.org, lvivier@redhat.com
Subject: [PATCH v2 0/1] Implements MMIO emulation for lvx/stvx instructions
Date: Mon, 29 Jan 2018 23:18:08 -0200
Message-Id: <20180130011809.20632-1-joserz@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

v2:
  - kvmppc_get_vsr_word_offset() moved back to its original place
  - EA AND ~0xF, following ISA.
  - fixed BE/LE cases

TESTS:

For testing purposes I wrote a small program that performs stvx/lvx using the
program's virtual memory and using MMIO. Load/Store into virtual memory is the
model I use to check if MMIO results are correct (because only MMIO is emulated
by KVM).

Results:

HOST LE - GUEST BE
address: 0x10034850010
0x21436587bbbbaaaa4444555578563412
io_address: 0x3fff89a20000
0x21436587bbbbaaaa4444555578563412

HOST LE - GUEST LE
address: 0x10033a20010
0x1234567855554444aaaabbbb87654321
io_address: 0x3fffb5380000
0x1234567855554444aaaabbbb87654321

HOST BE - GUEST BE
address: 0x1002c4a0010
0x21436587bbbbaaaa4444555578563412
io_address: 0x3ffface40000
0x21436587bbbbaaaa4444555578563412

HOST BR - GUEST LE
address: 0x100225e0010
0x1234567855554444aaaabbbb87654321
io_address: 0x3fff7fcb0000
0x1234567855554444aaaabbbb87654321

This patch implements MMIO emulation for two instructions: lvx and stvx.

Jose Ricardo Ziviani (1):
  KVM: PPC: Book3S: Add MMIO emulation for VMX instructions

 arch/powerpc/include/asm/kvm_host.h   |   2 +
 arch/powerpc/include/asm/kvm_ppc.h    |   4 +
 arch/powerpc/include/asm/ppc-opcode.h |   6 ++
 arch/powerpc/kvm/emulate_loadstore.c  |  34 ++++++++
 arch/powerpc/kvm/powerpc.c            | 153 +++++++++++++++++++++++++++++++++-
 5 files changed, 198 insertions(+), 1 deletion(-)

-- 
2.14.3
