Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1A7242C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 21:36:44 +1100 (EST)
Message-ID: <1382697373.3926.36.camel@aoeu.buserror.net>
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on
 e500 cores
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 25 Oct 2013 11:36:13 +0100
In-Reply-To: <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
 <1382607919.9395.56.camel@pasglop>
 <6BFC8EB0-1A75-41C3-985A-E3ED14846710@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-10-24 at 04:55 -0500, Kumar Gala wrote:
> On Oct 24, 2013, at 4:45 AM, Benjamin Herrenschmidt wrote:
> 
> > On Wed, 2013-10-23 at 23:06 -0500, Kumar Gala wrote:
> >> On Oct 23, 2013, at 5:15 AM, Scott Wood wrote:
> >> 
> >>> On Wed, 2013-10-23 at 00:07 -0500, Kumar Gala wrote:
> >>>> On Oct 18, 2013, at 2:38 AM, Wolfgang Denk wrote:
> >>>>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> >>>>> index f783c93..f330374 100644
> >>>>> --- a/arch/powerpc/kernel/traps.c
> >>>>> +++ b/arch/powerpc/kernel/traps.c
> >>>>> @@ -986,6 +986,13 @@ static int emulate_instruction(struct pt_regs *regs)
> >>>>> 		return 0;
> >>>>> 	}
> >>>>> 
> >>>>> +	/* Emulating the lwsync insn as a sync insn */
> >>>>> +	if (instword == PPC_INST_LWSYNC) {
> >>>>> +		PPC_WARN_EMULATED(lwsync, regs);
> >>>>> +		asm volatile("sync" : : : "memory");
> >>>> 
> >>>> Do we really need the inline asm?  Doesn't the fact of just taking an exception and returning from it equate to a sync.
> >>> 
> >>> No, it doesn't equate to a sync.  See the discussion here:
> >>> http://patchwork.ozlabs.org/patch/256747/
> >>> 
> >> 
> >> Thanks. 
> >> 
> >> I'm not sure I'm a fan of doing this as it silently hides a significant performance impact.
> >> 
> >> Could we possible re-write the userspace instruction to be a 'sync' when we hit this?
> > 
> > Rewriting user space is a can of worms I wouldn't get into ... is any
> > other arch doing it ?
> 
> Fair enough
> > 
> > I'm not too worried as long as we warn and account them.
> 
> Than, I'd ask this be under a Kconfig option that is disabled by
> default.  Users should have to explicitly enable this so they know what
> they are doing.

Why should this be any different than the other emulated instructions,
which are generally either not kconfigized, or on by default in some
configs (like fp emu)?

Making sure users are aware of this is what PPC_WARN_EMULATED is for.

Has anyone measured how much this slows things down with a typical
userspace?

-Scott
