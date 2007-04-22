Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id B8625DDEEE
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2007 07:49:53 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Fw: [PATCH][RFC] PCMCIA support for 8xx using platform devices
Date: Sun, 22 Apr 2007 23:49:41 +0200
References: <20070422232658.5f427fd3@localhost.localdomain>
In-Reply-To: <20070422232658.5f427fd3@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704222349.42368.arnd@arndb.de>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>, linux-pcmcia@lists.infradead.org,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 22 April 2007, Vitaly Bordug wrote:
> This utilizes PCMCIA on mpc885ads and mpc866ads from arch/powerpc. In the
> new approach, direct IMMR accesses from within drivers/ were totally
> eliminated, that requires hardware_enable, hardware_disable, voltage_set
> board-specific functions to be moved over to BSP code section   
> (arch/powerpc/platforms/8xx in 885 case). There is just no way to have
> both arch/ppc and arch/powerpc approaches to work simultaneously because
> of that.  

Maybe I'm missing a key issue here, but what's the point of adding
more platform_devices for stuff that is already in the device tree?
Shouldn't this be made an of_platform_driver instead so you can
use the existing of_device directly?

	Arnd <><
