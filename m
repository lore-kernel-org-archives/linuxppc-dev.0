Return-Path: <hughd@google.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id D354C1007D4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2011 10:51:54 +1100 (EST)
Received: by iakr3 with SMTP id r3so5087693iak.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2011 15:51:50 -0800 (PST)
Date: Mon, 5 Dec 2011 15:51:29 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: next BUG: using smp_processor_id() in preemptible
Message-ID: <alpine.LSU.2.00.1112051539100.3938@sister.anvils>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

3.2.0-rc3-next-20111202 with CONFIG_DEBUG_PREEMPT=y gives me lots of

Dec  4 20:03:19 thorn kernel: BUG: using smp_processor_id() in preemptible [00000000] code: startpar/1365
Dec  4 20:03:19 thorn kernel: caller is .arch_local_irq_restore+0x44/0x90
Dec  4 20:03:19 thorn kernel: Call Trace:
Dec  4 20:03:19 thorn kernel: [c0000001b45a7c60] [c000000000011fe8] .show_stack+0x6c/0x16c (unreliable)
Dec  4 20:03:19 thorn kernel: [c0000001b45a7d10] [c00000000024318c] .debug_smp_processor_id+0xe4/0x11c
Dec  4 20:03:19 thorn kernel: [c0000001b45a7da0] [c00000000000e2e8] .arch_local_irq_restore+0x44/0x90
Dec  4 20:03:19 thorn kernel: [c0000001b45a7e30] [c000000000005870] .do_hash_page+0x70/0x74
Dec  4 20:03:21 thorn kernel: debug_smp_processor_id: 21950 callbacks suppressed

from the u64 *next_tb = &__get_cpu_var(decrementers_next_tb)
in decrementer_check_overflow(): I've no idea whether it's safe
just to use get_cpu_var then put_cpu_var there instead,
but no hurry, I can survive with DEBUG_PREEMPT off.

Hugh
