Return-Path: <kay@vrfy.org>
Received: from mail-pb0-f42.google.com (mail-pb0-f42.google.com
 [209.85.160.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10EDF2C01CC
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jul 2012 18:39:53 +1000 (EST)
Received: by pbbrp12 with SMTP id rp12so10651277pbb.15
 for <linuxppc-dev@ozlabs.org>; Thu, 05 Jul 2012 01:39:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <22482.1341471787@neuling.org>
References: <1340651142.7037.2.camel@gandalf.stny.rr.com>
 <20120625150722.8cd4f45d.akpm@linux-foundation.org>
 <20120625235531.GB3652@kroah.com>
 <CA+55aFwczZTA=JUahoj_Sw1fQssDwoM2LGJ6g5nPvehTLxnSpg@mail.gmail.com>
 <20120626002307.GA4389@kroah.com>
 <CA+55aFxhYRqcU2EUmcsuLrhgo4FEO6-b+mB57wB3JRiXEp3ZrA@mail.gmail.com>
 <CAPXgP10cPFSmZ5yr6Z4wVtDa+x2J1yQDF57NJXtxjUuxMHm=Lw@mail.gmail.com>
 <CA+55aFzkX=jCC1O6+2oz8meswOqZQ+Q8Ao60q8eAS1G3AuEStQ@mail.gmail.com>
 <1340726856.977.6.camel@mop> <22482.1341471787@neuling.org>
From: Kay Sievers <kay@vrfy.org>
Date: Thu, 5 Jul 2012 10:39:31 +0200
Message-ID: <CAPXgP11=o5WB4WejaQCSCL-+5e4sL7tfVz_r3Khyrq3SyrMvsA@mail.gmail.com>
Subject: Re: [PATCH v3] printk: Have printk() never buffer its data
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@us.ibm.com>, linuxppc-dev@ozlabs.org,
 Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>,
 Wu Fengguang <fengguang.wu@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 5, 2012 at 9:03 AM, Michael Neuling <mikey@neuling.org> wrote:
>> On Mon, 2012-06-25 at 18:40 -0700, Linus Torvalds wrote:

>> > I think it might be a great idea to buffer for logging in order to
>> > generate one individual buffer record there.
>> >
>> > But it needs to be printed as it is generated.
>>
>> That's a good idea.
>>
>> Something like this could work - only minimally tested at this moment.
>
> This breaks some powerpc configs and is in Linus' tree now as
> 084681d14e.
>
> When we have printks without a newline (like show_regs()), it
> sometimes:

x86 has that a lot too.

> 1) drops the console output for that line (dmesg is fine).  Patch to fix
>    this below.

That doesn't look right. We should already have put that out to the
console, and we only want to store it away. Your patch, as expected,
duplicates all the continuation lines on the console here:
[    0.674957] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.674957] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0

> 2) adds a newline unnecessary to both console and dmesg.  I have no fix
>    for this currently.
> Reverting this patch fixes both problems.

Not here. I can't reproduce any of this here, it all looks fine.

Is that possibly some early printk() or other console trickery on ppc
that produces the issue?

Thanks,
Kay
