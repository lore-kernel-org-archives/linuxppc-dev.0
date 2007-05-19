Return-Path: <acahalan@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.235])
	by ozlabs.org (Postfix) with ESMTP id 21F57DDED2
	for <linuxppc-dev@ozlabs.org>; Sun, 20 May 2007 04:22:17 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so2012938nzf
	for <linuxppc-dev@ozlabs.org>; Sat, 19 May 2007 11:22:16 -0700 (PDT)
Message-ID: <787b0d920705191122m5f481d54k363f5f473880a664@mail.gmail.com>
Date: Sat, 19 May 2007 14:22:15 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH 2.6.21-rt2] PowerPC: decrementer clockevent driver
In-Reply-To: <fa84736ae121902d4bee24eb23ca1d0b@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <787b0d920705172024g723412b4n8f82d3cd78e0f702@mail.gmail.com>
	<464DBDBA.3060801@ru.mvista.com>
	<787b0d920705181845h355eed4fk2bf93323332a9d90@mail.gmail.com>
	<fa84736ae121902d4bee24eb23ca1d0b@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 5/19/07, Segher Boessenkool <segher@kernel.crashing.org> wrote:
> [Albert Cahalan]

> > Set MMCR0[TBEE], set MMCR0[PMXE], and choose a TBL bit via
> > MMCR0[TBSEL].
>
> That's the performance monitor, which could very well be
> in use already (for performance monitoring stuff, who
> would have guessed).

It is the performance monitor, which sadly can not be used
very well unless the decrementer is disabled. The hardware
is buggy. As long as we use the decrementer for timekeeping,
we can not safely generate performance monitor interrupts.

I'd like to have the performance monitor available. It's NOT
available unless we use part of it for timekeeping. That's the
choice the hardware gives us.

We can get TBL bit flip interrupts for free. We don't even need
to give up one of the event counters. If we do give up one of the
event counters (a rather reasonable idea), then we can count
one of those TBL bit flips or the cycle counter.
