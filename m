Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD2A92C00A2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Oct 2013 20:45:47 +1100 (EST)
Message-ID: <1382607919.9395.56.camel@pasglop>
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on
 e500 cores
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 24 Oct 2013 10:45:19 +0100
In-Reply-To: <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
 <1382523314.3926.21.camel@aoeu.buserror.net>
 <BE5B0245-4ED1-4E3F-ADB1-F6A70C8FE3E1@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-23 at 23:06 -0500, Kumar Gala wrote:
> On Oct 23, 2013, at 5:15 AM, Scott Wood wrote:
> 
> > On Wed, 2013-10-23 at 00:07 -0500, Kumar Gala wrote:
> >> On Oct 18, 2013, at 2:38 AM, Wolfgang Denk wrote:
> >>> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> >>> index f783c93..f330374 100644
> >>> --- a/arch/powerpc/kernel/traps.c
> >>> +++ b/arch/powerpc/kernel/traps.c
> >>> @@ -986,6 +986,13 @@ static int emulate_instruction(struct pt_regs *regs)
> >>> 		return 0;
> >>> 	}
> >>> 
> >>> +	/* Emulating the lwsync insn as a sync insn */
> >>> +	if (instword == PPC_INST_LWSYNC) {
> >>> +		PPC_WARN_EMULATED(lwsync, regs);
> >>> +		asm volatile("sync" : : : "memory");
> >> 
> >> Do we really need the inline asm?  Doesn't the fact of just taking an exception and returning from it equate to a sync.
> > 
> > No, it doesn't equate to a sync.  See the discussion here:
> > http://patchwork.ozlabs.org/patch/256747/
> > 
> 
> Thanks. 
> 
> I'm not sure I'm a fan of doing this as it silently hides a significant performance impact.
> 
> Could we possible re-write the userspace instruction to be a 'sync' when we hit this?

Rewriting user space is a can of worms I wouldn't get into ... is any
other arch doing it ?

I'm not too worried as long as we warn and account them.

Cheers,
Ben.
