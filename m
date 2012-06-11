Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe001.messaging.microsoft.com [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53A8FB6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2012 01:55:09 +1000 (EST)
Message-ID: <4FD614AF.70108@freescale.com>
Date: Mon, 11 Jun 2012 10:54:23 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Gopalakrishnan Raman <graman@arubanetworks.com>
Subject: Re: Question about MPIC_SINGLE_DEST_CPU on P1020 (e500 core) SMP
References: <802E1C77E421D345A43385A6BFAC7AC4BE502C@ROYALGORGE.arubanetworks.com>
In-Reply-To: <802E1C77E421D345A43385A6BFAC7AC4BE502C@ROYALGORGE.arubanetworks.com>
Content-Type: text/plain; charset="windows-1252"
Cc: "rgkwstl@gmail.com" <rgkwstl@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2012 03:37 PM, Gopalakrishnan Raman wrote:
> Hi
>=20
> The P1020 manual states (in the PIC chapter) that in the =93Internal
> Interrupt Destination=94 register, only 1 CPU (and not both) can be
> selected as the IRQ destination.

Right.

> How then can we achieve =93interrupt
> spraying=94 for the PCI interrupt (we want interrupts to be sent
> alternately to CPU0 and CPU1).

You'll have to implement it in software by changing the destination each
time (and be careful to follow the documented sequence for making such
changes).

Why do you want to do this?  Won't it cause a bunch of cache misses as
the IRQ-relevant data structures bounce between CPUs?  Distributing
different devices' interrupts among multiple CPUs is probably good for
load balancing, but distributing a single device's interrupts may not be
so good.

> Also,  we changed the code to ignore the
> MPIC_SINGLE_DEST_CPU flag and set both CPUs in the destination of the
> PIC_IIDRn register. This does seem to work.

What specifically does it seem to do?

> But we=92re not sure if we can
> rely on this behavior and whether it will cause other problems.

You cannot rely on this.  It is not a supported configuration.

-Scott
