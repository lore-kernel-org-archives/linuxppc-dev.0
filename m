Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2TYM3V9xzDvZ6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 19:12:55 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9O8AAvO083005
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 04:12:53 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 269ebg0whg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 04:12:52 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Mon, 24 Oct 2016 18:12:50 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id ED44F3578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 19:12:47 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9O8Clgc15728744
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 19:12:47 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9O8CkOC026447
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 19:12:47 +1100
Date: Mon, 24 Oct 2016 16:12:29 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org,
 xen-devel-request@lists.xenproject.org, kvm@vger.kernel.org
CC: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, peterz@infradead.org, paulmck@linux.vnet.ibm.com,
 will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com,
 pbonzini@redhat.com, bsingharora@gmail.com, boqun.feng@gmail.com,
 borntraeger@de.ibm.com, rkrcmar@redhat.com
Subject: Re: [PATCH v5 9/9] Documentation: virtual: kvm: Support vcpu preempted
 check
References: <1476998874-2089-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
In-Reply-To: <1476998874-2089-10-git-send-email-xinhui.pan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <580DC26D.4040908@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is new version for [PATCH v6 9/9] Documentation: virtual: kvm: Support vcpu preempted check
change:
	an explicit pad[3] after __u8 preempted.
	a typo fix in the commit log.
	
 From defac64d7c6a50d5f18ef64a7c776af3e21e8b68 Mon Sep 17 00:00:00 2001
From: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Date: Thu, 20 Oct 2016 09:33:36 -0400
Subject: [PATCH v6 9/9] Documentation: virtual: kvm: Support vcpu preempted check

Commit ("x86, kvm: support vcpu preempted check") add one field "__u8
preempted" into struct kvm_steal_time. This field tells if one vcpu is
running or not.

It is zero if 1) some old KVM deos not support this filed. 2) the vcpu is
not preempted. Other values mean the vcpu has been preempted.

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
