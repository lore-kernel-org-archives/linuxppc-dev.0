Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 42B1FB6EF3
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 07:50:52 +1100 (EST)
Message-ID: <4F63A7A4.4000205@freescale.com>
Date: Fri, 16 Mar 2012 15:50:44 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: don't call of_platform_bus_probe() twice
References: <1322669957-8259-1-git-send-email-timur@freescale.com>
 <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
In-Reply-To: <F8C3451C-1B14-4C30-A194-B15B6C10B0A7@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:

> This seems like paper taping over the real issue.  We should be able to call of_platform_bus_probe() multiple times.

I tried debugging it, but I couldn't figure it out.  My guess is that the
nodes probed by of_platform_bus_probe() are somehow "reserved", so that
the second time it's called, they're skipped.  I figured that this was
just a side-effect of the way the OF layer works.

If someone more familiar with the OF layer wants to look at it, that's
great.  Until then, my patch is the only one that allows the audio and
async DMA drivers to work, and any other drivers that probe on nodes that
are grandchildren of the root node.

-- 
Timur Tabi
Linux kernel developer at Freescale
