Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E60F1A00FD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 13:28:19 +1000 (EST)
Message-ID: <1410751698.24738.13.camel@concordia>
Subject: Re: [PATCH] rtc/tpo: Driver to support rtc and wakeup on PowerNV
 platform
From: Michael Ellerman <mpe@ellerman.id.au>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 13:28:18 +1000
In-Reply-To: <20140910053232.11176.35140.stgit@localhost.localdomain>
References: <20140910053232.11176.35140.stgit@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: a.zummo@towertech.it, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org,
 rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-09-10 at 11:08 +0530, Neelesh Gupta wrote:
> The patch implements the OPAL rtc driver that binds with the rtc
> driver subsystem. The driver uses the platform device infrastructure
> to probe the rtc device and register it to rtc class framework. The
> 'wakeup' is supported depending upon the property 'has-tpo' present
> in the OF node. It provides a way to load the generic rtc driver in
> in the absence of an OPAL driver.
> 
> The patch also moves the existing OPAL rtc get/set time interfaces to the
> new driver and exposes the necessary OPAL calls using EXPORT_SYMBOL_GPL.
> 
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> ---
> 
> Note:
> This patch depends upon the below patch posted on 'linuxppc-dev@lists.ozlabs.org'
> [PATCH 1/4] powerpc/powernv: Add OPAL check token call
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> 
>  arch/powerpc/include/asm/opal.h                |    7 -
>  arch/powerpc/kernel/time.c                     |    1 
>  arch/powerpc/platforms/powernv/opal-async.c    |    3 
>  arch/powerpc/platforms/powernv/opal-rtc.c      |   63 ++----
>  arch/powerpc/platforms/powernv/opal-wrappers.S |    2 
>  arch/powerpc/platforms/powernv/opal.c          |    6 +
>  arch/powerpc/platforms/powernv/setup.c         |    2 
>  drivers/rtc/Kconfig                            |   11 +
>  drivers/rtc/Makefile                           |    1 
>  drivers/rtc/rtc-opal.c                         |  257 ++++++++++++++++++++++++
>  10 files changed, 305 insertions(+), 48 deletions(-)
>  create mode 100644 drivers/rtc/rtc-opal.c


Alessandro, given this depends on other things in the powerpc tree do you mind
if we take this through the powerpc tree with your Ack?

Or I can create a topic branch with the required powerpc changes.

cheers
