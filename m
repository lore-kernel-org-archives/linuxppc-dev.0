Return-Path: <B43198@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0142.outbound.protection.outlook.com [207.46.100.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 569431A0C47
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 02:08:40 +1000 (AEST)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <tglx@linutronix.de>, <bigeasy@linutronix.de>, <pbonzini@redhat.com>,
 <agraf@suse.de>, <scottwood@freescale.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <mihai.caraman@freescale.com>, <b10716@freescale.com>
Subject: [PATCH v2 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Fri, 24 Apr 2015 15:53:11 +0000
Message-ID: <1429890793-19487-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patchset enables running KVM SMP guests with external interrupts on an
underlying RT-enabled Linux. Previous to this patch, a guest with in-kernel MPIC
emulation could easily panic the kernel due to preemption when delivering IPIs
and external interrupts, because of the openpic spinlock becoming a sleeping
mutex on PREEMPT_RT_FULL Linux.

0001: converts the openpic spinlock to a raw spinlock, in order to circumvent
this behavior. While this change is targeted for a RT enabled Linux, it has no
effect on upstream kvm-ppc, so send it upstream for better future maintenance.

0002: disables in-kernel MPIC emulation for guest running on RT, in order to
prevent a potential DoS attack due to large system latencies. This patch is
targeted to RT (due to CONFIG_PREEMPT_RT_FULL), but it can also be applied on
upstream Linux, with no effect.

- applied & compiled against vanilla 4.0
- applied & compiled against stable-rt 3.18-rt

v2:
- updated commit messages
- change the fix for potentially large latencies from limiting the max number of
  VCPUs a guest can have to disabling the in-kernel MPIC

Bogdan Purcareata (2):
  powerpc/kvm: Convert openpic lock to raw_spinlock
  powerpc/kvm: Disable in-kernel MPIC emulation for PREEMPT_RT_FULL

 arch/powerpc/kvm/Kconfig |  1 +
 arch/powerpc/kvm/mpic.c  | 44 ++++++++++++++++++++++----------------------
 2 files changed, 23 insertions(+), 22 deletions(-)

-- 
2.1.4
