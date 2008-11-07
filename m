Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-9.online-age.net (ext-nj2ut-9.online-age.net
	[64.14.54.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5C87ADDF37
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Nov 2008 02:16:00 +1100 (EST)
Received: from int-nj2ut-3.online-age.net (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by ext-nj2ut-9.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id mA7FFkO7023474
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 10:15:46 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-3.online-age.net
	[3.159.237.72])
	by int-nj2ut-3.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id mA7FFkHm013383
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Nov 2008 10:15:46 -0500
Date: Fri, 7 Nov 2008 15:16:14 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Watchdog timer support for GE Fanuc SBC610
Message-Id: <20081107151614.534d4607.martyn.welch@gefanuc.com>
In-Reply-To: <6A6D7DCB-067A-4891-B922-536765D6E6FB@kernel.crashing.org>
References: <20081107143818.9129.47899.stgit@ubuntu8041.localdomain>
	<6A6D7DCB-067A-4891-B922-536765D6E6FB@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 7 Nov 2008 08:44:45 -0600
Kumar Gala <galak@kernel.crashing.org> wrote:
> 
> On Nov 7, 2008, at 8:38 AM, Martyn Welch wrote:
> 
> > Support for the SBC610 VPX Single Baord Computer from GE Fanuc  
> > (PowerPC
> > MPC8641D).
> >
> > This patch adds support for the watchdog timer in the devices main  
> > FPGA.
> > There are two identical watchdog timers at different offsets in the  
> > main
> > FPGA, this driver is capable of supporting one of them. The watchdog  
> > timers
> > are also capable of generating interrupts at a user-configurable  
> > threshold,
> > though support for this operation is currently not supported by the  
> > driver.
> >
> > Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> > ---
> >
> > arch/powerpc/boot/dts/gef_sbc610.dts           |   19 +
> > arch/powerpc/configs/86xx/gef_sbc610_defconfig |    1
> > drivers/watchdog/Kconfig                       |    6
> > drivers/watchdog/Makefile                      |    1
> > drivers/watchdog/gef_wdt.c                     |  333 +++++++++++++++ 
> > +++++++++
> > 5 files changed, 360 insertions(+), 0 deletions(-)
> 
> Can you break this into two patches.  One for the driver and one for  
> the arch/powerpc stuff.  the driver should go via the watchdog  
> maintainer (and CC that list).
> 

Yeah - sorry, didn't think about that.

Thinking about it, the driver is specific to GEF Fanuc boards, should this be 
going into drivers/watchdog/ or would it be better for me to move it to 
arch/powerpc?

Martyn

> - k


-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
