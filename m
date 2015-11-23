Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E79BF1A029E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 19:24:51 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 13:54:48 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7C003E0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 13:55:18 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAN8OZTa42664142
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 13:54:36 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAN8OYxH017182
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 13:54:34 +0530
Message-ID: <5652CD42.5010008@linux.vnet.ibm.com>
Date: Mon, 23 Nov 2015 13:54:34 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Add rN aliases to the pt_regs_offset table.
References: <1448086096-3117-1-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1448086096-3117-1-git-send-email-rashmicy@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2015 11:38 AM, Rashmica Gupta wrote:
> It is common practice with powerpc to use 'rN' to refer to register 'N'. However
> when using the pt_regs_offset table we have to use 'gprN'.
> 
> So add aliases such that both 'rN' and 'gprN' can be used.
> 
> For example, we can currently do:
> $ su -
> $ echo "p:probe/sys_fchownat .sys_fchownat %gpr3:s32 +0(%gpr4):string %gpr5:s32
> %gpr6:s32 %gpr7:s32" > /sys/kernel/debug/tracing/kprobe_events
> $ echo 1 > /sys/kernel/debug/tracing/events/probe/sys_fchownat/enable
> $ touch /tmp/foo
> $ chown root /tmp/foo
> $ echo 0 > /sys/kernel/debug/tracing/events/enable
> $ cat /sys/kernel/debug/tracing/trace
>            chown-5040  [001] d... 24800.047211: sys_fchownat:
> (.SyS_fchownat+0x0/0x190) arg1=-100 arg2="foo" arg3=0 arg4=-1 arg5=0
> 
> Instead we'd like to be able to use:
> $ echo "p:probe/sys_fchownat sys_fchownat %r3:s32 +0(%r4):string %r5:s32
> %r6:s32 %r7:s32" > /sys/kernel/debug/tracing/kprobe_events

This makes sense and works for me on a LE guest. Just that the symbol
should not have the "." before it. 
