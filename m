Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2D3722C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2012 03:36:25 +1100 (EST)
Date: Fri, 2 Nov 2012 11:36:04 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: powerpc: Don't silently handle machine checks from userspace
To: Martijn de Gouw <martijn.de.gouw@prodrive.nl>
References: <5093B318.9040305@prodrive.nl>
In-Reply-To: <5093B318.9040305@prodrive.nl> (from
 martijn.de.gouw@prodrive.nl on Fri Nov  2 06:48:40 2012)
Message-ID: <1351874164.5089.1@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Micha Nelissen <micha.nelissen@prodrive.nl>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/02/2012 06:48:40 AM, Martijn de Gouw wrote:
> Hi,
>=20
> The following commit:
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dc=
ommit;h=3De49b1fae0ba4d06b29bd753a961abb447566bf4a
>=20
> causes confusion, because it prints "Machine check in kernel mode" =20
> also when the bus error is actually in user space. When using RapidIO =20
> memory mapped access, and the device is removed or powered off, then =20
> a bus error is generated. This is on a freescale mpc8548 powerpc. Due =20
> to removing the user_mode check, the kernel calls "die" which causes =20
> the process to die with a BUS error, regardless of having a SIGBUS =20
> handler or not.
>=20
> Therefore I request to put this check back, and even to put the =20
> removed code at the top of the machine check handler because there is =20
> no point in trying to recover from a user space bus error anyway.

Why is there no point trying to recover?  For example, see MCSR_ICPERR =20
and MCSR_DCPERR_MC in machine_check_e500mc.  The machine check is just =20
letting us know that there was an error and the read-only cache got =20
dumped (i.e. it was a correctable error).

-Scott=
