Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6302DDEBB
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 02:12:17 +1100 (EST)
Message-Id: <9E91DB29-BBB8-4CC9-8F6D-71306329D7A5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jochen Friedrich <jochen@scram.de>
In-Reply-To: <478F6C5F.4010505@scram.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH/RFCv2] wdt: Add support for PowerQUICC watchdog
Date: Thu, 17 Jan 2008 09:11:57 -0600
References: <478F4E4A.4060907@scram.de>
	<A00FB5AE-903B-461A-B234-4BA817B3C5CB@kernel.crashing.org>
	<478F6C5F.4010505@scram.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	wim@iguana.be, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 17, 2008, at 8:55 AM, Jochen Friedrich wrote:

> Hi Kumar,
>
>> Why are you commenting on mpc83xx_wdt with respect to pq1_wdt?
>> Also, is this driver just for PQ1 platforms or PQ1 & PQ2?  If its  
>> just pq1 we should probably call it pq1_wdt*
>
> It should be for pq1, pq2 and pq2pro. However, i only have the  
> possibility
> to test this on pq1.
>
>>> arch/powerpc/platforms/8xx/mpc86xads_setup.c |    5 +
>>> arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 +
>>> arch/powerpc/sysdev/Makefile                 |    3 +
>>> arch/powerpc/sysdev/pq_wdt.c                 |  203 +++++++++++++++ 
>>> ++++++++
>>> arch/powerpc/sysdev/pq_wdt.h                 |   28 ++++
>>> drivers/watchdog/Kconfig                     |   13 ++-
>>> drivers/watchdog/Makefile                    |    1 +
>>> drivers/watchdog/pq_wdt.c                    |  225 +++++++++++++++ 
>>> +++++++++++
>>> 8 files changed, 482 insertions(+), 1 deletions(-)
>>> create mode 100644 arch/powerpc/sysdev/pq_wdt.c
>>> create mode 100644 arch/powerpc/sysdev/pq_wdt.h
>>> create mode 100644 drivers/watchdog/pq_wdt.c
>> What are the bits in sysdev/pq_wdt.{c,h}.  Why aren't these just in  
>> drivers/watchdog?
>
> These are the parts needed to boot a device with activated watchdog.  
> If a bootloader like u-boot activates the watchdog, it can't be  
> deactivated again
> and needs to be reset at regular intervals. This is done using a  
> kernel timer.
> The driver in drivers/watchdog disables the timer as soon as the wdt  
> device
> is opened.

Ok, but is there a need for these bits to be in sysdev vs just being  
in the driver and calling into it.

- k
