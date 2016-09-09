Return-Path: <mroos@linux.ee>
Received: from smtp2.it.da.ut.ee (smtp2.it.da.ut.ee
 [IPv6:2001:bb8:2002:500:20f:1fff:fe04:1bbb])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sVwsP4dRnzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2016 22:06:17 +1000 (AEST)
Date: Fri, 9 Sep 2016 16:05:12 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
Sender: mroos@math.ut.ee
To: Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: UBSAN: Undefined behaviour in arch/powerpc/kernel/cputable.c
Message-ID: <alpine.LRH.2.20.1609091556420.29746@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Got this on my PowerPC G4 (533 MHz, PowerPC 7410, PowerMac3,4 platform), 
with gcc version 5.3.1 20160509 (Debian 5.3.1-19):

[    0.000000] ================================================================================
[    0.000000] UBSAN: Undefined behaviour in arch/powerpc/kernel/cputable.c:2240:25
[    0.000000] shift exponent 32 is too large for 32-bit type 'long unsigned int'
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.8.0-rc5-00075-gd71f058 #106
[    0.000000] Call Trace:
[    0.000000] [c0a5ff10] [c03aa588] ubsan_epilogue+0x18/0x4c (unreliable)
[    0.000000] [c0a5ff20] [c03aab38] __ubsan_handle_shift_out_of_bounds+0xe8/0x13c
[    0.000000] [c0a5ffa0] [c07c42d0] cpu_feature_keys_init+0xa0/0xb8
[    0.000000] [c0a5ffd0] [c07ca1fc] setup_feature_keys+0x14/0x24
[    0.000000] [c0a5ffe0] [c07c6c74] machine_init+0x18/0x58
[    0.000000] [c0a5fff0] [c000341c] start_here+0x38/0x78
[    0.000000] ================================================================================



-- 
Meelis Roos (mroos@linux.ee)
