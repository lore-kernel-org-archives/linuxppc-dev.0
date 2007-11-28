Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 8FA2BDDE3B
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 03:29:00 +1100 (EST)
Message-ID: <474D9758.9070200@ru.mvista.com>
Date: Wed, 28 Nov 2007 19:29:12 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
References: <20071127153708.GA12490@localhost.localdomain>	<20071127153908.GB14183@localhost.localdomain>	<20071127212222.GB10829@lixom.net>
	<200711272233.00456.arnd@arndb.de>
In-Reply-To: <200711272233.00456.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Arnd Bergmann wrote:

>>>This driver nicely wraps around pata_platform library functions,
>>>and provides OF platform bus bindings to the PATA devices.

>>>+static struct of_device_id pata_of_platform_match[] = {
>>>+     { .compatible = "pata-platform", },
>>>+};

>>"pata-platform" really means nothing outside of linux. A more
>>generic label would be useful.

> Maybe the name of the standards it supports? Could be
> "ata-4", "ata-5" and the like,

    It's not clear what info this would provide.

> or the exact transfer mode, like
> "pata-udma-5", "pata-pio-3", "sata-150", etc.

    I think this info should follow from the compatible property value 
implicitly, or maybe this info should be conveyed in some optional properties. 
It doesn't make sense to the generic platform driver anyway since it has no 
notion about the mode programming specifics. I think that as the device being 
driven is assumed to be a generic IDE device, the "compatible" property should 
contain "generic" or something alike (as well as usual board's and chip's names).

> 	Arnd <><

MBR, Sergei
