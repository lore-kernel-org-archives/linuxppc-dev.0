Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0EB1E1007D5
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2012 10:01:16 +1100 (EST)
Message-ID: <4F3EDC35.5070904@freescale.com>
Date: Fri, 17 Feb 2012 17:01:09 -0600
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/85xx: fix problem that prevents PHYS_64BIT
 from configurable
References: <1329394210-1014-1-git-send-email-leoli@freescale.com>
 <EDB74FED-002D-4F94-B134-995BFB4C0A6B@kernel.crashing.org>
 <CAOZdJXWQzxWXhU_4WmeKXx1mfTxGQx=-JZx0AkZcF7CmRrp1gQ@mail.gmail.com>
 <1329513033.3980.1.camel@pasglop>
In-Reply-To: <1329513033.3980.1.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So I noticed something else.  PHYS_64BIT is not defined in
mpc85xx_smp_defconfig.  This means that if we want to build a 36-bit
kernel, we need to have "select PHYS_64BIT" in the Kconfig for that board.
 This is what we have today for the P1022DS.

However, that select statement also means that we can't build a 32-bit
kernel.  This is a problem for mpc85xx_defconfig, because that defconfig
includes support for the MPC8540ADS.  The 8540 has an e500v1 core which
doesn't support MAS7 (i.e. no 36-bit physical addresses).

So any patch that removes "select PHYS_64BIT" from an mpc85xx_defconfig
board must also turn on that option in the defconfig.  The patches from me
and Leo don't do that.


-- 
Timur Tabi
Linux kernel developer at Freescale
