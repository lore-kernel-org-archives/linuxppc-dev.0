Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0A3E6DDF87
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 05:07:06 +1000 (EST)
In-Reply-To: <200704261911.22553.arnd@arndb.de>
References: <20070425204633.GC19781@lixom.net>
	<200704261055.33739.arnd@arndb.de>
	<20070426164835.GA14149@lixom.net>
	<200704261911.22553.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c8fb6a47d8be41f856ab9cf19fc3814d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] [2.6.22] pasemi: cpufreq driver
Date: Thu, 26 Apr 2007 21:05:59 +0200
To: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, egor@pasemi.com,
	paulus@samba.org, cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Unfortunately the setting of the current active state is done to an 
>> SDC
>> register, while information of the states is in the PMU, so access to
>> both is needed in the driver.
>
> One thing that you could do is to list only this one register of the
> SDC in the reg property, not all of the SDC.

The system-controller node should really describe
all of the system controller.  If the Linux driver
needs to access two separate devices, it should
really just do that.  Don't try to make things
"simpler" in the device tree.

You probably should map the SDC registers in the
platform startop code, and then have the various
platform drivers use that.  Maybe even do an
abstraction ;-)


Segher
