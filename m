Return-Path: <timur.tabi@gmail.com>
Received: from mail-ew0-f165.google.com (mail-ew0-f165.google.com
	[209.85.219.165]) by ozlabs.org (Postfix) with ESMTP id 92106DE213
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 07:45:50 +1100 (EST)
Received: by ewy9 with SMTP id 9so147634ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 13:45:47 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <49B80F7F.30705@freescale.com>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
	<1236729551.7086.26.camel@pasglop>
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
	<adaiqmgbq6w.fsf@cisco.com>
	<ed82fe3e0903110931y62e23a02yf2a9719e5a69bd2@mail.gmail.com>
	<49B7EC27.3030305@freescale.com>
	<ed82fe3e0903111214j2072319pe985e6bbecdd1665@mail.gmail.com>
	<49B80F7F.30705@freescale.com>
Date: Wed, 11 Mar 2009 15:45:47 -0500
Message-ID: <ed82fe3e0903111345m2962f5b5wdfc9e2efae1c33ae@mail.gmail.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
From: Timur Tabi <timur@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 2:22 PM, Scott Wood <scottwood@freescale.com> wrote=
:

> I was under the impression that we were only talking about timeouts, and
> that the common case was significantly shorter than that.

I think one of the concerns that Alan Cox raised is that the existence
of this macro would encourage people to spin for long durations.

> If it's atomic because preemption was disabled, yes -- but even a rare
> extended spin in such a context would be bad for hard realtime. =A0If
> interrupts are disabled, or the code is executing from a timer interrupt =
(or
> possibly other interrupts depending on the hardware and its priority
> scheme), no.

So in that case, I can't rely on jiffies.  I guess get_cycle() is my
only choice.  The problem is that there is no num_cycles_per_usec().

--=20
Timur Tabi
Linux kernel developer at Freescale
