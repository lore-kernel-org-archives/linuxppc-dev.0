Return-Path: <timur.tabi@gmail.com>
Received: from mail-ew0-f165.google.com (mail-ew0-f165.google.com
	[209.85.219.165]) by ozlabs.org (Postfix) with ESMTP id 3FDEFDDF00
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Mar 2009 06:15:03 +1100 (EST)
Received: by ewy9 with SMTP id 9so122952ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 12:14:59 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <49B7EC27.3030305@freescale.com>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
	<1236729551.7086.26.camel@pasglop>
	<ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
	<adaiqmgbq6w.fsf@cisco.com>
	<ed82fe3e0903110931y62e23a02yf2a9719e5a69bd2@mail.gmail.com>
	<49B7EC27.3030305@freescale.com>
Date: Wed, 11 Mar 2009 14:14:59 -0500
Message-ID: <ed82fe3e0903111214j2072319pe985e6bbecdd1665@mail.gmail.com>
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

On Wed, Mar 11, 2009 at 11:51 AM, Scott Wood <scottwood@freescale.com> wrote:

> One jiffy is fine, but two is just too long?

Any number of jiffies is *not* too long if a timeout occurs.  However,
I think even one jiffy is too long if that's the normal condition.
Unfortunately, the driver may not have any choice in some
circumstances.  If the hardware is just too slow to respond, and it
doesn't provide interrupts, but the code is running in atomic context,
and the function what else can it do?

> Disallow that, enforced with a call to might_sleep().

I think we need to be able to allow this function to work in atomic
context.  Is jiffies updated in atomic context?

> Alternatively, do something with get_cycles(), and have some sort of #define
> by which arches can say if get_cycles actually works.  In the absence of a
> working get_cycles() or equivalent, timeouts with interrupts disabled aren't
> going to happen whether we abstract it with a macro or not.

I think I can live with that.

-- 
Timur Tabi
Linux kernel developer at Freescale
