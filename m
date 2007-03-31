Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 067BBDDE29
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Apr 2007 04:38:52 +1000 (EST)
Date: Sat, 31 Mar 2007 20:38:44 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Rafal Jaworowski <raj@semihalf.com>
Subject: Re: [PATCH] icecube/lite5200b: wakeup from low-power support
Message-ID: <20070331183843.GA3143@nd47.coderock.org>
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104411.GF22215@moe.telargo.com>
	<460E9853.80902@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <460E9853.80902@semihalf.com>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 31/03/07 19:20 +0200, Rafal Jaworowski wrote:
> Domen Puncer wrote:
> >U-Boot part of Lite5200b low power mode support.
> >Puts SDRAM out of self-refresh and transfers control to
> >address saved at physical 0x0.
> >
> 
> Hi Domen,

Hi!
> 
> As I understand while waking up from the low-power mode the machine is 
> effectively powering on, similarly to the cold reset, so U-Boot runs 
> from the beginning as usual, but after the SDRAM controller has been 
> initialised we detect the wakeup and teleport to the saved DRAM address.

Right.

> 
> Since in case of a wakeup from the low-power mode we skip everything in 
> U-Boot that is happening past initdram(), please clarify the following:
> 
> - are you sure there are no steps beyond init_func_ram()/board_init_f() 
> that should be performed while waking up? For example:
> 
> - are all timers settings properly re-stored?

Hmm... right, I forgot to restart watchdog... but that will be done in
Linux code.

> 
> - wouldn't the host/PCI bridge need to be re-initialised and 
> re-configured as part of the wakeup process? Did you happen to test some 
> PCI devices and would they survive after wakeup from the the low-power 
> mode? (A similar question would apply to the USB controller)

Honestly, I don't know for PCI. IIRC some time ago, kernel compiled
with CONFIG_PCI didn't boot for me.

USB controller/devices survived the wakeup last time I checked.

> 
> Also, a more general question: isn't time base update required after the 
> wakeup, specially if it's been a long sleep?

Lite5200b doesn't have an external time source.


Thanks!

	Domen
