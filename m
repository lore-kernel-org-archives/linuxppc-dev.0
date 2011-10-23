Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 430D21007D1
 for <linuxppc-dev@ozlabs.org>; Mon, 24 Oct 2011 01:38:20 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 03/11] powerpc/85xx: Rework PCI nodes on P1020RDB
Date: Sun, 23 Oct 2011 14:37:17 +0000
Message-ID: <CAOZdJXUy5qDhbEAih2kx91fmgyxqd7u9T6AV4fDvp4AMMRA+4w@mail.gmail.com>
References: <1319318452-27036-1-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-2-git-send-email-galak@kernel.crashing.org>
 <1319318452-27036-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1319318452-27036-3-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Oct 22, 2011 at 4:20 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
> * Move SoC specific details like irq mapping to SoC dtsi
> * Update interrupt property to cover both error interrupt and PCIe
> =A0runtime interrupts

Are we going to be doing this for all our device trees?  If so, then I
think we need to document what properties the board dts should be
defining when it includes a node from a dtsi.  Something like this:

dtsi:
               pcie@0 {
                       /* dts should define 'reg' and 'ranges' */
                       reg =3D <0 0 0 0 0>;
                       #interrupt-cells =3D <1>;

I suppose it's obvious that 'reg' and 'ranges' should be defined, so
this isn't the best example.  But we should document if any other
properties should be defined.

For example, the SSI nodes contain a bunch of SOC- and board-specific
properties.

--=20
Timur Tabi
Linux kernel developer at Freescale=
