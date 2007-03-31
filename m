Return-Path: <raj@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [62.233.211.107])
	by ozlabs.org (Postfix) with ESMTP id 34A3BDDEF0
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  1 Apr 2007 03:46:44 +1000 (EST)
Message-ID: <460E9853.80902@semihalf.com>
Date: Sat, 31 Mar 2007 19:20:19 +0200
From: Rafal Jaworowski <raj@semihalf.com>
MIME-Version: 1.0
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH] icecube/lite5200b: wakeup from low-power support
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104411.GF22215@moe.telargo.com>
In-Reply-To: <20070315104411.GF22215@moe.telargo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Domen Puncer wrote:
> U-Boot part of Lite5200b low power mode support.
> Puts SDRAM out of self-refresh and transfers control to
> address saved at physical 0x0.
> 

Hi Domen,

As I understand while waking up from the low-power mode the machine is 
effectively powering on, similarly to the cold reset, so U-Boot runs 
from the beginning as usual, but after the SDRAM controller has been 
initialised we detect the wakeup and teleport to the saved DRAM address.

Since in case of a wakeup from the low-power mode we skip everything in 
U-Boot that is happening past initdram(), please clarify the following:

- are you sure there are no steps beyond init_func_ram()/board_init_f() 
that should be performed while waking up? For example:

- are all timers settings properly re-stored?

- wouldn't the host/PCI bridge need to be re-initialised and 
re-configured as part of the wakeup process? Did you happen to test some 
PCI devices and would they survive after wakeup from the the low-power 
mode? (A similar question would apply to the USB controller)

Also, a more general question: isn't time base update required after the 
wakeup, specially if it's been a long sleep?

kind regards,
Rafal
