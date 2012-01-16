Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1A7F5B6EF7
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jan 2012 07:22:25 +1100 (EST)
Message-ID: <4F1486F1.7000406@freescale.com>
Date: Mon, 16 Jan 2012 14:22:09 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
Subject: Re: Cannot wake-up from standby with MPC8313
References: <4F047BF8.7090400@aimvalley.nl> <4F04BFEA.1050009@freescale.com>
 <4F05C8C2.9070401@aimvalley.nl> <4F05EA6B.9040902@freescale.com>
 <4F06FCBC.4090302@aimvalley.nl> <4F076187.2080308@freescale.com>
 <4F103C17.3080003@aimvalley.nl>
In-Reply-To: <4F103C17.3080003@aimvalley.nl>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2012 08:13 AM, Norbert van Bolhuis wrote:
> I dumped SIPNR/SIMSR and uart IIR/EIR (since console triggers wake-up)
> but they do not change just before entering standby (via
> mpc6xx_enter_standby
> which omits setting MSR_POW). uart IRQ is always enabled, unmasked and
> not pending.
> 
> I tried to log to physical memory to see what's going on whenever the
> board fails to wake-up.
> (I can examine physical memory after CPU is stuck in sleep, by connecting
>  a JTAG debugger, start u-boot and stop after DDR2 SDRAM ctrl is
>  re-configured)

Are you sure this isn't going to disturb anything?  Why does U-Boot need
to be involved, and the SDRAM reconfigured?

> It looks like an interupt does occur, but do_IRQ seems to be stuck
> in ppc_md.get_irq=ipic_get_irq where it reads SIVCR.

Stuck as in the load never completes, or as in ipic_get_irq() gets
called repeatedly?  If the latter, what value is it reading out?  Is the
interrupt pending in SIPNR at this point?

-Scott
