Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xchnR5VNTzDqV5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 19:23:55 +1000 (AEST)
Message-ID: <1503480234.25055.20.camel@neuling.org>
Subject: Re: [PATCH RFC 2/7] powerpc: Change analyse_instr so it doesn't
 modify *regs
From: Michael Neuling <mikey@neuling.org>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
Date: Wed, 23 Aug 2017 19:23:54 +1000
In-Reply-To: <1503445683-12011-3-git-send-email-paulus@ozlabs.org>
References: <1503445683-12011-1-git-send-email-paulus@ozlabs.org>
 <1503445683-12011-3-git-send-email-paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-08-23 at 09:47 +1000, Paul Mackerras wrote:
> The analyse_instr function currently doesn't just work out what an
> instruction does, it also executes those instructions whose effect
> is only to update CPU registers that are stored in struct pt_regs.
> This is undesirable because optprobes uses analyse_instr to work out
> if an instruction could be successfully emulated in future.
>=20
> This changes analyse_instr so it doesn't modify *regs; instead it
> stores information in the instruction_op structure to indicate what
> registers (GPRs, CR, XER, LR) would be set and what value they would
> be set to.=C2=A0=C2=A0A companion function called emulate_update_regs() c=
an
> then use that information to update a pt_regs struct appropriately.
>=20
> As a minor cleanup, this replaces inline asm using the cntlzw and
> cntlzd instructions with calls to __builtin_clz() and __builtin_clzl().

+1 ! This is super useful!

As mentioned offline, this clashes with the recent changes to sstep.c in po=
werpc
next.  In fact, the new instructions added there need to have these changes
applied.

Mikey
