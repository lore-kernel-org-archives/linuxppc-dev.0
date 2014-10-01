Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A456A1A0995
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 08:39:29 +1000 (EST)
Message-ID: <1412203153.13320.352.camel@snotra.buserror.net>
Subject: Re: [PATCH 00/20] powerpc: Convert power off logic to pm_power_off
From: Scott Wood <scottwood@freescale.com>
To: Alexander Graf <agraf@suse.de>
Date: Wed, 1 Oct 2014 17:39:13 -0500
In-Reply-To: <1412170086-57971-1-git-send-email-agraf@suse.de>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 15:27 +0200, Alexander Graf wrote:
> The generic Linux framework to power off the machine is a function pointer
> called pm_power_off. The trick about this pointer is that device drivers can
> potentially implement it rather than board files.
> 
> Today on PowerPC we set pm_power_off to invoke our generic full machine power
> off logic which then calls ppc_md.power_off to invoke machine specific power
> off.
> 
> However, when we want to add a power off GPIO via the "gpio-poweroff" driver,
> this card house falls apart. That driver only registers itself if pm_power_off
> is NULL to ensure it doesn't override board specific logic. However, since we
> always set pm_power_off to the generic power off logic (which will just not
> power off the machine if no ppc_md.power_off call is implemented), we can't
> implement power off via the generic GPIO power off driver.
> 
> To fix this up, let's get rid of the ppc_md.power_off logic and just always use
> pm_power_off as was intended. Then individual drivers such as the GPIO power off
> driver can implement power off logic via that function pointer.
> 
> With this patch set applied and a few patches on top of QEMU that implement a
> power off GPIO on the virt e500 machine, I can successfully turn off my virtual
> machine after halt.

Are there any plans to handle restart similarly?

-Scott
