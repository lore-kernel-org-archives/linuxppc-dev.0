Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A5FC02C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Oct 2013 21:15:32 +1100 (EST)
Message-ID: <1382523314.3926.21.camel@aoeu.buserror.net>
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on
 e500 cores
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 23 Oct 2013 11:15:14 +0100
In-Reply-To: <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
 <39CCEB38-1D9B-4918-B8F4-148D4E90FE21@kernel.crashing.org>
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

On Wed, 2013-10-23 at 00:07 -0500, Kumar Gala wrote:
> On Oct 18, 2013, at 2:38 AM, Wolfgang Denk wrote:
> > diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> > index f783c93..f330374 100644
> > --- a/arch/powerpc/kernel/traps.c
> > +++ b/arch/powerpc/kernel/traps.c
> > @@ -986,6 +986,13 @@ static int emulate_instruction(struct pt_regs *regs)
> > 		return 0;
> > 	}
> > 
> > +	/* Emulating the lwsync insn as a sync insn */
> > +	if (instword == PPC_INST_LWSYNC) {
> > +		PPC_WARN_EMULATED(lwsync, regs);
> > +		asm volatile("sync" : : : "memory");
> 
> Do we really need the inline asm?  Doesn't the fact of just taking an exception and returning from it equate to a sync.

No, it doesn't equate to a sync.  See the discussion here:
http://patchwork.ozlabs.org/patch/256747/

-Scott
