Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AA7A2DDF02
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 01:54:33 +1100 (EST)
Message-ID: <478F6C5F.4010505@scram.de>
Date: Thu, 17 Jan 2008 15:55:27 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFCv2] wdt: Add support for PowerQUICC watchdog
References: <478F4E4A.4060907@scram.de>
	<A00FB5AE-903B-461A-B234-4BA817B3C5CB@kernel.crashing.org>
In-Reply-To: <A00FB5AE-903B-461A-B234-4BA817B3C5CB@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi Kumar,

> Why are you commenting on mpc83xx_wdt with respect to pq1_wdt?
> 
> Also, is this driver just for PQ1 platforms or PQ1 & PQ2?  If its just 
> pq1 we should probably call it pq1_wdt*

It should be for pq1, pq2 and pq2pro. However, i only have the possibility
to test this on pq1.

>> arch/powerpc/platforms/8xx/mpc86xads_setup.c |    5 +
>> arch/powerpc/platforms/8xx/mpc885ads_setup.c |    5 +
>> arch/powerpc/sysdev/Makefile                 |    3 +
>> arch/powerpc/sysdev/pq_wdt.c                 |  203 
>> +++++++++++++++++++++++
>> arch/powerpc/sysdev/pq_wdt.h                 |   28 ++++
>> drivers/watchdog/Kconfig                     |   13 ++-
>> drivers/watchdog/Makefile                    |    1 +
>> drivers/watchdog/pq_wdt.c                    |  225 
>> ++++++++++++++++++++++++++
>> 8 files changed, 482 insertions(+), 1 deletions(-)
>> create mode 100644 arch/powerpc/sysdev/pq_wdt.c
>> create mode 100644 arch/powerpc/sysdev/pq_wdt.h
>> create mode 100644 drivers/watchdog/pq_wdt.c
> 
> What are the bits in sysdev/pq_wdt.{c,h}.  Why aren't these just in 
> drivers/watchdog?

These are the parts needed to boot a device with activated watchdog. If a 
bootloader like u-boot activates the watchdog, it can't be deactivated again
and needs to be reset at regular intervals. This is done using a kernel timer.
The driver in drivers/watchdog disables the timer as soon as the wdt device
is opened.

Thanks,
Jochen
