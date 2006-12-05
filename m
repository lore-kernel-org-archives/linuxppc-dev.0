Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 723AE67A3A
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 00:34:37 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [POWERPC] fix cell pmu initialisation
Date: Tue, 5 Dec 2006 14:34:07 +0100
References: <20061205155414.4afdcc77.sfr@canb.auug.org.au>
In-Reply-To: <20061205155414.4afdcc77.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612051434.07917.arnd@arndb.de>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 05 December 2006 05:54, Stephen Rothwell wrote:
> -int __init cbe_init_pm_irq(void)
> +static int __init cbe_init_pm_irq(void)
> =A0{
> =A0=A0=A0=A0=A0=A0=A0=A0unsigned int irq;
> =A0=A0=A0=A0=A0=A0=A0=A0int rc, node;
> =A0
> +=A0=A0=A0=A0=A0=A0=A0if (!machine_is(cell))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return 0;
> +

This looks like a working fix at the moment, but it will break if we
add machine more descriptions have these registers.

I see three options here how to solve this:

1. export a method from cbe_regs.c to find out whether the pmd=20
   regs are available and test that in cbe_init_pm_irq().
2. take you patch as is, with a comment hinting to fix it up
   when needed.
3. change cbe_init_pm_irq to be called explicitly from cbe_regs_init(),
   which already scans the device tree correctly.

	Arnd <><
