Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F0092C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Oct 2013 03:38:52 +1100 (EST)
Message-ID: <1382114321.7979.840.camel@snotra.buserror.net>
Subject: Re: [PATCH] [RFC] Emulate "lwsync" to run standard user land on
 e500 cores
From: Scott Wood <scottwood@freescale.com>
To: Wolfgang Denk <wd@denx.de>
Date: Fri, 18 Oct 2013 11:38:41 -0500
In-Reply-To: <1382081880-6666-1-git-send-email-wd@denx.de>
References: <1382081880-6666-1-git-send-email-wd@denx.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-10-18 at 09:38 +0200, Wolfgang Denk wrote:
> Default Debian PowerPC doesn't work on e500 because the code contains
> "lwsync" instructions, which are unsupported on this core.  As a
> result, applications using this will crash with an "unhandled signal 4"
> "Illegal instruction" error.
> 
> As a work around we add code to emulate this insn.  This is expensive
> performance-wise, but allows to run standard user land code.
> 
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Scott Wood <scottwood@freescale.com>
> ---
> I am aware that the clean solution to the problem is to build user
> space with compiler options that match the target architecture.
> However, sometimes this is just too much effort.
> 
> Also, of course the performance of such an emulation sucks. But the
> the occurrence of such instructions is so rare that no significant
> slowdown can be oserved.
> 
> I'm not sure if this should / could go into mainline.  I'm posting it
> primarily so it can be found should anybody else need this.
> - wd
> 
>  arch/powerpc/kernel/traps.c | 7 +++++++
>  1 file changed, 7 insertions(+)

There's already been a patch posted for this:
http://patchwork.ozlabs.org/patch/256747/

I plan to apply it for my next pull request.

-Scott
