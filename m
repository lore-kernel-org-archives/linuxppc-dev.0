Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t4rLB0JcJzDvQQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:26:25 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9S4Nt8C099249
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 00:26:24 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26bvc29ys5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 00:26:23 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 28 Oct 2016 14:26:21 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 4B0E62CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:26:17 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9S4QHF84456916
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:26:17 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9S4QFHb022879
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Oct 2016 15:26:17 +1100
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org, x86@kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com, David.Laight@ACULAB.COM,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Subject: [PATCH v6 11/11] Documentation: virtual: kvm: Support vcpu preempted
 check
Date: Fri, 28 Oct 2016 04:11:27 -0400
In-Reply-To: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
References: <1477642287-24104-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1477642287-24104-12-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit ("x86, kvm: support vcpu preempted check") add one field "__u8
preempted" into struct kvm_steal_time. This field tells if one vcpu is
running or not.

It is zero if 1) some old KVM deos not support this filed. 2) the vcpu is
not preempted. Other values means the vcpu has been preempted.

Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Acked-by: Radim Krčmář <rkrcmar@redhat.com>
---
 Documentation/virtual/kvm/msr.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/virtual/kvm/msr.txt b/Documentation/virtual/kvm/msr.txt
index 2a71c8f..ab2ab76 100644
--- a/Documentation/virtual/kvm/msr.txt
+++ b/Documentation/virtual/kvm/msr.txt
@@ -208,7 +208,9 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
 		__u64 steal;
 		__u32 version;
 		__u32 flags;
-		__u32 pad[12];
+		__u8  preempted;
+		__u8  u8_pad[3];
+		__u32 pad[11];
 	}
 
 	whose data will be filled in by the hypervisor periodically. Only one
@@ -232,6 +234,11 @@ MSR_KVM_STEAL_TIME: 0x4b564d03
 		nanoseconds. Time during which the vcpu is idle, will not be
 		reported as steal time.
 
+		preempted: indicate the VCPU who owns this struct is running or
+		not. Non-zero values mean the VCPU has been preempted. Zero
+		means the VCPU is not preempted. NOTE, it is always zero if the
+		the hypervisor doesn't support this field.
+
 MSR_KVM_EOI_EN: 0x4b564d04
 	data: Bit 0 is 1 when PV end of interrupt is enabled on the vcpu; 0
 	when disabled.  Bit 1 is reserved and must be zero.  When PV end of
-- 
2.4.11
