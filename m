Return-Path: <srs0=0lqz=4g=samba.org=anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wG6K92Fz3zDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 22:28:13 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wG6K91Xzfz8tBY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Apr 2017 22:28:13 +1000 (AEST)
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wG6K850dwz9s7l
 for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2017 22:28:12 +1000 (AEST)
Date: Sun, 30 Apr 2017 22:27:58 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, npiggin@gmail.com
Subject: Re: [PATCH v2] powerpc/xmon: Wait for secondaries before IPI'ing on
 system reset
Message-ID: <20170430222758.79fa94ea@kryten>
In-Reply-To: <1493377669-7658-1-git-send-email-mpe@ellerman.id.au>
References: <1493377669-7658-1-git-send-email-mpe@ellerman.id.au>
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

Hi Nick,

> An externally triggered system reset (e.g., via QEMU nmi command, or
> pseries reset button) can cause system reset interrupts on all CPUs.
> In case this causes xmon to be entered, it is undesirable for the
> primary (first) CPU into xmon to trigger an NMI IPI to others,
> because this may cause a nested system reset interrupt.
> 
> So spin for a time waiting for secondaries to join xmon before
> performing the NMI IPI, similarly to what the crash dump code does.

That reminds me of similar delays in our crash path:

/*
 * The primary CPU waits a while for all secondary CPUs to enter. This is to
 * avoid sending an IPI if the secondary CPUs are entering
 * crash_kexec_secondary on their own (eg via a system reset).
 *
 * The secondary timeout has to be longer than the primary. Both timeouts are
 * in milliseconds.
 */
#define PRIMARY_TIMEOUT         500
#define SECONDARY_TIMEOUT       1000

...

        /*
         * If we came in via system reset, wait a while for the secondary
         * CPUs to enter.
         */
        if (TRAP(regs) == 0x100)
                mdelay(PRIMARY_TIMEOUT);

We might want to consolidate the juggling we do. Not sure if many people use
it, but kdb and kgdb may benefit if we make it common.

Anton
