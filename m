Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sWfHk1lHGzDrq8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 02:13:05 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8AGBhYW051217
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 12:13:02 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25cep7t75k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Sep 2016 12:13:02 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 10 Sep 2016 10:13:01 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Meelis Roos <mroos@linux.ee>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: UBSAN: Undefined behaviour in arch/powerpc/kernel/cputable.c
In-Reply-To: <alpine.LRH.2.20.1609091556420.29746@math.ut.ee>
References: <alpine.LRH.2.20.1609091556420.29746@math.ut.ee>
Date: Sat, 10 Sep 2016 21:42:55 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87poobpwc8.fsf@linux.vnet.ibm.com>
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
>
>

Can you try

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
 
