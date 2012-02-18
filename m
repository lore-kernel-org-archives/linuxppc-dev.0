Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AC4F11007D5
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2012 11:56:34 +1100 (EST)
Message-ID: <4F3EF72C.2090305@freescale.com>
Date: Fri, 17 Feb 2012 18:56:12 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <b04825@freescale.com>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
 <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
 <CAOZdJXWQzxWXhU_4WmeKXx1mfTxGQx=-JZx0AkZcF7CmRrp1gQ@mail.gmail.com>
 <1329513033.3980.1.camel@pasglop> <4F3EDC35.5070904@freescale.com>
In-Reply-To: <4F3EDC35.5070904@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Li Yang-R58472 <r58472@freescale.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 05:01 PM, Timur Tabi wrote:
> So I noticed something else.  PHYS_64BIT is not defined in
> mpc85xx_smp_defconfig.

It couldn't have been, since it was selected by another kconfig option.
 defconfigs only hold non-default options.

> However, that select statement also means that we can't build a 32-bit
> kernel.  This is a problem for mpc85xx_defconfig, because that defconfig
> includes support for the MPC8540ADS.  The 8540 has an e500v1 core which
> doesn't support MAS7 (i.e. no 36-bit physical addresses).

It's not a problem for 8540, just lost optimization potential.

> So any patch that removes "select PHYS_64BIT" from an mpc85xx_defconfig
> board must also turn on that option in the defconfig.  The patches from me
> and Leo don't do that.

Yes, or maybe make it "default y", and/or require an "I know what I'm
doing" option to be set for it to be unset if a board otherwise wants it.

The ability to turn it off is potentially useful for any board, since
the address map is determined by boot software which can be changed, but
we shouldn't make it too easy to fail to select it for boards that
normally require it.

-Scott
