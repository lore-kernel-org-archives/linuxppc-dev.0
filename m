Return-Path: <hejianet@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x72GS1NtmzDqgX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 01:01:36 +1000 (AEST)
Received: by mail-it0-x243.google.com with SMTP id o202so2373468itc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 08:01:36 -0700 (PDT)
From: Jia He <hejianet@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ingo Molnar <mingo@kernel.org>, fweisbec@gmail.com,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <john.stultz@linaro.org>,
 Stanislaw Gruszka <sgruszka@redhat.com>, Ivan Mikhaylov <ivan@de.ibm.com>,
 cyrilbur@gmail.com, Jia He <hejianet@gmail.com>
Subject: [PATCH] powerpc/time: use get_tb instead of get_vtb in running_clock
Date: Wed, 12 Jul 2017 23:01:10 +0800
Message-Id: <1499871670-24671-1-git-send-email-hejianet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Virtual time base(vtb) is a register which increases only in guest.
Any exit from guest to host will stop the vtb(saved and restored by kvm).
But if there is an IO causes guest exits to host, the guest's watchdog
(watchdog_timer_fn -> is_softlockup -> get_timestamp -> running_clock)
needs to also include the time elapsed in host. get_vtb is not correct in
this case.

Also, the TB_OFFSET is well saved and restored by qemu after commit [1].
So we can use get_tb here.

[1] http://git.qemu.org/?p=qemu.git;a=commit;h=42043e4f1

Signed-off-by: Jia He <hejianet@gmail.com>
---
 arch/powerpc/kernel/time.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index fe6f3a2..c542dd3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -695,16 +695,15 @@ notrace unsigned long long sched_clock(void)
 unsigned long long running_clock(void)
 {
 	/*
-	 * Don't read the VTB as a host since KVM does not switch in host
-	 * timebase into the VTB when it takes a guest off the CPU, reading the
-	 * VTB would result in reading 'last switched out' guest VTB.
+	 * Use get_tb instead of get_vtb for guest since the TB_OFFSET has been
+	 * well saved/restored when qemu does suspend/resume.
 	 *
 	 * Host kernels are often compiled with CONFIG_PPC_PSERIES checked, it
 	 * would be unsafe to rely only on the #ifdef above.
 	 */
 	if (firmware_has_feature(FW_FEATURE_LPAR) &&
 	    cpu_has_feature(CPU_FTR_ARCH_207S))
-		return mulhdu(get_vtb() - boot_tb, tb_to_ns_scale) << tb_to_ns_shift;
+		return mulhdu(get_tb() - boot_tb, tb_to_ns_scale) << tb_to_ns_shift;
 
 	/*
 	 * This is a next best approximation without a VTB.
-- 
2.9.3
