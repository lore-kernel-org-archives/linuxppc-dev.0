Return-Path: <daniel.thompson@linaro.org>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com
 [IPv6:2a00:1450:400c:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 161A51A1A19
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 21:18:13 +1100 (AEDT)
Received: by mail-wm0-x233.google.com with SMTP id l126so58474670wml.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Dec 2015 02:18:13 -0800 (PST)
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
To: Jiri Kosina <jikos@kernel.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek
 <pmladek@suse.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 Cris <linux-cris-kernel@axis.com>,
 Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-s390 <linux-s390@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 sparclinux <sparclinux@vger.kernel.org>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <5673DD60.7080302@linaro.org>
Date: Fri, 18 Dec 2015 10:18:08 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/12/15 23:26, Jiri Kosina wrote:
> On Fri, 11 Dec 2015, Russell King - ARM Linux wrote:
>
>> I'm personally happy with the existing code, and I've been wondering why
>> there's this effort to apply further cleanups - to me, the changelogs
>> don't seem to make that much sense, unless we want to start using
>> printk() extensively in NMI functions - using the generic nmi backtrace
>> code surely gets us something that works across all architectures...
>
> It is already being used extensively, and not only for all-CPU backtraces.
> For starters, please consider
>
> - WARN_ON(in_nmi())
> - BUG_ON(in_nmi())

Sorry to join in so late but...

Today we risk deadlock when we try to issue these diagnostic errors 
directly from NMI context.

After this change we will still risk deadlock, because that's what the 
diagnostic code is trying to tell us, *and* we delay actually reporting 
the error until, and only if, the NMI handler completes.

I'm not entirely sure that this is an improvement.


> - anything being printed out from MCE handlers

The MCE handlers should only call printk() when they decide to panic and 
*after* busting the spinlocks. At this point deferring printk() until it 
is safe is not very helpful.

When we bust the spinlocks we should probably restore the normal 
printk() function to give best chance of the failure messages making it out.


Daniel.
