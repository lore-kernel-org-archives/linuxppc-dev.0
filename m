Return-Path: <shawnxjin@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.199])
	by ozlabs.org (Postfix) with ESMTP id 5399A67A70
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 07:14:24 +1000 (EST)
Received: by rproxy.gmail.com with SMTP id 40so473603rnz
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Apr 2005 14:14:23 -0700 (PDT)
Message-ID: <c3d0340b05041814144133a608@mail.gmail.com>
Date: Mon, 18 Apr 2005 14:14:23 -0700
From: Shawn Jin <shawnxjin@gmail.com>
To: ppcembed <linuxppc-embedded@ozlabs.org>
In-Reply-To: <20050416005026.GB1086@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <c3d0340b05041514362746169a@mail.gmail.com>
	<20050415221235.GA29802@gate.ebshome.net>
	<c3d0340b0504151609397d73f7@mail.gmail.com>
	<20050416005026.GB1086@gate.ebshome.net>
Subject: Re: Interrupt prioritization on linux for ppc440
Reply-To: Shawn Jin <shawnxjin@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 4/15/05, Eugene Surovegin <ebs@ebshome.net> wrote:
> I really think that if you need some special higher-priority IRQ
> context you'd better use RTAI or RTLinux. At least, they make clear
> (IIRC) that these IRQ contexts are special.

OK, I'll look into RTAI or RTLinux for priority issue.

> What could be interesting, though, is to to make all 4xx IRQs
> critical, in this case we could use VR to quickly determine which IRQ
> was asserted, instead of current implementation when we use bit
> operations. Not sure, if performance gain is really worth the
> effort :)

If we use VR to determine which IRQ was asserted, it's kind of
reverse. We usually fetch a handler by its IRQ number. It could
require to change irq_desc[] and request_irq().

VR can be calculated automatically provided that VCR is set. What
should be the vector base address? One possible way is similar to the
way how IVPR is set to interrupt_base in head_44x.S but leave the
actual interrupt handler blank, which will be filled in later with a
jump instruction which jumps to the actual ISR once a device driver
request its irq. This means that request_irq() needs to modify kernel
code. Kinda of dangerous, isn't it? This might be part of
infrastructure change you mentioned?

Regards,
-Shawn.
