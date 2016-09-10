Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWTqR2BXfzDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 19:51:31 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Meelis Roos <mroos@linux.ee>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: UBSAN: Undefined behaviour in arch/powerpc/kernel/cputable.c
In-Reply-To: <alpine.LRH.2.20.1609091556420.29746@math.ut.ee>
References: <alpine.LRH.2.20.1609091556420.29746@math.ut.ee>
Date: Sat, 10 Sep 2016 19:51:29 +1000
Message-ID: <87r38snkv2.fsf@concordia.ellerman.id.au>
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

Meelis Roos <mroos@linux.ee> writes:

> Got this on my PowerPC G4 (533 MHz, PowerPC 7410, PowerMac3,4 platform), 
> with gcc version 5.3.1 20160509 (Debian 5.3.1-19):
>
> [    0.000000] ================================================================================
> [    0.000000] UBSAN: Undefined behaviour in arch/powerpc/kernel/cputable.c:2240:25
> [    0.000000] shift exponent 32 is too large for 32-bit type 'long unsigned int'
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.8.0-rc5-00075-gd71f058 #106
> [    0.000000] Call Trace:
> [    0.000000] [c0a5ff10] [c03aa588] ubsan_epilogue+0x18/0x4c (unreliable)
> [    0.000000] [c0a5ff20] [c03aab38] __ubsan_handle_shift_out_of_bounds+0xe8/0x13c
> [    0.000000] [c0a5ffa0] [c07c42d0] cpu_feature_keys_init+0xa0/0xb8
> [    0.000000] [c0a5ffd0] [c07ca1fc] setup_feature_keys+0x14/0x24
> [    0.000000] [c0a5ffe0] [c07c6c74] machine_init+0x18/0x58
> [    0.000000] [c0a5fff0] [c000341c] start_here+0x38/0x78
> [    0.000000] ================================================================================

Oops, my bad.

#define NUM_CPU_FTR_KEYS	64

...

	for (i = 0; i < NUM_CPU_FTR_KEYS; i++) {
		unsigned long f = 1ul << i;

Does this fix it?

cheers

diff --git a/arch/powerpc/include/asm/cpu_has_feature.h b/arch/powerpc/include/asm/cpu_has_feature.h
index 2ef55f8968a2..b312b152461b 100644
--- a/arch/powerpc/include/asm/cpu_has_feature.h
+++ b/arch/powerpc/include/asm/cpu_has_feature.h
@@ -15,7 +15,7 @@ static inline bool early_cpu_has_feature(unsigned long feature)
 #ifdef CONFIG_JUMP_LABEL_FEATURE_CHECKS
 #include <linux/jump_label.h>
 
-#define NUM_CPU_FTR_KEYS	64
+#define NUM_CPU_FTR_KEYS	BITS_PER_LONG
 
 extern struct static_key_true cpu_feature_keys[NUM_CPU_FTR_KEYS];
 
