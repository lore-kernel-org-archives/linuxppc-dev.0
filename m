Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 05AA6DDEDA
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jun 2007 02:12:01 +1000 (EST)
In-Reply-To: <91EBCC0C-48B7-4748-A936-E74CEB7685E0@kernel.crashing.org>
References: <20070616000511.712667424@arndb.de>
	<20070616000618.314570319@arndb.de>
	<91EBCC0C-48B7-4748-A936-E74CEB7685E0@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4919e259332813addb0c287848fa48c3@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 2/9] autoselect optimal -mcpu= flag by platform
Date: Sun, 17 Jun 2007 18:11:50 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Is there a reason we don't distinguish between 7400/7410 and 74{4,5}
> x?  Is it because we dont have any discrete systems with just a 7400
> on it?

It's quite important for 74[01]0 systems to not run
code tuned for 7450.  Older Macs have such CPUs, the
user should have the option to tune for it.

> Also I'd suggest we have the config options be a 1:1 matching for the
> -mcpu/-mtune options in gcc for the following cases:
>
>> +	default "-mcpu=750" if CPU_7xx
>> +	default "-mcpu=7450" if CPU_74xx
>> +	default "-mcpu=860" if PPC_8xx
>> +	default "-mcpu=8540" if PPC_85xx

It would be good to do that for all cases, unfortunately
GCC doesn't recognise all CPU/core names as -mcpu options.


Segher
