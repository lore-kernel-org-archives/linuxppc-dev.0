Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 235C467A46
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jan 2005 11:43:55 +1100 (EST)
Message-ID: <41ED49E2.5050401@orkun.us>
Date: Tue, 18 Jan 2005 11:39:46 -0600
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
References: <41EC29A8.1040703@mvista.com>	<20050118161515.GI28724@smtp.west.cox.net>
	<93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
In-Reply-To: <93780AB0-696D-11D9-81BE-003065F9B7DC@embeddededge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] Option to disable mapping genrtc calls to ppc_md calls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:
> 
> On Jan 18, 2005, at 11:15 AM, Tom Rini wrote:
> 
>> On Mon, Jan 17, 2005 at 02:10:00PM -0700, Mark A. Greer wrote:
> 
> 
>>> There are 2 reasons to not use the ppc_md.get_rtc_time() et. al. 
>>> interfaces:
>>> 1) They are called before the i2c driver is initialized and even loaded
>>> if its a module.
> 
> 
> There are three reasons.  You don't want to use an I2c rtc clock at
> all in these functions because they get can get called from the
> clock interrupt to update the time in the rtc.  If it does happen to work,
> it creates long latencies in the timer interrupt.  If the i2c requires an
> interrupt, they system will crash or hang.
> 
> A system using an I2C RTC should find some way to access the
> clock from application space as a standard I2C device and manage
> time/clock from the application, not from the kernel.

This is exactly what I've done for our PPC405GP based Linux port 
(2.4.25). I've written a clone of hwclock utility using /dev/i2c0 to 
access Dallas RTC chip with I2C interface. I setthe system clock from 
RTC within /etc/rcS (Busybox). It is less than perfect as early logs 
have the date wrong but it was the direction of least resistance.

Still, I think there should be a better standardized RTC interface to 
help deal with I2C/SMBus based RTC chips.
