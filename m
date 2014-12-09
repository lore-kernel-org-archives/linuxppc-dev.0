Return-Path: <linus971@gmail.com>
Received: from mail-qg0-x22b.google.com (mail-qg0-x22b.google.com
 [IPv6:2607:f8b0:400d:c04::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A78C91A05FC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 07:54:47 +1100 (AEDT)
Received: by mail-qg0-f43.google.com with SMTP id i50so1115330qgf.30
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Dec 2014 12:54:44 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20141209105819.0e847b4b@kryten>
References: <1418009221-12719-1-git-send-email-anton@samba.org>
 <20141208083408.GA8023@gmail.com> <20141208211859.6e81ec81@kryten>
 <20141209105819.0e847b4b@kryten>
Date: Tue, 9 Dec 2014 12:54:43 -0800
Message-ID: <CA+55aFyR5PzNkojvEej1NXnpEFOPOYfnxCcPDAjg1rE79tQv7A@mail.gmail.com>
Subject: Re: [PATCH] powerpc: secondary CPUs signal to master before setting
 active and online (fixes kernel BUG at kernel/smpboot.c:134!)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=UTF-8
Cc: Peter Zijlstra <peterz@infradead.org>,
 Yuanhan Liu <yuanhan.liu@linux.intel.com>,
 Benjamin Segall <bsegall@google.com>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
 yuyang.du@intel.com, Daniel J Blueman <daniel@numascale.com>,
 Steven Rostedt <rostedt@goodmis.org>, subbaram@codeaurora.org,
 Thomas Gleixner <tglx@linutronix.de>, Wu Fengguang <fengguang.wu@intel.com>,
 lkp@01.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Slava Pestov <sp@datera.io>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brian Norris <computersforpeace@gmail.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 8, 2014 at 3:58 PM, Anton Blanchard <anton@samba.org> wrote:
> Hi Ingo,
>
>> At that point I thought the previous task_cpu() was somewhat ingrained
>> in the scheduler and came up with the patch. If not, we could go on a
>> hunt to see what else needs fixing.
>
> I had another look. The scheduled does indeed make assumptions about the
> previous task_cpu, but we have a hammer to fix it up called
> select_fallback_rq.
>
> I annotated select_fallback_rq, and did hit a case where the CPU was
> not active. ppc64 patch below.

Anton, I'll assume I will get this through the usual powerpc pull requests?

> I think x86 have a similar (although harder to hit) issue.

Ingo?

                         Linus
