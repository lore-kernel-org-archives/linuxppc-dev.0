Return-Path: <daniel.thompson@linaro.org>
Received: from mail-wm0-x234.google.com (mail-wm0-x234.google.com
 [IPv6:2a00:1450:400c:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CFC71A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 01:04:26 +1100 (AEDT)
Received: by mail-wm0-x234.google.com with SMTP id p65so34925617wmp.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 01 Mar 2016 06:04:26 -0800 (PST)
Subject: Re: [PATCH v3 4/4] printk/nmi: Increase the size of NMI buffer and
 make it configurable
To: Petr Mladek <pmladek@suse.com>
References: <1449667265-17525-1-git-send-email-pmladek@suse.com>
 <1449667265-17525-5-git-send-email-pmladek@suse.com>
 <CAMuHMdXVgr58YjoePGrRbMyMncQ27f85prL7G5SpeHeNxoYrXQ@mail.gmail.com>
 <20151211124159.GB3729@pathway.suse.cz>
 <20151211145725.b0e81bb4bb18fcd72ef5f557@linux-foundation.org>
 <20151211232113.GZ8644@n2100.arm.linux.org.uk>
 <alpine.LNX.2.00.1512120024370.9922@cbobk.fhfr.pm>
 <5673DD60.7080302@linaro.org> <20151218145207.GK3729@pathway.suse.cz>
 <56743BA0.1030409@linaro.org>
Cc: Jiri Kosina <jikos@kernel.org>,
 Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
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
Message-ID: <56D5A164.3000000@linaro.org>
Date: Tue, 1 Mar 2016 14:04:20 +0000
MIME-Version: 1.0
In-Reply-To: <56743BA0.1030409@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18/12/15 17:00, Daniel Thompson wrote:
>>> The MCE handlers should only call printk() when they decide to panic
>>> and *after* busting the spinlocks. At this point deferring printk()
>>> until it is safe is not very helpful.
>>>
>>> When we bust the spinlocks we should probably restore the normal
>>> printk() function to give best chance of the failure messages making
>>> it out.
>>
>> The problem is that we do not know what locks need to be busted. There
>> are too many consoles and too many locks involved. Also busting locks
>> open another can of worms.
>
> Yes, I agree that busting the spinlocks doesn't avoid all risk of deadlock.
>
> Probably I've been placing too much weight on the importance of getting
> messages out when dying. You're right that surviving far enough through
> a panic to trigger kdump or reset is equally (or more) important in many
> scenarios than getting a failure message out.
>
> However on a system with nothing but "while(1) {}" hooked up to panic()
> then its worth risking a lock up. In this case restoring normal printk()
> behavior and dumping the NMI buffers would be worthwhile.

An a (much) later thread[1] Andrew Morton described this comment as 
non-committal. Sorry for that.

I don't object to the overall approach taken by Petr, merely that I 
think there are cases where the current patchset doesn't put in quite 
enough effort to issue messages.

Panic triggered during NMI is the only case I can think of and that, I 
think, could be addressed by adding an extra call to printk_nmi_flush() 
during panic(). It should probably only cover cases where we *don't* 
call kdump and the panic handler doesn't restart the machine... so just 
after the pr_emerg("...end kernel panic") would be OK for me.


Daniel.


[1]: http://thread.gmane.org/gmane.linux.ports.arm.kernel/482845
