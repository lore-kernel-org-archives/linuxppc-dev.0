Return-Path: <B43198@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0118.outbound.protection.outlook.com [157.56.110.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 576531A0146
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 20:33:03 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-rt-users@vger.kernel.org>,
 <bigeasy@linutronix.de>, <agraf@suse.de>, <pbonzini@redhat.com>
Subject: [PATCH 0/2] powerpc/kvm: Enable running guests on RT Linux
Date: Wed, 18 Feb 2015 09:32:33 +0000
Message-ID: <1424251955-308-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, mihai.caraman@freescale.com,
 linux-kernel@vger.kernel.org,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>
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

0002: introduces a limit on the maximum VCPUs a guest can have, in order to
prevent potential DoS attack due to large system latencies. This patch is
targeted to RT (due to CONFIG_PREEMPT_RT_FULL), but it can also be applied on
upstream Linux, with no effect. Not sure if it's best to send it upstream and
have a hanging CONFIG_PREEMPT_RT_FULL check there, with no effect, or send it
against linux-stable-rt. Please apply as you consider appropriate.

- applied & compiled against upstream 3.19
- applied & compiled against stable-rt 3.14-rt (0002 with minor fuzz)

Bogdan Purcareata (2):
  powerpc/kvm: Convert openpic lock to raw_spinlock
  powerpc/kvm: Limit MAX_VCPUS for guests running on RT Linux

 arch/powerpc/include/asm/kvm_host.h |  6 +++++
 arch/powerpc/kvm/mpic.c             | 44 ++++++++++++++++++-------------------
 2 files changed, 28 insertions(+), 22 deletions(-)

-- 
2.1.4
