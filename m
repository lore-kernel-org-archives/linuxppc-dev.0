Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 5BCB467A3F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 01:58:40 +1000 (EST)
Date: Tue, 12 Sep 2006 10:58:30 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Fredrik Roubert <roubert@df.lth.se>
Subject: Re: How to move from /ppc/ to /powerpc/
Message-Id: <20060912105830.3923d537.kim.phillips@freescale.com>
In-Reply-To: <20060912153316.GC16340@igloo.df.lth.se>
References: <20060912153316.GC16340@igloo.df.lth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 12 Sep 2006 17:33:16 +0200
Fredrik Roubert <roubert@df.lth.se> wrote:

> Hi!
> 
> I have a custom board on which I currently run Linux 2.6.18-rc6
> configured for MPC834x_SYS in the /ppc/ tree, which just a few minor
> changes. Now I'm interested to move to using the /powerpc/ source tree
> instead, but I can't figure out exactly what steps are necessary to do
> this.
> 
> Does anyone run a MPC834x_SYS built with ARCH=powerpc?
> 
yes

> I boot the board with U-Boot (version 1.1.4, customized), and I assume
> that I need to add some stuff for this new device tree thing, but I
> can't figure out exactly what the kernel will expect.

the kernel expects a pointer to a device tree instead of a bd_t.  The 8349EMDS device tree source is now in linux/arch/powerpc/boot/dts.  You'll need the device tree compiler (dtc) from jdl.com to build your flat device tree binary (dtb; what the kernel expects).

> 
> Does anyone have some pointers on how to do this?
> 
Matt's u-boot patches address the issue well for 85xx, they are straightforward to adapt to 83xx:

http://sourceforge.net/mailarchive/forum.php?thread_id=15518792&forum_id=12898

they allow you to tftp the dtb into mem, and "bootm ${loadaddr} - ${oftaddr}" to start an ARCH=powerpc kernel. 

> Cheers // Fredrik Roubert

Kim
