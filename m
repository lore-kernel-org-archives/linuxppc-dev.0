Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (cdma-61-61.msk.skylink.ru [83.217.61.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 934A4DDEF5
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 17:12:43 +1000 (EST)
Date: Mon, 23 Apr 2007 10:14:27 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH][RFC] PCMCIA support for 8xx using platform devices
Message-ID: <20070423101427.3a1d4983@localhost.localdomain>
In-Reply-To: <200704222349.42368.arnd@arndb.de>
References: <20070422232658.5f427fd3@localhost.localdomain>
	<200704222349.42368.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 22 Apr 2007 23:49:41 +0200
Arnd Bergmann wrote:

> On Sunday 22 April 2007, Vitaly Bordug wrote:
> > This utilizes PCMCIA on mpc885ads and mpc866ads from arch/powerpc.
> > In the new approach, direct IMMR accesses from within drivers/ were
> > totally eliminated, that requires hardware_enable,
> > hardware_disable, voltage_set board-specific functions to be moved
> > over to BSP code section (arch/powerpc/platforms/8xx in 885 case).
> > There is just no way to have both arch/ppc and arch/powerpc
> > approaches to work simultaneously because of that.  
> 
> Maybe I'm missing a key issue here, but what's the point of adding
> more platform_devices for stuff that is already in the device tree?
> Shouldn't this be made an of_platform_driver instead so you can
> use the existing of_device directly?
> 
Was thinking of it but platform_device is better for migration purposes. Hence,
assuming somebody would want to have pcmcia working not bothering to add whole arch/powerpc support,
it can be accomplished quickly. OTOH, further change from pd to of_device is not hard as well. So far, most ppc stuff (if not all) still existing both in ppc/ and powerpc/ paths, and to keep consistency platform_devices are used here and there. So, with pd approach arch/ppc/ boards are encouraged to get source device/driver bus ready, hereby simplifying transition to of_device later.

With current bootwrapper activities it may happen sooner, but there are many places in kernel nobody want to move for almost zero value..



-- 
Sincerely, Vitaly
