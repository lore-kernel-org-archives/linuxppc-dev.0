Return-Path: <cedric.pradalier@free.fr>
Received: from qsrv02sl.mx.bigpond.com (qsrv02sl.mx.bigpond.com
	[144.140.93.182]) by ozlabs.org (Postfix) with ESMTP id 6FBCA689C8
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2006 00:18:50 +1100 (EST)
Date: Thu, 12 Jan 2006 21:52:00 +1000
From: Cedric Pradalier <cedric.pradalier@free.fr>
To: linuxppc-dev@ozlabs.org
Message-Id: <20060112215200.680a8cc1.cedric.pradalier@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: Fw:   therm_adm103x: inquiry
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Begin forwarded message:

Date: Thu, 12 Jan 2006 21:34:14 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cedric Pradalier <cedric.pradalier@free.fr>
Subject: Re: therm_adm103x: inquiry


>
>> So practically, what should I do? What should I sent to who?
>
>linuxppc-dev@ozlabs.org CC me & paulus :)
>
>Ben.
>
>

Hi

I'm the author of the therm_adm103x module, used to control
and display the fan management information on ibook G3, rev
2.2 (at least), available since 2.6.4.

Currently, the module is available as a patch or as a
binary module linked with current debian testing kernel:
http://cedric.pradalier.free.fr/ibook2

As far as I can see, this module seems mature enough for
inclusion in official kernel.

A tested patch against 2.6.14 is available at:
http://cedric.pradalier.free.fr/ibook2/adm103x-2.6.14.diff.gz

I've not tested it yet for 2.6.15. 

Some details, from the link site above:

The module provides and sysfs access to the adm103x fan
control parameters. For instance

	  #cat /sys/device/temperatures/info? 
	  T:51°C S:56°C R:10°C  <-- sensor 0
	  T:48°C S:76°C R:10°C  <-- sensor 1
	  #echo "56 10" > /sys/device/temperatures/info0 

make the fan starts at 56 degrees and accelerate
progressively till max at 66 degrees (56 + 10), on the
sensor 0.

To see if thermal control is done by the chips that this
module can manage, just check that
	#cat /proc/device-tree/uni-n/i2c/fan/device_type
returns adm1030 or adm1031.

-- 
Cedric
