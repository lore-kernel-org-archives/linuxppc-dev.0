Return-Path: <timur.tabi@gmail.com>
Received: from mail-ew0-f165.google.com (mail-ew0-f165.google.com
	[209.85.219.165]) by ozlabs.org (Postfix) with ESMTP id 3A408DE132
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:29:26 +1100 (EST)
Received: by ewy9 with SMTP id 9so1346465ewy.9
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 17:29:25 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1236729551.7086.26.camel@pasglop>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
	<1236729551.7086.26.camel@pasglop>
Date: Tue, 10 Mar 2009 19:22:28 -0500
Message-ID: <ed82fe3e0903101722i610638e8le1f2e925095c8ba6@mail.gmail.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
From: Timur Tabi <timur@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 10, 2009 at 6:59 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> And ? We can disagree with Alan...

If you guys want to argue with Alan on lkml, please go ahead.  I could
use the support.

Alan did have one valid point though.  Determining how long to loop
for is architecture-specific.  Using jiffies is bad, because even one
jiffy is too long.  Adding a udelay() inside the loop means that it
only checks he condition every microsecond.  So the real solution is
to use keep looping until a certain amount of time has passed.  This
means using an architecture-specific timebase register.

Now we can create a generic version of the function that uses jiffies,
and then arch-specific versions where possible.  But Alan still needs
to be convinced.  I already posted a length rebuttal to his email, but
I haven't gotten a reply yet.

-- 
Timur Tabi
Linux kernel developer at Freescale
