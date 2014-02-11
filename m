Return-Path: <raghavendra.kt.linux@gmail.com>
Received: from mail-qc0-x22e.google.com (mail-qc0-x22e.google.com
 [IPv6:2607:f8b0:400d:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F34042C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 20:53:54 +1100 (EST)
Received: by mail-qc0-f174.google.com with SMTP id x13so12609663qcv.33
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Feb 2014 01:53:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1392001823.3996.21.camel@pasglop>
References: <20140207165801.GC2107@lst.de> <1392001823.3996.21.camel@pasglop>
Date: Tue, 11 Feb 2014 15:23:51 +0530
Message-ID: <CAC4Lta2Pssu5QY_QLmy5C3Fm2G3fwpiuc5BNOLBnQTmmRH+W4Q@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc ticket locks
From: Raghavendra KT <raghavendra.kt.linux@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Torsten Duwe <duwe@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Tom Musta <tommusta@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Raghavendra KT <raghavendra.kt@linux.vnet.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Scott Wood <scottwood@freescale.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 10, 2014 at 8:40 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2014-02-07 at 17:58 +0100, Torsten Duwe wrote:
>>  typedef struct {
>> -       volatile unsigned int slock;
>> -} arch_spinlock_t;
>> +       union {
>> +               __ticketpair_t head_tail;
>> +               struct __raw_tickets {
>> +#ifdef __BIG_ENDIAN__          /* The "tail" part should be in the MSBs */
>> +                       __ticket_t tail, head;
>> +#else
>> +                       __ticket_t head, tail;
>> +#endif
>> +               } tickets;
>> +       };
>> +#if defined(CONFIG_PPC_SPLPAR)
>> +       u32 holder;
>> +#endif
>> +} arch_spinlock_t __aligned(4);
>
> That's still broken with lockref (which we just merged).
>
> We must have the arch_spinlock_t and the ref in the same 64-bit word
> otherwise it will break.
>
> We can make it work in theory since the holder doesn't have to be
> accessed atomically, but the practicals are a complete mess ...
> lockref would essentially have to re-implement the holder handling
> of the spinlocks and use lower level ticket stuff.
>

Probably very basic and stupid question from me.
How much important to have holder information for PPC? From my
previous experiment
on x86, it was lock-waiter preemption which is problematic rather than
lock-holder preemption.
