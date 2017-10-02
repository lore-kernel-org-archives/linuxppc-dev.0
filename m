Return-Path: <linus971@gmail.com>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5Wmj20j0zDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 06:04:20 +1100 (AEDT)
Received: by mail-io0-x241.google.com with SMTP id n69so3602400ioi.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Oct 2017 12:04:20 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <alpine.DEB.2.20.1710021957480.2114@nanos>
References: <alpine.DEB.2.20.1710011217510.3874@nanos>
 <CA+55aFxQsmSb=zohGZOZK7eR4n5xOHNArmCa9j1b7+wJ+khQrg@mail.gmail.com>
 <alpine.DEB.2.20.1710021957480.2114@nanos>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Oct 2017 12:04:17 -0700
Message-ID: <CA+55aFyVX_aPac8dSJPED-XLTtfQOYe_eCV7HdYKABgGazWHAg@mail.gmail.com>
Subject: Re: [RFC GIT Pull] core watchdog sanitizing
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Don Zickus <dzickus@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 2, 2017 at 11:46 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I agree that adding that 'run' argument was certainly not a piece of
> art. Though I disagree with the sentiment that non-functional garbage is
> preferrable over functionally correct code which merily contains a bad
> implementation choice.

I agree that it's somewhat arbitrary, but I also find it really hard
to vet code where my initial reaction is just "this is too ugly".

So it may be superficial, but ..

> Enough vented. Find below the cure for that major offense.

Looks much better to me. Thanks.

Side note: would it perhaps make sense to have that
cpus_read_lock/unlock() sequence around the whole reconfiguration
section?

Because while looking at that sequence, it looks a bit odd to me that
cpu's can come and go in the middle of the nmi watchdog
reconfiguration sequence.

In particular, what happens if a new CPU is brought up just as the NMI
matchdog is being reconfigured? The NMI's have been stopped for the
old CPU's, what happens for the new one that came up in between that
watchdog_nmi_stop/start?

This may be all obviously safe, I'm just asking for clarification.

               Linus
