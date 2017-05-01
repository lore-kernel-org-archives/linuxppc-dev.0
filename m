Return-Path: <srs0=wzem=4h=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wGSPf49ltzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:03:18 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wGSPf39LHz8w5S
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 May 2017 12:03:18 +1000 (AEST)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wGSPd5H5Wz9s9c
 for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2017 12:03:17 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id b23so10203805pfc.0
 for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2017 19:03:17 -0700 (PDT)
Date: Mon, 1 May 2017 12:03:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Anton Blanchard <anton@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc/xmon: Wait for secondaries before IPI'ing on
 system reset
Message-ID: <20170501120300.18e1a4d4@roar.ozlabs.ibm.com>
In-Reply-To: <20170430222758.79fa94ea@kryten>
References: <1493377669-7658-1-git-send-email-mpe@ellerman.id.au>
 <20170430222758.79fa94ea@kryten>
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

On Sun, 30 Apr 2017 22:27:58 +1000
Anton Blanchard <anton@samba.org> wrote:

> Hi Nick,
> 
> > An externally triggered system reset (e.g., via QEMU nmi command, or
> > pseries reset button) can cause system reset interrupts on all CPUs.
> > In case this causes xmon to be entered, it is undesirable for the
> > primary (first) CPU into xmon to trigger an NMI IPI to others,
> > because this may cause a nested system reset interrupt.
> > 
> > So spin for a time waiting for secondaries to join xmon before
> > performing the NMI IPI, similarly to what the crash dump code does.  
> 
> That reminds me of similar delays in our crash path:
> 
> /*
>  * The primary CPU waits a while for all secondary CPUs to enter. This is to
>  * avoid sending an IPI if the secondary CPUs are entering
>  * crash_kexec_secondary on their own (eg via a system reset).
>  *
>  * The secondary timeout has to be longer than the primary. Both timeouts are
>  * in milliseconds.
>  */
> #define PRIMARY_TIMEOUT         500
> #define SECONDARY_TIMEOUT       1000
> 
> ...
> 
>         /*
>          * If we came in via system reset, wait a while for the secondary
>          * CPUs to enter.
>          */
>         if (TRAP(regs) == 0x100)
>                 mdelay(PRIMARY_TIMEOUT);
> 
> We might want to consolidate the juggling we do. Not sure if many people use
> it, but kdb and kgdb may benefit if we make it common.

Good point, yes we definitely should consolidate these. I had a few misc patches
that were supposed to improve the crash paths to go after the NMI stacks and
IPIs series. I'll look at consolidating some of this timeout logic there, if
nobody beats me to it. Thanks.
