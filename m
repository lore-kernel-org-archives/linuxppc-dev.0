Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6EBBEDDEDE
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 05:21:18 +1000 (EST)
In-Reply-To: <20080329215753.GA27226@lixom.net>
References: <20080328233954.GA29499@farnsworth.org>
	<20080328234704.GD30214@farnsworth.org>
	<20080329215753.GA27226@lixom.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cca3a75a9de9aad936df234195f97bb7@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/9] [POWERPC] mv64x60: Fix FDT compatible names: mv64x60
	=> mv64360
Date: Sun, 30 Mar 2008 21:20:40 +0200
To: Olof Johansson <olof@lixom.net>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Compatible names should refer to a specific version of the hardware,
>> without wildcards.  Change each instance of mv64x60 to mv64360, which
>> is the oldest version we currently support.
>
> Actually, it's normal to have more than one compatible field, from
> specific to generic. So it should make sense to have both (with the
> 64360 entry first).

The normal use is to have the exact device first, and older devices
that the device is compatible to after that.

There is no such thing as a "generic" device, in general.  It's a
mistake to define generic "compatible" values [*], that's like
trying to predict the future -- how can you guarantee that all
future devices in a device family will be compatible?


Segher


[*] In certain cases, like usb-ohci, there _is_ a defined interface
for all future devices.  Also, "legacy" devices have a de facto such
interface.
