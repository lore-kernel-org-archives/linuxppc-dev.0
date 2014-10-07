Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03D5F1A0127
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 19:18:08 +1100 (EST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3C2FC1400BE
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 19:18:05 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Tue, 7 Oct 2014 13:48:00 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id F2B72125804D
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2014 13:48:44 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s978IHLl56623232
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2014 13:48:18 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s978HtBY003705
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2014 13:47:55 +0530
Subject: [PATCH] powerpc/book3s: Fix an issue where guest is paused on
 receiving HMI.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Oct 2014 13:47:55 +0530
Message-ID: <20141007081706.9297.89891.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

When we get an HMI while in guest enter/exit path, we see that guest enters
into paused state. The reason is, in kvmppc_handle_exit_hv it falls through
default path and returns to host instead of resuming guest. This causes
guest to enter into paused state.  HMI is hypervisor only interrupt and it
is safe to resume guest since host has handled it already. This patch adds
switch case to handle HMI and resume guest.

Without this patch we see guest entering into pasued state with following
console messages:

[ 3003.329351] Severe Hypervisor Maintenance interrupt [Recovered]
[ 3003.329356]  Error detail: Timer facility experienced an error
[ 3003.329359] 	HMER: 0840000000000000
[ 3003.329360] 	TFMR: 4a12000980a84000
[ 3003.329366] vcpu c0000007c35094c0 (40):
[ 3003.329368] pc  = c0000000000c2ba0  msr = 8000000000009032  trap = e60
[ 3003.329370] r 0 = c00000000021ddc0  r16 = 0000000000000046
[ 3003.329372] r 1 = c00000007a02bbd0  r17 = 00003ffff27d5d98
[ 3003.329375] r 2 = c0000000010980b8  r18 = 00001fffffc9a0b0
[ 3003.329377] r 3 = c00000000142d6b8  r19 = c00000000142d6b8
[ 3003.329379] r 4 = 0000000000000002  r20 = 0000000000000000
[ 3003.329381] r 5 = c00000000524a110  r21 = 0000000000000000
[ 3003.329383] r 6 = 0000000000000001  r22 = 0000000000000000
[ 3003.329386] r 7 = 0000000000000000  r23 = c00000000524a110
[ 3003.329388] r 8 = 0000000000000000  r24 = 0000000000000001
[ 3003.329391] r 9 = 0000000000000001  r25 = c00000007c31da38
[ 3003.329393] r10 = c0000000014280b8  r26 = 0000000000000002
[ 3003.329395] r11 = 746f6f6c2f68656c  r27 = c00000000524a110
[ 3003.329397] r12 = 0000000028004484  r28 = c00000007c31da38
[ 3003.329399] r13 = c00000000fe01400  r29 = 0000000000000002
[ 3003.329401] r14 = 0000000000000046  r30 = c000000003011e00
[ 3003.329403] r15 = ffffffffffffffba  r31 = 0000000000000002
[ 3003.329404] ctr = c00000000041a670  lr  = c000000000272520
[ 3003.329405] srr0 = c00000000007e8d8 srr1 = 9000000000001002
[ 3003.329406] sprg0 = 0000000000000000 sprg1 = c00000000fe01400
[ 3003.329407] sprg2 = c00000000fe01400 sprg3 = 0000000000000005
[ 3003.329408] cr = 48004482  xer = 2000000000000000  dsisr = 42000000
[ 3003.329409] dar = 0000010015020048
[ 3003.329410] fault dar = 0000010015020048 dsisr = 42000000
[ 3003.329411] SLB (8 entries):
[ 3003.329412]   ESID = c000000008000000 VSID = 40016e7779000510
[ 3003.329413]   ESID = d000000008000001 VSID = 400142add1000510
[ 3003.329414]   ESID = f000000008000004 VSID = 4000eb1a81000510
[ 3003.329415]   ESID = 00001f000800000b VSID = 40004fda0a000d90
[ 3003.329416]   ESID = 00003f000800000c VSID = 400039f536000d90
[ 3003.329417]   ESID = 000000001800000d VSID = 0001251b35150d90
[ 3003.329417]   ESID = 000001000800000e VSID = 4001e46090000d90
[ 3003.329418]   ESID = d000080008000019 VSID = 40013d349c000400
[ 3003.329419] lpcr = c048800001847001 sdr1 = 0000001b19000006 last_inst = ffffffff
[ 3003.329421] trap=0xe60 | pc=0xc0000000000c2ba0 | msr=0x8000000000009032
[ 3003.329524] Severe Hypervisor Maintenance interrupt [Recovered]
[ 3003.329526]  Error detail: Timer facility experienced an error
[ 3003.329527] 	HMER: 0840000000000000
[ 3003.329527] 	TFMR: 4a12000980a94000
[ 3006.359786] Severe Hypervisor Maintenance interrupt [Recovered]
[ 3006.359792]  Error detail: Timer facility experienced an error
[ 3006.359795] 	HMER: 0840000000000000
[ 3006.359797] 	TFMR: 4a12000980a84000


# virsh list --all
 Id    Name                           State
----------------------------------------------------
 2     guest2                         running
 3     guest3                         paused
 4     guest4                         running

Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 27cced9..c2d30be 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -745,6 +745,8 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		vcpu->stat.ext_intr_exits++;
 		r = RESUME_GUEST;
 		break;
+	/* HMI is hypervisor interrupt and host has handled it. Resume guest.*/
+	case BOOK3S_INTERRUPT_HMI:
 	case BOOK3S_INTERRUPT_PERFMON:
 		r = RESUME_GUEST;
 		break;
