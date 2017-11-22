Return-Path: <srs0=/uob=cu=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhyVf0y4tzDql3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 09:56:10 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yhyVd66zXz8t88
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Nov 2017 09:56:09 +1100 (AEDT)
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yhyVc72Sqz9s71
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2017 09:56:08 +1100 (AEDT)
Received: by mail-ua0-x243.google.com with SMTP id s28so11683534uag.4
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2017 14:56:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
References: <151137178794.14123.18003389448303728066.stgit@jupiter.in.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 23 Nov 2017 09:56:05 +1100
Message-ID: <CAKTCnzkSJo0wKx96=N2fxDVZ8KaM+uT3sUHGNgtdOD=RLajwCg@mail.gmail.com>
Subject: Re: [PATCH] powernv: Avoid calling trace tlbie in kexec path.
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 23, 2017 at 4:32 AM, Mahesh J Salgaonkar
<mahesh@linux.vnet.ibm.com> wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> Rebooting into a new kernel with kexec fails in trace_tlbie() which is
> called from native_hpte_clear(). This happens if the running kernel has
> CONFIG_LOCKDEP enabled. With lockdep enabled, the tracepoints always
> execute few RCU checks regardless of whether tracing is on or off.
> We are already in the last phase of kexec sequence in real mode with
> HILE_BE set. At this point the RCU check ends up in RCU_LOCKDEP_WARN and
> causes kexec to fail.
>

Effectively we can't enter the trace point code after we've set
HILE_BE.  Do we need
a fixes tag? Or is this a side-effect of a new generic change?

I think the right thing in the longer run might be to do a TRACE_EVENT_CONDITION
and have the condition do the right thing, but what you have for now is good.

Balbir Singh.
