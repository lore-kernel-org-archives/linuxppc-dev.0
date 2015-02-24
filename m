Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-we0-x230.google.com (mail-we0-x230.google.com
 [IPv6:2a00:1450:400c:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D763D1A0D91
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2015 17:41:14 +1100 (AEDT)
Received: by wesu56 with SMTP id u56so23149298wes.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 22:41:11 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 24 Feb 2015 07:41:07 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/7] Add die_spin_lock_{irqsave,irqrestore}
Message-ID: <20150224064107.GB15387@gmail.com>
References: <1424748634-9153-1-git-send-email-anton@samba.org>
 <1424748634-9153-2-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424748634-9153-2-git-send-email-anton@samba.org>
Cc: Don Zickus <dzickus@redhat.com>, x86@kernel.org,
 Russell King <linux@arm.linux.org.uk>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 peterz@infradead.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>, sam.bobroff@au1.ibm.com,
 Arjan van de Ven <arjan@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Anton Blanchard <anton@samba.org> wrote:

> +static arch_spinlock_t die_lock = __ARCH_SPIN_LOCK_UNLOCKED;
> +static int die_owner = -1;
> +static unsigned int die_nest_count;
> +
> +unsigned long __die_spin_lock_irqsave(void)
> +{
> +	unsigned long flags;
> +	int cpu;
> +
> +	/* racy, but better than risking deadlock. */
> +	raw_local_irq_save(flags);
> +
> +	cpu = smp_processor_id();
> +	if (!arch_spin_trylock(&die_lock)) {
> +		if (cpu != die_owner)
> +			arch_spin_lock(&die_lock);

So why not trylock and time out here after a few seconds, 
instead of indefinitely supressing some potentially vital 
output due to some other CPU crashing/locking with the lock 
held?

> +	}
> +	die_nest_count++;
> +	die_owner = cpu;
> +
> +	return flags;

I suspect this would work in most cases.

If we fix the deadlock potential, and get a true global 
ordering of various oopses/warnings as they triggered (or 
at least timestamping them), then I'm sold on this I guess, 
it will likely improve things.

Thanks,

	Ingo
