Return-Path: <fweisbec@gmail.com>
Received: from mail-la0-x234.google.com (mail-la0-x234.google.com
 [IPv6:2a00:1450:4010:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 04BE32C0095
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 01:10:20 +1100 (EST)
Received: by mail-la0-f52.google.com with SMTP id fs12so5118476lab.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 06:10:13 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1359714465-6297-3-git-send-email-zhong@linux.vnet.ibm.com>
References: <1359714465-6297-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1359714465-6297-3-git-send-email-zhong@linux.vnet.ibm.com>
Date: Sun, 10 Feb 2013 15:10:13 +0100
Message-ID: <CAFTL4hzfXfCGDjwjW=Frcs5+jS_i3U_JHytNOEhEF5X7_Fw6Sg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] powerpc: Exception hooks for context tracking
 subsystem
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: paulmck@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2013/2/1 Li Zhong <zhong@linux.vnet.ibm.com>:
> This is the exception hooks for context tracking subsystem, including
> data access, program check, single step, instruction breakpoint, machine check,
> alignment, fp unavailable, altivec assist, unknown exception, whose handlers
> might use RCU.
>
> This patch corresponds to
> [PATCH] x86: Exception hooks for userspace RCU extended QS
>   commit 6ba3c97a38803883c2eee489505796cb0a727122
>
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>

Looks good!

I guess we should move exception_enter/exit definition to the generic
code. They should be the same for all archs after all. Also we are
relying on user_mode(regs) but this may be buggy with some corner
cases. For example if an exception happen after a call to user_exit()
(on syscall exit) but before we actually resume in userspace, the
exception will exit in kernel mode from the context tracking POV.

So instead on relying on the regs, which are not sync with the context
tracking state, we should use something like:

prev_state = exception_enter();
...
exception_exit(prev_state);

Also preempt_schedule_irq() is concerned as well by this problem. So I
should convert it to that scheme as well. I'm going to prepare some
patches.

Feel free to merge this patch in the powerpc tree, I'll do the
conversion along the way.

Thanks.
