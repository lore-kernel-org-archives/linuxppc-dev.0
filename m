Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 4B272DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Mar 2009 10:08:02 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1923499yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Mar 2009 15:08:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <025a01c99c8b$90afb030$6b03a8c0@sdelaney2>
References: <025a01c99c8b$90afb030$6b03a8c0@sdelaney2>
Date: Wed, 4 Mar 2009 16:08:01 -0700
Message-ID: <fa686aa40903041508h4da7a567ka0def0dcd26a7792@mail.gmail.com>
Subject: Re: mpc8349e-mitx 2.6.25 serial IRQ assigned wrong
From: Grant Likely <grant.likely@secretlab.ca>
To: onramp123@yahoo.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 3, 2009 at 10:39 PM, Steve DeLaney <onramp123@yahoo.com> wrote:
> I didn't realize before that /proc/interrupts
> serviced by irq.c show_interrupts() displays virtual vector numbers.
>
> For the mpc8349e-mitx this must be incorrect since there is no ISA?
> Essentially all that is needed is a 1:1 mapping hirq:virq since
> each interrupt source in the system appears to have a unique vector
> in the SOC IPIC. =A0It seems this scheme is needlessly complex, at least =
for
> mpc8349e.

It may look to be needlessly complex for boards that only have one
interrupt controller, but it is far simpler than the alternative when
you have boards with multiple cascaded IRQ controllers.  This is not
an uncommon circumstance any more, even on embedded boards.  ie. I'm
working on two different MPC5200 platforms and each has an FPGA which
coalesces interrupts to a single MPC5200 external IRQ line.

Without VIRQs, I'd need to slice up the IRQ number space for each
board variant I work with and write the code to match.  With VIRQs,
there is no need to, and all of the boards can use common support
code.

g.
.
--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
