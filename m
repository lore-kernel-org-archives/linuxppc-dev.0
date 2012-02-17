Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58C64B6EF1
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Feb 2012 08:18:04 +1100 (EST)
Message-ID: <4F3EC3FF.3050304@freescale.com>
Date: Fri, 17 Feb 2012 15:17:51 -0600
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

Benjamin Herrenschmidt wrote:
> Sorry, I fail to see how... it basically makes all those boards
> non-functional even when enabled...

So you're saying that if we allow 32-bit address spacing for a particular
board, then we must provide a 32-bit DTS to go with it?

I was hoping to use the defconfig to force 36-bit, so that we can have a
32-bit option if we want.  Just because we don't put a 32-bit DTS in the
upstream kernel, that doesn't mean that no one is allowed to have a 32-bit
kernel.

> What's wrong with the current scheme ?

It prevents the possibility of creating an "optimized" 32-bit address
environment, for people who have <= 2GB of DDR on the board.  If we want
to ship a 32-bit DTS and 32-bit U-Boot on our BSP, then we'll need to
patch the Kconfig to remove the "select" line.

-- 
Timur Tabi
Linux kernel developer at Freescale
