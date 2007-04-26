Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 78A55DDF5B
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 06:37:43 +1000 (EST)
Date: Thu, 26 Apr 2007 15:38:02 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] [2.6.22] pasemi: cpufreq driver
Message-ID: <20070426203802.GC17302@lixom.net>
References: <20070425204633.GC19781@lixom.net>
	<200704261055.33739.arnd@arndb.de>
	<20070426164835.GA14149@lixom.net>
	<200704261911.22553.arnd@arndb.de>
	<c8fb6a47d8be41f856ab9cf19fc3814d@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c8fb6a47d8be41f856ab9cf19fc3814d@kernel.crashing.org>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, egor@pasemi.com,
	Arnd Bergmann <arnd@arndb.de>, cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 09:05:59PM +0200, Segher Boessenkool wrote:
> >>Unfortunately the setting of the current active state is done to an 
> >>SDC
> >>register, while information of the states is in the PMU, so access to
> >>both is needed in the driver.
> >
> >One thing that you could do is to list only this one register of the
> >SDC in the reg property, not all of the SDC.
> 
> The system-controller node should really describe
> all of the system controller.  If the Linux driver
> needs to access two separate devices, it should
> really just do that.  Don't try to make things
> "simpler" in the device tree.
> 
> You probably should map the SDC registers in the
> platform startop code, and then have the various
> platform drivers use that.  Maybe even do an
> abstraction ;-)

Yep, it's a good idea to do and I'll look at it for 2.6.23 time frame.


Thanks,

-Olof
