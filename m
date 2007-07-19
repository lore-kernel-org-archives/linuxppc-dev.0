Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from hirscho.in-berlin.de (fallback-mx.in-berlin.de [192.109.42.17])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6B514DDF48
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 07:02:08 +1000 (EST)
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	by fallback-mx.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id
	l6JKoAjE020996
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 22:50:10 +0200
Message-ID: <469FCE5E.80803@s5r6.in-berlin.de>
Date: Thu, 19 Jul 2007 22:49:34 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: 2.6.22-git* regression: Kconfig prompts without help text
References: <469BBDAD.2010908@s5r6.in-berlin.de>
	<Pine.LNX.4.64.0707181634100.5385@fbirervta.pbzchgretzou.qr>
	<20070718094119.4a26ae03.randy.dunlap@oracle.com>
	<Pine.LNX.4.64.0707181916410.5385@fbirervta.pbzchgretzou.qr>
	<Pine.LNX.4.64.0707192219380.18342@anakin>
In-Reply-To: <Pine.LNX.4.64.0707192219380.18342@anakin>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	Linux/m68k <linux-m68k@vger.kernel.org>,
	Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Jan Engelhardt <jengelh@computergmbh.de>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On Wed, 18 Jul 2007, Jan Engelhardt wrote:
>> Add some help texts to recently-introduced kconfig items
>>
>> Index: linux-2.6.23/drivers/macintosh/Kconfig
>> ===================================================================
>> --- linux-2.6.23.orig/drivers/macintosh/Kconfig
>> +++ linux-2.6.23/drivers/macintosh/Kconfig
>> @@ -3,6 +3,12 @@ menuconfig MACINTOSH_DRIVERS
>>  	bool "Macintosh device drivers"
>>  	depends on PPC || MAC || X86
>>  	default y if (PPC_PMAC || MAC)
>> +	---help---
>> +	  Say Y here to get to see options for devices used with Macintosh
>> +	  computers, both PPC and Intel based. This option alone does not add
>                                   ^^^^^
>> +	  any kernel code.
>> +
>> +	  If you say N, all options in this submenu will be skipped and disabled.
> 
> `MAC' is the symbol for m68k Macs.

OK, then this should read

	  Say Y here to get to see options for devices used with Macintosh
	  computers. This option alone does not add any kernel code.

	  If you say N, all options in this submenu will be skipped and disabled.

> From a quick look at drivers/macintosh/Kconfig, all of the entries are for m68k
> and PPC Macs only.  The only thing that depends on X86 is the main menu...

There is one entry for all sorts of Macs, MAC_EMUMOUSEBTN.
-- 
Stefan Richter
-=====-=-=== -=== =--==
http://arcgraph.de/sr/
